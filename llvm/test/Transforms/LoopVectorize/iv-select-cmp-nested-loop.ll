; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes=loop-vectorize -force-vector-interleave=1 -force-vector-width=4 -S < %s | FileCheck %s --check-prefix=CHECK-VF4IC1
; RUN: opt -passes=loop-vectorize -force-vector-interleave=4 -force-vector-width=4 -S < %s | FileCheck %s --check-prefix=CHECK-VF4IC4
; RUN: opt -passes=loop-vectorize -force-vector-interleave=4 -force-vector-width=1 -S < %s | FileCheck %s --check-prefix=CHECK-VF1IC4

; This should be an AnyOf reduction instead of FindLastIV reduction.
; The reason is the outer induction variable is invariant for inner loop.
define i64 @select_iv_def_from_outer_loop(ptr %a, i64 %start, i64 %n) {
; CHECK-VF4IC1-LABEL: define i64 @select_iv_def_from_outer_loop(
; CHECK-VF4IC1-SAME: ptr [[A:%.*]], i64 [[START:%.*]], i64 [[N:%.*]]) {
; CHECK-VF4IC1-NEXT:  [[ENTRY:.*]]:
; CHECK-VF4IC1-NEXT:    br label %[[OUTER_LOOP:.*]]
; CHECK-VF4IC1:       [[OUTER_LOOP]]:
; CHECK-VF4IC1-NEXT:    [[RDX_OUTER:%.*]] = phi i64 [ [[START]], %[[ENTRY]] ], [ [[SELECT_LCSSA:%.*]], %[[OUTER_LOOP_EXIT:.*]] ]
; CHECK-VF4IC1-NEXT:    [[IV_OUTER:%.*]] = phi i64 [ 0, %[[ENTRY]] ], [ [[IV_OUTER_NEXT:%.*]], %[[OUTER_LOOP_EXIT]] ]
; CHECK-VF4IC1-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds ptr, ptr [[A]], i64 [[IV_OUTER]]
; CHECK-VF4IC1-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARRAYIDX]], align 8
; CHECK-VF4IC1-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N]], 4
; CHECK-VF4IC1-NEXT:    br i1 [[MIN_ITERS_CHECK]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK-VF4IC1:       [[VECTOR_PH]]:
; CHECK-VF4IC1-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], 4
; CHECK-VF4IC1-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-VF4IC1-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK-VF4IC1:       [[VECTOR_BODY]]:
; CHECK-VF4IC1-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF4IC1-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i1> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP5:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF4IC1-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 0
; CHECK-VF4IC1-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[TMP1]]
; CHECK-VF4IC1-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i64, ptr [[TMP2]], i32 0
; CHECK-VF4IC1-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i64>, ptr [[TMP3]], align 8
; CHECK-VF4IC1-NEXT:    [[TMP4:%.*]] = icmp eq <4 x i64> [[WIDE_LOAD]], splat (i64 3)
; CHECK-VF4IC1-NEXT:    [[TMP5]] = or <4 x i1> [[VEC_PHI]], [[TMP4]]
; CHECK-VF4IC1-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-VF4IC1-NEXT:    [[TMP6:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-VF4IC1-NEXT:    br i1 [[TMP6]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK-VF4IC1:       [[MIDDLE_BLOCK]]:
; CHECK-VF4IC1-NEXT:    [[TMP7:%.*]] = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> [[TMP5]])
; CHECK-VF4IC1-NEXT:    [[TMP8:%.*]] = freeze i1 [[TMP7]]
; CHECK-VF4IC1-NEXT:    [[RDX_SELECT:%.*]] = select i1 [[TMP8]], i64 [[IV_OUTER]], i64 [[RDX_OUTER]]
; CHECK-VF4IC1-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-VF4IC1-NEXT:    br i1 [[CMP_N]], label %[[OUTER_LOOP_EXIT]], label %[[SCALAR_PH]]
; CHECK-VF4IC1:       [[SCALAR_PH]]:
; CHECK-VF4IC1-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i64 [ [[RDX_SELECT]], %[[MIDDLE_BLOCK]] ], [ [[RDX_OUTER]], %[[OUTER_LOOP]] ]
; CHECK-VF4IC1-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[OUTER_LOOP]] ]
; CHECK-VF4IC1-NEXT:    br label %[[INNER_LOOP:.*]]
; CHECK-VF4IC1:       [[INNER_LOOP]]:
; CHECK-VF4IC1-NEXT:    [[RDX_INNER:%.*]] = phi i64 [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ], [ [[SELECT:%.*]], %[[INNER_LOOP]] ]
; CHECK-VF4IC1-NEXT:    [[IV_INNER:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_INNER_NEXT:%.*]], %[[INNER_LOOP]] ]
; CHECK-VF4IC1-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[IV_INNER]]
; CHECK-VF4IC1-NEXT:    [[TMP9:%.*]] = load i64, ptr [[ARRAYIDX2]], align 8
; CHECK-VF4IC1-NEXT:    [[CMP:%.*]] = icmp eq i64 [[TMP9]], 3
; CHECK-VF4IC1-NEXT:    [[SELECT]] = select i1 [[CMP]], i64 [[IV_OUTER]], i64 [[RDX_INNER]]
; CHECK-VF4IC1-NEXT:    [[IV_INNER_NEXT]] = add nuw nsw i64 [[IV_INNER]], 1
; CHECK-VF4IC1-NEXT:    [[EXITCOND_NOT_INNER:%.*]] = icmp eq i64 [[IV_INNER_NEXT]], [[N]]
; CHECK-VF4IC1-NEXT:    br i1 [[EXITCOND_NOT_INNER]], label %[[OUTER_LOOP_EXIT]], label %[[INNER_LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK-VF4IC1:       [[OUTER_LOOP_EXIT]]:
; CHECK-VF4IC1-NEXT:    [[SELECT_LCSSA]] = phi i64 [ [[SELECT]], %[[INNER_LOOP]] ], [ [[RDX_SELECT]], %[[MIDDLE_BLOCK]] ]
; CHECK-VF4IC1-NEXT:    [[IV_OUTER_NEXT]] = add nuw nsw i64 [[IV_OUTER]], 1
; CHECK-VF4IC1-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_OUTER_NEXT]], [[N]]
; CHECK-VF4IC1-NEXT:    br i1 [[EXITCOND_NOT]], label %[[EXIT:.*]], label %[[OUTER_LOOP]]
; CHECK-VF4IC1:       [[EXIT]]:
; CHECK-VF4IC1-NEXT:    [[SELECT_LCSSA_LCSSA:%.*]] = phi i64 [ [[SELECT_LCSSA]], %[[OUTER_LOOP_EXIT]] ]
; CHECK-VF4IC1-NEXT:    ret i64 [[SELECT_LCSSA_LCSSA]]
;
; CHECK-VF4IC4-LABEL: define i64 @select_iv_def_from_outer_loop(
; CHECK-VF4IC4-SAME: ptr [[A:%.*]], i64 [[START:%.*]], i64 [[N:%.*]]) {
; CHECK-VF4IC4-NEXT:  [[ENTRY:.*]]:
; CHECK-VF4IC4-NEXT:    br label %[[OUTER_LOOP:.*]]
; CHECK-VF4IC4:       [[OUTER_LOOP]]:
; CHECK-VF4IC4-NEXT:    [[RDX_OUTER:%.*]] = phi i64 [ [[START]], %[[ENTRY]] ], [ [[SELECT_LCSSA:%.*]], %[[OUTER_LOOP_EXIT:.*]] ]
; CHECK-VF4IC4-NEXT:    [[IV_OUTER:%.*]] = phi i64 [ 0, %[[ENTRY]] ], [ [[IV_OUTER_NEXT:%.*]], %[[OUTER_LOOP_EXIT]] ]
; CHECK-VF4IC4-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds ptr, ptr [[A]], i64 [[IV_OUTER]]
; CHECK-VF4IC4-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARRAYIDX]], align 8
; CHECK-VF4IC4-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N]], 16
; CHECK-VF4IC4-NEXT:    br i1 [[MIN_ITERS_CHECK]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK-VF4IC4:       [[VECTOR_PH]]:
; CHECK-VF4IC4-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], 16
; CHECK-VF4IC4-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-VF4IC4-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK-VF4IC4:       [[VECTOR_BODY]]:
; CHECK-VF4IC4-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF4IC4-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i1> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP11:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF4IC4-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x i1> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP12:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF4IC4-NEXT:    [[VEC_PHI2:%.*]] = phi <4 x i1> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP13:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF4IC4-NEXT:    [[VEC_PHI3:%.*]] = phi <4 x i1> [ zeroinitializer, %[[VECTOR_PH]] ], [ [[TMP14:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF4IC4-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 0
; CHECK-VF4IC4-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[TMP1]]
; CHECK-VF4IC4-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i64, ptr [[TMP2]], i32 0
; CHECK-VF4IC4-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i64, ptr [[TMP2]], i32 4
; CHECK-VF4IC4-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i64, ptr [[TMP2]], i32 8
; CHECK-VF4IC4-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i64, ptr [[TMP2]], i32 12
; CHECK-VF4IC4-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i64>, ptr [[TMP3]], align 8
; CHECK-VF4IC4-NEXT:    [[WIDE_LOAD4:%.*]] = load <4 x i64>, ptr [[TMP4]], align 8
; CHECK-VF4IC4-NEXT:    [[WIDE_LOAD5:%.*]] = load <4 x i64>, ptr [[TMP5]], align 8
; CHECK-VF4IC4-NEXT:    [[WIDE_LOAD6:%.*]] = load <4 x i64>, ptr [[TMP6]], align 8
; CHECK-VF4IC4-NEXT:    [[TMP7:%.*]] = icmp eq <4 x i64> [[WIDE_LOAD]], splat (i64 3)
; CHECK-VF4IC4-NEXT:    [[TMP8:%.*]] = icmp eq <4 x i64> [[WIDE_LOAD4]], splat (i64 3)
; CHECK-VF4IC4-NEXT:    [[TMP9:%.*]] = icmp eq <4 x i64> [[WIDE_LOAD5]], splat (i64 3)
; CHECK-VF4IC4-NEXT:    [[TMP10:%.*]] = icmp eq <4 x i64> [[WIDE_LOAD6]], splat (i64 3)
; CHECK-VF4IC4-NEXT:    [[TMP11]] = or <4 x i1> [[VEC_PHI]], [[TMP7]]
; CHECK-VF4IC4-NEXT:    [[TMP12]] = or <4 x i1> [[VEC_PHI1]], [[TMP8]]
; CHECK-VF4IC4-NEXT:    [[TMP13]] = or <4 x i1> [[VEC_PHI2]], [[TMP9]]
; CHECK-VF4IC4-NEXT:    [[TMP14]] = or <4 x i1> [[VEC_PHI3]], [[TMP10]]
; CHECK-VF4IC4-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 16
; CHECK-VF4IC4-NEXT:    [[TMP15:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-VF4IC4-NEXT:    br i1 [[TMP15]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK-VF4IC4:       [[MIDDLE_BLOCK]]:
; CHECK-VF4IC4-NEXT:    [[BIN_RDX:%.*]] = or <4 x i1> [[TMP12]], [[TMP11]]
; CHECK-VF4IC4-NEXT:    [[BIN_RDX7:%.*]] = or <4 x i1> [[TMP13]], [[BIN_RDX]]
; CHECK-VF4IC4-NEXT:    [[BIN_RDX8:%.*]] = or <4 x i1> [[TMP14]], [[BIN_RDX7]]
; CHECK-VF4IC4-NEXT:    [[TMP16:%.*]] = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> [[BIN_RDX8]])
; CHECK-VF4IC4-NEXT:    [[TMP17:%.*]] = freeze i1 [[TMP16]]
; CHECK-VF4IC4-NEXT:    [[RDX_SELECT:%.*]] = select i1 [[TMP17]], i64 [[IV_OUTER]], i64 [[RDX_OUTER]]
; CHECK-VF4IC4-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-VF4IC4-NEXT:    br i1 [[CMP_N]], label %[[OUTER_LOOP_EXIT]], label %[[SCALAR_PH]]
; CHECK-VF4IC4:       [[SCALAR_PH]]:
; CHECK-VF4IC4-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i64 [ [[RDX_SELECT]], %[[MIDDLE_BLOCK]] ], [ [[RDX_OUTER]], %[[OUTER_LOOP]] ]
; CHECK-VF4IC4-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[OUTER_LOOP]] ]
; CHECK-VF4IC4-NEXT:    br label %[[INNER_LOOP:.*]]
; CHECK-VF4IC4:       [[INNER_LOOP]]:
; CHECK-VF4IC4-NEXT:    [[RDX_INNER:%.*]] = phi i64 [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ], [ [[SELECT:%.*]], %[[INNER_LOOP]] ]
; CHECK-VF4IC4-NEXT:    [[IV_INNER:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_INNER_NEXT:%.*]], %[[INNER_LOOP]] ]
; CHECK-VF4IC4-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[IV_INNER]]
; CHECK-VF4IC4-NEXT:    [[TMP18:%.*]] = load i64, ptr [[ARRAYIDX2]], align 8
; CHECK-VF4IC4-NEXT:    [[CMP:%.*]] = icmp eq i64 [[TMP18]], 3
; CHECK-VF4IC4-NEXT:    [[SELECT]] = select i1 [[CMP]], i64 [[IV_OUTER]], i64 [[RDX_INNER]]
; CHECK-VF4IC4-NEXT:    [[IV_INNER_NEXT]] = add nuw nsw i64 [[IV_INNER]], 1
; CHECK-VF4IC4-NEXT:    [[EXITCOND_NOT_INNER:%.*]] = icmp eq i64 [[IV_INNER_NEXT]], [[N]]
; CHECK-VF4IC4-NEXT:    br i1 [[EXITCOND_NOT_INNER]], label %[[OUTER_LOOP_EXIT]], label %[[INNER_LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK-VF4IC4:       [[OUTER_LOOP_EXIT]]:
; CHECK-VF4IC4-NEXT:    [[SELECT_LCSSA]] = phi i64 [ [[SELECT]], %[[INNER_LOOP]] ], [ [[RDX_SELECT]], %[[MIDDLE_BLOCK]] ]
; CHECK-VF4IC4-NEXT:    [[IV_OUTER_NEXT]] = add nuw nsw i64 [[IV_OUTER]], 1
; CHECK-VF4IC4-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_OUTER_NEXT]], [[N]]
; CHECK-VF4IC4-NEXT:    br i1 [[EXITCOND_NOT]], label %[[EXIT:.*]], label %[[OUTER_LOOP]]
; CHECK-VF4IC4:       [[EXIT]]:
; CHECK-VF4IC4-NEXT:    [[SELECT_LCSSA_LCSSA:%.*]] = phi i64 [ [[SELECT_LCSSA]], %[[OUTER_LOOP_EXIT]] ]
; CHECK-VF4IC4-NEXT:    ret i64 [[SELECT_LCSSA_LCSSA]]
;
; CHECK-VF1IC4-LABEL: define i64 @select_iv_def_from_outer_loop(
; CHECK-VF1IC4-SAME: ptr [[A:%.*]], i64 [[START:%.*]], i64 [[N:%.*]]) {
; CHECK-VF1IC4-NEXT:  [[ENTRY:.*]]:
; CHECK-VF1IC4-NEXT:    br label %[[OUTER_LOOP:.*]]
; CHECK-VF1IC4:       [[OUTER_LOOP]]:
; CHECK-VF1IC4-NEXT:    [[RDX_OUTER:%.*]] = phi i64 [ [[START]], %[[ENTRY]] ], [ [[SELECT_LCSSA:%.*]], %[[OUTER_LOOP_EXIT:.*]] ]
; CHECK-VF1IC4-NEXT:    [[IV_OUTER:%.*]] = phi i64 [ 0, %[[ENTRY]] ], [ [[IV_OUTER_NEXT:%.*]], %[[OUTER_LOOP_EXIT]] ]
; CHECK-VF1IC4-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds ptr, ptr [[A]], i64 [[IV_OUTER]]
; CHECK-VF1IC4-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[ARRAYIDX]], align 8
; CHECK-VF1IC4-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N]], 4
; CHECK-VF1IC4-NEXT:    br i1 [[MIN_ITERS_CHECK]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK-VF1IC4:       [[VECTOR_PH]]:
; CHECK-VF1IC4-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], 4
; CHECK-VF1IC4-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-VF1IC4-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK-VF1IC4:       [[VECTOR_BODY]]:
; CHECK-VF1IC4-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF1IC4-NEXT:    [[VEC_PHI:%.*]] = phi i1 [ false, %[[VECTOR_PH]] ], [ [[TMP17:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF1IC4-NEXT:    [[VEC_PHI1:%.*]] = phi i1 [ false, %[[VECTOR_PH]] ], [ [[TMP18:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF1IC4-NEXT:    [[VEC_PHI2:%.*]] = phi i1 [ false, %[[VECTOR_PH]] ], [ [[TMP19:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF1IC4-NEXT:    [[VEC_PHI3:%.*]] = phi i1 [ false, %[[VECTOR_PH]] ], [ [[TMP20:%.*]], %[[VECTOR_BODY]] ]
; CHECK-VF1IC4-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 0
; CHECK-VF1IC4-NEXT:    [[TMP2:%.*]] = add i64 [[INDEX]], 1
; CHECK-VF1IC4-NEXT:    [[TMP3:%.*]] = add i64 [[INDEX]], 2
; CHECK-VF1IC4-NEXT:    [[TMP4:%.*]] = add i64 [[INDEX]], 3
; CHECK-VF1IC4-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[TMP1]]
; CHECK-VF1IC4-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[TMP2]]
; CHECK-VF1IC4-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[TMP3]]
; CHECK-VF1IC4-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[TMP4]]
; CHECK-VF1IC4-NEXT:    [[TMP9:%.*]] = load i64, ptr [[TMP5]], align 8
; CHECK-VF1IC4-NEXT:    [[TMP10:%.*]] = load i64, ptr [[TMP6]], align 8
; CHECK-VF1IC4-NEXT:    [[TMP11:%.*]] = load i64, ptr [[TMP7]], align 8
; CHECK-VF1IC4-NEXT:    [[TMP12:%.*]] = load i64, ptr [[TMP8]], align 8
; CHECK-VF1IC4-NEXT:    [[TMP13:%.*]] = icmp eq i64 [[TMP9]], 3
; CHECK-VF1IC4-NEXT:    [[TMP14:%.*]] = icmp eq i64 [[TMP10]], 3
; CHECK-VF1IC4-NEXT:    [[TMP15:%.*]] = icmp eq i64 [[TMP11]], 3
; CHECK-VF1IC4-NEXT:    [[TMP16:%.*]] = icmp eq i64 [[TMP12]], 3
; CHECK-VF1IC4-NEXT:    [[TMP17]] = or i1 [[VEC_PHI]], [[TMP13]]
; CHECK-VF1IC4-NEXT:    [[TMP18]] = or i1 [[VEC_PHI1]], [[TMP14]]
; CHECK-VF1IC4-NEXT:    [[TMP19]] = or i1 [[VEC_PHI2]], [[TMP15]]
; CHECK-VF1IC4-NEXT:    [[TMP20]] = or i1 [[VEC_PHI3]], [[TMP16]]
; CHECK-VF1IC4-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-VF1IC4-NEXT:    [[TMP21:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-VF1IC4-NEXT:    br i1 [[TMP21]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK-VF1IC4:       [[MIDDLE_BLOCK]]:
; CHECK-VF1IC4-NEXT:    [[BIN_RDX:%.*]] = or i1 [[TMP18]], [[TMP17]]
; CHECK-VF1IC4-NEXT:    [[BIN_RDX4:%.*]] = or i1 [[TMP19]], [[BIN_RDX]]
; CHECK-VF1IC4-NEXT:    [[BIN_RDX5:%.*]] = or i1 [[TMP20]], [[BIN_RDX4]]
; CHECK-VF1IC4-NEXT:    [[TMP22:%.*]] = freeze i1 [[BIN_RDX5]]
; CHECK-VF1IC4-NEXT:    [[RDX_SELECT:%.*]] = select i1 [[TMP22]], i64 [[IV_OUTER]], i64 [[RDX_OUTER]]
; CHECK-VF1IC4-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-VF1IC4-NEXT:    br i1 [[CMP_N]], label %[[OUTER_LOOP_EXIT]], label %[[SCALAR_PH]]
; CHECK-VF1IC4:       [[SCALAR_PH]]:
; CHECK-VF1IC4-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i64 [ [[RDX_SELECT]], %[[MIDDLE_BLOCK]] ], [ [[RDX_OUTER]], %[[OUTER_LOOP]] ]
; CHECK-VF1IC4-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[OUTER_LOOP]] ]
; CHECK-VF1IC4-NEXT:    br label %[[INNER_LOOP:.*]]
; CHECK-VF1IC4:       [[INNER_LOOP]]:
; CHECK-VF1IC4-NEXT:    [[RDX_INNER:%.*]] = phi i64 [ [[BC_MERGE_RDX]], %[[SCALAR_PH]] ], [ [[SELECT:%.*]], %[[INNER_LOOP]] ]
; CHECK-VF1IC4-NEXT:    [[IV_INNER:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_INNER_NEXT:%.*]], %[[INNER_LOOP]] ]
; CHECK-VF1IC4-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i64, ptr [[TMP0]], i64 [[IV_INNER]]
; CHECK-VF1IC4-NEXT:    [[TMP23:%.*]] = load i64, ptr [[ARRAYIDX2]], align 8
; CHECK-VF1IC4-NEXT:    [[CMP:%.*]] = icmp eq i64 [[TMP23]], 3
; CHECK-VF1IC4-NEXT:    [[SELECT]] = select i1 [[CMP]], i64 [[IV_OUTER]], i64 [[RDX_INNER]]
; CHECK-VF1IC4-NEXT:    [[IV_INNER_NEXT]] = add nuw nsw i64 [[IV_INNER]], 1
; CHECK-VF1IC4-NEXT:    [[EXITCOND_NOT_INNER:%.*]] = icmp eq i64 [[IV_INNER_NEXT]], [[N]]
; CHECK-VF1IC4-NEXT:    br i1 [[EXITCOND_NOT_INNER]], label %[[OUTER_LOOP_EXIT]], label %[[INNER_LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK-VF1IC4:       [[OUTER_LOOP_EXIT]]:
; CHECK-VF1IC4-NEXT:    [[SELECT_LCSSA]] = phi i64 [ [[SELECT]], %[[INNER_LOOP]] ], [ [[RDX_SELECT]], %[[MIDDLE_BLOCK]] ]
; CHECK-VF1IC4-NEXT:    [[IV_OUTER_NEXT]] = add nuw nsw i64 [[IV_OUTER]], 1
; CHECK-VF1IC4-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_OUTER_NEXT]], [[N]]
; CHECK-VF1IC4-NEXT:    br i1 [[EXITCOND_NOT]], label %[[EXIT:.*]], label %[[OUTER_LOOP]]
; CHECK-VF1IC4:       [[EXIT]]:
; CHECK-VF1IC4-NEXT:    [[SELECT_LCSSA_LCSSA:%.*]] = phi i64 [ [[SELECT_LCSSA]], %[[OUTER_LOOP_EXIT]] ]
; CHECK-VF1IC4-NEXT:    ret i64 [[SELECT_LCSSA_LCSSA]]
;
entry:
  br label %outer.loop

outer.loop:
  %rdx.outer = phi i64 [ %start, %entry ], [ %select, %outer.loop.exit ]
  %iv.outer = phi i64 [ 0, %entry ], [ %iv.outer.next, %outer.loop.exit ]
  %arrayidx = getelementptr inbounds ptr, ptr %a, i64 %iv.outer
  %0 = load ptr, ptr %arrayidx, align 8
  br label %inner.loop

inner.loop:
  %rdx.inner = phi i64 [ %rdx.outer, %outer.loop ], [ %select, %inner.loop ]
  %iv.inner = phi i64 [ 0, %outer.loop ], [ %iv.inner.next, %inner.loop ]
  %arrayidx2 = getelementptr inbounds i64, ptr %0, i64 %iv.inner
  %1 = load i64, ptr %arrayidx2, align 8
  %cmp = icmp eq i64 %1, 3
  %select = select i1 %cmp, i64 %iv.outer, i64 %rdx.inner
  %iv.inner.next = add nuw nsw i64 %iv.inner, 1
  %exitcond.not.inner = icmp eq i64 %iv.inner.next, %n
  br i1 %exitcond.not.inner, label %outer.loop.exit, label %inner.loop

outer.loop.exit:
  %iv.outer.next = add nuw nsw i64 %iv.outer, 1
  %exitcond.not = icmp eq i64 %iv.outer.next, %n
  br i1 %exitcond.not, label %exit, label %outer.loop

exit:
  ret i64 %select
}
;.
; CHECK-VF4IC1: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK-VF4IC1: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK-VF4IC1: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK-VF4IC1: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
;.
; CHECK-VF4IC4: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK-VF4IC4: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK-VF4IC4: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK-VF4IC4: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
;.
; CHECK-VF1IC4: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK-VF1IC4: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK-VF1IC4: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK-VF1IC4: [[LOOP3]] = distinct !{[[LOOP3]], [[META1]]}
;.