; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-eabi %s -o - | FileCheck %s

define i32 @test(i32 %a) {
; CHECK-LABEL: test:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    add w0, w0, #193
; CHECK-NEXT:    ret
entry:
  %add = add i32 %a, 1
  %or1 = or disjoint i32 %add, 64
  %or = or disjoint i32 %or1, 128
  ret i32 %or
}