; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; Test to check that instcombine doesn't drop the address space when optimizing
; memset.
%struct.Moves = type { [9 x i8], i8, i8, i8, [5 x i8] }

define i32 @test(ptr addrspace(1) nocapture %moves) {
; CHECK-LABEL: define i32 @test
; CHECK-SAME: (ptr addrspace(1) nocapture [[MOVES:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds nuw i8, ptr addrspace(1) [[MOVES]], i64 26
; CHECK-NEXT:    store i64 0, ptr addrspace(1) [[GEP]], align 1
; CHECK-NEXT:    ret i32 0
;
entry:
  %gep = getelementptr inbounds %struct.Moves, ptr addrspace(1) %moves, i32 1, i32 0, i32 9
  call void @llvm.memset.p1.i64(ptr addrspace(1) %gep, i8 0, i64 8, i1 false)
  ret i32 0
}

declare void @llvm.memset.p1.i64(ptr addrspace(1) nocapture, i8, i64, i1) nounwind