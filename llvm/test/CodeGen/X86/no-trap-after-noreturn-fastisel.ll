; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -O0 -trap-unreachable -no-trap-after-noreturn -fast-isel-abort=3 < %s | FileCheck %s

declare void @foo()

define void @noreturn_unreachable() nounwind {
; CHECK-LABEL: noreturn_unreachable:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    callq foo@PLT
  call void @foo() noreturn
  unreachable
}