; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -S -passes="msan<eager-checks;track-origins=2>" -msan-instrumentation-with-call-threshold=0 | FileCheck %s
;
; This test illustrates a bug in MemorySanitizer that will shortly be fixed
; (https://github.com/llvm/llvm-project/pull/96722).
;
; '-msan-instrumentation-with-call-threshold=0' makes it possible to detect the
; bug with a short test case.

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-grtev4-linux-gnu"

; Function Attrs: mustprogress noreturn nounwind sanitize_memory
define dso_local void @_Z1cv() local_unnamed_addr #0 {
; CHECK-LABEL: define dso_local void @_Z1cv(
; CHECK-SAME: ) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[DOTPRE:%.*]] = load <4 x i16>, ptr @_Z1cv, align 8, !tbaa [[TBAA1:![0-9]+]]
; CHECK-NEXT:    [[_MSLD:%.*]] = load <4 x i16>, ptr inttoptr (i64 xor (i64 ptrtoint (ptr @_Z1cv to i64), i64 193514046488576) to ptr), align 8
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr inttoptr (i64 add (i64 xor (i64 ptrtoint (ptr @_Z1cv to i64), i64 193514046488576), i64 35184372088832) to ptr), align 8
; CHECK-NEXT:    br label %[[FOR_COND:.*]]
; CHECK:       [[FOR_COND]]:
; CHECK-NEXT:    [[_MSPHI_S:%.*]] = phi <4 x i16> [ [[_MSLD]], %[[ENTRY]] ], [ [[_MSLD3:%.*]], %[[FOR_COND]] ]
; CHECK-NEXT:    [[_MSPHI_O:%.*]] = phi i32 [ [[TMP0]], %[[ENTRY]] ], [ [[TMP11:%.*]], %[[FOR_COND]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = phi <4 x i16> [ [[DOTPRE]], %[[ENTRY]] ], [ [[TMP5:%.*]], %[[FOR_COND]] ]
; CHECK-NEXT:    [[_MSPHI_S1:%.*]] = phi <4 x i16> [ splat (i16 -1), %[[ENTRY]] ], [ [[_MSLD3]], %[[FOR_COND]] ]
; CHECK-NEXT:    [[_MSPHI_O2:%.*]] = phi i32 [ 0, %[[ENTRY]] ], [ [[TMP11]], %[[FOR_COND]] ]
; CHECK-NEXT:    [[E_0:%.*]] = phi <4 x i16> [ undef, %[[ENTRY]] ], [ [[TMP5]], %[[FOR_COND]] ]
; CHECK-NEXT:    [[_MSPROP:%.*]] = shufflevector <4 x i16> [[_MSPHI_S1]], <4 x i16> splat (i16 -1), <4 x i32> <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[LANE:%.*]] = shufflevector <4 x i16> [[E_0]], <4 x i16> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast <4 x i16> [[_MSPHI_S]] to i64
; CHECK-NEXT:    call void @__msan_maybe_warning_8(i64 zeroext [[TMP2]], i32 zeroext [[_MSPHI_O]])
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x i16> [[_MSPROP]] to i64
; CHECK-NEXT:    call void @__msan_maybe_warning_8(i64 zeroext [[TMP3]], i32 zeroext [[_MSPHI_O2]])
; CHECK-NEXT:    [[CALL:%.*]] = tail call noundef i32 @_Z1b11__Int16x4_tS_(<4 x i16> noundef [[TMP1]], <4 x i16> noundef [[LANE]])
; CHECK-NEXT:    [[CONV:%.*]] = sext i32 [[CALL]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = inttoptr i64 [[CONV]] to ptr
; CHECK-NEXT:    [[TMP5]] = load <4 x i16>, ptr [[TMP4]], align 8, !tbaa [[TBAA1]]
; CHECK-NEXT:    [[TMP6:%.*]] = ptrtoint ptr [[TMP4]] to i64
; CHECK-NEXT:    [[TMP7:%.*]] = xor i64 [[TMP6]], 193514046488576
; CHECK-NEXT:    [[TMP8:%.*]] = inttoptr i64 [[TMP7]] to ptr
; CHECK-NEXT:    [[TMP9:%.*]] = add i64 [[TMP7]], 35184372088832
; CHECK-NEXT:    [[TMP10:%.*]] = inttoptr i64 [[TMP9]] to ptr
; CHECK-NEXT:    [[_MSLD3]] = load <4 x i16>, ptr [[TMP8]], align 8
; CHECK-NEXT:    [[TMP11]] = load i32, ptr [[TMP10]], align 8
; CHECK-NEXT:    store <4 x i16> [[_MSLD3]], ptr inttoptr (i64 xor (i64 ptrtoint (ptr @_Z1cv to i64), i64 193514046488576) to ptr), align 8
; CHECK-NEXT:    [[TMP12:%.*]] = bitcast <4 x i16> [[_MSLD3]] to i64
; CHECK-NEXT:    call void @__msan_maybe_store_origin_8(i64 zeroext [[TMP12]], ptr @_Z1cv, i32 zeroext [[TMP11]])
; CHECK-NEXT:    store <4 x i16> [[TMP5]], ptr @_Z1cv, align 8, !tbaa [[TBAA1]]
; CHECK-NEXT:    br label %[[FOR_COND]], !llvm.loop [[LOOP4:![0-9]+]]
;
entry:
  %.pre = load <4 x i16>, ptr @_Z1cv, align 8, !tbaa !2
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %0 = phi <4 x i16> [ %.pre, %entry ], [ %2, %for.cond ]
  %e.0 = phi <4 x i16> [ undef, %entry ], [ %2, %for.cond ]
  %lane = shufflevector <4 x i16> %e.0, <4 x i16> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %call = tail call noundef i32 @_Z1b11__Int16x4_tS_(<4 x i16> noundef %0, <4 x i16> noundef %lane) #2
  %conv = sext i32 %call to i64
  %1 = inttoptr i64 %conv to ptr
  %2 = load <4 x i16>, ptr %1, align 8, !tbaa !2
  store <4 x i16> %2, ptr @_Z1cv, align 8, !tbaa !2
  br label %for.cond, !llvm.loop !5
}

declare noundef i32 @_Z1b11__Int16x4_tS_(<4 x i16> noundef, <4 x i16> noundef) local_unnamed_addr #1

attributes #0 = { mustprogress noreturn nounwind sanitize_memory "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+neon" }

!2 = !{!3, !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C++ TBAA"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
;.
; CHECK: [[TBAA1]] = !{[[META2:![0-9]+]], [[META2]], i64 0}
; CHECK: [[META2]] = !{!"omnipotent char", [[META3:![0-9]+]], i64 0}
; CHECK: [[META3]] = !{!"Simple C++ TBAA"}
; CHECK: [[LOOP4]] = distinct !{[[LOOP4]], [[META5:![0-9]+]]}
; CHECK: [[META5]] = !{!"llvm.loop.mustprogress"}
;.