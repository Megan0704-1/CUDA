; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize,dce,instcombine -S -force-vector-width=4 < %s 2>%t | FileCheck %s

define void @inv_store_last_lane(ptr noalias nocapture %a, ptr noalias nocapture %inv, ptr noalias nocapture readonly %b, i64 %n) {
; CHECK-LABEL: @inv_store_last_lane(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], -4
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = shl nsw <4 x i32> [[WIDE_LOAD]], splat (i32 1)
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    store <4 x i32> [[TMP1]], ptr [[TMP2]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP3]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x i32> [[TMP1]], i64 3
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[MUL:%.*]] = shl nsw i32 [[TMP5]], 1
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 [[MUL]], ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    [[MUL_LCSSA:%.*]] = phi i32 [ [[MUL]], [[FOR_BODY]] ], [ [[TMP4]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds nuw i8, ptr [[INV:%.*]], i64 168
; CHECK-NEXT:    store i32 [[MUL_LCSSA]], ptr [[ARRAYIDX5]], align 4
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %b, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4
  %mul = shl nsw i32 %0, 1
  %arrayidx2 = getelementptr inbounds i32, ptr %a, i64 %indvars.iv
  store i32 %mul, ptr %arrayidx2, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body

exit:              ; preds = %for.body
  %arrayidx5 = getelementptr inbounds i32, ptr %inv, i64 42
  store i32 %mul, ptr %arrayidx5, align 4
  ret void
}

define float @ret_last_lane(ptr noalias nocapture %a, ptr noalias nocapture readonly %b, i64 %n) {
; CHECK-LABEL: @ret_last_lane(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], -4
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds float, ptr [[B:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = fmul <4 x float> [[WIDE_LOAD]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    store <4 x float> [[TMP1]], ptr [[TMP2]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP3]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x float> [[TMP1]], i64 3
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[B]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP5:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[TMP5]], 2.000000e+00
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds float, ptr [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store float [[MUL]], ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    [[MUL_LCSSA:%.*]] = phi float [ [[MUL]], [[FOR_BODY]] ], [ [[TMP4]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret float [[MUL_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds float, ptr %b, i64 %indvars.iv
  %0 = load float, ptr %arrayidx, align 4
  %mul = fmul float %0, 2.000000e+00
  %arrayidx2 = getelementptr inbounds float, ptr %a, i64 %indvars.iv
  store float %mul, ptr %arrayidx2, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %n
  br i1 %exitcond.not, label %exit, label %for.body

exit:                                 ; preds = %for.body, %entry
  ret float %mul
}