; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z16 | FileCheck %s
;
; Test that SystemZTargetLowering::combineSTORE() does not crash on a
; truncated immediate.

@G1 = external global i64, align 8
@G2 = external global i64, align 8

define void @func_5(ptr %Dst) {
; CHECK-LABEL: func_5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lgrl %r1, G2@GOT
; CHECK-NEXT:    llihl %r0, 50
; CHECK-NEXT:    oill %r0, 2
; CHECK-NEXT:    stg %r0, 0(%r1)
; CHECK-NEXT:    lgrl %r1, G1@GOT
; CHECK-NEXT:    stg %r0, 0(%r1)
; CHECK-NEXT:    mvhi 0(%r2), 2
; CHECK-NEXT:    br %r14
  store i64 214748364802, ptr @G2, align 8
  store i64 214748364802, ptr @G1, align 8
  %1 = load i32, ptr getelementptr inbounds (i8, ptr @G1, i64 4), align 4
  store i32 %1, ptr %Dst, align 4
  ret void
}