; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=riscv64 -mattr=+m | FileCheck %s

define signext i8 @trunc_nsw_add(i32 signext %x) nounwind {
; CHECK-LABEL: trunc_nsw_add:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addiw a0, a0, 1
; CHECK-NEXT:    ret
entry:
  %add = add nsw i32 %x, 1
  %trunc = trunc nsw i32 %add to i8
  ret i8 %trunc
}

define signext i32 @trunc_nuw_nsw_urem(i64 %x) nounwind {
; CHECK-LABEL: trunc_nuw_nsw_urem:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a1, 210
; CHECK-NEXT:    lui a2, 2
; CHECK-NEXT:    addiw a1, a1, -1167
; CHECK-NEXT:    slli a1, a1, 12
; CHECK-NEXT:    addi a1, a1, 1881
; CHECK-NEXT:    mul a1, a0, a1
; CHECK-NEXT:    srli a1, a1, 45
; CHECK-NEXT:    addi a2, a2, 1808
; CHECK-NEXT:    mul a1, a1, a2
; CHECK-NEXT:    subw a0, a0, a1
; CHECK-NEXT:    ret
entry:
  %trunc = trunc nuw nsw i64 %x to i32
  %rem = urem i32 %trunc, 10000
  ret i32 %rem
}

define i64 @zext_nneg_udiv_trunc_nuw(i64 %x) nounwind {
; CHECK-LABEL: zext_nneg_udiv_trunc_nuw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a1, 13
; CHECK-NEXT:    addi a1, a1, -819
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    srliw a0, a0, 23
; CHECK-NEXT:    ret
entry:
  %trunc = trunc nuw i64 %x to i16
  %div = udiv i16 %trunc, 160
  %ext = zext nneg i16 %div to i64
  ret i64 %ext
}

define i64 @sext_udiv_trunc_nuw(i64 %x) nounwind {
; CHECK-LABEL: sext_udiv_trunc_nuw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a1, 13
; CHECK-NEXT:    addi a1, a1, -819
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    srliw a0, a0, 23
; CHECK-NEXT:    ret
entry:
  %trunc = trunc nuw i64 %x to i16
  %div = udiv i16 %trunc, 160
  %ext = sext i16 %div to i64
  ret i64 %ext
}

define ptr @gep_nusw_zext_nneg_add_trunc_nuw_nsw(ptr %p, i64 %x) nounwind {
; CHECK-LABEL: gep_nusw_zext_nneg_add_trunc_nuw_nsw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    addi a0, a0, 20
; CHECK-NEXT:    ret
entry:
  %trunc = trunc nuw nsw i64 %x to i32
  %add = add nuw nsw i32 %trunc, 5
  %offset = zext nneg i32 %add to i64
  %gep = getelementptr nusw float, ptr %p, i64 %offset
  ret ptr %gep
}