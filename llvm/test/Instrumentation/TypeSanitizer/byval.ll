; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals --include-generated-funcs
; Test basic type sanitizer instrumentation.
; RUN: opt -passes='tysan' -S %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"


%struct.s20 = type { i32, i32, [24 x i8] }
define void @byval_test(ptr byval(%struct.s20) align 32 %x) sanitize_type {
entry:
  ret void
; NOTE: Ideally, we'd get the type from the caller's copy of the data (instead
; of setting it all to unknown).
}

%struct = type { ptr, ptr }

define ptr @test_insert_point(ptr byval(%struct) %v) {
entry:
  %name = getelementptr inbounds %struct, ptr %v, i64 0, i32 1
  %0 = load ptr, ptr %name, align 8
  ret ptr %0
}
;.
; CHECK: @llvm.used = appending global [1 x ptr] [ptr @tysan.module_ctor], section "llvm.metadata"
; CHECK: @llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 0, ptr @tysan.module_ctor, ptr null }]
; CHECK: @__tysan_shadow_memory_address = external global i64
; CHECK: @__tysan_app_memory_mask = external global i64
;.
; CHECK-LABEL: @byval_test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[APP_MEM_MASK:%.*]] = load i64, ptr @__tysan_app_memory_mask, align 8
; CHECK-NEXT:    [[SHADOW_BASE:%.*]] = load i64, ptr @__tysan_shadow_memory_address, align 8
; CHECK-NEXT:    [[TMP0:%.*]] = ptrtoint ptr [[X:%.*]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], [[APP_MEM_MASK]]
; CHECK-NEXT:    [[TMP2:%.*]] = shl i64 [[TMP1]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[TMP2]], [[SHADOW_BASE]]
; CHECK-NEXT:    [[TMP4:%.*]] = inttoptr i64 [[TMP3]] to ptr
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP4]], i8 0, i64 256, i1 false)
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: @test_insert_point(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[APP_MEM_MASK:%.*]] = load i64, ptr @__tysan_app_memory_mask, align 8
; CHECK-NEXT:    [[SHADOW_BASE:%.*]] = load i64, ptr @__tysan_shadow_memory_address, align 8
; CHECK-NEXT:    [[TMP0:%.*]] = ptrtoint ptr [[V:%.*]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], [[APP_MEM_MASK]]
; CHECK-NEXT:    [[TMP2:%.*]] = shl i64 [[TMP1]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[TMP2]], [[SHADOW_BASE]]
; CHECK-NEXT:    [[TMP4:%.*]] = inttoptr i64 [[TMP3]] to ptr
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP4]], i8 0, i64 128, i1 false)
; CHECK-NEXT:    [[NAME:%.*]] = getelementptr inbounds [[STRUCT:%.*]], ptr [[V]], i64 0, i32 1
; CHECK-NEXT:    [[APP_PTR_INT:%.*]] = ptrtoint ptr [[NAME]] to i64
; CHECK-NEXT:    [[APP_PTR_MASKED:%.*]] = and i64 [[APP_PTR_INT]], [[APP_MEM_MASK]]
; CHECK-NEXT:    [[APP_PTR_SHIFTED:%.*]] = shl i64 [[APP_PTR_MASKED]], 3
; CHECK-NEXT:    [[SHADOW_PTR_INT:%.*]] = add i64 [[APP_PTR_SHIFTED]], [[SHADOW_BASE]]
; CHECK-NEXT:    [[SHADOW_PTR:%.*]] = inttoptr i64 [[SHADOW_PTR_INT]] to ptr
; CHECK-NEXT:    [[SHADOW_DESC:%.*]] = load ptr, ptr [[SHADOW_PTR]], align 8
; CHECK-NEXT:    [[DESC_SET:%.*]] = icmp eq ptr [[SHADOW_DESC]], null
; CHECK-NEXT:    br i1 [[DESC_SET]], label [[SET_TYPE:%.*]], label [[TMP5:%.*]], !prof [[PROF0:![0-9]+]]
; CHECK:       set.type:
; CHECK-NEXT:    store ptr null, ptr [[SHADOW_PTR]], align 8
; CHECK-NEXT:    [[SHADOW_BYTE_1_OFFSET:%.*]] = add i64 [[SHADOW_PTR_INT]], 8
; CHECK-NEXT:    [[SHADOW_BYTE_1_PTR:%.*]] = inttoptr i64 [[SHADOW_BYTE_1_OFFSET]] to ptr
; CHECK-NEXT:    store ptr inttoptr (i64 -1 to ptr), ptr [[SHADOW_BYTE_1_PTR]], align 8
; CHECK-NEXT:    [[SHADOW_BYTE_2_OFFSET:%.*]] = add i64 [[SHADOW_PTR_INT]], 16
; CHECK-NEXT:    [[SHADOW_BYTE_2_PTR:%.*]] = inttoptr i64 [[SHADOW_BYTE_2_OFFSET]] to ptr
; CHECK-NEXT:    store ptr inttoptr (i64 -2 to ptr), ptr [[SHADOW_BYTE_2_PTR]], align 8
; CHECK-NEXT:    [[SHADOW_BYTE_3_OFFSET:%.*]] = add i64 [[SHADOW_PTR_INT]], 24
; CHECK-NEXT:    [[SHADOW_BYTE_3_PTR:%.*]] = inttoptr i64 [[SHADOW_BYTE_3_OFFSET]] to ptr
; CHECK-NEXT:    store ptr inttoptr (i64 -3 to ptr), ptr [[SHADOW_BYTE_3_PTR]], align 8
; CHECK-NEXT:    [[SHADOW_BYTE_4_OFFSET:%.*]] = add i64 [[SHADOW_PTR_INT]], 32
; CHECK-NEXT:    [[SHADOW_BYTE_4_PTR:%.*]] = inttoptr i64 [[SHADOW_BYTE_4_OFFSET]] to ptr
; CHECK-NEXT:    store ptr inttoptr (i64 -4 to ptr), ptr [[SHADOW_BYTE_4_PTR]], align 8
; CHECK-NEXT:    [[SHADOW_BYTE_5_OFFSET:%.*]] = add i64 [[SHADOW_PTR_INT]], 40
; CHECK-NEXT:    [[SHADOW_BYTE_5_PTR:%.*]] = inttoptr i64 [[SHADOW_BYTE_5_OFFSET]] to ptr
; CHECK-NEXT:    store ptr inttoptr (i64 -5 to ptr), ptr [[SHADOW_BYTE_5_PTR]], align 8
; CHECK-NEXT:    [[SHADOW_BYTE_6_OFFSET:%.*]] = add i64 [[SHADOW_PTR_INT]], 48
; CHECK-NEXT:    [[SHADOW_BYTE_6_PTR:%.*]] = inttoptr i64 [[SHADOW_BYTE_6_OFFSET]] to ptr
; CHECK-NEXT:    store ptr inttoptr (i64 -6 to ptr), ptr [[SHADOW_BYTE_6_PTR]], align 8
; CHECK-NEXT:    [[SHADOW_BYTE_7_OFFSET:%.*]] = add i64 [[SHADOW_PTR_INT]], 56
; CHECK-NEXT:    [[SHADOW_BYTE_7_PTR:%.*]] = inttoptr i64 [[SHADOW_BYTE_7_OFFSET]] to ptr
; CHECK-NEXT:    store ptr inttoptr (i64 -7 to ptr), ptr [[SHADOW_BYTE_7_PTR]], align 8
; CHECK-NEXT:    br label [[TMP5]]
; CHECK:       5:
; CHECK-NEXT:    [[TMP6:%.*]] = load ptr, ptr [[NAME]], align 8
; CHECK-NEXT:    ret ptr [[TMP6]]
;
;
; CHECK-LABEL: @tysan.module_ctor(
; CHECK-NEXT:    call void @__tysan_init()
; CHECK-NEXT:    ret void
;
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { sanitize_type }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nounwind }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { nocallback nofree nounwind willreturn memory(argmem: write) }
;.
; CHECK: [[PROF0]] = !{!"branch_weights", i32 1, i32 100000}
;.