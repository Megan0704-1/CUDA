; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='loop(indvars,loop-deletion)' -verify-scev -S %s | FileCheck %s

; Make sure indvarsimplify properly forgets the exit value %p.2.lcssa phi after
; modifying it. Loop deletion is required to show the incorrect use of the cached
; SCEV value.

define void @test(i1 %c) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[HEADER_1:%.*]]
; CHECK:       header.1.loopexit:
; CHECK-NEXT:    br label [[HEADER_1_BACKEDGE:%.*]]
; CHECK:       header.1:
; CHECK-NEXT:    br label [[HEADER_2:%.*]]
; CHECK:       header.2:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LATCH_1:%.*]], label [[LATCH_2:%.*]]
; CHECK:       latch.1:
; CHECK-NEXT:    br label [[HEADER_1_LOOPEXIT:%.*]]
; CHECK:       latch.2:
; CHECK-NEXT:    br label [[HEADER_1_BACKEDGE]]
; CHECK:       header.1.backedge:
; CHECK-NEXT:    br label [[HEADER_1]]
;
entry:
  br label %header.1

header.1:
  %p.1 = phi i32 [ 0, %entry ], [ %p.2.lcssa, %latch.2 ], [ 0, %latch.1 ]
  br label %header.2

header.2:
  %p.2 = phi i32 [ %p.1, %header.1 ], [ %p.2.next, %latch.1 ]
  br i1 %c, label %latch.1, label %latch.2

latch.1:
  %p.2.next = add i32 %p.2, 1
  br i1 false, label %header.2, label %header.1

latch.2:
  %p.2.lcssa = phi i32 [ %p.2, %header.2 ]
  br label %header.1
}

define i8 @test_pr52023(i1 %c.1, i1 %c.2) {
; CHECK-LABEL: @test_pr52023(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_1:%.*]]
; CHECK:       loop.1:
; CHECK-NEXT:    [[INC79:%.*]] = phi i8 [ [[TMP0:%.*]], [[LOOP_1_LATCH:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = add i8 [[INC79]], 1
; CHECK-NEXT:    br label [[LOOP_2:%.*]]
; CHECK:       loop.2:
; CHECK-NEXT:    br i1 [[C_1:%.*]], label [[LOOP_2_LATCH:%.*]], label [[LOOP_1_LATCH]]
; CHECK:       loop.2.latch:
; CHECK-NEXT:    br label [[LOOP_1_LATCH]]
; CHECK:       loop.1.latch:
; CHECK-NEXT:    [[TMP0]] = phi i8 [ [[TMP1]], [[LOOP_2_LATCH]] ], [ undef, [[LOOP_2]] ]
; CHECK-NEXT:    br i1 [[C_2:%.*]], label [[EXIT:%.*]], label [[LOOP_1]]
; CHECK:       exit:
; CHECK-NEXT:    [[INC_LCSSA_LCSSA:%.*]] = phi i8 [ [[TMP0]], [[LOOP_1_LATCH]] ]
; CHECK-NEXT:    ret i8 [[INC_LCSSA_LCSSA]]
;
entry:
  br label %loop.1

loop.1:
  %inc79 = phi i8 [ %inc.lcssa, %loop.1.latch ], [ 0, %entry ]
  br label %loop.2

loop.2:
  %inc6 = phi i8 [ %inc79, %loop.1 ], [ %inc, %loop.2.latch ]
  %inc = add i8 %inc6, 1
  br i1 %c.1, label %loop.2.latch , label %loop.1.latch

loop.2.latch:
  br i1 false, label %loop.2, label %loop.1.latch

loop.1.latch:
  %inc.lcssa = phi i8 [ %inc, %loop.2.latch ], [ undef, %loop.2 ]
  br i1 %c.2, label %exit, label %loop.1

exit:
  %inc.lcssa.lcssa = phi i8 [ %inc.lcssa, %loop.1.latch ]
  ret i8 %inc.lcssa.lcssa
}

define i32 @test_pr58440(i1 %c.0) {
; CHECK-LABEL: @test_pr58440(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = or i32 0, 1
; CHECK-NEXT:    br label [[LOOP_1_HEADER:%.*]]
; CHECK:       loop.1.header.loopexit:
; CHECK-NEXT:    br label [[LOOP_1_HEADER]]
; CHECK:       loop.1.header:
; CHECK-NEXT:    br label [[LOOP_2_HEADER:%.*]]
; CHECK:       loop.2.header:
; CHECK-NEXT:    br i1 [[C_0:%.*]], label [[LOOP_2_LATCH:%.*]], label [[LOOP_1_HEADER_LOOPEXIT:%.*]]
; CHECK:       loop.2.latch:
; CHECK-NEXT:    br i1 false, label [[EXIT:%.*]], label [[LOOP_2_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    [[LCSSA:%.*]] = phi i32 [ [[TMP0]], [[LOOP_2_LATCH]] ]
; CHECK-NEXT:    ret i32 [[LCSSA]]
;
entry:
  br label %loop.1.header

loop.1.header:
  %p.1 = phi i32 [ 0, %entry ], [ %p.2, %loop.2.header ]
  br label %loop.2.header

loop.2.header:
  %p.2 = phi i32 [ %p.1, %loop.1.header ], [ %0, %loop.2.latch ]
  br i1 %c.0, label %loop.2.latch, label %loop.1.header

loop.2.latch:
  %0 = or i32 %p.1, 1
  br i1 false, label %exit, label %loop.2.header

exit:
  %lcssa = phi i32 [ %0, %loop.2.latch ]
  ret i32 %lcssa
}


define i16 @test_pr58515_invalidate_loop_disposition(ptr %a) {
; CHECK-LABEL: @test_pr58515_invalidate_loop_disposition(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SEL:%.*]] = select i1 true, i16 2, i16 0
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ 1, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi i16 [ 0, [[ENTRY]] ], [ [[SUM_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[SUM_NEXT]] = add i16 [[SEL]], [[SUM]]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i16 [[IV]], 1
; CHECK-NEXT:    [[C_2:%.*]] = icmp ult i16 [[IV]], 9
; CHECK-NEXT:    br i1 [[C_2]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[LCSSA:%.*]] = phi i16 [ [[SUM_NEXT]], [[LOOP]] ]
; CHECK-NEXT:    ret i16 0
;
entry:
  br label %loop

loop:
  %iv = phi i16 [ 1, %entry ], [ %iv.next, %loop ]
  %sum = phi i16 [ 0, %entry ], [ %sum.next, %loop ]
  %gep = getelementptr inbounds i16, ptr %a, i16 %iv
  %c.1 = icmp ne ptr %a, %gep
  %sel = select i1 %c.1, i16 2, i16 0
  %sum.next = add i16 %sel, %sum
  %iv.next = add nuw nsw i16 %iv, 1
  %c.2 = icmp ult i16 %iv, 9
  br i1 %c.2, label %loop, label %exit

exit:
  %lcssa = phi i16 [ %sum.next, %loop ]
  ret i16 0
}

define i32 @pr58750(i16 %a, ptr %dst, i1 %c.0) {
; CHECK-LABEL: @pr58750(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP186_NOT:%.*]] = icmp eq i16 [[A:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP186_NOT]])
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    [[P_0:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[LCSSA:%.*]], [[OUTER_LATCH:%.*]] ]
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[P_0]], 0
; CHECK-NEXT:    br label [[INNER:%.*]]
; CHECK:       inner:
; CHECK-NEXT:    store i16 0, ptr [[DST:%.*]], align 1
; CHECK-NEXT:    br i1 false, label [[INNER]], label [[OUTER_LATCH]]
; CHECK:       outer.latch:
; CHECK-NEXT:    [[LCSSA]] = phi i32 [ [[XOR]], [[INNER]] ]
; CHECK-NEXT:    br i1 [[C_0:%.*]], label [[OUTER_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[LCSSA_LCSSA:%.*]] = phi i32 [ [[LCSSA]], [[OUTER_LATCH]] ]
; CHECK-NEXT:    ret i32 [[LCSSA_LCSSA]]
;
entry:
  %cmp186.not = icmp eq i16 %a, 0
  call void @llvm.assume(i1 %cmp186.not)
  br label %outer.header

outer.header:
  %p.0 = phi i32 [ 0, %entry ], [ %lcssa, %outer.latch ]
  br label %inner

inner:
  %inner.iv = phi i16 [ 0, %outer.header ], [ %inner.iv.next, %inner ]
  %p.1 = phi i32 [ %p.0, %outer.header ], [ %xor, %inner ]
  store i16 %inner.iv, ptr %dst, align 1
  %conv = sext i16 %inner.iv to i32
  %xor = xor i32 %p.1, %conv
  %inner.iv.next = add nuw i16 %inner.iv, 1
  %c.1 = icmp ult i16 %inner.iv.next, %a
  br i1 %c.1, label %inner, label %outer.latch

outer.latch:
  %lcssa = phi i32 [ %xor, %inner ]
  br i1 %c.0, label %outer.header, label %exit

exit:
  ret i32 %lcssa
}

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #1

