; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -p loop-vectorize -force-vector-width=4 -force-vector-interleave=1 -S %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"

@c = global i32 1, align 4
@a = global i32 0, align 4

define void @pr75298_store_reduction_value_in_folded_loop(i64 %iv.start) optsize {
; CHECK-LABEL: define void @pr75298_store_reduction_value_in_folded_loop(
; CHECK-SAME: i64 [[IV_START:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP3:%.*]] = icmp slt i64 [[IV_START]], 7
; CHECK-NEXT:    br i1 [[CMP3]], label [[PH:%.*]], label [[EXIT:%.*]]
; CHECK:       ph:
; CHECK-NEXT:    [[TMP0:%.*]] = sub i64 7, [[IV_START]]
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[TMP0]], 3
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TRIP_COUNT_MINUS_1:%.*]] = sub i64 [[TMP0]], 1
; CHECK-NEXT:    [[IND_END:%.*]] = add i64 [[IV_START]], [[N_VEC]]
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i64> poison, i64 [[TRIP_COUNT_MINUS_1]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i64> [[BROADCAST_SPLATINSERT]], <4 x i64> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP3:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT1:%.*]] = insertelement <4 x i64> poison, i64 [[INDEX]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT2:%.*]] = shufflevector <4 x i64> [[BROADCAST_SPLATINSERT1]], <4 x i64> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[VEC_IV:%.*]] = add <4 x i64> [[BROADCAST_SPLAT2]], <i64 0, i64 1, i64 2, i64 3>
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule <4 x i64> [[VEC_IV]], [[BROADCAST_SPLAT]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr @c, align 4
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT3:%.*]] = insertelement <4 x i32> poison, i32 [[TMP2]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT4:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT3]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP3]] = xor <4 x i32> [[VEC_PHI]], [[BROADCAST_SPLAT4]]
; CHECK-NEXT:    [[TMP4:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> [[TMP3]], <4 x i32> [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> [[TMP4]])
; CHECK-NEXT:    store i32 [[TMP6]], ptr @a, align 4
; CHECK-NEXT:    br i1 true, label [[EXIT_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[IV_START]], [[PH]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ [[TMP6]], [[MIDDLE_BLOCK]] ], [ 0, [[PH]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[RED:%.*]] = phi i32 [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[RED_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr @c, align 4
; CHECK-NEXT:    [[RED_NEXT]] = xor i32 [[RED]], [[L]]
; CHECK-NEXT:    store i32 [[RED_NEXT]], ptr @a, align 4
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV_NEXT]], 7
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[EXIT_LOOPEXIT]], label [[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %cmp3 = icmp slt i64 %iv.start, 7
  br i1 %cmp3, label %ph, label %exit

ph:
  br label %loop

loop:
  %iv = phi i64 [ %iv.start, %ph ], [ %iv.next, %loop ]
  %red = phi i32 [ 0, %ph ], [ %red.next, %loop ]
  %l = load i32, ptr @c, align 4
  %red.next = xor i32 %red, %l
  store i32 %red.next, ptr @a, align 4
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, 7
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META2]], [[META1]]}
;.