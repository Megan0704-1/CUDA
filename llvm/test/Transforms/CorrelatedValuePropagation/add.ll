; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt < %s -passes=correlated-propagation -S | FileCheck %s

define void @test0(i32 %a) {
; CHECK-LABEL: define void @test0(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[A]], 100
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp slt i32 %a, 100
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

define void @test1(i32 %a) {
; CHECK-LABEL: define void @test1(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[A]], 100
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp ult i32 %a, 100
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

define void @test2(i32 %a) {
; CHECK-LABEL: define void @test2(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[A]], -1
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp ult i32 %a, -1
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

define void @test3(i32 %a) {
; CHECK-LABEL: define void @test3(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule i32 [[A]], -1
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp ule i32 %a, -1
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

define void @test4(i32 %a) {
; CHECK-LABEL: define void @test4(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[A]], 2147483647
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp slt i32 %a, 2147483647
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

define void @test5(i32 %a) {
; CHECK-LABEL: define void @test5(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i32 [[A]], 2147483647
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp sle i32 %a, 2147483647
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check for a corner case where an integer value is represented with a constant
; LVILatticeValue instead of constantrange. Check that we don't fail with an
; assertion in this case.
@b = global i32 0, align 4
define void @test6(i32 %a) {
; CHECK-LABEL: define void @test6(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[A]], ptrtoint (ptr @b to i32)
; CHECK-NEXT:    ret void
;
bb:
  %add = add i32 %a, ptrtoint (ptr @b to i32)
  ret void
}

; Check that we can gather information for conditions is the form of
;   and ( i s< 100, Unknown )
define void @test7(i32 %a, i1 %flag) {
; CHECK-LABEL: define void @test7(
; CHECK-SAME: i32 [[A:%.*]], i1 [[FLAG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp slt i32 [[A]], 100
; CHECK-NEXT:    [[CMP:%.*]] = and i1 [[CMP_1]], [[FLAG]]
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp slt i32 %a, 100
  %cmp = and i1 %cmp.1, %flag
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check that we can gather information for conditions is the form of
;   and ( i s< 100, i s> 0 )
define void @test8(i32 %a) {
; CHECK-LABEL: define void @test8(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp slt i32 [[A]], 100
; CHECK-NEXT:    [[CMP_2:%.*]] = icmp sgt i32 [[A]], 0
; CHECK-NEXT:    [[CMP:%.*]] = and i1 [[CMP_1]], [[CMP_2]]
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp slt i32 %a, 100
  %cmp.2 = icmp sgt i32 %a, 0
  %cmp = and i1 %cmp.1, %cmp.2
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check that for conditions is the form of cond1 && cond2 we don't mistakenly
; assume that !cond1 && !cond2 holds down to false path.
define void @test8_neg(i32 %a) {
; CHECK-LABEL: define void @test8_neg(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp sge i32 [[A]], 100
; CHECK-NEXT:    [[CMP_2:%.*]] = icmp sle i32 [[A]], 0
; CHECK-NEXT:    [[CMP:%.*]] = and i1 [[CMP_1]], [[CMP_2]]
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp sge i32 %a, 100
  %cmp.2 = icmp sle i32 %a, 0
  %cmp = and i1 %cmp.1, %cmp.2
  br i1 %cmp, label %exit, label %bb

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check that we can gather information for conditions is the form of
;   and ( i s< 100, and (i s> 0, Unknown )
define void @test9(i32 %a, i1 %flag) {
; CHECK-LABEL: define void @test9(
; CHECK-SAME: i32 [[A:%.*]], i1 [[FLAG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp slt i32 [[A]], 100
; CHECK-NEXT:    [[CMP_2:%.*]] = icmp sgt i32 [[A]], 0
; CHECK-NEXT:    [[CMP_3:%.*]] = and i1 [[CMP_2]], [[FLAG]]
; CHECK-NEXT:    [[CMP:%.*]] = and i1 [[CMP_1]], [[CMP_3]]
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp slt i32 %a, 100
  %cmp.2 = icmp sgt i32 %a, 0
  %cmp.3 = and i1 %cmp.2, %flag
  %cmp = and i1 %cmp.1, %cmp.3
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check that we can gather information for conditions is the form of
;   and ( i s< Unknown, ... )
define void @test10(i32 %a, i32 %b, i1 %flag) {
; CHECK-LABEL: define void @test10(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]], i1 [[FLAG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp slt i32 [[A]], [[B]]
; CHECK-NEXT:    [[CMP:%.*]] = and i1 [[CMP_1]], [[FLAG]]
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp slt i32 %a, %b
  %cmp = and i1 %cmp.1, %flag
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

@limit = external global i32
define i32 @test11(ptr %p, i32 %i) {
; CHECK-LABEL: define range(i32 0, 2147483645) i32 @test11(
; CHECK-SAME: ptr [[P:%.*]], i32 [[I:%.*]]) {
; CHECK-NEXT:    [[LIMIT:%.*]] = load i32, ptr [[P]], align 4, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[WITHIN_1:%.*]] = icmp ugt i32 [[LIMIT]], [[I]]
; CHECK-NEXT:    [[I_PLUS_7:%.*]] = add i32 [[I]], 7
; CHECK-NEXT:    [[WITHIN_2:%.*]] = icmp ugt i32 [[LIMIT]], [[I_PLUS_7]]
; CHECK-NEXT:    [[WITHIN:%.*]] = and i1 [[WITHIN_1]], [[WITHIN_2]]
; CHECK-NEXT:    br i1 [[WITHIN]], label [[THEN:%.*]], label [[ELSE:%.*]]
; CHECK:       then:
; CHECK-NEXT:    [[I_PLUS_6:%.*]] = add nuw nsw i32 [[I]], 6
; CHECK-NEXT:    ret i32 [[I_PLUS_6]]
; CHECK:       else:
; CHECK-NEXT:    ret i32 0
;
  %limit = load i32, ptr %p, !range !{i32 0, i32 2147483647}
  %within.1 = icmp ugt i32 %limit, %i
  %i.plus.7 = add i32 %i, 7
  %within.2 = icmp ugt i32 %limit, %i.plus.7
  %within = and i1 %within.1, %within.2
  br i1 %within, label %then, label %else

then:
  %i.plus.6 = add i32 %i, 6
  ret i32 %i.plus.6

else:
  ret i32 0
}

; Check that we can gather information for conditions is the form of
;   or ( i s>= 100, Unknown )
define void @test12(i32 %a, i1 %flag) {
; CHECK-LABEL: define void @test12(
; CHECK-SAME: i32 [[A:%.*]], i1 [[FLAG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp sge i32 [[A]], 100
; CHECK-NEXT:    [[CMP:%.*]] = or i1 [[CMP_1]], [[FLAG]]
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp sge i32 %a, 100
  %cmp = or i1 %cmp.1, %flag
  br i1 %cmp, label %exit, label %bb

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check that we can gather information for conditions is the form of
;   or ( i s>= 100, i s<= 0 )
define void @test13(i32 %a) {
; CHECK-LABEL: define void @test13(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp sge i32 [[A]], 100
; CHECK-NEXT:    [[CMP_2:%.*]] = icmp sle i32 [[A]], 0
; CHECK-NEXT:    [[CMP:%.*]] = or i1 [[CMP_1]], [[CMP_2]]
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp sge i32 %a, 100
  %cmp.2 = icmp sle i32 %a, 0
  %cmp = or i1 %cmp.1, %cmp.2
  br i1 %cmp, label %exit, label %bb

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check that for conditions is the form of cond1 || cond2 we don't mistakenly
; assume that cond1 || cond2 holds down to true path.
define void @test13_neg(i32 %a) {
; CHECK-LABEL: define void @test13_neg(
; CHECK-SAME: i32 [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp slt i32 [[A]], 100
; CHECK-NEXT:    [[CMP_2:%.*]] = icmp sgt i32 [[A]], 0
; CHECK-NEXT:    [[CMP:%.*]] = or i1 [[CMP_1]], [[CMP_2]]
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp slt i32 %a, 100
  %cmp.2 = icmp sgt i32 %a, 0
  %cmp = or i1 %cmp.1, %cmp.2
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check that we can gather information for conditions is the form of
;   or ( i s>=100, or (i s<= 0, Unknown )
define void @test14(i32 %a, i1 %flag) {
; CHECK-LABEL: define void @test14(
; CHECK-SAME: i32 [[A:%.*]], i1 [[FLAG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp sge i32 [[A]], 100
; CHECK-NEXT:    [[CMP_2:%.*]] = icmp sle i32 [[A]], 0
; CHECK-NEXT:    [[CMP_3:%.*]] = or i1 [[CMP_2]], [[FLAG]]
; CHECK-NEXT:    [[CMP:%.*]] = or i1 [[CMP_1]], [[CMP_3]]
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp sge i32 %a, 100
  %cmp.2 = icmp sle i32 %a, 0
  %cmp.3 = or i1 %cmp.2, %flag
  %cmp = or i1 %cmp.1, %cmp.3
  br i1 %cmp, label %exit, label %bb

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; Check that we can gather information for conditions is the form of
;   or ( i s>= Unknown, ... )
define void @test15(i32 %a, i32 %b, i1 %flag) {
; CHECK-LABEL: define void @test15(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]], i1 [[FLAG:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_1:%.*]] = icmp sge i32 [[A]], [[B]]
; CHECK-NEXT:    [[CMP:%.*]] = or i1 [[CMP_1]], [[FLAG]]
; CHECK-NEXT:    br i1 [[CMP]], label [[EXIT:%.*]], label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[A]], 1
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.1 = icmp sge i32 %a, %b
  %cmp = or i1 %cmp.1, %flag
  br i1 %cmp, label %exit, label %bb

bb:
  %add = add i32 %a, 1
  br label %exit

exit:
  ret void
}

; single basic block loop
; because the loop exit condition is SLT, we can supplement the iv add
; (iv.next def) with an nsw.
define i32 @test16(ptr %n, ptr %a) {
; CHECK-LABEL: define i32 @test16(
; CHECK-SAME: ptr [[N:%.*]], ptr [[A:%.*]]) {
; CHECK-NEXT:  preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[PREHEADER:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[ACC:%.*]] = phi i32 [ 0, [[PREHEADER]] ], [ [[ACC_CURR:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[X:%.*]] = load atomic i32, ptr [[A]] unordered, align 8
; CHECK-NEXT:    fence acquire
; CHECK-NEXT:    [[ACC_CURR]] = add i32 [[ACC]], [[X]]
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], 1
; CHECK-NEXT:    [[NVAL:%.*]] = load atomic i32, ptr [[N]] unordered, align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[IV_NEXT]], [[NVAL]]
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 [[ACC_CURR]]
;
preheader:
  br label %loop

loop:
  %iv = phi i32 [ 0, %preheader ], [ %iv.next, %loop ]
  %acc = phi i32 [ 0, %preheader ], [ %acc.curr, %loop ]
  %x = load atomic i32, ptr %a unordered, align 8
  fence acquire
  %acc.curr = add i32 %acc, %x
  %iv.next = add i32 %iv, 1
  %nval = load atomic i32, ptr %n unordered, align 8
  %cmp = icmp slt i32 %iv.next, %nval
  br i1 %cmp, label %loop, label %exit

exit:
  ret i32 %acc.curr
}

define i32 @test_undef_range(i32 %x) {
; CHECK-LABEL: define i32 @test_undef_range(
; CHECK-SAME: i32 [[X:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 [[X]], label [[JOIN:%.*]] [
; CHECK-NEXT:      i32 1, label [[CASE1:%.*]]
; CHECK-NEXT:      i32 2, label [[CASE2:%.*]]
; CHECK-NEXT:    ]
; CHECK:       case1:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       case2:
; CHECK-NEXT:    br label [[JOIN]]
; CHECK:       join:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32 [ 1, [[CASE1]] ], [ 2, [[CASE2]] ], [ undef, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[PHI]], 1
; CHECK-NEXT:    ret i32 [[ADD]]
;
entry:
  switch i32 %x, label %join [
  i32 1, label %case1
  i32 2, label %case2
  ]

case1:
  br label %join

case2:
  br label %join

join:
  %phi = phi i32 [ 1, %case1 ], [ 2, %case2 ], [ undef, %entry ]
  %add = add i32 %phi, 1
  ret i32 %add
}

;.
; CHECK: [[RNG0]] = !{i32 0, i32 2147483647}
;.