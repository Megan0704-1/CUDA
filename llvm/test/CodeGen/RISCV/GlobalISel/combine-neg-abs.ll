; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -global-isel -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=RV32I
; RUN: llc -mtriple=riscv32 -global-isel -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=RV32ZBB
; RUN: llc -mtriple=riscv64 -global-isel -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=RV64I
; RUN: llc -mtriple=riscv64 -global-isel -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=RV64ZBB

define i32 @expanded_neg_abs32(i32 %x) {
; RV32I-LABEL: expanded_neg_abs32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a1, a0
; RV32I-NEXT:    blt a0, a1, .LBB0_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    neg a0, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: expanded_neg_abs32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    neg a1, a0
; RV32ZBB-NEXT:    min a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV64I-LABEL: expanded_neg_abs32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    negw a1, a0
; RV64I-NEXT:    sext.w a2, a0
; RV64I-NEXT:    blt a2, a1, .LBB0_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB0_2:
; RV64I-NEXT:    negw a0, a1
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: expanded_neg_abs32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    negw a1, a0
; RV64ZBB-NEXT:    sext.w a0, a0
; RV64ZBB-NEXT:    max a0, a1, a0
; RV64ZBB-NEXT:    negw a0, a0
; RV64ZBB-NEXT:    ret
  %n = sub i32 0, %x
  %t = call i32 @llvm.smax.i32(i32 %n, i32 %x)
  %r = sub i32 0, %t
  ret i32 %r
}

define i32 @expanded_neg_abs32_unsigned(i32 %x) {
; RV32I-LABEL: expanded_neg_abs32_unsigned:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a1, a0
; RV32I-NEXT:    bltu a0, a1, .LBB1_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:  .LBB1_2:
; RV32I-NEXT:    neg a0, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: expanded_neg_abs32_unsigned:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    neg a1, a0
; RV32ZBB-NEXT:    minu a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV64I-LABEL: expanded_neg_abs32_unsigned:
; RV64I:       # %bb.0:
; RV64I-NEXT:    negw a1, a0
; RV64I-NEXT:    sext.w a2, a0
; RV64I-NEXT:    bltu a2, a1, .LBB1_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB1_2:
; RV64I-NEXT:    negw a0, a1
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: expanded_neg_abs32_unsigned:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    negw a1, a0
; RV64ZBB-NEXT:    sext.w a0, a0
; RV64ZBB-NEXT:    maxu a0, a1, a0
; RV64ZBB-NEXT:    negw a0, a0
; RV64ZBB-NEXT:    ret
  %n = sub i32 0, %x
  %t = call i32 @llvm.umax.i32(i32 %n, i32 %x)
  %r = sub i32 0, %t
  ret i32 %r
}

define i64 @expanded_neg_abs64(i64 %x) {
; RV32I-LABEL: expanded_neg_abs64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    snez a2, a0
; RV32I-NEXT:    neg a3, a1
; RV32I-NEXT:    sub a2, a3, a2
; RV32I-NEXT:    neg a3, a0
; RV32I-NEXT:    beq a2, a1, .LBB2_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    slt a4, a1, a2
; RV32I-NEXT:    beqz a4, .LBB2_3
; RV32I-NEXT:    j .LBB2_4
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    sltu a4, a0, a3
; RV32I-NEXT:    bnez a4, .LBB2_4
; RV32I-NEXT:  .LBB2_3:
; RV32I-NEXT:    mv a3, a0
; RV32I-NEXT:    mv a2, a1
; RV32I-NEXT:  .LBB2_4:
; RV32I-NEXT:    neg a0, a3
; RV32I-NEXT:    snez a1, a3
; RV32I-NEXT:    neg a2, a2
; RV32I-NEXT:    sub a1, a2, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: expanded_neg_abs64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    snez a2, a0
; RV32ZBB-NEXT:    neg a3, a1
; RV32ZBB-NEXT:    sub a2, a3, a2
; RV32ZBB-NEXT:    neg a3, a0
; RV32ZBB-NEXT:    beq a2, a1, .LBB2_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    slt a4, a1, a2
; RV32ZBB-NEXT:    beqz a4, .LBB2_3
; RV32ZBB-NEXT:    j .LBB2_4
; RV32ZBB-NEXT:  .LBB2_2:
; RV32ZBB-NEXT:    sltu a4, a0, a3
; RV32ZBB-NEXT:    bnez a4, .LBB2_4
; RV32ZBB-NEXT:  .LBB2_3:
; RV32ZBB-NEXT:    mv a3, a0
; RV32ZBB-NEXT:    mv a2, a1
; RV32ZBB-NEXT:  .LBB2_4:
; RV32ZBB-NEXT:    neg a0, a3
; RV32ZBB-NEXT:    snez a1, a3
; RV32ZBB-NEXT:    neg a2, a2
; RV32ZBB-NEXT:    sub a1, a2, a1
; RV32ZBB-NEXT:    ret
;
; RV64I-LABEL: expanded_neg_abs64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a1, a0
; RV64I-NEXT:    blt a0, a1, .LBB2_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB2_2:
; RV64I-NEXT:    neg a0, a1
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: expanded_neg_abs64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    neg a1, a0
; RV64ZBB-NEXT:    min a0, a0, a1
; RV64ZBB-NEXT:    ret
  %n = sub i64 0, %x
  %t = call i64 @llvm.smax.i64(i64 %n, i64 %x)
  %r = sub i64 0, %t
  ret i64 %r
}

define i64 @expanded_neg_abs64_unsigned(i64 %x) {
; RV32I-LABEL: expanded_neg_abs64_unsigned:
; RV32I:       # %bb.0:
; RV32I-NEXT:    snez a2, a0
; RV32I-NEXT:    neg a3, a1
; RV32I-NEXT:    sub a2, a3, a2
; RV32I-NEXT:    neg a3, a0
; RV32I-NEXT:    beq a2, a1, .LBB3_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sltu a4, a1, a2
; RV32I-NEXT:    beqz a4, .LBB3_3
; RV32I-NEXT:    j .LBB3_4
; RV32I-NEXT:  .LBB3_2:
; RV32I-NEXT:    sltu a4, a0, a3
; RV32I-NEXT:    bnez a4, .LBB3_4
; RV32I-NEXT:  .LBB3_3:
; RV32I-NEXT:    mv a3, a0
; RV32I-NEXT:    mv a2, a1
; RV32I-NEXT:  .LBB3_4:
; RV32I-NEXT:    neg a0, a3
; RV32I-NEXT:    snez a1, a3
; RV32I-NEXT:    neg a2, a2
; RV32I-NEXT:    sub a1, a2, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: expanded_neg_abs64_unsigned:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    snez a2, a0
; RV32ZBB-NEXT:    neg a3, a1
; RV32ZBB-NEXT:    sub a2, a3, a2
; RV32ZBB-NEXT:    neg a3, a0
; RV32ZBB-NEXT:    beq a2, a1, .LBB3_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    sltu a4, a1, a2
; RV32ZBB-NEXT:    beqz a4, .LBB3_3
; RV32ZBB-NEXT:    j .LBB3_4
; RV32ZBB-NEXT:  .LBB3_2:
; RV32ZBB-NEXT:    sltu a4, a0, a3
; RV32ZBB-NEXT:    bnez a4, .LBB3_4
; RV32ZBB-NEXT:  .LBB3_3:
; RV32ZBB-NEXT:    mv a3, a0
; RV32ZBB-NEXT:    mv a2, a1
; RV32ZBB-NEXT:  .LBB3_4:
; RV32ZBB-NEXT:    neg a0, a3
; RV32ZBB-NEXT:    snez a1, a3
; RV32ZBB-NEXT:    neg a2, a2
; RV32ZBB-NEXT:    sub a1, a2, a1
; RV32ZBB-NEXT:    ret
;
; RV64I-LABEL: expanded_neg_abs64_unsigned:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a1, a0
; RV64I-NEXT:    bltu a0, a1, .LBB3_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB3_2:
; RV64I-NEXT:    neg a0, a1
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: expanded_neg_abs64_unsigned:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    neg a1, a0
; RV64ZBB-NEXT:    minu a0, a0, a1
; RV64ZBB-NEXT:    ret
  %n = sub i64 0, %x
  %t = call i64 @llvm.umax.i64(i64 %n, i64 %x)
  %r = sub i64 0, %t
  ret i64 %r
}

define i32 @expanded_neg_inv_abs32(i32 %x) {
; RV32I-LABEL: expanded_neg_inv_abs32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a1, a0
; RV32I-NEXT:    blt a1, a0, .LBB4_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:  .LBB4_2:
; RV32I-NEXT:    neg a0, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: expanded_neg_inv_abs32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    neg a1, a0
; RV32ZBB-NEXT:    max a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV64I-LABEL: expanded_neg_inv_abs32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    negw a1, a0
; RV64I-NEXT:    sext.w a2, a0
; RV64I-NEXT:    blt a1, a2, .LBB4_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB4_2:
; RV64I-NEXT:    negw a0, a1
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: expanded_neg_inv_abs32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    negw a1, a0
; RV64ZBB-NEXT:    sext.w a0, a0
; RV64ZBB-NEXT:    min a0, a1, a0
; RV64ZBB-NEXT:    negw a0, a0
; RV64ZBB-NEXT:    ret
  %n = sub i32 0, %x
  %t = call i32 @llvm.smin.i32(i32 %n, i32 %x)
  %r = sub i32 0, %t
  ret i32 %r
}

define i32 @expanded_neg_inv_abs32_unsigned(i32 %x) {
; RV32I-LABEL: expanded_neg_inv_abs32_unsigned:
; RV32I:       # %bb.0:
; RV32I-NEXT:    neg a1, a0
; RV32I-NEXT:    bltu a1, a0, .LBB5_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:  .LBB5_2:
; RV32I-NEXT:    neg a0, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: expanded_neg_inv_abs32_unsigned:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    neg a1, a0
; RV32ZBB-NEXT:    maxu a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV64I-LABEL: expanded_neg_inv_abs32_unsigned:
; RV64I:       # %bb.0:
; RV64I-NEXT:    negw a1, a0
; RV64I-NEXT:    sext.w a2, a0
; RV64I-NEXT:    bltu a1, a2, .LBB5_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB5_2:
; RV64I-NEXT:    negw a0, a1
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: expanded_neg_inv_abs32_unsigned:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    negw a1, a0
; RV64ZBB-NEXT:    sext.w a0, a0
; RV64ZBB-NEXT:    minu a0, a1, a0
; RV64ZBB-NEXT:    negw a0, a0
; RV64ZBB-NEXT:    ret
  %n = sub i32 0, %x
  %t = call i32 @llvm.umin.i32(i32 %n, i32 %x)
  %r = sub i32 0, %t
  ret i32 %r
}

define i64 @expanded_neg_inv_abs64(i64 %x) {
; RV32I-LABEL: expanded_neg_inv_abs64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    snez a2, a0
; RV32I-NEXT:    neg a3, a1
; RV32I-NEXT:    sub a2, a3, a2
; RV32I-NEXT:    neg a3, a0
; RV32I-NEXT:    beq a2, a1, .LBB6_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    slt a4, a2, a1
; RV32I-NEXT:    beqz a4, .LBB6_3
; RV32I-NEXT:    j .LBB6_4
; RV32I-NEXT:  .LBB6_2:
; RV32I-NEXT:    sltu a4, a3, a0
; RV32I-NEXT:    bnez a4, .LBB6_4
; RV32I-NEXT:  .LBB6_3:
; RV32I-NEXT:    mv a3, a0
; RV32I-NEXT:    mv a2, a1
; RV32I-NEXT:  .LBB6_4:
; RV32I-NEXT:    neg a0, a3
; RV32I-NEXT:    snez a1, a3
; RV32I-NEXT:    neg a2, a2
; RV32I-NEXT:    sub a1, a2, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: expanded_neg_inv_abs64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    snez a2, a0
; RV32ZBB-NEXT:    neg a3, a1
; RV32ZBB-NEXT:    sub a2, a3, a2
; RV32ZBB-NEXT:    neg a3, a0
; RV32ZBB-NEXT:    beq a2, a1, .LBB6_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    slt a4, a2, a1
; RV32ZBB-NEXT:    beqz a4, .LBB6_3
; RV32ZBB-NEXT:    j .LBB6_4
; RV32ZBB-NEXT:  .LBB6_2:
; RV32ZBB-NEXT:    sltu a4, a3, a0
; RV32ZBB-NEXT:    bnez a4, .LBB6_4
; RV32ZBB-NEXT:  .LBB6_3:
; RV32ZBB-NEXT:    mv a3, a0
; RV32ZBB-NEXT:    mv a2, a1
; RV32ZBB-NEXT:  .LBB6_4:
; RV32ZBB-NEXT:    neg a0, a3
; RV32ZBB-NEXT:    snez a1, a3
; RV32ZBB-NEXT:    neg a2, a2
; RV32ZBB-NEXT:    sub a1, a2, a1
; RV32ZBB-NEXT:    ret
;
; RV64I-LABEL: expanded_neg_inv_abs64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a1, a0
; RV64I-NEXT:    blt a1, a0, .LBB6_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB6_2:
; RV64I-NEXT:    neg a0, a1
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: expanded_neg_inv_abs64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    neg a1, a0
; RV64ZBB-NEXT:    max a0, a0, a1
; RV64ZBB-NEXT:    ret
  %n = sub i64 0, %x
  %t = call i64 @llvm.smin.i64(i64 %n, i64 %x)
  %r = sub i64 0, %t
  ret i64 %r
}

define i64 @expanded_neg_inv_abs64_unsigned(i64 %x) {
; RV32I-LABEL: expanded_neg_inv_abs64_unsigned:
; RV32I:       # %bb.0:
; RV32I-NEXT:    snez a2, a0
; RV32I-NEXT:    neg a3, a1
; RV32I-NEXT:    sub a2, a3, a2
; RV32I-NEXT:    neg a3, a0
; RV32I-NEXT:    beq a2, a1, .LBB7_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sltu a4, a2, a1
; RV32I-NEXT:    beqz a4, .LBB7_3
; RV32I-NEXT:    j .LBB7_4
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    sltu a4, a3, a0
; RV32I-NEXT:    bnez a4, .LBB7_4
; RV32I-NEXT:  .LBB7_3:
; RV32I-NEXT:    mv a3, a0
; RV32I-NEXT:    mv a2, a1
; RV32I-NEXT:  .LBB7_4:
; RV32I-NEXT:    neg a0, a3
; RV32I-NEXT:    snez a1, a3
; RV32I-NEXT:    neg a2, a2
; RV32I-NEXT:    sub a1, a2, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: expanded_neg_inv_abs64_unsigned:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    snez a2, a0
; RV32ZBB-NEXT:    neg a3, a1
; RV32ZBB-NEXT:    sub a2, a3, a2
; RV32ZBB-NEXT:    neg a3, a0
; RV32ZBB-NEXT:    beq a2, a1, .LBB7_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    sltu a4, a2, a1
; RV32ZBB-NEXT:    beqz a4, .LBB7_3
; RV32ZBB-NEXT:    j .LBB7_4
; RV32ZBB-NEXT:  .LBB7_2:
; RV32ZBB-NEXT:    sltu a4, a3, a0
; RV32ZBB-NEXT:    bnez a4, .LBB7_4
; RV32ZBB-NEXT:  .LBB7_3:
; RV32ZBB-NEXT:    mv a3, a0
; RV32ZBB-NEXT:    mv a2, a1
; RV32ZBB-NEXT:  .LBB7_4:
; RV32ZBB-NEXT:    neg a0, a3
; RV32ZBB-NEXT:    snez a1, a3
; RV32ZBB-NEXT:    neg a2, a2
; RV32ZBB-NEXT:    sub a1, a2, a1
; RV32ZBB-NEXT:    ret
;
; RV64I-LABEL: expanded_neg_inv_abs64_unsigned:
; RV64I:       # %bb.0:
; RV64I-NEXT:    neg a1, a0
; RV64I-NEXT:    bltu a1, a0, .LBB7_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB7_2:
; RV64I-NEXT:    neg a0, a1
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: expanded_neg_inv_abs64_unsigned:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    neg a1, a0
; RV64ZBB-NEXT:    maxu a0, a0, a1
; RV64ZBB-NEXT:    ret
  %n = sub i64 0, %x
  %t = call i64 @llvm.umin.i64(i64 %n, i64 %x)
  %r = sub i64 0, %t
  ret i64 %r
}