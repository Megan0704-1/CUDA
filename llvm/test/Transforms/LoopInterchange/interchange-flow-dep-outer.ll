; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=loop-interchange -cache-line-size=64 -verify-dom-info -verify-loop-info -S 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

@A = common global [100 x [100 x i32]] zeroinitializer
@B = common global [100 x i32] zeroinitializer
@C = common global [100 x [100 x i32]] zeroinitializer
@D = common global [100 x [100 x [100 x i32]]] zeroinitializer
@T = internal global [100 x double] zeroinitializer, align 4
@Arr = internal global [1000 x [1000 x i32]] zeroinitializer, align 4

; Test that a flow dependency in outer loop doesn't prevent interchange in
; loops i and j.
;
;  for (int k = 0; k < 100; ++k) {
;    T[k] = fn1();
;    for (int i = 0; i < 1000; ++i)
;      for(int j = 1; j < 1000; ++j)
;        Arr[j][i] = Arr[j][i]+k;
;    fn2(T[k]);
;  }
;
; So, loops InnerLoopId = 2 and OuterLoopId = 1 should be interchanged,
; but not InnerLoopId = 1 and OuterLoopId = 0.
;
define void @interchange_09(i32 %k) {
; CHECK-LABEL: define void @interchange_09(
; CHECK-SAME: i32 [[K:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_COND_CLEANUP:.*]]:
; CHECK-NEXT:    ret void
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[INDVARS_IV45:%.*]] = phi i64 [ 0, %[[ENTRY]] ], [ [[INDVARS_IV_NEXT46:%.*]], %[[FOR_COND_CLEANUP4:.*]] ]
; CHECK-NEXT:    [[CALL:%.*]] = call double @fn1()
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [100 x double], ptr @T, i64 0, i64 [[INDVARS_IV45]]
; CHECK-NEXT:    store double [[CALL]], ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    br label %[[FOR_BODY9_PREHEADER:.*]]
; CHECK:       [[FOR_COND6_PREHEADER_PREHEADER:.*]]:
; CHECK-NEXT:    br label %[[FOR_COND6_PREHEADER:.*]]
; CHECK:       [[FOR_COND6_PREHEADER]]:
; CHECK-NEXT:    [[INDVARS_IV42:%.*]] = phi i64 [ [[INDVARS_IV_NEXT43:%.*]], %[[FOR_COND_CLEANUP8:.*]] ], [ 0, %[[FOR_COND6_PREHEADER_PREHEADER]] ]
; CHECK-NEXT:    br label %[[FOR_BODY9_SPLIT1:.*]]
; CHECK:       [[FOR_BODY9_PREHEADER]]:
; CHECK-NEXT:    br label %[[FOR_BODY9:.*]]
; CHECK:       [[FOR_COND_CLEANUP4]]:
; CHECK-NEXT:    [[TMP:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    call void @fn2(double [[TMP]])
; CHECK-NEXT:    [[INDVARS_IV_NEXT46]] = add nuw nsw i64 [[INDVARS_IV45]], 1
; CHECK-NEXT:    [[EXITCOND47:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT46]], 100
; CHECK-NEXT:    br i1 [[EXITCOND47]], label %[[FOR_BODY]], label %[[FOR_COND_CLEANUP]]
; CHECK:       [[FOR_COND_CLEANUP8]]:
; CHECK-NEXT:    [[INDVARS_IV_NEXT43]] = add nuw nsw i64 [[INDVARS_IV42]], 1
; CHECK-NEXT:    [[EXITCOND44:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT43]], 1000
; CHECK-NEXT:    br i1 [[EXITCOND44]], label %[[FOR_COND6_PREHEADER]], label %[[FOR_BODY9_SPLIT:.*]]
; CHECK:       [[FOR_BODY9]]:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[TMP0:%.*]], %[[FOR_BODY9_SPLIT]] ], [ 1, %[[FOR_BODY9_PREHEADER]] ]
; CHECK-NEXT:    br label %[[FOR_COND6_PREHEADER_PREHEADER]]
; CHECK:       [[FOR_BODY9_SPLIT1]]:
; CHECK-NEXT:    [[ARRAYIDX13:%.*]] = getelementptr inbounds [1000 x [1000 x i32]], ptr @Arr, i64 0, i64 [[INDVARS_IV]], i64 [[INDVARS_IV42]]
; CHECK-NEXT:    [[T1:%.*]] = load i32, ptr [[ARRAYIDX13]], align 4
; CHECK-NEXT:    [[T2:%.*]] = trunc i64 [[INDVARS_IV45]] to i32
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[T1]], [[T2]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[ARRAYIDX13]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT:%.*]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT]], 1000
; CHECK-NEXT:    br label %[[FOR_COND_CLEANUP8]]
; CHECK:       [[FOR_BODY9_SPLIT]]:
; CHECK-NEXT:    [[TMP0]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne i64 [[TMP0]], 1000
; CHECK-NEXT:    br i1 [[TMP1]], label %[[FOR_BODY9]], label %[[FOR_COND_CLEANUP4]]
;
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup4
  ret void

for.body:                                         ; preds = %for.cond.cleanup4, %entry
  %indvars.iv45 = phi i64 [ 0, %entry ], [ %indvars.iv.next46, %for.cond.cleanup4 ]
  %call = call double @fn1()
  %arrayidx = getelementptr inbounds [100 x double], ptr @T, i64 0, i64 %indvars.iv45
  store double %call, ptr %arrayidx, align 8
  br label %for.cond6.preheader

for.cond6.preheader:                              ; preds = %for.cond.cleanup8, %for.body
  %indvars.iv42 = phi i64 [ 0, %for.body ], [ %indvars.iv.next43, %for.cond.cleanup8 ]
  br label %for.body9

for.cond.cleanup4:                                ; preds = %for.cond.cleanup8
  %tmp = load double, ptr %arrayidx, align 8
  call void @fn2(double %tmp)
  %indvars.iv.next46 = add nuw nsw i64 %indvars.iv45, 1
  %exitcond47 = icmp ne i64 %indvars.iv.next46, 100
  br i1 %exitcond47, label %for.body, label %for.cond.cleanup

for.cond.cleanup8:                                ; preds = %for.body9
  %indvars.iv.next43 = add nuw nsw i64 %indvars.iv42, 1
  %exitcond44 = icmp ne i64 %indvars.iv.next43, 1000
  br i1 %exitcond44, label %for.cond6.preheader, label %for.cond.cleanup4

for.body9:                                        ; preds = %for.body9, %for.cond6.preheader
  %indvars.iv = phi i64 [ 1, %for.cond6.preheader ], [ %indvars.iv.next, %for.body9 ]
  %arrayidx13 = getelementptr inbounds [1000 x [1000 x i32]], ptr @Arr, i64 0, i64 %indvars.iv, i64 %indvars.iv42
  %t1 = load i32, ptr %arrayidx13, align 4
  %t2 = trunc i64 %indvars.iv45 to i32
  %add = add nsw i32 %t1, %t2
  store i32 %add, ptr %arrayidx13, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp ne i64 %indvars.iv.next, 1000
  br i1 %exitcond, label %for.body9, label %for.cond.cleanup8
}

declare double @fn1() readnone
declare void @fn2(double) readnone