// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --include-generated-funcs --prefix-filecheck-ir-name _ --version 5
// RUN: %clang_cc1 -triple x86_64-unknown-unknown -fopenmp -fopenmp-version=52 -x c -emit-llvm %s -o - | FileCheck %s
// expected-no-diagnostics
#define N 100
void parallel_masked_taskloop(){
	#pragma omp parallel masked taskloop
	for( int i = 0; i < N; i++)
	;

}

int main()
{
 parallel_masked_taskloop();
}
// CHECK-LABEL: define dso_local void @parallel_masked_taskloop(
// CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB1:[0-9]+]], i32 0, ptr @parallel_masked_taskloop.omp_outlined)
// CHECK-NEXT:    ret void
//
//
// CHECK-LABEL: define internal void @parallel_masked_taskloop.omp_outlined(
// CHECK-SAME: ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]]) #[[ATTR1:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[AGG_CAPTURED:%.*]] = alloca [[STRUCT_ANON:%.*]], align 1
// CHECK-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[TMP0]], align 4
// CHECK-NEXT:    [[TMP2:%.*]] = call i32 @__kmpc_masked(ptr @[[GLOB1]], i32 [[TMP1]], i32 0)
// CHECK-NEXT:    [[TMP3:%.*]] = icmp ne i32 [[TMP2]], 0
// CHECK-NEXT:    br i1 [[TMP3]], label %[[OMP_IF_THEN:.*]], label %[[OMP_IF_END:.*]]
// CHECK:       [[OMP_IF_THEN]]:
// CHECK-NEXT:    call void @__kmpc_taskgroup(ptr @[[GLOB1]], i32 [[TMP1]])
// CHECK-NEXT:    [[TMP4:%.*]] = call ptr @__kmpc_omp_task_alloc(ptr @[[GLOB1]], i32 [[TMP1]], i32 1, i64 80, i64 0, ptr @.omp_task_entry.)
// CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds nuw [[STRUCT_KMP_TASK_T_WITH_PRIVATES:%.*]], ptr [[TMP4]], i32 0, i32 0
// CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds nuw [[STRUCT_KMP_TASK_T:%.*]], ptr [[TMP5]], i32 0, i32 5
// CHECK-NEXT:    store i64 0, ptr [[TMP6]], align 8
// CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds nuw [[STRUCT_KMP_TASK_T]], ptr [[TMP5]], i32 0, i32 6
// CHECK-NEXT:    store i64 99, ptr [[TMP7]], align 8
// CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds nuw [[STRUCT_KMP_TASK_T]], ptr [[TMP5]], i32 0, i32 7
// CHECK-NEXT:    store i64 1, ptr [[TMP8]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds nuw [[STRUCT_KMP_TASK_T]], ptr [[TMP5]], i32 0, i32 9
// CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP9]], i8 0, i64 8, i1 false)
// CHECK-NEXT:    [[TMP10:%.*]] = load i64, ptr [[TMP8]], align 8
// CHECK-NEXT:    call void @__kmpc_taskloop(ptr @[[GLOB1]], i32 [[TMP1]], ptr [[TMP4]], i32 1, ptr [[TMP6]], ptr [[TMP7]], i64 [[TMP10]], i32 1, i32 0, i64 0, ptr null)
// CHECK-NEXT:    call void @__kmpc_end_taskgroup(ptr @[[GLOB1]], i32 [[TMP1]])
// CHECK-NEXT:    call void @__kmpc_end_masked(ptr @[[GLOB1]], i32 [[TMP1]])
// CHECK-NEXT:    br label %[[OMP_IF_END]]
// CHECK:       [[OMP_IF_END]]:
// CHECK-NEXT:    ret void
//
// CHECK-LABEL: define dso_local i32 @main(
// CHECK-SAME: ) #[[ATTR0]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    call void @parallel_masked_taskloop()
// CHECK-NEXT:    ret i32 0
