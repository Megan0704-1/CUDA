; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=atomic-expand -mtriple=powerpc64le-unknown-unknown \
; RUN:   < %s 2>&1 | FileCheck %s
; RUN: opt -S -passes=atomic-expand -mtriple=powerpc64-unknown-unknown \
; RUN:   < %s 2>&1 | FileCheck %s

define double @foo(ptr %dp) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load atomic i64, ptr [[DP:%.*]] monotonic, align 8
; CHECK-NEXT:    call void @llvm.ppc.cfence.i64(i64 [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i64 [[TMP0]] to double
; CHECK-NEXT:    ret double [[TMP1]]
;
entry:
  %0 = load atomic double, ptr %dp acquire, align 8
  ret double %0
}