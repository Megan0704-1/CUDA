; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs --version 5
; RUN: opt -passes="ipsccp<func-spec>" -funcspec-min-function-size=1       \
; RUN:                                 -funcspec-for-literal-constant=true \
; RUN:                                 -funcspec-min-codesize-savings=50   \
; RUN:                                 -funcspec-min-latency-savings=0     \
; RUN:                                 -S < %s | FileCheck %s

; Verify that we are able to estimate the codesize savings arising from a branch
; based on a comparison with a value found to have a constant range by IPSCCP.
define i32 @main() {
  %notspec = call i32 @test_use_on_lhs(i32 8)
  %spec1 = call i32 @test_use_on_lhs(i32 0)
  %spec2 = call i32 @test_use_on_rhs(i32 1)
  %sum1 = add i32 %notspec, %spec1
  %sum2 = add i32 %sum1, %spec2
  ret i32 %sum2
}

define i32 @test_use_on_lhs(i32 %x) {
entry:
  %range = call i32 @foo(), !range !{ i32 1, i32 0 }
  %bound = shl nsw nuw i32 %range, 3
  %cmp = icmp uge i32 %x, %bound
  br i1 %cmp, label %if.then, label %if.end

if.then:
  call void @do_something()
  call void @do_something()
  call void @do_something()
  call void @do_something()
  br label %if.end

if.end:
  %res = phi i32 [ 0, %entry ], [ 1, %if.then]
  ret i32 %res
}

define i32 @test_use_on_rhs(i32 %x) {
entry:
  %range = call i32 @foo(), !range !{ i32 1, i32 0 }
  %bound = shl nsw nuw i32 %range, 3
  %x.sub = sub nsw nuw i32 %x, 1
  %cmp = icmp ult i32 %bound, %x.sub
  br i1 %cmp, label %if.then, label %if.end

if.then:
  call void @do_something()
  call void @do_something()
  call void @do_something()
  call void @do_something()
  br label %if.end

if.end:
  %res = phi i32 [ 0, %entry ], [ 1, %if.then]
  ret i32 %res
}

declare i32 @foo()
declare void @do_something()
; CHECK-LABEL: define range(i32 0, 2) i32 @main() {
; CHECK-NEXT:    [[NOTSPEC:%.*]] = call i32 @test_use_on_lhs(i32 8)
; CHECK-NEXT:    [[SPEC1:%.*]] = call i32 @test_use_on_lhs.specialized.1(i32 0)
; CHECK-NEXT:    [[SPEC2:%.*]] = call i32 @test_use_on_rhs.specialized.2(i32 1)
; CHECK-NEXT:    [[SUM:%.*]] = add nuw nsw i32 [[NOTSPEC]], 0
; CHECK-NEXT:    [[RES:%.*]] = add nuw nsw i32 [[SUM]], 0
; CHECK-NEXT:    ret i32 [[RES]]
;
;
; CHECK-LABEL: define range(i32 0, 2) i32 @test_use_on_lhs(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[RANGE:%.*]] = call i32 @foo(), !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[BOUND:%.*]] = shl nuw nsw i32 [[RANGE]], 3
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i32 [[X]], [[BOUND]]
; CHECK-NEXT:    br i1 [[CMP]], label %[[IF_THEN:.*]], label %[[IF_END:.*]]
; CHECK:       [[IF_THEN]]:
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    br label %[[IF_END]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ 0, %[[ENTRY]] ], [ 1, %[[IF_THEN]] ]
; CHECK-NEXT:    ret i32 [[RES]]
;
;
; CHECK-LABEL: define range(i32 0, 2) i32 @test_use_on_rhs(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[RANGE:%.*]] = call i32 @foo(), !range [[RNG0]]
; CHECK-NEXT:    [[BOUND:%.*]] = shl nuw nsw i32 [[RANGE]], 3
; CHECK-NEXT:    [[X_SUB:%.*]] = sub nuw nsw i32 [[X]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[BOUND]], [[X_SUB]]
; CHECK-NEXT:    br i1 [[CMP]], label %[[IF_THEN:.*]], label %[[IF_END:.*]]
; CHECK:       [[IF_THEN]]:
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    br label %[[IF_END]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ 0, %[[ENTRY]] ], [ 1, %[[IF_THEN]] ]
; CHECK-NEXT:    ret i32 [[RES]]
;
;
; CHECK-LABEL: define internal i32 @test_use_on_lhs.specialized.1(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[RANGE:%.*]] = call i32 @foo(), !range [[RNG0]]
; CHECK-NEXT:    [[BOUND:%.*]] = shl nuw nsw i32 [[RANGE]], 3
; CHECK-NEXT:    br label %[[IF_END:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    ret i32 poison
;
;
; CHECK-LABEL: define internal i32 @test_use_on_rhs.specialized.2(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[RANGE:%.*]] = call i32 @foo(), !range [[RNG0]]
; CHECK-NEXT:    [[BOUND:%.*]] = shl nuw nsw i32 [[RANGE]], 3
; CHECK-NEXT:    br label %[[IF_END:.*]]
; CHECK:       [[IF_END]]:
; CHECK-NEXT:    ret i32 poison
;
;.
; CHECK: [[RNG0]] = !{i32 1, i32 0}
;.