; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -O3 -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s --check-prefix=SLP
; RUN: opt < %s -O3 -vectorize-slp=false -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s --check-prefix=NOSLP

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.8.0"

; Make sure we can disable slp vectorization in opt.

define void @test1(ptr %a, ptr %b, ptr %c) {
; SLP-LABEL: @test1(
; SLP-NEXT:  entry:
; SLP-NEXT:    [[TMP0:%.*]] = load <2 x double>, ptr [[A:%.*]], align 8
; SLP-NEXT:    [[TMP1:%.*]] = load <2 x double>, ptr [[B:%.*]], align 8
; SLP-NEXT:    [[TMP2:%.*]] = fmul <2 x double> [[TMP0]], [[TMP1]]
; SLP-NEXT:    store <2 x double> [[TMP2]], ptr [[C:%.*]], align 8
; SLP-NEXT:    ret void
;
; NOSLP-LABEL: @test1(
; NOSLP-NEXT:  entry:
; NOSLP-NEXT:    [[I0:%.*]] = load double, ptr [[A:%.*]], align 8
; NOSLP-NEXT:    [[I1:%.*]] = load double, ptr [[B:%.*]], align 8
; NOSLP-NEXT:    [[MUL:%.*]] = fmul double [[I0]], [[I1]]
; NOSLP-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds nuw i8, ptr [[A]], i64 8
; NOSLP-NEXT:    [[I3:%.*]] = load double, ptr [[ARRAYIDX3]], align 8
; NOSLP-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds nuw i8, ptr [[B]], i64 8
; NOSLP-NEXT:    [[I4:%.*]] = load double, ptr [[ARRAYIDX4]], align 8
; NOSLP-NEXT:    [[MUL5:%.*]] = fmul double [[I3]], [[I4]]
; NOSLP-NEXT:    store double [[MUL]], ptr [[C:%.*]], align 8
; NOSLP-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds nuw i8, ptr [[C]], i64 8
; NOSLP-NEXT:    store double [[MUL5]], ptr [[ARRAYIDX5]], align 8
; NOSLP-NEXT:    ret void
;
entry:
  %i0 = load double, ptr %a, align 8
  %i1 = load double, ptr %b, align 8
  %mul = fmul double %i0, %i1
  %arrayidx3 = getelementptr inbounds double, ptr %a, i64 1
  %i3 = load double, ptr %arrayidx3, align 8
  %arrayidx4 = getelementptr inbounds double, ptr %b, i64 1
  %i4 = load double, ptr %arrayidx4, align 8
  %mul5 = fmul double %i3, %i4
  store double %mul, ptr %c, align 8
  %arrayidx5 = getelementptr inbounds double, ptr %c, i64 1
  store double %mul5, ptr %arrayidx5, align 8
  ret void
}