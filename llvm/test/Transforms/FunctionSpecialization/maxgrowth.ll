; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs --version 5
; RUN: opt -passes="ipsccp<func-spec>" -funcspec-min-function-size=1       \
; RUN:                                 -funcspec-for-literal-constant=true \
; RUN:                                 -funcspec-min-codesize-savings=50   \
; RUN:                                 -funcspec-min-latency-savings=50    \
; RUN:                                 -funcspec-max-codesize-growth=1     \
; RUN:                                 -S < %s | FileCheck %s

; Verify that we are able to specialize a function successfully after analysis
; of other specializations that are found to not be profitable.
define void @test_specialize_after_failed_analysis(i32 %n) {
entry:
  %notspec0 = call i32 @add(i32 0, i32 %n)
  %notspec1 = call i32 @add(i32 1, i32 %n)
  %spec = call i32 @add(i32 1, i32 1)
  ret void
}

define i32 @add(i32 %x, i32 %y) {
entry:
  %res = add i32 %x, %y
  ret i32 %res
}
; CHECK-LABEL: define void @test_specialize_after_failed_analysis(
; CHECK-SAME: i32 [[N:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[NOTSPEC0:%.*]] = call i32 @add(i32 0, i32 [[N]])
; CHECK-NEXT:    [[NOTSPEC1:%.*]] = call i32 @add(i32 1, i32 [[N]])
; CHECK-NEXT:    [[SPEC:%.*]] = call i32 @add.specialized.1(i32 1, i32 1)
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define i32 @add(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[RES:%.*]] = add i32 [[X]], [[Y]]
; CHECK-NEXT:    ret i32 [[RES]]
;
;
; CHECK-LABEL: define internal i32 @add.specialized.1(
; CHECK-SAME: i32 [[X:%.*]], i32 [[Y:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    ret i32 poison
;