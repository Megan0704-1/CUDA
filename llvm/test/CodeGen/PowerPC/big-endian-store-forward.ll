; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=powerpc64-unknown-linux-gnu < %s | FileCheck %s

; The load is to the high byte of the 2-byte store
@g = global i8 -75

define void @f(i16 %v) {
; CHECK-LABEL: f:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addis 4, 2, .LC0@toc@ha
; CHECK-NEXT:    sth 3, -2(1)
; CHECK-NEXT:    ld 4, .LC0@toc@l(4)
; CHECK-NEXT:    lbz 3, -2(1)
; CHECK-NEXT:    stb 3, 0(4)
; CHECK-NEXT:    blr
  %p32 = alloca i16
  store i16 %v, ptr %p32
  %tmp = load i8, ptr %p32
  store i8 %tmp, ptr @g
  ret void
}