; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -p indvars -S %s | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"

; Test for https://github.com/llvm/llvm-project/issues/82243.
; Check that NUW flag on hoisted wide IV is dropped properly.
define void @test_pr82243(ptr %f) {
; CHECK-LABEL: define void @test_pr82243(
; CHECK-SAME: ptr [[F:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[OUTER_LATCH:%.*]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[GEP_IV_EXT:%.*]] = getelementptr i32, ptr [[F]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 1, ptr [[GEP_IV_EXT]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[TMP0:%.*]] = trunc nuw nsw i64 [[INDVARS_IV_NEXT]] to i32
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 123, [[TMP0]]
; CHECK-NEXT:    [[GEP_SHL:%.*]] = getelementptr i32, ptr [[F]], i32 [[SHL]]
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    store i32 0, ptr [[GEP_SHL]], align 4
; CHECK-NEXT:    br i1 false, label [[INNER_LATCH:%.*]], label [[EXIT:%.*]]
; CHECK:       inner.latch:
; CHECK-NEXT:    br i1 false, label [[INNER_HEADER]], label [[OUTER_LATCH]]
; CHECK:       outer.latch:
; CHECK-NEXT:    br label [[OUTER_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %outer.header

outer.header:
  %iv = phi i32 [ 1, %entry ], [ %iv.next, %outer.latch ]
  %iv.sext = sext i32 %iv to i64
  %gep.iv.ext = getelementptr i32, ptr %f, i64 %iv.sext
  store i32 1, ptr %gep.iv.ext
  %sub = add i32 %iv, -1
  %shl = shl i32 123, %sub
  %gep.shl = getelementptr i32, ptr %f, i32 %shl
  br label %inner.header

inner.header:
  store i32 0, ptr %gep.shl, align 4
  br i1 false, label %inner.latch, label %exit

inner.latch:
  br i1 false, label %inner.header, label %outer.latch

outer.latch:
  %iv.next = add i32 %iv, -1
  br label %outer.header

exit:
  ret void
}