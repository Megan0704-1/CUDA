; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=vector-combine -S -mtriple=aarch64-- | FileCheck %s --check-prefixes=CHECK

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

; This test checks we are not crashing with TTI when trying to get shuffle cost.
; This test also check that shuffle mask <vscale x 4 x i32> zeroinitializer is
; not narrowed into <0, 1, 0, 1, ...>, which we cannot reason if it's a valid
; splat or not.

define <vscale x 8 x i16> @bitcast_shuffle(<vscale x 4 x i32> %a) {
; CHECK-LABEL: @bitcast_shuffle(
; CHECK-NEXT:    [[I:%.*]] = shufflevector <vscale x 4 x i32> [[A:%.*]], <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    [[R:%.*]] = bitcast <vscale x 4 x i32> [[I]] to <vscale x 8 x i16>
; CHECK-NEXT:    ret <vscale x 8 x i16> [[R]]
;
  %i = shufflevector <vscale x 4 x i32> %a, <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer
  %r = bitcast <vscale x 4 x i32> %i to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %r
}