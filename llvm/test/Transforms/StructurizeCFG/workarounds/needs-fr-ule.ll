; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -fix-irreducible -unify-loop-exits -structurizecfg -S | FileCheck %s
define void @irreducible_mountain_bug(i1 %Pred0, i1 %Pred1, i1 %Pred2, i1 %Pred3, i1 %Pred4, i1 %Pred5, i1 %Pred6, i1 %Pred7, i1 %Pred8, i1 %Pred9, i1 %Pred10, i1 %Pred11, i1 %Pred12, i1 %Pred13) {
; CHECK-LABEL: @irreducible_mountain_bug(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PRED0_INV:%.*]] = xor i1 [[PRED0:%.*]], true
; CHECK-NEXT:    [[PRED1_INV:%.*]] = xor i1 [[PRED1:%.*]], true
; CHECK-NEXT:    [[PRED2_INV:%.*]] = xor i1 [[PRED2:%.*]], true
; CHECK-NEXT:    [[PRED3_INV:%.*]] = xor i1 [[PRED3:%.*]], true
; CHECK-NEXT:    [[PRED5_INV:%.*]] = xor i1 [[PRED5:%.*]], true
; CHECK-NEXT:    [[PRED10_INV:%.*]] = xor i1 [[PRED10:%.*]], true
; CHECK-NEXT:    [[PRED11_INV:%.*]] = xor i1 [[PRED11:%.*]], true
; CHECK-NEXT:    [[PRED12_INV:%.*]] = xor i1 [[PRED12:%.*]], true
; CHECK-NEXT:    [[PRED13_INV:%.*]] = xor i1 [[PRED13:%.*]], true
; CHECK-NEXT:    br i1 [[PRED0_INV]], label [[IF_THEN:%.*]], label [[FLOW22:%.*]]
; CHECK:       Flow22:
; CHECK-NEXT:    [[TMP0:%.*]] = phi i1 [ false, [[FLOW5:%.*]] ], [ true, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br i1 [[TMP0]], label [[IF_END:%.*]], label [[FLOW23:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    br i1 [[PRED1_INV]], label [[IF_ELSE:%.*]], label [[FLOW21:%.*]]
; CHECK:       Flow21:
; CHECK-NEXT:    [[TMP1:%.*]] = phi i1 [ false, [[IF_ELSE]] ], [ true, [[IF_END]] ]
; CHECK-NEXT:    br i1 [[TMP1]], label [[IF_THEN7:%.*]], label [[IF_END16:%.*]]
; CHECK:       if.then7:
; CHECK-NEXT:    br label [[IF_END16]]
; CHECK:       if.else:
; CHECK-NEXT:    br label [[FLOW21]]
; CHECK:       Flow23:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       if.end16:
; CHECK-NEXT:    br i1 [[PRED2_INV]], label [[IF_THEN39:%.*]], label [[FLOW19:%.*]]
; CHECK:       Flow19:
; CHECK-NEXT:    [[TMP2:%.*]] = phi i1 [ false, [[FLOW7:%.*]] ], [ true, [[IF_END16]] ]
; CHECK-NEXT:    br i1 [[TMP2]], label [[WHILE_COND_PREHEADER:%.*]], label [[FLOW20:%.*]]
; CHECK:       while.cond.preheader:
; CHECK-NEXT:    br label [[WHILE_COND:%.*]]
; CHECK:       Flow20:
; CHECK-NEXT:    br label [[FLOW23]]
; CHECK:       while.cond:
; CHECK-NEXT:    br i1 [[PRED3_INV]], label [[LOR_RHS:%.*]], label [[FLOW15:%.*]]
; CHECK:       Flow10:
; CHECK-NEXT:    [[TMP3:%.*]] = phi i1 [ false, [[WHILE_COND47:%.*]] ], [ true, [[WHILE_BODY63:%.*]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = phi i1 [ [[PRED6:%.*]], [[WHILE_COND47]] ], [ false, [[WHILE_BODY63]] ]
; CHECK-NEXT:    br label [[FLOW9:%.*]]
; CHECK:       cond.true49:
; CHECK-NEXT:    br label [[FLOW11:%.*]]
; CHECK:       while.body63:
; CHECK-NEXT:    br i1 [[PRED5_INV]], label [[WHILE_COND47]], label [[FLOW10:%.*]]
; CHECK:       Flow9:
; CHECK-NEXT:    [[TMP5:%.*]] = phi i1 [ [[TMP3]], [[FLOW10]] ], [ undef, [[IRR_GUARD1:%.*]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = phi i1 [ false, [[FLOW10]] ], [ undef, [[IRR_GUARD1]] ]
; CHECK-NEXT:    [[TMP7:%.*]] = phi i1 [ true, [[FLOW10]] ], [ undef, [[IRR_GUARD1]] ]
; CHECK-NEXT:    [[TMP8:%.*]] = phi i1 [ true, [[FLOW10]] ], [ undef, [[IRR_GUARD1]] ]
; CHECK-NEXT:    [[TMP9:%.*]] = phi i1 [ [[TMP4]], [[FLOW10]] ], [ true, [[IRR_GUARD1]] ]
; CHECK-NEXT:    br i1 [[TMP9]], label [[COND_TRUE49:%.*]], label [[FLOW11]]
; CHECK:       while.cond47:
; CHECK-NEXT:    br label [[FLOW10]]
; CHECK:       cond.end61:
; CHECK-NEXT:    br label [[FLOW12:%.*]]
; CHECK:       Flow17:
; CHECK-NEXT:    [[TMP10:%.*]] = phi i1 [ [[TMP19:%.*]], [[FLOW18:%.*]] ], [ undef, [[LOOP_EXIT_GUARD2:%.*]] ]
; CHECK-NEXT:    [[TMP11:%.*]] = phi i1 [ [[TMP20:%.*]], [[FLOW18]] ], [ [[DOTINV:%.*]], [[LOOP_EXIT_GUARD2]] ]
; CHECK-NEXT:    br label [[FLOW16:%.*]]
; CHECK:       if.then69:
; CHECK-NEXT:    br label [[FLOW18]]
; CHECK:       lor.rhs:
; CHECK-NEXT:    br label [[FLOW15]]
; CHECK:       while.end76:
; CHECK-NEXT:    br label [[FLOW8:%.*]]
; CHECK:       if.then39:
; CHECK-NEXT:    br i1 [[PRED10_INV]], label [[IF_END_I145:%.*]], label [[FLOW7]]
; CHECK:       if.end.i145:
; CHECK-NEXT:    br i1 [[PRED11_INV]], label [[IF_END8_I149:%.*]], label [[FLOW6:%.*]]
; CHECK:       if.end8.i149:
; CHECK-NEXT:    br label [[FLOW6]]
; CHECK:       if.then:
; CHECK-NEXT:    br i1 [[PRED12_INV]], label [[IF_END_I:%.*]], label [[FLOW5]]
; CHECK:       if.end.i:
; CHECK-NEXT:    br i1 [[PRED13_INV]], label [[IF_END8_I:%.*]], label [[FLOW:%.*]]
; CHECK:       if.end8.i:
; CHECK-NEXT:    br label [[FLOW]]
; CHECK:       Flow:
; CHECK-NEXT:    br label [[FLOW5]]
; CHECK:       Flow5:
; CHECK-NEXT:    br label [[FLOW22]]
; CHECK:       Flow6:
; CHECK-NEXT:    br label [[FLOW7]]
; CHECK:       Flow7:
; CHECK-NEXT:    br label [[FLOW19]]
; CHECK:       Flow8:
; CHECK-NEXT:    br label [[FLOW20]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       Flow15:
; CHECK-NEXT:    [[TMP12:%.*]] = phi i1 [ true, [[LOR_RHS]] ], [ undef, [[WHILE_COND]] ]
; CHECK-NEXT:    [[TMP13:%.*]] = phi i1 [ true, [[LOR_RHS]] ], [ false, [[WHILE_COND]] ]
; CHECK-NEXT:    [[TMP14:%.*]] = phi i1 [ [[PRED9:%.*]], [[LOR_RHS]] ], [ true, [[WHILE_COND]] ]
; CHECK-NEXT:    br i1 [[TMP14]], label [[IRR_GUARD:%.*]], label [[FLOW16]]
; CHECK:       irr.guard:
; CHECK-NEXT:    [[GUARD_COND_END61:%.*]] = phi i1 [ [[TMP28:%.*]], [[FLOW13:%.*]] ], [ [[TMP13]], [[FLOW15]] ]
; CHECK-NEXT:    br i1 [[GUARD_COND_END61]], label [[COND_END61:%.*]], label [[FLOW12]]
; CHECK:       Flow12:
; CHECK-NEXT:    [[TMP15:%.*]] = phi i1 [ false, [[COND_END61]] ], [ undef, [[IRR_GUARD]] ]
; CHECK-NEXT:    [[TMP16:%.*]] = phi i1 [ true, [[COND_END61]] ], [ undef, [[IRR_GUARD]] ]
; CHECK-NEXT:    [[TMP17:%.*]] = phi i1 [ true, [[COND_END61]] ], [ false, [[IRR_GUARD]] ]
; CHECK-NEXT:    [[TMP18:%.*]] = phi i1 [ [[PRED7:%.*]], [[COND_END61]] ], [ true, [[IRR_GUARD]] ]
; CHECK-NEXT:    br i1 [[TMP18]], label [[IRR_GUARD1]], label [[FLOW13]]
; CHECK:       irr.guard1:
; CHECK-NEXT:    [[GUARD_WHILE_BODY63:%.*]] = phi i1 [ [[TMP23:%.*]], [[FLOW11]] ], [ [[TMP17]], [[FLOW12]] ]
; CHECK-NEXT:    br i1 [[GUARD_WHILE_BODY63]], label [[WHILE_BODY63]], label [[FLOW9]]
; CHECK:       Flow18:
; CHECK-NEXT:    [[TMP19]] = phi i1 [ false, [[IF_THEN69:%.*]] ], [ [[TMP31:%.*]], [[LOOP_EXIT_GUARD3:%.*]] ]
; CHECK-NEXT:    [[TMP20]] = phi i1 [ [[PRED8:%.*]], [[IF_THEN69]] ], [ [[DOTINV]], [[LOOP_EXIT_GUARD3]] ]
; CHECK-NEXT:    br label [[FLOW17:%.*]]
; CHECK:       loop.exit.guard:
; CHECK-NEXT:    br i1 [[TMP21:%.*]], label [[WHILE_END76:%.*]], label [[FLOW8]]
; CHECK:       Flow16:
; CHECK-NEXT:    [[TMP21]] = phi i1 [ [[TMP10]], [[FLOW17]] ], [ [[TMP12]], [[FLOW15]] ]
; CHECK-NEXT:    [[TMP22:%.*]] = phi i1 [ [[TMP11]], [[FLOW17]] ], [ true, [[FLOW15]] ]
; CHECK-NEXT:    br i1 [[TMP22]], label [[LOOP_EXIT_GUARD:%.*]], label [[WHILE_COND]]
; CHECK:       loop.exit.guard2:
; CHECK-NEXT:    br i1 [[DOTINV]], label [[LOOP_EXIT_GUARD3]], label [[FLOW17]]
; CHECK:       loop.exit.guard3:
; CHECK-NEXT:    br i1 [[DOTINV14:%.*]], label [[IF_THEN69]], label [[FLOW18]]
; CHECK:       Flow11:
; CHECK-NEXT:    [[TMP23]] = phi i1 [ true, [[COND_TRUE49]] ], [ undef, [[FLOW9]] ]
; CHECK-NEXT:    [[TMP24:%.*]] = phi i1 [ true, [[COND_TRUE49]] ], [ [[TMP5]], [[FLOW9]] ]
; CHECK-NEXT:    [[TMP25:%.*]] = phi i1 [ false, [[COND_TRUE49]] ], [ [[TMP6]], [[FLOW9]] ]
; CHECK-NEXT:    [[TMP26:%.*]] = phi i1 [ false, [[COND_TRUE49]] ], [ [[TMP7]], [[FLOW9]] ]
; CHECK-NEXT:    [[TMP27:%.*]] = phi i1 [ [[PRED4:%.*]], [[COND_TRUE49]] ], [ true, [[FLOW9]] ]
; CHECK-NEXT:    br i1 [[TMP27]], label [[LOOP_EXIT_GUARD4:%.*]], label [[IRR_GUARD1]]
; CHECK:       Flow13:
; CHECK-NEXT:    [[TMP28]] = phi i1 [ [[TMP8]], [[LOOP_EXIT_GUARD4]] ], [ undef, [[FLOW12]] ]
; CHECK-NEXT:    [[TMP29:%.*]] = phi i1 [ [[TMP26]], [[LOOP_EXIT_GUARD4]] ], [ [[TMP15]], [[FLOW12]] ]
; CHECK-NEXT:    [[TMP30:%.*]] = phi i1 [ [[TMP25]], [[LOOP_EXIT_GUARD4]] ], [ [[TMP16]], [[FLOW12]] ]
; CHECK-NEXT:    [[TMP31]] = phi i1 [ [[TMP6]], [[LOOP_EXIT_GUARD4]] ], [ undef, [[FLOW12]] ]
; CHECK-NEXT:    [[TMP32:%.*]] = phi i1 [ [[TMP24]], [[LOOP_EXIT_GUARD4]] ], [ true, [[FLOW12]] ]
; CHECK-NEXT:    [[DOTINV14]] = xor i1 [[TMP29]], true
; CHECK-NEXT:    [[DOTINV]] = xor i1 [[TMP30]], true
; CHECK-NEXT:    br i1 [[TMP32]], label [[LOOP_EXIT_GUARD2]], label [[IRR_GUARD]]
; CHECK:       loop.exit.guard4:
; CHECK-NEXT:    br label [[FLOW13]]
;
entry:
  br i1 %Pred0, label %if.end, label %if.then

if.end:
  br i1 %Pred1, label %if.then7, label %if.else

if.then7:
  br label %if.end16

if.else:
  br label %if.end16

if.end16:
  br i1 %Pred2, label %while.cond.preheader, label %if.then39

while.cond.preheader:
  br label %while.cond

while.cond:
  br i1 %Pred3, label %cond.true49, label %lor.rhs

cond.true49:
  br i1 %Pred4, label %if.then69, label %while.body63

while.body63:
  br i1 %Pred5, label %exit, label %while.cond47

while.cond47:
  br i1 %Pred6, label %cond.true49, label %cond.end61

cond.end61:
  br i1 %Pred7, label %while.body63, label %while.cond

if.then69:
  br i1 %Pred8, label %exit, label %while.cond

lor.rhs:
  br i1 %Pred9, label %cond.end61, label %while.end76

while.end76:
  br label %exit

if.then39:
  br i1 %Pred10, label %exit, label %if.end.i145

if.end.i145:
  br i1 %Pred11, label %exit, label %if.end8.i149

if.end8.i149:
  br label %exit

if.then:
  br i1 %Pred12, label %exit, label %if.end.i

if.end.i:
  br i1 %Pred13, label %exit, label %if.end8.i

if.end8.i:
  br label %exit

exit:
  ret void
}