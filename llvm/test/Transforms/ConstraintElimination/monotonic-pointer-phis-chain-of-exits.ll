; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

declare void @use(ptr)
declare i1 @cond()

define void @test_monotonic_ptr_iv_inc_1_different_element_types_1_chain_of_2_exit_condition_unrelated_condition_in_header(ptr %start, i16 %len, i16 %x) {
; CHECK-LABEL: @test_monotonic_ptr_iv_inc_1_different_element_types_1_chain_of_2_exit_condition_unrelated_condition_in_header(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UPPER:%.*]] = getelementptr inbounds i32, ptr [[START:%.*]], i16 [[LEN:%.*]]
; CHECK-NEXT:    [[LEN_NEG:%.*]] = icmp slt i16 [[LEN]], 0
; CHECK-NEXT:    br i1 [[LEN_NEG]], label [[EXIT:%.*]], label [[LOOP_PH:%.*]]
; CHECK:       loop.ph:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], [[LOOP_PH]] ], [ [[PTR_IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[C_0:%.*]] = icmp eq i16 [[X:%.*]], 1
; CHECK-NEXT:    br i1 [[C_0]], label [[EXIT]], label [[THEN:%.*]]
; CHECK:       then:
; CHECK-NEXT:    [[C_1:%.*]] = icmp eq ptr [[PTR_IV]], [[UPPER]]
; CHECK-NEXT:    br i1 [[C_1]], label [[EXIT]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[C_2:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C_2]], label [[LOOP_NEXT:%.*]], label [[EXIT]]
; CHECK:       loop.next:
; CHECK-NEXT:    [[T_1:%.*]] = icmp uge ptr [[PTR_IV]], [[START]]
; CHECK-NEXT:    [[T_2:%.*]] = icmp ult ptr [[PTR_IV]], [[UPPER]]
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[T_1]], [[T_2]]
; CHECK-NEXT:    br i1 [[AND]], label [[LOOP_LATCH]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @use(ptr [[PTR_IV]])
; CHECK-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i8, ptr [[PTR_IV]], i16 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %upper = getelementptr inbounds i32, ptr %start, i16 %len
  %len.neg = icmp slt i16 %len, 0
  br i1 %len.neg, label %exit, label %loop.ph

loop.ph:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %loop.ph ], [ %ptr.iv.next, %loop.latch ]
  %c.0 = icmp eq i16 %x, 1
  br i1 %c.0, label %exit, label %then

then:
  %c.1 = icmp eq ptr %ptr.iv, %upper
  br i1 %c.1, label %exit, label %for.body

for.body:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %loop.next, label %exit

loop.next:
  %t.1 = icmp uge ptr %ptr.iv, %start
  %t.2 = icmp ult ptr %ptr.iv, %upper
  %and = and i1 %t.1, %t.2
  br i1 %and, label %loop.latch, label %exit

loop.latch:
  call void @use(ptr %ptr.iv)
  %ptr.iv.next = getelementptr inbounds i8, ptr %ptr.iv, i16 1
  br label %loop.header

exit:
  ret void
}

define void @test_monotonic_ptr_iv_inc_1_different_element_types_1_chain_of_3_exit_condition_unrelated_condition_in_header(ptr %start, i16 %len, i16 %x) {
; CHECK-LABEL: @test_monotonic_ptr_iv_inc_1_different_element_types_1_chain_of_3_exit_condition_unrelated_condition_in_header(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UPPER:%.*]] = getelementptr inbounds i32, ptr [[START:%.*]], i16 [[LEN:%.*]]
; CHECK-NEXT:    [[LEN_NEG:%.*]] = icmp slt i16 [[LEN]], 0
; CHECK-NEXT:    br i1 [[LEN_NEG]], label [[EXIT:%.*]], label [[LOOP_PH:%.*]]
; CHECK:       loop.ph:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], [[LOOP_PH]] ], [ [[PTR_IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[C_0:%.*]] = icmp eq i16 [[X:%.*]], 1
; CHECK-NEXT:    br i1 [[C_0]], label [[EXIT]], label [[THEN_1:%.*]]
; CHECK:       then.1:
; CHECK-NEXT:    [[C_00:%.*]] = icmp ult i16 [[X]], 100
; CHECK-NEXT:    br i1 [[C_0]], label [[EXIT]], label [[THEN_2:%.*]]
; CHECK:       then.2:
; CHECK-NEXT:    [[C_1:%.*]] = icmp eq ptr [[PTR_IV]], [[UPPER]]
; CHECK-NEXT:    br i1 [[C_1]], label [[EXIT]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[C_2:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C_2]], label [[LOOP_NEXT:%.*]], label [[EXIT]]
; CHECK:       loop.next:
; CHECK-NEXT:    [[T_1:%.*]] = icmp uge ptr [[PTR_IV]], [[START]]
; CHECK-NEXT:    [[T_2:%.*]] = icmp ult ptr [[PTR_IV]], [[UPPER]]
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[T_1]], [[T_2]]
; CHECK-NEXT:    br i1 [[AND]], label [[LOOP_LATCH]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @use(ptr [[PTR_IV]])
; CHECK-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i8, ptr [[PTR_IV]], i16 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %upper = getelementptr inbounds i32, ptr %start, i16 %len
  %len.neg = icmp slt i16 %len, 0
  br i1 %len.neg, label %exit, label %loop.ph

loop.ph:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %loop.ph ], [ %ptr.iv.next, %loop.latch ]
  %c.0 = icmp eq i16 %x, 1
  br i1 %c.0, label %exit, label %then.1

then.1:
  %c.00 = icmp ult i16 %x, 100
  br i1 %c.0, label %exit, label %then.2

then.2:
  %c.1 = icmp eq ptr %ptr.iv, %upper
  br i1 %c.1, label %exit, label %for.body

for.body:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %loop.next, label %exit

loop.next:
  %t.1 = icmp uge ptr %ptr.iv, %start
  %t.2 = icmp ult ptr %ptr.iv, %upper
  %and = and i1 %t.1, %t.2
  br i1 %and, label %loop.latch, label %exit

loop.latch:
  call void @use(ptr %ptr.iv)
  %ptr.iv.next = getelementptr inbounds i8, ptr %ptr.iv, i16 1
  br label %loop.header

exit:
  ret void
}

define void @test_monotonic_ptr_iv_inc_1_different_element_types_1_chain_of_2_exit_conditions_with_slt_in_header(ptr %start, i16 %len, i16 %x) {
; CHECK-LABEL: @test_monotonic_ptr_iv_inc_1_different_element_types_1_chain_of_2_exit_conditions_with_slt_in_header(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UPPER:%.*]] = getelementptr inbounds i32, ptr [[START:%.*]], i16 [[LEN:%.*]]
; CHECK-NEXT:    br label [[LOOP_PH:%.*]]
; CHECK:       loop.ph:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], [[LOOP_PH]] ], [ [[PTR_IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LEN_NEG:%.*]] = icmp slt i16 [[LEN]], 0
; CHECK-NEXT:    br i1 [[LEN_NEG]], label [[EXIT:%.*]], label [[THEN:%.*]]
; CHECK:       then:
; CHECK-NEXT:    [[C_1:%.*]] = icmp eq ptr [[PTR_IV]], [[UPPER]]
; CHECK-NEXT:    br i1 [[C_1]], label [[EXIT]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[C_2:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C_2]], label [[LOOP_NEXT:%.*]], label [[EXIT]]
; CHECK:       loop.next:
; CHECK-NEXT:    [[T_1:%.*]] = icmp uge ptr [[PTR_IV]], [[START]]
; CHECK-NEXT:    [[T_2:%.*]] = icmp ult ptr [[PTR_IV]], [[UPPER]]
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[T_1]], [[T_2]]
; CHECK-NEXT:    br i1 [[AND]], label [[LOOP_LATCH]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @use(ptr [[PTR_IV]])
; CHECK-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i8, ptr [[PTR_IV]], i16 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %upper = getelementptr inbounds i32, ptr %start, i16 %len
  br label %loop.ph

loop.ph:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %loop.ph ], [ %ptr.iv.next, %loop.latch ]
  %len.neg = icmp slt i16 %len, 0
  br i1 %len.neg, label %exit, label %then

then:
  %c.1 = icmp eq ptr %ptr.iv, %upper
  br i1 %c.1, label %exit, label %for.body

for.body:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %loop.next, label %exit

loop.next:
  %t.1 = icmp uge ptr %ptr.iv, %start
  %t.2 = icmp ult ptr %ptr.iv, %upper
  %and = and i1 %t.1, %t.2
  br i1 %and, label %loop.latch, label %exit

loop.latch:
  call void @use(ptr %ptr.iv)
  %ptr.iv.next = getelementptr inbounds i8, ptr %ptr.iv, i16 1
  br label %loop.header

exit:
  ret void
}

define void @test_header_not_exiting(ptr %start, i16 %len, i16 %x) {
; CHECK-LABEL: @test_header_not_exiting(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UPPER:%.*]] = getelementptr inbounds i32, ptr [[START:%.*]], i16 [[LEN:%.*]]
; CHECK-NEXT:    br label [[LOOP_PH:%.*]]
; CHECK:       loop.ph:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[START]], [[LOOP_PH]] ], [ [[PTR_IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LEN_NEG:%.*]] = icmp slt i16 [[LEN]], 0
; CHECK-NEXT:    br i1 [[LEN_NEG]], label [[THEN:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       then:
; CHECK-NEXT:    [[C_1:%.*]] = icmp eq ptr [[PTR_IV]], [[UPPER]]
; CHECK-NEXT:    br i1 [[C_1]], label [[EXIT:%.*]], label [[FOR_BODY]]
; CHECK:       for.body:
; CHECK-NEXT:    [[C_2:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C_2]], label [[LOOP_NEXT:%.*]], label [[EXIT]]
; CHECK:       loop.next:
; CHECK-NEXT:    [[T_1:%.*]] = icmp uge ptr [[PTR_IV]], [[START]]
; CHECK-NEXT:    [[T_2:%.*]] = icmp ult ptr [[PTR_IV]], [[UPPER]]
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[T_1]], [[T_2]]
; CHECK-NEXT:    br i1 [[AND]], label [[LOOP_LATCH]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @use(ptr [[PTR_IV]])
; CHECK-NEXT:    [[PTR_IV_NEXT]] = getelementptr inbounds i8, ptr [[PTR_IV]], i16 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %upper = getelementptr inbounds i32, ptr %start, i16 %len
  br label %loop.ph

loop.ph:
  br label %loop.header

loop.header:
  %ptr.iv = phi ptr [ %start, %loop.ph ], [ %ptr.iv.next, %loop.latch ]
  %len.neg = icmp slt i16 %len, 0
  br i1 %len.neg, label %then, label %for.body

then:
  %c.1 = icmp eq ptr %ptr.iv, %upper
  br i1 %c.1, label %exit, label %for.body

for.body:
  %c.2 = call i1 @cond()
  br i1 %c.2, label %loop.next, label %exit

loop.next:
  %t.1 = icmp uge ptr %ptr.iv, %start
  %t.2 = icmp ult ptr %ptr.iv, %upper
  %and = and i1 %t.1, %t.2
  br i1 %and, label %loop.latch, label %exit

loop.latch:
  call void @use(ptr %ptr.iv)
  %ptr.iv.next = getelementptr inbounds i8, ptr %ptr.iv, i16 1
  br label %loop.header

exit:
  ret void
}

declare void @foo()

define i32 @test_latch_exiting1(i32 %N) {
; CHECK-LABEL: @test_latch_exiting1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EC]], label [[EXIT_1:%.*]], label [[LOOP]]
; CHECK:       exit.1:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop

loop:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop ]
  call void @foo()
  %iv.next = add i32 %iv, 1
  %ec = icmp eq i32 %iv, %N
  br i1 %ec, label %exit.1, label %loop

exit.1:
  ret i32 10
}

define i32 @test_latch_exiting2(i1 %c, i32 %N) {
; CHECK-LABEL: @test_latch_exiting2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LOOP_LATCH]], label [[EXIT_1:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[EC]], label [[EXIT_2:%.*]], label [[LOOP_HEADER]]
; CHECK:       exit.1:
; CHECK-NEXT:    ret i32 10
; CHECK:       exit.2:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  br i1 %c, label %loop.latch, label %exit.1

loop.latch:
  call void @foo()
  %iv.next = add i32 %iv, 1
  %ec = icmp eq i32 %iv, %N
  br i1 %ec, label %exit.2, label %loop.header

exit.1:
  ret i32 10

exit.2:
  ret i32 0
}