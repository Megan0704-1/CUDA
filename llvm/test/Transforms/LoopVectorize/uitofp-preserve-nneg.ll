; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes="loop-vectorize" -force-vector-interleave=1 -force-vector-width=4 -S < %s | FileCheck %s

define void @uitofp_preserve_nneg(ptr %result, i32 %size, float %y) {
; CHECK-LABEL: @uitofp_preserve_nneg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[FOR_BODY_PREHEADER4:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT2:%.*]] = insertelement <4 x float> poison, float [[Y:%.*]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT3:%.*]] = shufflevector <4 x float> [[BROADCAST_SPLATINSERT2]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX1:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX1]], 0
; CHECK-NEXT:    [[TMP0:%.*]] = uitofp nneg <4 x i32> [[VEC_IND]] to <4 x float>
; CHECK-NEXT:    [[TMP3:%.*]] = fmul <4 x float> [[TMP0]], [[BROADCAST_SPLAT3]]
; CHECK-NEXT:    [[INDEX:%.*]] = zext nneg i32 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds float, ptr [[RESULT:%.*]], i64 [[INDEX]]
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds float, ptr [[TMP2]], i32 0
; CHECK-NEXT:    store <4 x float> [[TMP3]], ptr [[TMP7]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX1]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[VEC_IND]], splat (i32 4)
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i32 [[INDEX_NEXT]], 256
; CHECK-NEXT:    br i1 [[TMP6]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[FOR_EXIT:%.*]], label [[FOR_BODY_PREHEADER4]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 256, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[TMP4:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[FOR_BODY_PREHEADER4]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[CONV:%.*]] = uitofp nneg i32 [[TMP4]] to float
; CHECK-NEXT:    [[TMP5:%.*]] = fmul float [[CONV]], [[Y]]
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = zext nneg i32 [[TMP4]] to i64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[RESULT]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store float [[TMP5]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[TMP4]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[INC]], 256
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_EXIT]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %conv = uitofp nneg i32 %iv to float
  %val = fmul float %conv, %y
  %idxprom = zext nneg i32 %iv to i64
  %arrayidx = getelementptr inbounds float, ptr %result, i64 %idxprom
  store float %val, ptr %arrayidx, align 4
  %inc = add nuw nsw i32 %iv, 1
  %cmp = icmp slt i32 %inc, 256
  br i1 %cmp, label %for.body, label %for.exit

for.exit:
  ret void
}