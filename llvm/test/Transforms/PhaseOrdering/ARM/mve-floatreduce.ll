; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -O3 -S                   | FileCheck %s
; RUN: opt < %s -passes="default<O3>" -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv8.1m.main-none-none-eabi"

define arm_aapcs_vfpcc half @vecAddAcrossF16Mve(<8 x half> %in) #0 {
; CHECK-LABEL: @vecAddAcrossF16Mve(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <8 x half> [[IN:%.*]], <8 x half> poison, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:    [[TMP1:%.*]] = fadd fast <8 x half> [[TMP0]], [[IN]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <8 x half> [[TMP1]] to <4 x i32>
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> poison, <4 x i32> <i32 1, i32 poison, i32 3, i32 poison>
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <4 x i32> [[TMP3]] to <8 x half>
; CHECK-NEXT:    [[TMP5:%.*]] = fadd fast <8 x half> [[TMP1]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <8 x half> [[TMP5]], i64 0
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <8 x half> [[TMP5]], i64 4
; CHECK-NEXT:    [[ADD:%.*]] = fadd fast half [[TMP6]], [[TMP7]]
; CHECK-NEXT:    ret half [[ADD]]
;
entry:
  %0 = shufflevector <8 x half> %in, <8 x half> poison, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %1 = fadd fast <8 x half> %0, %in
  %2 = bitcast <8 x half> %1 to <4 x i32>
  %3 = shufflevector <4 x i32> %2, <4 x i32> poison, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %4 = bitcast <4 x i32> %3 to <8 x half>
  %5 = fadd fast <8 x half> %1, %4
  %6 = extractelement <8 x half> %5, i32 0
  %7 = extractelement <8 x half> %5, i32 4
  %add = fadd fast half %6, %7
  ret half %add
}

define arm_aapcs_vfpcc float @vecAddAcrossF32Mve(<4 x float> %in) {
; CHECK-LABEL: @vecAddAcrossF32Mve(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <4 x float> [[IN:%.*]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <4 x float> [[IN]], i64 1
; CHECK-NEXT:    [[ADD:%.*]] = fadd fast float [[TMP0]], [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <4 x float> [[IN]], i64 2
; CHECK-NEXT:    [[ADD1:%.*]] = fadd fast float [[ADD]], [[TMP2]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x float> [[IN]], i64 3
; CHECK-NEXT:    [[ADD2:%.*]] = fadd fast float [[ADD1]], [[TMP3]]
; CHECK-NEXT:    ret float [[ADD2]]
;
entry:
  %0 = extractelement <4 x float> %in, i32 0
  %1 = extractelement <4 x float> %in, i32 1
  %add = fadd fast float %0, %1
  %2 = extractelement <4 x float> %in, i32 2
  %add1 = fadd fast float %add, %2
  %3 = extractelement <4 x float> %in, i32 3
  %add2 = fadd fast float %add1, %3
  ret float %add2
}

attributes #0 = { "target-features"="+mve.fp" }