; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; Regression test for https://bugs.llvm.org/show_bug.cgi?id=32842
;
; RUN: opt < %s -S -passes=msan 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Make sure the shadow of the (x < y) comparison isn't truncated to i1.

define zeroext i1 @_Z1fii(i32 %x, i32 %y) sanitize_memory {
; CHECK-LABEL: define zeroext i1 @_Z1fii(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr @__msan_param_tls, align 8
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[TMP10:%.*]] = xor i32 [[X]], -2147483648
; CHECK-NEXT:    [[TMP3:%.*]] = xor i32 [[TMP0]], -1
; CHECK-NEXT:    [[TMP4:%.*]] = and i32 [[TMP10]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = or i32 [[TMP10]], [[TMP0]]
; CHECK-NEXT:    [[TMP6:%.*]] = xor i32 [[Y]], -2147483648
; CHECK-NEXT:    [[TMP7:%.*]] = xor i32 [[TMP1]], -1
; CHECK-NEXT:    [[TMP8:%.*]] = and i32 [[TMP6]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = or i32 [[TMP6]], [[TMP1]]
; CHECK-NEXT:    [[TMP14:%.*]] = icmp ult i32 [[TMP4]], [[TMP9]]
; CHECK-NEXT:    [[TMP27:%.*]] = icmp ult i32 [[TMP5]], [[TMP8]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP14]], [[TMP27]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[X]], [[Y]]
; CHECK-NEXT:    store i1 [[TMP2]], ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  %cmp = icmp slt i32 %x, %y
  ret i1 %cmp
}