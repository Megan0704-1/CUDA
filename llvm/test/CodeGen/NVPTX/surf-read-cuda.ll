; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=nvptx64 -mcpu=sm_20 -verify-machineinstrs | FileCheck %s
; RUN: llc < %s -mtriple=nvptx64 -mcpu=sm_30 -verify-machineinstrs | FileCheck %s
; RUN: %if ptxas %{ llc < %s -mtriple=nvptx64 -mcpu=sm_20 -verify-machineinstrs | %ptxas-verify %}
; RUN: %if ptxas %{ llc < %s -mtriple=nvptx64 -mcpu=sm_30 -verify-machineinstrs | %ptxas-verify %}

target triple = "nvptx-unknown-cuda"

declare i32 @llvm.nvvm.suld.1d.i32.trap(i64, i32)
declare i64 @llvm.nvvm.texsurf.handle.internal.p1(ptr addrspace(1))


define ptx_kernel void @foo(i64 %img, ptr %red, i32 %idx) {
; CHECK-LABEL: foo(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<3>;
; CHECK-NEXT:    .reg .f32 %f<2>;
; CHECK-NEXT:    .reg .b64 %rd<4>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u64 %rd1, [foo_param_0];
; CHECK-NEXT:    ld.param.u64 %rd2, [foo_param_1];
; CHECK-NEXT:    cvta.to.global.u64 %rd3, %rd2;
; CHECK-NEXT:    ld.param.u32 %r1, [foo_param_2];
; CHECK-NEXT:    suld.b.1d.b32.trap {%r2}, [%rd1, {%r1}];
; CHECK-NEXT:    cvt.rn.f32.s32 %f1, %r2;
; CHECK-NEXT:    st.global.f32 [%rd3], %f1;
; CHECK-NEXT:    ret;
  %val = tail call i32 @llvm.nvvm.suld.1d.i32.trap(i64 %img, i32 %idx)
  %ret = sitofp i32 %val to float
  store float %ret, ptr %red
  ret void
}

@surf0 = internal addrspace(1) global i64 0, align 8

define ptx_kernel void @bar(ptr %red, i32 %idx) {
; CHECK-LABEL: bar(
; CHECK:       {
; CHECK-NEXT:    .reg .b32 %r<3>;
; CHECK-NEXT:    .reg .f32 %f<2>;
; CHECK-NEXT:    .reg .b64 %rd<4>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u64 %rd1, [bar_param_0];
; CHECK-NEXT:    cvta.to.global.u64 %rd2, %rd1;
; CHECK-NEXT:    ld.param.u32 %r1, [bar_param_1];
; CHECK-NEXT:    suld.b.1d.b32.trap {%r2}, [surf0, {%r1}];
; CHECK-NEXT:    cvt.rn.f32.s32 %f1, %r2;
; CHECK-NEXT:    st.global.f32 [%rd2], %f1;
; CHECK-NEXT:    ret;
  %surfHandle = tail call i64 @llvm.nvvm.texsurf.handle.internal.p1(ptr addrspace(1) @surf0)
  %val = tail call i32 @llvm.nvvm.suld.1d.i32.trap(i64 %surfHandle, i32 %idx)
  %ret = sitofp i32 %val to float
  store float %ret, ptr %red
  ret void
}

!nvvm.annotations = !{!1}
!1 = !{ptr addrspace(1) @surf0, !"surface", i32 1}