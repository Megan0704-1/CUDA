//===- VPlanPatternMatch.h - Match on VPValues and recipes ------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file provides a simple and efficient mechanism for performing general
// tree-based pattern matches on the VPlan values and recipes, based on
// LLVM's IR pattern matchers.
//
// Currently it provides generic matchers for unary and binary VPInstructions,
// and specialized matchers like m_Not, m_ActiveLaneMask, m_BranchOnCond,
// m_BranchOnCount to match specific VPInstructions.
// TODO: Add missing matchers for additional opcodes and recipes as needed.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_TRANSFORM_VECTORIZE_VPLANPATTERNMATCH_H
#define LLVM_TRANSFORM_VECTORIZE_VPLANPATTERNMATCH_H

#include "VPlan.h"

namespace llvm {
namespace VPlanPatternMatch {

template <typename Val, typename Pattern> bool match(Val *V, const Pattern &P) {
  return P.match(V);
}

template <typename Pattern> bool match(VPUser *U, const Pattern &P) {
  auto *R = dyn_cast<VPRecipeBase>(U);
  return R && match(R, P);
}

template <typename Class> struct class_match {
  template <typename ITy> bool match(ITy *V) const { return isa<Class>(V); }
};

/// Match an arbitrary VPValue and ignore it.
inline class_match<VPValue> m_VPValue() { return class_match<VPValue>(); }

template <typename Class> struct bind_ty {
  Class *&VR;

  bind_ty(Class *&V) : VR(V) {}

  template <typename ITy> bool match(ITy *V) const {
    if (auto *CV = dyn_cast<Class>(V)) {
      VR = CV;
      return true;
    }
    return false;
  }
};

/// Match a specified VPValue.
struct specificval_ty {
  const VPValue *Val;

  specificval_ty(const VPValue *V) : Val(V) {}

  bool match(VPValue *VPV) const { return VPV == Val; }
};

inline specificval_ty m_Specific(const VPValue *VPV) { return VPV; }

/// Match a specified integer value or vector of all elements of that
/// value. \p BitWidth optionally specifies the bitwidth the matched constant
/// must have. If it is 0, the matched constant can have any bitwidth.
template <unsigned BitWidth = 0> struct specific_intval {
  APInt Val;

  specific_intval(APInt V) : Val(std::move(V)) {}

  bool match(VPValue *VPV) const {
    if (!VPV->isLiveIn())
      return false;
    Value *V = VPV->getLiveInIRValue();
    if (!V)
      return false;
    const auto *CI = dyn_cast<ConstantInt>(V);
    if (!CI && V->getType()->isVectorTy())
      if (const auto *C = dyn_cast<Constant>(V))
        CI = dyn_cast_or_null<ConstantInt>(
            C->getSplatValue(/*AllowPoison=*/false));
    if (!CI)
      return false;

    if (BitWidth != 0 && CI->getBitWidth() != BitWidth)
      return false;
    return APInt::isSameValue(CI->getValue(), Val);
  }
};

inline specific_intval<0> m_SpecificInt(uint64_t V) {
  return specific_intval<0>(APInt(64, V));
}

inline specific_intval<1> m_False() { return specific_intval<1>(APInt(64, 0)); }

inline specific_intval<1> m_True() { return specific_intval<1>(APInt(64, 1)); }

/// Matching combinators
template <typename LTy, typename RTy> struct match_combine_or {
  LTy L;
  RTy R;

  match_combine_or(const LTy &Left, const RTy &Right) : L(Left), R(Right) {}

  template <typename ITy> bool match(ITy *V) const {
    if (L.match(V))
      return true;
    if (R.match(V))
      return true;
    return false;
  }
};

template <typename LTy, typename RTy>
inline match_combine_or<LTy, RTy> m_CombineOr(const LTy &L, const RTy &R) {
  return match_combine_or<LTy, RTy>(L, R);
}

/// Match a VPValue, capturing it if we match.
inline bind_ty<VPValue> m_VPValue(VPValue *&V) { return V; }

namespace detail {

/// A helper to match an opcode against multiple recipe types.
template <unsigned Opcode, typename...> struct MatchRecipeAndOpcode {};

template <unsigned Opcode, typename RecipeTy>
struct MatchRecipeAndOpcode<Opcode, RecipeTy> {
  static bool match(const VPRecipeBase *R) {
    auto *DefR = dyn_cast<RecipeTy>(R);
    // Check for recipes that do not have opcodes.
    if constexpr (std::is_same<RecipeTy, VPScalarIVStepsRecipe>::value ||
                  std::is_same<RecipeTy, VPCanonicalIVPHIRecipe>::value ||
                  std::is_same<RecipeTy, VPWidenSelectRecipe>::value ||
                  std::is_same<RecipeTy, VPDerivedIVRecipe>::value ||
                  std::is_same<RecipeTy, VPWidenGEPRecipe>::value)
      return DefR;
    else
      return DefR && DefR->getOpcode() == Opcode;
  }
};

template <unsigned Opcode, typename RecipeTy, typename... RecipeTys>
struct MatchRecipeAndOpcode<Opcode, RecipeTy, RecipeTys...> {
  static bool match(const VPRecipeBase *R) {
    return MatchRecipeAndOpcode<Opcode, RecipeTy>::match(R) ||
           MatchRecipeAndOpcode<Opcode, RecipeTys...>::match(R);
  }
};
template <typename TupleTy, typename Fn, std::size_t... Is>
bool CheckTupleElements(const TupleTy &Ops, Fn P, std::index_sequence<Is...>) {
  return (P(std::get<Is>(Ops), Is) && ...);
}

/// Helper to check if predicate \p P holds on all tuple elements in \p Ops
template <typename TupleTy, typename Fn>
bool all_of_tuple_elements(const TupleTy &Ops, Fn P) {
  return CheckTupleElements(
      Ops, P, std::make_index_sequence<std::tuple_size<TupleTy>::value>{});
}
} // namespace detail

template <typename Ops_t, unsigned Opcode, bool Commutative,
          typename... RecipeTys>
struct Recipe_match {
  Ops_t Ops;

  Recipe_match() : Ops() {
    static_assert(std::tuple_size<Ops_t>::value == 0 &&
                  "constructor can only be used with zero operands");
  }
  Recipe_match(Ops_t Ops) : Ops(Ops) {}
  template <typename A_t, typename B_t>
  Recipe_match(A_t A, B_t B) : Ops({A, B}) {
    static_assert(std::tuple_size<Ops_t>::value == 2 &&
                  "constructor can only be used for binary matcher");
  }

  bool match(const VPValue *V) const {
    auto *DefR = V->getDefiningRecipe();
    return DefR && match(DefR);
  }

  bool match(const VPSingleDefRecipe *R) const {
    return match(static_cast<const VPRecipeBase *>(R));
  }

  bool match(const VPRecipeBase *R) const {
    if (!detail::MatchRecipeAndOpcode<Opcode, RecipeTys...>::match(R))
      return false;
    assert(R->getNumOperands() == std::tuple_size<Ops_t>::value &&
           "recipe with matched opcode the expected number of operands");

    if (detail::all_of_tuple_elements(Ops, [R](auto Op, unsigned Idx) {
          return Op.match(R->getOperand(Idx));
        }))
      return true;

    return Commutative &&
           detail::all_of_tuple_elements(Ops, [R](auto Op, unsigned Idx) {
             return Op.match(R->getOperand(R->getNumOperands() - Idx - 1));
           });
  }
};

template <typename Op0_t, unsigned Opcode, typename... RecipeTys>
using UnaryRecipe_match =
    Recipe_match<std::tuple<Op0_t>, Opcode, false, RecipeTys...>;

template <typename Op0_t, unsigned Opcode>
using UnaryVPInstruction_match =
    UnaryRecipe_match<Op0_t, Opcode, VPInstruction>;

template <typename Op0_t, unsigned Opcode>
using AllUnaryRecipe_match =
    UnaryRecipe_match<Op0_t, Opcode, VPWidenRecipe, VPReplicateRecipe,
                      VPWidenCastRecipe, VPInstruction>;

template <typename Op0_t, typename Op1_t, unsigned Opcode, bool Commutative,
          typename... RecipeTys>
using BinaryRecipe_match =
    Recipe_match<std::tuple<Op0_t, Op1_t>, Opcode, Commutative, RecipeTys...>;

template <typename Op0_t, typename Op1_t, unsigned Opcode>
using BinaryVPInstruction_match =
    BinaryRecipe_match<Op0_t, Op1_t, Opcode, /*Commutative*/ false,
                       VPInstruction>;

template <typename Op0_t, typename Op1_t, unsigned Opcode,
          bool Commutative = false>
using AllBinaryRecipe_match =
    BinaryRecipe_match<Op0_t, Op1_t, Opcode, Commutative, VPWidenRecipe,
                       VPReplicateRecipe, VPWidenCastRecipe, VPInstruction>;

template <unsigned Opcode, typename Op0_t>
inline UnaryVPInstruction_match<Op0_t, Opcode>
m_VPInstruction(const Op0_t &Op0) {
  return UnaryVPInstruction_match<Op0_t, Opcode>(Op0);
}

template <unsigned Opcode, typename Op0_t, typename Op1_t>
inline BinaryVPInstruction_match<Op0_t, Op1_t, Opcode>
m_VPInstruction(const Op0_t &Op0, const Op1_t &Op1) {
  return BinaryVPInstruction_match<Op0_t, Op1_t, Opcode>(Op0, Op1);
}

template <typename Op0_t>
inline UnaryVPInstruction_match<Op0_t, VPInstruction::Not>
m_Not(const Op0_t &Op0) {
  return m_VPInstruction<VPInstruction::Not>(Op0);
}

template <typename Op0_t>
inline UnaryVPInstruction_match<Op0_t, VPInstruction::BranchOnCond>
m_BranchOnCond(const Op0_t &Op0) {
  return m_VPInstruction<VPInstruction::BranchOnCond>(Op0);
}

template <typename Op0_t, typename Op1_t>
inline BinaryVPInstruction_match<Op0_t, Op1_t, VPInstruction::ActiveLaneMask>
m_ActiveLaneMask(const Op0_t &Op0, const Op1_t &Op1) {
  return m_VPInstruction<VPInstruction::ActiveLaneMask>(Op0, Op1);
}

template <typename Op0_t, typename Op1_t>
inline BinaryVPInstruction_match<Op0_t, Op1_t, VPInstruction::BranchOnCount>
m_BranchOnCount(const Op0_t &Op0, const Op1_t &Op1) {
  return m_VPInstruction<VPInstruction::BranchOnCount>(Op0, Op1);
}

template <unsigned Opcode, typename Op0_t>
inline AllUnaryRecipe_match<Op0_t, Opcode> m_Unary(const Op0_t &Op0) {
  return AllUnaryRecipe_match<Op0_t, Opcode>(Op0);
}

template <typename Op0_t>
inline AllUnaryRecipe_match<Op0_t, Instruction::Trunc>
m_Trunc(const Op0_t &Op0) {
  return m_Unary<Instruction::Trunc, Op0_t>(Op0);
}

template <typename Op0_t>
inline AllUnaryRecipe_match<Op0_t, Instruction::ZExt> m_ZExt(const Op0_t &Op0) {
  return m_Unary<Instruction::ZExt, Op0_t>(Op0);
}

template <typename Op0_t>
inline AllUnaryRecipe_match<Op0_t, Instruction::SExt> m_SExt(const Op0_t &Op0) {
  return m_Unary<Instruction::SExt, Op0_t>(Op0);
}

template <typename Op0_t>
inline match_combine_or<AllUnaryRecipe_match<Op0_t, Instruction::ZExt>,
                        AllUnaryRecipe_match<Op0_t, Instruction::SExt>>
m_ZExtOrSExt(const Op0_t &Op0) {
  return m_CombineOr(m_ZExt(Op0), m_SExt(Op0));
}

template <unsigned Opcode, typename Op0_t, typename Op1_t,
          bool Commutative = false>
inline AllBinaryRecipe_match<Op0_t, Op1_t, Opcode, Commutative>
m_Binary(const Op0_t &Op0, const Op1_t &Op1) {
  return AllBinaryRecipe_match<Op0_t, Op1_t, Opcode, Commutative>(Op0, Op1);
}

template <unsigned Opcode, typename Op0_t, typename Op1_t>
inline AllBinaryRecipe_match<Op0_t, Op1_t, Opcode, true>
m_c_Binary(const Op0_t &Op0, const Op1_t &Op1) {
  return AllBinaryRecipe_match<Op0_t, Op1_t, Opcode, true>(Op0, Op1);
}

template <typename Op0_t, typename Op1_t>
inline AllBinaryRecipe_match<Op0_t, Op1_t, Instruction::Mul>
m_Mul(const Op0_t &Op0, const Op1_t &Op1) {
  return m_Binary<Instruction::Mul, Op0_t, Op1_t>(Op0, Op1);
}

template <typename Op0_t, typename Op1_t>
inline AllBinaryRecipe_match<Op0_t, Op1_t, Instruction::Mul,
                             /* Commutative =*/true>
m_c_Mul(const Op0_t &Op0, const Op1_t &Op1) {
  return m_Binary<Instruction::Mul, Op0_t, Op1_t, true>(Op0, Op1);
}

/// Match a binary OR operation. Note that while conceptually the operands can
/// be matched commutatively, \p Commutative defaults to false in line with the
/// IR-based pattern matching infrastructure. Use m_c_BinaryOr for a commutative
/// version of the matcher.
template <typename Op0_t, typename Op1_t, bool Commutative = false>
inline AllBinaryRecipe_match<Op0_t, Op1_t, Instruction::Or, Commutative>
m_BinaryOr(const Op0_t &Op0, const Op1_t &Op1) {
  return m_Binary<Instruction::Or, Op0_t, Op1_t, Commutative>(Op0, Op1);
}

template <typename Op0_t, typename Op1_t>
inline AllBinaryRecipe_match<Op0_t, Op1_t, Instruction::Or,
                             /*Commutative*/ true>
m_c_BinaryOr(const Op0_t &Op0, const Op1_t &Op1) {
  return m_BinaryOr<Op0_t, Op1_t, /*Commutative*/ true>(Op0, Op1);
}

template <typename Op0_t, typename Op1_t>
using GEPLikeRecipe_match =
    BinaryRecipe_match<Op0_t, Op1_t, Instruction::GetElementPtr, false,
                       VPWidenRecipe, VPReplicateRecipe, VPWidenGEPRecipe,
                       VPInstruction>;

template <typename Op0_t, typename Op1_t>
inline GEPLikeRecipe_match<Op0_t, Op1_t> m_GetElementPtr(const Op0_t &Op0,
                                                         const Op1_t &Op1) {
  return GEPLikeRecipe_match<Op0_t, Op1_t>(Op0, Op1);
}

template <typename Op0_t, typename Op1_t, typename Op2_t, unsigned Opcode>
using AllTernaryRecipe_match =
    Recipe_match<std::tuple<Op0_t, Op1_t, Op2_t>, Opcode, false,
                 VPReplicateRecipe, VPInstruction, VPWidenSelectRecipe>;

template <typename Op0_t, typename Op1_t, typename Op2_t>
inline AllTernaryRecipe_match<Op0_t, Op1_t, Op2_t, Instruction::Select>
m_Select(const Op0_t &Op0, const Op1_t &Op1, const Op2_t &Op2) {
  return AllTernaryRecipe_match<Op0_t, Op1_t, Op2_t, Instruction::Select>(
      {Op0, Op1, Op2});
}

template <typename Op0_t, typename Op1_t>
inline match_combine_or<
    BinaryVPInstruction_match<Op0_t, Op1_t, VPInstruction::LogicalAnd>,
    AllTernaryRecipe_match<Op0_t, Op1_t, specific_intval<1>,
                           Instruction::Select>>
m_LogicalAnd(const Op0_t &Op0, const Op1_t &Op1) {
  return m_CombineOr(
      m_VPInstruction<VPInstruction::LogicalAnd, Op0_t, Op1_t>(Op0, Op1),
      m_Select(Op0, Op1, m_False()));
}

template <typename Op0_t, typename Op1_t>
inline AllTernaryRecipe_match<Op0_t, specific_intval<1>, Op1_t,
                              Instruction::Select>
m_LogicalOr(const Op0_t &Op0, const Op1_t &Op1) {
  return m_Select(Op0, m_True(), Op1);
}

using VPCanonicalIVPHI_match =
    Recipe_match<std::tuple<>, 0, false, VPCanonicalIVPHIRecipe>;

inline VPCanonicalIVPHI_match m_CanonicalIV() {
  return VPCanonicalIVPHI_match();
}

template <typename Op0_t, typename Op1_t>
using VPScalarIVSteps_match =
    Recipe_match<std::tuple<Op0_t, Op1_t>, 0, false, VPScalarIVStepsRecipe>;

template <typename Op0_t, typename Op1_t>
inline VPScalarIVSteps_match<Op0_t, Op1_t> m_ScalarIVSteps(const Op0_t &Op0,
                                                           const Op1_t &Op1) {
  return VPScalarIVSteps_match<Op0_t, Op1_t>(Op0, Op1);
}

template <typename Op0_t, typename Op1_t, typename Op2_t>
using VPDerivedIV_match =
    Recipe_match<std::tuple<Op0_t, Op1_t, Op2_t>, 0, false, VPDerivedIVRecipe>;

template <typename Op0_t, typename Op1_t, typename Op2_t>
inline VPDerivedIV_match<Op0_t, Op1_t, Op2_t>
m_DerivedIV(const Op0_t &Op0, const Op1_t &Op1, const Op2_t &Op2) {
  return VPDerivedIV_match<Op0_t, Op1_t, Op2_t>({Op0, Op1, Op2});
}

} // namespace VPlanPatternMatch
} // namespace llvm

#endif