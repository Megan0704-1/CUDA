; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=riscv64 -mattr=+a | FileCheck %s

define ptr @cmpxchg_masked_and_branch1(ptr %ptr, i8 signext %cmp, i8 signext %val) nounwind {
; CHECK-LABEL: cmpxchg_masked_and_branch1:
; CHECK:       # %bb.0: # %do_cmpxchg
; CHECK-NEXT:    andi a3, a0, -4
; CHECK-NEXT:    slli a4, a0, 3
; CHECK-NEXT:    li a5, 255
; CHECK-NEXT:    andi a1, a1, 255
; CHECK-NEXT:    andi a2, a2, 255
; CHECK-NEXT:    sllw a5, a5, a4
; CHECK-NEXT:    sllw a1, a1, a4
; CHECK-NEXT:    sllw a2, a2, a4
; CHECK-NEXT:  .LBB0_3: # %do_cmpxchg
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    lr.w.aqrl a4, (a3)
; CHECK-NEXT:    and a6, a4, a5
; CHECK-NEXT:    bne a6, a1, .LBB0_5
; CHECK-NEXT:  # %bb.4: # %do_cmpxchg
; CHECK-NEXT:    # in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    xor a6, a4, a2
; CHECK-NEXT:    and a6, a6, a5
; CHECK-NEXT:    xor a6, a4, a6
; CHECK-NEXT:    sc.w.rl a6, a6, (a3)
; CHECK-NEXT:    bnez a6, .LBB0_3
; CHECK-NEXT:  .LBB0_5: # %do_cmpxchg
; CHECK-NEXT:    and a2, a4, a5
; CHECK-NEXT:    bne a1, a2, .LBB0_2
; CHECK-NEXT:  # %bb.1: # %returnptr
; CHECK-NEXT:    xor a1, a1, a2
; CHECK-NEXT:    snez a1, a1
; CHECK-NEXT:    addi a1, a1, -1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB0_2: # %exit
; CHECK-NEXT:    li a0, 0
; CHECK-NEXT:    ret
do_cmpxchg:
  %0 = cmpxchg ptr %ptr, i8 %cmp, i8 %val seq_cst seq_cst
  %1 = extractvalue { i8, i1 } %0, 1
  %2 = select i1 %1, ptr %ptr, ptr null
  br i1 %1, label %returnptr, label %exit
returnptr:
  ret ptr %2
exit:
  ret ptr null
}