; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=nvptx64 -mattr=+ptx73 -mcpu=sm_52 | FileCheck %s

target triple = "nvptx64-nvidia-cuda"

define void @foo(i64 %a, ptr %p0, ptr %p1) {
; CHECK-LABEL: foo(
; CHECK:       {
; CHECK-NEXT:    .reg .b64 %rd<8>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u64 %rd1, [foo_param_0];
; CHECK-NEXT:    add.s64 %rd2, %rd1, 7;
; CHECK-NEXT:    and.b64 %rd3, %rd2, -8;
; CHECK-NEXT:    alloca.u64 %rd4, %rd3, 16;
; CHECK-NEXT:    cvta.local.u64 %rd4, %rd4;
; CHECK-NEXT:    ld.param.u64 %rd5, [foo_param_1];
; CHECK-NEXT:    alloca.u64 %rd6, %rd3, 16;
; CHECK-NEXT:    cvta.local.u64 %rd6, %rd6;
; CHECK-NEXT:    ld.param.u64 %rd7, [foo_param_2];
; CHECK-NEXT:    st.u64 [%rd5], %rd4;
; CHECK-NEXT:    st.u64 [%rd7], %rd6;
; CHECK-NEXT:    ret;
  %b = alloca i8, i64 %a, align 16
  %c = alloca i8, i64 %a, align 16
  store ptr %b, ptr %p0, align 8
  store ptr %c, ptr %p1, align 8
  ret void
}