; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs --version 5
; RUN: opt -passes=print-predicateinfo -disable-output -S < %s 2>&1 | FileCheck %s --check-prefix=PREDINF
; RUN: opt -passes="ipsccp<func-spec>" -funcspec-min-function-size=1       \
; RUN:                                 -funcspec-for-literal-constant=true \
; RUN:                                 -funcspec-min-codesize-savings=50   \
; RUN:                                 -funcspec-min-latency-savings=0     \
; RUN:                                 -S < %s | FileCheck %s --check-prefix=FUNCSPEC

; Verify that we are able to estimate the codesize savings by looking through
; calls to ssa_copy intrinsics, which are inserted by PredicateInfo when IPSCCP
; is run prior to FunctionSpecialization.
define i32 @main() {
entry:
  %res = call i32 @test_ssa_copy(i32 0)
  ret i32 %res
}

define i32 @test_ssa_copy(i32 %x) {
entry:
  br label %block1

block1:
  %cmp = icmp eq i32 %x, 0
  br i1 %cmp, label %block2, label %exit1

block2:
  br i1 %cmp, label %block3, label %exit2

block3:
  br i1 %cmp, label %exit4, label %exit3

exit1:
  ret i32 %x

exit2:
  ret i32 %x

exit3:
  ret i32 %x

exit4:
  ret i32 999
}
; PREDINF-LABEL: define i32 @main() {
; PREDINF-NEXT:  [[ENTRY:.*:]]
; PREDINF-NEXT:    [[RES:%.*]] = call i32 @test_ssa_copy(i32 0)
; PREDINF-NEXT:    ret i32 [[RES]]
;
;
; PREDINF-LABEL: define i32 @test_ssa_copy(
; PREDINF-SAME: i32 [[X:%.*]]) {
; PREDINF-NEXT:  [[ENTRY:.*:]]
; PREDINF-NEXT:    br label %[[BLOCK1:.*]]
; PREDINF:       [[BLOCK1]]:
; PREDINF-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X]], 0
; PREDINF:         [[CMP_0:%.*]] = call i1 @llvm.ssa.copy.i1(i1 [[CMP]])
; PREDINF:         [[X_0:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; PREDINF:         [[X_4:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X]])
; PREDINF-NEXT:    br i1 [[CMP]], label %[[BLOCK2:.*]], label %[[EXIT1:.*]]
; PREDINF:       [[BLOCK2]]:
; PREDINF:         [[CMP_0_1:%.*]] = call i1 @llvm.ssa.copy.i1(i1 [[CMP_0]])
; PREDINF:         [[X_0_1:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X_0]])
; PREDINF:         [[X_0_3:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X_0]])
; PREDINF-NEXT:    br i1 [[CMP_0]], label %[[BLOCK3:.*]], label %[[EXIT2:.*]]
; PREDINF:       [[BLOCK3]]:
; PREDINF:         [[X_0_1_2:%.*]] = call i32 @llvm.ssa.copy.i32(i32 [[X_0_1]])
; PREDINF-NEXT:    br i1 [[CMP_0_1]], label %[[EXIT4:.*]], label %[[EXIT3:.*]]
; PREDINF:       [[EXIT1]]:
; PREDINF-NEXT:    ret i32 [[X_4]]
; PREDINF:       [[EXIT2]]:
; PREDINF-NEXT:    ret i32 [[X_0_3]]
; PREDINF:       [[EXIT3]]:
; PREDINF-NEXT:    ret i32 [[X_0_1_2]]
; PREDINF:       [[EXIT4]]:
; PREDINF-NEXT:    ret i32 999
;
;
; FUNCSPEC-LABEL: define i32 @main() {
; FUNCSPEC-NEXT:  [[ENTRY:.*:]]
; FUNCSPEC-NEXT:    [[RES:%.*]] = call i32 @test_ssa_copy.specialized.1(i32 0)
; FUNCSPEC-NEXT:    ret i32 999
;
;
; FUNCSPEC-LABEL: define range(i32 1, 0) i32 @test_ssa_copy(
; FUNCSPEC-SAME: i32 [[X:%.*]]) {
; FUNCSPEC-NEXT:  [[ENTRY:.*:]]
; FUNCSPEC-NEXT:    br label %[[BLOCK1:.*]]
; FUNCSPEC:       [[BLOCK1]]:
; FUNCSPEC-NEXT:    [[CMP:%.*]] = icmp eq i32 [[X]], 0
; FUNCSPEC-NEXT:    br i1 [[CMP]], label %[[BLOCK2:.*]], label %[[EXIT1:.*]]
; FUNCSPEC:       [[BLOCK2]]:
; FUNCSPEC-NEXT:    br label %[[BLOCK3:.*]]
; FUNCSPEC:       [[BLOCK3]]:
; FUNCSPEC-NEXT:    br label %[[EXIT4:.*]]
; FUNCSPEC:       [[EXIT1]]:
; FUNCSPEC-NEXT:    ret i32 [[X]]
; FUNCSPEC:       [[EXIT4]]:
; FUNCSPEC-NEXT:    ret i32 999
;
;
; FUNCSPEC-LABEL: define internal i32 @test_ssa_copy.specialized.1(
; FUNCSPEC-SAME: i32 [[X:%.*]]) {
; FUNCSPEC-NEXT:  [[ENTRY:.*:]]
; FUNCSPEC-NEXT:    br label %[[BLOCK1:.*]]
; FUNCSPEC:       [[BLOCK1]]:
; FUNCSPEC-NEXT:    br label %[[BLOCK2:.*]]
; FUNCSPEC:       [[BLOCK2]]:
; FUNCSPEC-NEXT:    br label %[[BLOCK3:.*]]
; FUNCSPEC:       [[BLOCK3]]:
; FUNCSPEC-NEXT:    br label %[[EXIT4:.*]]
; FUNCSPEC:       [[EXIT4]]:
; FUNCSPEC-NEXT:    ret i32 poison
;