; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5

; RUN: llc -mtriple=riscv32 -mattr=+f -global-isel \
; RUN:   < %s | FileCheck %s --check-prefixes=CHECK
; RUN: llc -mtriple=riscv64 -mattr=+f -global-isel \
; RUN:   < %s | FileCheck %s --check-prefixes=CHECK

define i1 @fpclass(ptr %x) {
; CHECK-LABEL: fpclass:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flw fa5, 0(a0)
; CHECK-NEXT:    fclass.s a0, fa5
; CHECK-NEXT:    andi a0, a0, 927
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    ret
  %a = load float, ptr %x
  %cmp = call i1 @llvm.is.fpclass.f32(float %a, i32 639)
  ret i1 %cmp
}