; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -passes=loop-vectorize,instcombine -force-vector-width=4 -force-vector-interleave=1 -enable-interleaved-mem-accesses=true < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; Check that the interleaved-mem-access analysis currently does not create an
; interleave group for the access to array 'in' due to the possibly wrapping
; unsigned 'out_ix' index.
;
; In this test the interleave-group of the loads is not full (has gaps), so
; the wrapping checks are necessary. Here this cannot be done statically so
; runtime checks are needed, but with Assume=false getPtrStride cannot add
; runtime checks and as a result we can't create the interleave-group.
;
; #include <stdlib.h>
; void test(ptr __restrict__ out, ptr __restrict__ in, size_t size)
; {
;    for (size_t out_offset = 0; out_offset < size; ++out_offset)
;      {
;        float t0 = in[2*out_offset];
;        out[out_offset] = t0;
;      }
; }

define void @_Z4testPfS_m(ptr noalias nocapture %out, ptr noalias nocapture readonly %in, i64 %size) local_unnamed_addr {
; CHECK-LABEL: define void @_Z4testPfS_m(
; CHECK-SAME: ptr noalias nocapture [[OUT:%.*]], ptr noalias nocapture readonly [[IN:%.*]], i64 [[SIZE:%.*]]) local_unnamed_addr {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[CMP7:%.*]] = icmp eq i64 [[SIZE]], 0
; CHECK-NEXT:    br i1 [[CMP7]], label %[[FOR_COND_CLEANUP:.*]], label %[[FOR_BODY_PREHEADER:.*]]
; CHECK:       [[FOR_BODY_PREHEADER]]:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[SIZE]], 5
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = and i64 [[SIZE]], 3
; CHECK-NEXT:    [[TMP0:%.*]] = icmp eq i64 [[N_MOD_VF]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = select i1 [[TMP0]], i64 4, i64 [[N_MOD_VF]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[SIZE]], [[TMP1]]
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[DOTIDX:%.*]] = shl i64 [[INDEX]], 3
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, ptr [[IN]], i64 [[DOTIDX]]
; CHECK-NEXT:    [[WIDE_VEC:%.*]] = load <8 x i32>, ptr [[TMP2]], align 4
; CHECK-NEXT:    [[STRIDED_VEC:%.*]] = shufflevector <8 x i32> [[WIDE_VEC]], <8 x i32> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds float, ptr [[OUT]], i64 [[INDEX]]
; CHECK-NEXT:    store <4 x i32> [[STRIDED_VEC]], ptr [[TMP3]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP4]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_COND_CLEANUP_LOOPEXIT:.*]]:
; CHECK-NEXT:    br label %[[FOR_COND_CLEANUP]]
; CHECK:       [[FOR_COND_CLEANUP]]:
; CHECK-NEXT:    ret void
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[OUT_OFFSET_08:%.*]] = phi i64 [ [[INC:%.*]], %[[FOR_BODY]] ], [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX_IDX:%.*]] = shl i64 [[OUT_OFFSET_08]], 3
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, ptr [[IN]], i64 [[ARRAYIDX_IDX]]
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds float, ptr [[OUT]], i64 [[OUT_OFFSET_08]]
; CHECK-NEXT:    store i32 [[TMP5]], ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    [[INC]] = add nuw i64 [[OUT_OFFSET_08]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[SIZE]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_COND_CLEANUP_LOOPEXIT]], label %[[FOR_BODY]], !llvm.loop [[LOOP3:![0-9]+]]
;
entry:
  %cmp7 = icmp eq i64 %size, 0
  br i1 %cmp7, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:
  br label %for.body

for.cond.cleanup.loopexit:
  br label %for.cond.cleanup

for.cond.cleanup:
  ret void

for.body:
  %out_offset.08 = phi i64 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %mul = shl i64 %out_offset.08, 1
  %arrayidx = getelementptr inbounds float, ptr %in, i64 %mul
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds float, ptr %out, i64 %out_offset.08
  store i32 %0, ptr %arrayidx1, align 4
  %inc = add nuw i64 %out_offset.08, 1
  %exitcond = icmp eq i64 %inc, %size
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body
}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
;.