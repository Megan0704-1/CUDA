; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -mtriple=arm-none-eabi -passes=globalopt -S | FileCheck %s

@f.string1 = private unnamed_addr constant [45 x i8] c"The quick brown dog jumps over the lazy fox.\00", align 1

; Function Attrs: nounwind
define  i32 @f() {
; CHECK-LABEL: define i32 @f() local_unnamed_addr {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[STRING1:%.*]] = alloca [48 x i8], align 1
; CHECK-NEXT:    [[POS:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TOKEN:%.*]] = alloca ptr, align 4
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 45, ptr [[STRING1]])
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i32(ptr align 1 [[STRING1]], ptr align 1 @f.string1, i32 48, i1 false)
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[POS]])
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 4, ptr [[TOKEN]])
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @strchr(ptr [[STRING1]], i32 101)
; CHECK-NEXT:    store ptr [[CALL]], ptr [[TOKEN]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[TOKEN]], align 4
; CHECK-NEXT:    [[SUB_PTR_LHS_CAST:%.*]] = ptrtoint ptr [[TMP1]] to i32
; CHECK-NEXT:    [[SUB_PTR_RHS_CAST:%.*]] = ptrtoint ptr [[STRING1]] to i32
; CHECK-NEXT:    [[SUB_PTR_SUB:%.*]] = sub i32 [[SUB_PTR_LHS_CAST]], [[SUB_PTR_RHS_CAST]]
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[SUB_PTR_SUB]], 1
; CHECK-NEXT:    store i32 [[ADD]], ptr [[POS]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[POS]], align 4
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 4, ptr [[TOKEN]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 4, ptr [[POS]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 45, ptr [[STRING1]])
; CHECK-NEXT:    ret i32 [[TMP2]]
;
entry:
  %string1 = alloca [45 x i8], align 1
  %pos = alloca i32, align 4
  %token = alloca ptr, align 4
  call void @llvm.lifetime.start.p0i8(i64 45, ptr %string1)
  call void @llvm.memcpy.p0i8.p0i8.i32(ptr align 1 %string1, ptr align 1 @f.string1, i32 45, i1 false)
  call void @llvm.lifetime.start.p0i8(i64 4, ptr %pos)
  call void @llvm.lifetime.start.p0i8(i64 4, ptr %token)
  %call = call ptr @strchr(ptr %string1, i32 101)
  store ptr %call, ptr %token, align 4
  %0 = load ptr, ptr %token, align 4
  %sub.ptr.lhs.cast = ptrtoint ptr %0 to i32
  %sub.ptr.rhs.cast = ptrtoint ptr %string1 to i32
  %sub.ptr.sub = sub i32 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %add = add nsw i32 %sub.ptr.sub, 1
  store i32 %add, ptr %pos, align 4
  %1 = load i32, ptr %pos, align 4
  call void @llvm.lifetime.end.p0i8(i64 4, ptr %token)
  call void @llvm.lifetime.end.p0i8(i64 4, ptr %pos)
  call void @llvm.lifetime.end.p0i8(i64 45, ptr %string1)
  ret i32 %1
}

declare ptr @strchr(ptr, i32)