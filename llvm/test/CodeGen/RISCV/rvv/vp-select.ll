; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=riscv64 -mattr=+v -verify-machineinstrs | FileCheck %s

define <vscale x 1 x i64> @all_ones(<vscale x 1 x i64> %true, <vscale x 1 x i64> %false, i32 %evl) {
; CHECK-LABEL: all_ones:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i64> @llvm.vp.select.nxv1i64(<vscale x 1 x i1> splat (i1 true), <vscale x 1 x i64> %true, <vscale x 1 x i64> %false, i32 %evl)
  ret <vscale x 1 x i64> %v
}

define <vscale x 1 x i64> @all_zeroes(<vscale x 1 x i64> %true, <vscale x 1 x i64> %false, i32 %evl) {
; CHECK-LABEL: all_zeroes:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i64> @llvm.vp.select.nxv1i64(<vscale x 1 x i1> splat (i1 false), <vscale x 1 x i64> %true, <vscale x 1 x i64> %false, i32 %evl)
  ret <vscale x 1 x i64> %v
}