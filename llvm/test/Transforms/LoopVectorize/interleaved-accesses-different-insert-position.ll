; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -p loop-vectorize -force-vector-width=4 -enable-interleaved-mem-accesses=true -S %s | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"

define void @gep_for_first_member_does_not_dominate_insert_point(ptr %str, ptr noalias %dst) {
; CHECK-LABEL: define void @gep_for_first_member_does_not_dominate_insert_point(
; CHECK-SAME: ptr [[STR:%.*]], ptr noalias [[DST:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = mul i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = or disjoint i64 [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr i8, ptr [[STR]], i64 [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr i8, ptr [[TMP3]], i32 -1
; CHECK-NEXT:    [[WIDE_VEC:%.*]] = load <8 x i8>, ptr [[TMP4]], align 1
; CHECK-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <8 x i8> [[WIDE_VEC]], <8 x i8> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; CHECK-NEXT:    [[STRIDED_VEC2:%.*]] = shufflevector <8 x i8> [[WIDE_VEC]], <8 x i8> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; CHECK-NEXT:    [[TMP5:%.*]] = add <4 x i8> [[STRIDED_VEC2]], [[STRIDED_VEC]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i8, ptr [[TMP6]], i32 0
; CHECK-NEXT:    store <4 x i8> [[TMP5]], ptr [[TMP7]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq i64 [[INDEX_NEXT]], 100
; CHECK-NEXT:    br i1 [[TMP8]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[EXIT:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 100, %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL2:%.*]] = phi i64 [ 200, %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], %[[LOOP]] ]
; CHECK-NEXT:    [[IV2:%.*]] = phi i64 [ [[BC_RESUME_VAL2]], %[[SCALAR_PH]] ], [ [[IV2_NEXT:%.*]], %[[LOOP]] ]
; CHECK-NEXT:    [[OR_1:%.*]] = or disjoint i64 [[IV2]], 1
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr i8, ptr [[STR]], i64 [[OR_1]]
; CHECK-NEXT:    [[TMP9:%.*]] = load i8, ptr [[GEP1]], align 1
; CHECK-NEXT:    [[GEP0:%.*]] = getelementptr i8, ptr [[STR]], i64 [[IV2]]
; CHECK-NEXT:    [[TMP10:%.*]] = load i8, ptr [[GEP0]], align 1
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[TMP9]], [[TMP10]]
; CHECK-NEXT:    [[GEP_DST:%.*]] = getelementptr inbounds i8, ptr [[DST]], i64 [[IV]]
; CHECK-NEXT:    store i8 [[ADD]], ptr [[GEP_DST]], align 1
; CHECK-NEXT:    [[IV2_NEXT]] = add i64 [[IV2]], 2
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq i64 [[IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[EC]], label %[[EXIT]], label %[[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:                                         ; preds = %loop, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %iv2 = phi i64 [ 0, %entry ], [ %iv2.next, %loop ]
  %or.1 = or disjoint i64 %iv2, 1
  %gep1 = getelementptr i8, ptr %str, i64 %or.1
  %1 = load i8, ptr %gep1, align 1
  %gep0 = getelementptr i8, ptr %str, i64 %iv2
  %2 = load i8, ptr %gep0, align 1
  %add = add i8 %1, %2
  %gep.dst = getelementptr inbounds i8, ptr %dst, i64 %iv
  store i8 %add, ptr %gep.dst, align 1
  %iv2.next = add i64 %iv2, 2
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, 100
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @test_ig_insert_pos_at_end_of_vpbb(ptr noalias %dst, ptr noalias %src, i16 %x, i64 %N) {
; CHECK-LABEL: define void @test_ig_insert_pos_at_end_of_vpbb(
; CHECK-SAME: ptr noalias [[DST:%.*]], ptr noalias [[SRC:%.*]], i16 [[X:%.*]], i64 [[N:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[N]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ule i64 [[TMP0]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP0]], 4
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i64 [[N_MOD_VF]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], i64 4, i64 [[N_MOD_VF]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP0]], [[TMP2]]
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr nusw { i16, i16, i16, i16 }, ptr [[SRC]], i64 [[TMP3]], i32 2
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr i8, ptr [[TMP4]], i32 -4
; CHECK-NEXT:    [[WIDE_VEC:%.*]] = load <16 x i16>, ptr [[TMP5]], align 2
; CHECK-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <16 x i16> [[WIDE_VEC]], <16 x i16> poison, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
; CHECK-NEXT:    [[STRIDED_VEC1:%.*]] = shufflevector <16 x i16> [[WIDE_VEC]], <16 x i16> poison, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <4 x i16> [[STRIDED_VEC]], i32 3
; CHECK-NEXT:    store i16 [[TMP6]], ptr [[DST]], align 2
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP7:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP7]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[LOOP_HEADER:.*]]
; CHECK:       [[LOOP_HEADER]]:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; CHECK-NEXT:    [[GEP_2:%.*]] = getelementptr nusw { i16, i16, i16, i16 }, ptr [[SRC]], i64 [[IV]], i32 2
; CHECK-NEXT:    [[L_1:%.*]] = load i16, ptr [[GEP_2]], align 2
; CHECK-NEXT:    switch i16 [[L_1]], label %[[THEN:.*]] [
; CHECK-NEXT:      i16 0, label %[[LOOP_LATCH]]
; CHECK-NEXT:      i16 1, label %[[LOOP_LATCH]]
; CHECK-NEXT:    ]
; CHECK:       [[THEN]]:
; CHECK-NEXT:    br label %[[LOOP_LATCH]]
; CHECK:       [[LOOP_LATCH]]:
; CHECK-NEXT:    [[P:%.*]] = phi i16 [ [[X]], %[[THEN]] ], [ 0, %[[LOOP_HEADER]] ], [ 0, %[[LOOP_HEADER]] ]
; CHECK-NEXT:    [[GEP_0:%.*]] = getelementptr { i16, i16, i16, i16 }, ptr [[SRC]], i64 [[IV]]
; CHECK-NEXT:    [[L_2:%.*]] = load i16, ptr [[GEP_0]], align 2
; CHECK-NEXT:    store i16 [[L_2]], ptr [[DST]], align 2
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq i64 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP_HEADER]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:                                     ; preds = %loop.latch, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %gep.2 = getelementptr nusw { i16, i16, i16, i16 }, ptr %src, i64 %iv, i32 2
  %l.1 = load i16, ptr %gep.2, align 2
  switch i16 %l.1, label %then [
  i16 0, label %loop.latch
  i16 1, label %loop.latch
  ]

then:
  br label %loop.latch

loop.latch:
  %p = phi i16 [ %x, %then ], [ 0, %loop.header ], [ 0, %loop.header ]
  %gep.0 = getelementptr { i16, i16, i16, i16 }, ptr %src, i64 %iv
  %l.2 = load i16, ptr %gep.0, align 2
  store i16 %l.2, ptr %dst, align 2
  %iv.next = add nsw i64 %iv, 1
  %ec = icmp eq i64 %iv, %N
  br i1 %ec, label %exit, label %loop.header

exit:
  ret void
}

; FIXME: Currently the start address of the interleav group is computed
; incorrectly.
define i64 @interleave_group_load_pointer_type(ptr %start, ptr %end) {
; CHECK-LABEL: define i64 @interleave_group_load_pointer_type(
; CHECK-SAME: ptr [[START:%.*]], ptr [[END:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[START2:%.*]] = ptrtoint ptr [[START]] to i64
; CHECK-NEXT:    [[END1:%.*]] = ptrtoint ptr [[END]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = sub i64 [[END1]], [[START2]]
; CHECK-NEXT:    [[TMP1:%.*]] = udiv i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i64 [[TMP1]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ule i64 [[TMP2]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP2]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i64 [[N_MOD_VF]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = select i1 [[TMP3]], i64 4, i64 [[N_MOD_VF]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[N_VEC]], 24
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i8, ptr [[START]], i64 [[TMP5]]
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i64> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP12:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = mul i64 [[INDEX]], 24
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, ptr [[START]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr i8, ptr [[NEXT_GEP]], i64 16
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr i8, ptr [[TMP7]], i32 -8
; CHECK-NEXT:    [[WIDE_VEC:%.*]] = load <12 x ptr>, ptr [[TMP8]], align 8
; CHECK-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <12 x ptr> [[WIDE_VEC]], <12 x ptr> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
; CHECK-NEXT:    [[STRIDED_VEC3:%.*]] = shufflevector <12 x ptr> [[WIDE_VEC]], <12 x ptr> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
; CHECK-NEXT:    [[TMP9:%.*]] = ptrtoint <4 x ptr> [[STRIDED_VEC3]] to <4 x i64>
; CHECK-NEXT:    [[TMP10:%.*]] = ptrtoint <4 x ptr> [[STRIDED_VEC]] to <4 x i64>
; CHECK-NEXT:    [[TMP11:%.*]] = or <4 x i64> [[TMP9]], [[TMP10]]
; CHECK-NEXT:    [[TMP12]] = or <4 x i64> [[TMP11]], [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP13:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP13]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    [[TMP14:%.*]] = call i64 @llvm.vector.reduce.or.v4i64(<4 x i64> [[TMP12]])
; CHECK-NEXT:    br label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi ptr [ [[IND_END]], %[[MIDDLE_BLOCK]] ], [ [[START]], %[[ENTRY]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i64 [ [[TMP14]], %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[PTR_IV:%.*]] = phi ptr [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[PTR_IV_NEXT:%.*]], %[[LOOP]] ]
; CHECK-NEXT:    [[RED:%.*]] = phi i64 [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ], [ [[RED_NEXT:%.*]], %[[LOOP]] ]
; CHECK-NEXT:    [[GEP_16:%.*]] = getelementptr i8, ptr [[PTR_IV]], i64 16
; CHECK-NEXT:    [[L_16:%.*]] = load ptr, ptr [[GEP_16]], align 8
; CHECK-NEXT:    [[P_16:%.*]] = ptrtoint ptr [[L_16]] to i64
; CHECK-NEXT:    [[GEP_8:%.*]] = getelementptr i8, ptr [[PTR_IV]], i64 8
; CHECK-NEXT:    [[L_8:%.*]] = load ptr, ptr [[GEP_8]], align 8
; CHECK-NEXT:    [[P_8:%.*]] = ptrtoint ptr [[L_8]] to i64
; CHECK-NEXT:    [[OR_1:%.*]] = or i64 [[P_16]], [[P_8]]
; CHECK-NEXT:    [[RED_NEXT]] = or i64 [[OR_1]], [[RED]]
; CHECK-NEXT:    [[PTR_IV_NEXT]] = getelementptr nusw i8, ptr [[PTR_IV]], i64 24
; CHECK-NEXT:    [[EC:%.*]] = icmp eq ptr [[PTR_IV]], [[END]]
; CHECK-NEXT:    br i1 [[EC]], label %[[EXIT:.*]], label %[[LOOP]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    [[RED_NEXT_LCSSA:%.*]] = phi i64 [ [[RED_NEXT]], %[[LOOP]] ]
; CHECK-NEXT:    ret i64 [[RED_NEXT_LCSSA]]
;
entry:
  br label %loop

loop:
  %ptr.iv = phi ptr [ %start, %entry ], [ %ptr.iv.next, %loop ]
  %red = phi i64 [ 0, %entry ], [ %red.next, %loop ]
  %gep.16 = getelementptr i8, ptr %ptr.iv, i64 16
  %l.16 = load ptr, ptr %gep.16, align 8
  %p.16 = ptrtoint ptr %l.16 to i64
  %gep.8 = getelementptr i8, ptr %ptr.iv, i64 8
  %l.8 = load ptr, ptr %gep.8, align 8
  %p.8 = ptrtoint ptr %l.8 to i64
  %or.1 = or i64 %p.16, %p.8
  %red.next = or i64 %or.1, %red
  %ptr.iv.next = getelementptr nusw i8, ptr %ptr.iv, i64 24
  %ec = icmp eq ptr %ptr.iv, %end
  br i1 %ec, label %exit, label %loop

exit:
  ret i64 %red.next
}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
; CHECK: [[LOOP4]] = distinct !{[[LOOP4]], [[META1]], [[META2]]}
; CHECK: [[LOOP5]] = distinct !{[[LOOP5]], [[META2]], [[META1]]}
; CHECK: [[LOOP6]] = distinct !{[[LOOP6]], [[META1]], [[META2]]}
; CHECK: [[LOOP7]] = distinct !{[[LOOP7]], [[META2]], [[META1]]}
;.