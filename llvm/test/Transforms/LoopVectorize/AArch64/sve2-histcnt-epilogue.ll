; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt < %s -mattr=+sve2 -passes=loop-vectorize,instcombine -enable-histogram-loop-vectorization -sve-gather-overhead=2 -sve-scatter-overhead=2 -epilogue-vectorization-minimum-VF=4 -debug-only=loop-vectorize -force-vector-interleave=1 -S 2>&1 | FileCheck %s
; REQUIRES: asserts

target triple = "aarch64-unknown-linux-gnu"

define void @simple_histogram(ptr noalias %buckets, ptr readonly %indices, i64 %N) {
; CHECK-LABEL: define void @simple_histogram(
; CHECK-SAME: ptr noalias [[BUCKETS:%.*]], ptr readonly [[INDICES:%.*]], i64 [[N:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  iter.check:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = shl i64 [[TMP0]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N]], [[TMP1]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.main.loop.iter.check:
; CHECK-NEXT:    [[TMP6:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[TMP6]], 2
; CHECK-NEXT:    [[MIN_ITERS_CHECK1:%.*]] = icmp ult i64 [[N]], [[TMP3]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK1]], label [[VEC_EPILOG_PH:%.*]], label [[VECTOR_PH1:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP7:%.*]] = shl i64 [[TMP2]], 2
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], [[TMP7]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP4:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP5:%.*]] = shl i64 [[TMP4]], 2
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH1]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i32, ptr [[INDICES]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD1:%.*]] = load <vscale x 4 x i32>, ptr [[TMP8]], align 4
; CHECK-NEXT:    [[TMP14:%.*]] = zext <vscale x 4 x i32> [[WIDE_LOAD1]] to <vscale x 4 x i64>
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds i32, ptr [[BUCKETS]], <vscale x 4 x i64> [[TMP14]]
; CHECK-NEXT:    call void @llvm.experimental.vector.histogram.add.nxv4p0.i32(<vscale x 4 x ptr> [[TMP15]], i32 1, <vscale x 4 x i1> splat (i1 true))
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP5]]
; CHECK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_MOD_VF]], 0
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_EXIT:%.*]], label [[VEC_EPILOG_ITER_CHECK:%.*]]
; CHECK:       vec.epilog.iter.check:
; CHECK-NEXT:    [[TMP22:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP23:%.*]] = shl i64 [[TMP22]], 1
; CHECK-NEXT:    [[MIN_EPILOG_ITERS_CHECK:%.*]] = icmp ult i64 [[N_MOD_VF]], [[TMP23]]
; CHECK-NEXT:    br i1 [[MIN_EPILOG_ITERS_CHECK]], label [[SCALAR_PH]], label [[VEC_EPILOG_PH]]
; CHECK:       vec.epilog.ph:
; CHECK-NEXT:    [[VEC_EPILOG_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ], [ 0, [[VECTOR_PH]] ]
; CHECK-NEXT:    [[TMP24:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP25:%.*]] = shl i64 [[TMP24]], 1
; CHECK-NEXT:    [[N_MOD_VF2:%.*]] = urem i64 [[N]], [[TMP25]]
; CHECK-NEXT:    [[N_VEC3:%.*]] = sub i64 [[N]], [[N_MOD_VF2]]
; CHECK-NEXT:    [[TMP16:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP17:%.*]] = shl i64 [[TMP16]], 1
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       vec.epilog.vector.body:
; CHECK-NEXT:    [[INDEX4:%.*]] = phi i64 [ [[VEC_EPILOG_RESUME_VAL]], [[VEC_EPILOG_PH]] ], [ [[INDEX_NEXT6:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i32, ptr [[INDICES]], i64 [[INDEX4]]
; CHECK-NEXT:    [[WIDE_LOAD5:%.*]] = load <vscale x 2 x i32>, ptr [[TMP18]], align 4
; CHECK-NEXT:    [[TMP19:%.*]] = zext <vscale x 2 x i32> [[WIDE_LOAD5]] to <vscale x 2 x i64>
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr inbounds i32, ptr [[BUCKETS]], <vscale x 2 x i64> [[TMP19]]
; CHECK-NEXT:    call void @llvm.experimental.vector.histogram.add.nxv2p0.i32(<vscale x 2 x ptr> [[TMP20]], i32 1, <vscale x 2 x i1> splat (i1 true))
; CHECK-NEXT:    [[INDEX_NEXT6]] = add nuw i64 [[INDEX4]], [[TMP17]]
; CHECK-NEXT:    [[TMP21:%.*]] = icmp eq i64 [[INDEX_NEXT6]], [[N_VEC3]]
; CHECK-NEXT:    br i1 [[TMP21]], label [[VEC_EPILOG_MIDDLE_BLOCK:%.*]], label [[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       vec.epilog.middle.block:
; CHECK-NEXT:    [[CMP_N7:%.*]] = icmp eq i64 [[N_MOD_VF2]], 0
; CHECK-NEXT:    br i1 [[CMP_N7]], label [[FOR_EXIT]], label [[SCALAR_PH]]
; CHECK:       vec.epilog.scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC3]], [[VEC_EPILOG_MIDDLE_BLOCK]] ], [ 0, [[ITER_CHECK:%.*]] ], [ [[N_VEC]], [[VEC_EPILOG_ITER_CHECK]] ]
; CHECK-NEXT:    br label [[FOR_BODY1:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[FOR_BODY1]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[INDICES]], i64 [[IV]]
; CHECK-NEXT:    [[TMP12:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[IDXPROM1:%.*]] = zext i32 [[TMP12]] to i64
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds nuw i32, ptr [[BUCKETS]], i64 [[IDXPROM1]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i32, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[INC:%.*]] = add nsw i32 [[TMP13]], 1
; CHECK-NEXT:    store i32 [[INC]], ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_EXIT]], label [[FOR_BODY1]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       for.exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %for.body ]
  %gep.indices = getelementptr inbounds i32, ptr %indices, i64 %iv
  %l.idx = load i32, ptr %gep.indices, align 4
  %idxprom1 = zext i32 %l.idx to i64
  %gep.bucket = getelementptr inbounds i32, ptr %buckets, i64 %idxprom1
  %l.bucket = load i32, ptr %gep.bucket, align 4
  %inc = add nsw i32 %l.bucket, 1
  store i32 %inc, ptr %gep.bucket, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, %N
  br i1 %exitcond, label %for.exit, label %for.body

for.exit:
  ret void
}