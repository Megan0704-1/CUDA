; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=aarch64-unknown-linux-gnu -mcpu=cortex-a57 | FileCheck %s
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

define void @test1(ptr noalias nocapture %a, ptr noalias nocapture readonly %b, ptr noalias nocapture readonly %c) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, ptr [[B:%.*]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load <4 x i32>, ptr [[C:%.*]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = add nsw <4 x i32> [[TMP3]], [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = sdiv <4 x i32> [[TMP4]], splat (i32 2)
; CHECK-NEXT:    store <4 x i32> [[TMP5]], ptr [[A:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i32, ptr %b, align 4
  %1 = load i32, ptr %c, align 4
  %add = add nsw i32 %1, %0
  %div = sdiv i32 %add, 2
  store i32 %div, ptr %a, align 4
  %arrayidx3 = getelementptr inbounds i32, ptr %b, i64 1
  %2 = load i32, ptr %arrayidx3, align 4
  %arrayidx4 = getelementptr inbounds i32, ptr %c, i64 1
  %3 = load i32, ptr %arrayidx4, align 4
  %add5 = add nsw i32 %3, %2
  %div6 = sdiv i32 %add5, 2
  %arrayidx7 = getelementptr inbounds i32, ptr %a, i64 1
  store i32 %div6, ptr %arrayidx7, align 4
  %arrayidx8 = getelementptr inbounds i32, ptr %b, i64 2
  %4 = load i32, ptr %arrayidx8, align 4
  %arrayidx9 = getelementptr inbounds i32, ptr %c, i64 2
  %5 = load i32, ptr %arrayidx9, align 4
  %add10 = add nsw i32 %5, %4
  %div11 = sdiv i32 %add10, 2
  %arrayidx12 = getelementptr inbounds i32, ptr %a, i64 2
  store i32 %div11, ptr %arrayidx12, align 4
  %arrayidx13 = getelementptr inbounds i32, ptr %b, i64 3
  %6 = load i32, ptr %arrayidx13, align 4
  %arrayidx14 = getelementptr inbounds i32, ptr %c, i64 3
  %7 = load i32, ptr %arrayidx14, align 4
  %add15 = add nsw i32 %7, %6
  %div16 = sdiv i32 %add15, 2
  %arrayidx17 = getelementptr inbounds i32, ptr %a, i64 3
  store i32 %div16, ptr %arrayidx17, align 4
  ret void
}