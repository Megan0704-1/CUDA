; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs --version 5
; RUN: opt -passes="ipsccp<func-spec>" -funcspec-min-function-size=1       \
; RUN:                                 -funcspec-for-literal-constant=true \
; RUN:                                 -funcspec-min-codesize-savings=50   \
; RUN:                                 -funcspec-min-latency-savings=0     \
; RUN:                                 -S < %s | FileCheck %s

; Verify that we are able to estimate the codesize savings arising from a block
; which is found dead, where the block has a predecessor that was found dead by
; IPSCCP.
define i32 @main(i1 %flag) {
  %notspec = call i32 @test(i1 %flag, i1 true)
  %spec = call i32 @test(i1 true, i1 true)
  %sum = add i32 %notspec, %spec
  ret i32 %sum
}

define internal i32 @test(i1 %argflag, i1 %constflag) {
entry:
  br i1 %argflag, label %block1, label %block3

block1:
  br i1 %constflag, label %end, label %block2

block2:
  br label %block3

block3:
  call void @do_something()
  call void @do_something()
  call void @do_something()
  call void @do_something()
  br label %end

end:
  %res = phi i32 [ 0, %block1 ], [ 1, %block3]
  ret i32 %res
}

declare void @do_something()
; CHECK-LABEL: define range(i32 0, 2) i32 @main(
; CHECK-SAME: i1 [[FLAG:%.*]]) {
; CHECK-NEXT:    [[NOTSPEC:%.*]] = call i32 @test(i1 [[FLAG]], i1 true)
; CHECK-NEXT:    [[SPEC:%.*]] = call i32 @test.specialized.1(i1 true, i1 true)
; CHECK-NEXT:    [[SUM:%.*]] = add nuw nsw i32 [[NOTSPEC]], 0
; CHECK-NEXT:    ret i32 [[SUM]]
;
;
; CHECK-LABEL: define internal range(i32 0, 2) i32 @test(
; CHECK-SAME: i1 [[ARGFLAG:%.*]], i1 [[CONSTFLAG:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[ARGFLAG]], label %[[BLOCK1:.*]], label %[[BLOCK3:.*]]
; CHECK:       [[BLOCK1]]:
; CHECK-NEXT:    br label %[[END:.*]]
; CHECK:       [[BLOCK3]]:
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    call void @do_something()
; CHECK-NEXT:    br label %[[END]]
; CHECK:       [[END]]:
; CHECK-NEXT:    [[RES:%.*]] = phi i32 [ 0, %[[BLOCK1]] ], [ 1, %[[BLOCK3]] ]
; CHECK-NEXT:    ret i32 [[RES]]
;
;
; CHECK-LABEL: define internal i32 @test.specialized.1(
; CHECK-SAME: i1 [[ARGFLAG:%.*]], i1 [[CONSTFLAG:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br label %[[BLOCK1:.*]]
; CHECK:       [[BLOCK1]]:
; CHECK-NEXT:    br label %[[END:.*]]
; CHECK:       [[END]]:
; CHECK-NEXT:    ret i32 poison
;