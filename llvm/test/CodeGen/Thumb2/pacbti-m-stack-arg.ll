; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=thumbv8m.main-none-eabi %s -o - | FileCheck %s

define i32 @test_leaf(i32 %arg0, i32 %arg1, i32 %arg2, i32 %arg3, i32 %x) "sign-return-address"="all" {
; CHECK-LABEL: test_leaf:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    pac r12, lr, sp
; CHECK-NEXT:    .save {ra_auth_code}
; CHECK-NEXT:    str r12, [sp, #-4]!
; CHECK-NEXT:    ldr r0, [sp, #4]
; CHECK-NEXT:    ldr r12, [sp], #4
; CHECK-NEXT:    aut r12, lr, sp
; CHECK-NEXT:    bx lr
entry:
  ret i32 %x
}

define i32 @test_non_leaf(i32 %arg0, i32 %arg1, i32 %arg2, i32 %arg3, i32 %x) "sign-return-address"="all" {
; CHECK-LABEL: test_non_leaf:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    pac r12, lr, sp
; CHECK-NEXT:    .save {r7, ra_auth_code, lr}
; CHECK-NEXT:    push.w {r7, r12, lr}
; CHECK-NEXT:    .pad #4
; CHECK-NEXT:    sub sp, #4
; CHECK-NEXT:    bl otherfn
; CHECK-NEXT:    ldr r0, [sp, #16]
; CHECK-NEXT:    add sp, #4
; CHECK-NEXT:    pop.w {r7, r12, lr}
; CHECK-NEXT:    aut r12, lr, sp
; CHECK-NEXT:    bx lr
entry:
  call void @otherfn()
  ret i32 %x
}

declare void @otherfn(...)

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 8, !"branch-target-enforcement", i32 0}
!1 = !{i32 8, !"sign-return-address", i32 1}
!2 = !{i32 8, !"sign-return-address-all", i32 1}