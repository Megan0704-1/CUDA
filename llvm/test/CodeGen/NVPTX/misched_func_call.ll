; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -O3 -mtriple=nvptx64 -enable-misched %s -o - | FileCheck %s

target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define ptx_kernel void @wombat(i32 %arg, i32 %arg1, i32 %arg2) {
; CHECK-LABEL: wombat(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<11>;
; CHECK-NEXT:    .reg .b64 %rd<2>;
; CHECK-NEXT:    .reg .f64 %fd<6>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0: // %bb
; CHECK-NEXT:    ld.param.u32 %r4, [wombat_param_2];
; CHECK-NEXT:    ld.param.u32 %r3, [wombat_param_1];
; CHECK-NEXT:    ld.param.u32 %r2, [wombat_param_0];
; CHECK-NEXT:    mov.b32 %r10, 0;
; CHECK-NEXT:  $L__BB0_1: // %bb3
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    { // callseq 0, 0
; CHECK-NEXT:    .param .b64 param0;
; CHECK-NEXT:    st.param.f64 [param0], 0d0000000000000000;
; CHECK-NEXT:    .param .b64 retval0;
; CHECK-NEXT:    call.uni (retval0),
; CHECK-NEXT:    quux,
; CHECK-NEXT:    (
; CHECK-NEXT:    param0
; CHECK-NEXT:    );
; CHECK-NEXT:    ld.param.f64 %fd1, [retval0];
; CHECK-NEXT:    } // callseq 0
; CHECK-NEXT:    mul.lo.s32 %r7, %r10, %r3;
; CHECK-NEXT:    or.b32 %r8, %r4, %r7;
; CHECK-NEXT:    mul.lo.s32 %r9, %r2, %r8;
; CHECK-NEXT:    cvt.rn.f64.s32 %fd3, %r9;
; CHECK-NEXT:    cvt.rn.f64.u32 %fd4, %r10;
; CHECK-NEXT:    add.rn.f64 %fd5, %fd4, %fd3;
; CHECK-NEXT:    mov.b64 %rd1, 0;
; CHECK-NEXT:    st.global.f64 [%rd1], %fd5;
; CHECK-NEXT:    mov.b32 %r10, 1;
; CHECK-NEXT:    bra.uni $L__BB0_1;
bb:
  br label %bb3

bb3:                                              ; preds = %bb3, %bb
  %phi = phi i32 [ 0, %bb ], [ 1, %bb3 ]
  %call = tail call double @quux(double 0.000000e+00)
  %mul = mul i32 %phi, %arg1
  %or = or i32 %arg2, %mul
  %mul4 = mul i32 %arg, %or
  %sitofp = sitofp i32 %mul4 to double
  %uitofp = uitofp i32 %phi to double
  %fadd = fadd double %uitofp, %sitofp
  store double %fadd, ptr addrspace(1) null, align 8
  br label %bb3
}

declare double @quux(double)