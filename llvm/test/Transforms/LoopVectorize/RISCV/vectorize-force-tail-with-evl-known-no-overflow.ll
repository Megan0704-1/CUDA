; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes=loop-vectorize \
; RUN: -force-tail-folding-style=data-with-evl \
; RUN: -prefer-predicate-over-epilogue=predicate-dont-vectorize \
; RUN: -mtriple=riscv64 -mattr=+v -S < %s | FileCheck %s

; TODO: We know the IV will never overflow here so we can skip the overflow
; check

define void @trip_count_max_1024(ptr %p, i64 %tc) vscale_range(2, 1024) {
; CHECK-LABEL: define void @trip_count_max_1024(
; CHECK-SAME: ptr [[P:%.*]], i64 [[TC:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[GUARD:%.*]] = icmp ugt i64 [[TC]], 1024
; CHECK-NEXT:    br i1 [[GUARD]], label %[[EXIT:.*]], label %[[LOOP_PREHEADER:.*]]
; CHECK:       [[LOOP_PREHEADER]]:
; CHECK-NEXT:    [[UMAX:%.*]] = call i64 @llvm.umax.i64(i64 [[TC]], i64 1)
; CHECK-NEXT:    [[TMP0:%.*]] = sub i64 -1, [[UMAX]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP2:%.*]] = mul i64 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult i64 [[TMP0]], [[TMP2]]
; CHECK-NEXT:    br i1 [[TMP3]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[TMP4:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 2
; CHECK-NEXT:    [[TMP6:%.*]] = sub i64 [[TMP5]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[UMAX]], [[TMP6]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP5]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP8:%.*]] = mul i64 [[TMP7]], 2
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[EVL_BASED_IV:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_EVL_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[AVL:%.*]] = sub i64 [[UMAX]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[TMP9:%.*]] = call i32 @llvm.experimental.get.vector.length.i64(i64 [[AVL]], i32 2, i1 true)
; CHECK-NEXT:    [[TMP10:%.*]] = add i64 [[EVL_BASED_IV]], 0
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr i64, ptr [[P]], i64 [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr i64, ptr [[TMP11]], i32 0
; CHECK-NEXT:    [[VP_OP_LOAD:%.*]] = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 [[TMP12]], <vscale x 2 x i1> splat (i1 true), i32 [[TMP9]])
; CHECK-NEXT:    [[VP_OP:%.*]] = call <vscale x 2 x i64> @llvm.vp.add.nxv2i64(<vscale x 2 x i64> [[VP_OP_LOAD]], <vscale x 2 x i64> splat (i64 1), <vscale x 2 x i1> splat (i1 true), i32 [[TMP9]])
; CHECK-NEXT:    call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> [[VP_OP]], ptr align 8 [[TMP12]], <vscale x 2 x i1> splat (i1 true), i32 [[TMP9]])
; CHECK-NEXT:    [[TMP13:%.*]] = zext i32 [[TMP9]] to i64
; CHECK-NEXT:    [[INDEX_EVL_NEXT]] = add i64 [[TMP13]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], [[TMP8]]
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP14]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[EXIT_LOOPEXIT:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[LOOP_PREHEADER]] ]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ [[I_NEXT:%.*]], %[[LOOP]] ], [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i64, ptr [[P]], i64 [[I]]
; CHECK-NEXT:    [[X:%.*]] = load i64, ptr [[GEP]], align 8
; CHECK-NEXT:    [[Y:%.*]] = add i64 [[X]], 1
; CHECK-NEXT:    store i64 [[Y]], ptr [[GEP]], align 8
; CHECK-NEXT:    [[I_NEXT]] = add i64 [[I]], 1
; CHECK-NEXT:    [[DONE:%.*]] = icmp uge i64 [[I_NEXT]], [[TC]]
; CHECK-NEXT:    br i1 [[DONE]], label %[[EXIT_LOOPEXIT]], label %[[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       [[EXIT_LOOPEXIT]]:
; CHECK-NEXT:    br label %[[EXIT]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop
loop:
  %i = phi i64 [%i.next, %loop], [0, %entry]
  %gep = getelementptr i64, ptr %p, i64 %i
  %x = load i64, ptr %gep
  %y = add i64 %x, 1
  store i64 %y, ptr %gep
  %i.next = add i64 %i, 1
  %done = icmp uge i64 %i.next, %tc
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; If %tc = 0 the IV will overflow, so we need to emit an overflow check
; FIXME: The check still allows %tc =0

define void @overflow_at_0(ptr %p, i64 %tc) vscale_range(2, 1024) {
; CHECK-LABEL: define void @overflow_at_0(
; CHECK-SAME: ptr [[P:%.*]], i64 [[TC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[GUARD:%.*]] = icmp ugt i64 [[TC]], 1024
; CHECK-NEXT:    br i1 [[GUARD]], label %[[EXIT:.*]], label %[[LOOP_PREHEADER:.*]]
; CHECK:       [[LOOP_PREHEADER]]:
; CHECK-NEXT:    [[TMP0:%.*]] = sub i64 -1, [[TC]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP2:%.*]] = mul i64 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult i64 [[TMP0]], [[TMP2]]
; CHECK-NEXT:    br i1 [[TMP3]], label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[TMP4:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP5:%.*]] = mul i64 [[TMP4]], 2
; CHECK-NEXT:    [[TMP6:%.*]] = sub i64 [[TMP5]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[TC]], [[TMP6]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP5]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP7:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP8:%.*]] = mul i64 [[TMP7]], 2
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[EVL_BASED_IV:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_EVL_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[AVL:%.*]] = sub i64 [[TC]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[TMP9:%.*]] = call i32 @llvm.experimental.get.vector.length.i64(i64 [[AVL]], i32 2, i1 true)
; CHECK-NEXT:    [[TMP10:%.*]] = add i64 [[EVL_BASED_IV]], 0
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr i64, ptr [[P]], i64 [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr i64, ptr [[TMP11]], i32 0
; CHECK-NEXT:    [[VP_OP_LOAD:%.*]] = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 [[TMP12]], <vscale x 2 x i1> splat (i1 true), i32 [[TMP9]])
; CHECK-NEXT:    [[VP_OP:%.*]] = call <vscale x 2 x i64> @llvm.vp.add.nxv2i64(<vscale x 2 x i64> [[VP_OP_LOAD]], <vscale x 2 x i64> splat (i64 1), <vscale x 2 x i1> splat (i1 true), i32 [[TMP9]])
; CHECK-NEXT:    call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> [[VP_OP]], ptr align 8 [[TMP12]], <vscale x 2 x i1> splat (i1 true), i32 [[TMP9]])
; CHECK-NEXT:    [[TMP13:%.*]] = zext i32 [[TMP9]] to i64
; CHECK-NEXT:    [[INDEX_EVL_NEXT]] = add i64 [[TMP13]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], [[TMP8]]
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP14]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[EXIT_LOOPEXIT:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[LOOP_PREHEADER]] ]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ [[I_NEXT:%.*]], %[[LOOP]] ], [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i64, ptr [[P]], i64 [[I]]
; CHECK-NEXT:    [[X:%.*]] = load i64, ptr [[GEP]], align 8
; CHECK-NEXT:    [[Y:%.*]] = add i64 [[X]], 1
; CHECK-NEXT:    store i64 [[Y]], ptr [[GEP]], align 8
; CHECK-NEXT:    [[I_NEXT]] = add i64 [[I]], 1
; CHECK-NEXT:    [[DONE:%.*]] = icmp eq i64 [[I_NEXT]], [[TC]]
; CHECK-NEXT:    br i1 [[DONE]], label %[[EXIT_LOOPEXIT]], label %[[LOOP]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       [[EXIT_LOOPEXIT]]:
; CHECK-NEXT:    br label %[[EXIT]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop
loop:
  %i = phi i64 [%i.next, %loop], [0, %entry]
  %gep = getelementptr i64, ptr %p, i64 %i
  %x = load i64, ptr %gep
  %y = add i64 %x, 1
  store i64 %y, ptr %gep
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %tc
  br i1 %done, label %exit, label %loop
exit:
  ret void
}

; %tc won't = 0 so the IV won't overflow

define void @no_overflow_at_0(ptr %p, i64 %tc) vscale_range(2, 1024) {
; CHECK-LABEL: define void @no_overflow_at_0(
; CHECK-SAME: ptr [[P:%.*]], i64 [[TC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TC_ADD:%.*]] = add i64 [[TC]], 1
; CHECK-NEXT:    [[GUARD:%.*]] = icmp ugt i64 [[TC]], 1024
; CHECK-NEXT:    br i1 [[GUARD]], label %[[EXIT:.*]], label %[[LOOP_PREHEADER:.*]]
; CHECK:       [[LOOP_PREHEADER]]:
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 2
; CHECK-NEXT:    [[TMP2:%.*]] = sub i64 [[TMP1]], 1
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[TC_ADD]], [[TMP2]]
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], [[TMP1]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i64 @llvm.vscale.i64()
; CHECK-NEXT:    [[TMP4:%.*]] = mul i64 [[TMP3]], 2
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[EVL_BASED_IV:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_EVL_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[AVL:%.*]] = sub i64 [[TC_ADD]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @llvm.experimental.get.vector.length.i64(i64 [[AVL]], i32 2, i1 true)
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[EVL_BASED_IV]], 0
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr i64, ptr [[P]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr i64, ptr [[TMP7]], i32 0
; CHECK-NEXT:    [[VP_OP_LOAD:%.*]] = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr align 8 [[TMP8]], <vscale x 2 x i1> splat (i1 true), i32 [[TMP5]])
; CHECK-NEXT:    [[VP_OP:%.*]] = call <vscale x 2 x i64> @llvm.vp.add.nxv2i64(<vscale x 2 x i64> [[VP_OP_LOAD]], <vscale x 2 x i64> splat (i64 1), <vscale x 2 x i1> splat (i1 true), i32 [[TMP5]])
; CHECK-NEXT:    call void @llvm.vp.store.nxv2i64.p0(<vscale x 2 x i64> [[VP_OP]], ptr align 8 [[TMP8]], <vscale x 2 x i1> splat (i1 true), i32 [[TMP5]])
; CHECK-NEXT:    [[TMP9:%.*]] = zext i32 [[TMP5]] to i64
; CHECK-NEXT:    [[INDEX_EVL_NEXT]] = add nuw i64 [[TMP9]], [[EVL_BASED_IV]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP4]]
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP10]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[EXIT_LOOPEXIT:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[LOOP_PREHEADER]] ]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ [[I_NEXT:%.*]], %[[LOOP]] ], [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i64, ptr [[P]], i64 [[I]]
; CHECK-NEXT:    [[X:%.*]] = load i64, ptr [[GEP]], align 8
; CHECK-NEXT:    [[Y:%.*]] = add i64 [[X]], 1
; CHECK-NEXT:    store i64 [[Y]], ptr [[GEP]], align 8
; CHECK-NEXT:    [[I_NEXT]] = add i64 [[I]], 1
; CHECK-NEXT:    [[DONE:%.*]] = icmp eq i64 [[I_NEXT]], [[TC_ADD]]
; CHECK-NEXT:    br i1 [[DONE]], label %[[EXIT_LOOPEXIT]], label %[[LOOP]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       [[EXIT_LOOPEXIT]]:
; CHECK-NEXT:    br label %[[EXIT]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  %tc.add = add nuw i64 %tc, 1
  %guard = icmp ugt i64 %tc, 1024
  br i1 %guard, label %exit, label %loop
loop:
  %i = phi i64 [%i.next, %loop], [0, %entry]
  %gep = getelementptr i64, ptr %p, i64 %i
  %x = load i64, ptr %gep
  %y = add i64 %x, 1
  store i64 %y, ptr %gep
  %i.next = add i64 %i, 1
  %done = icmp eq i64 %i.next, %tc.add
  br i1 %done, label %exit, label %loop
exit:
  ret void
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