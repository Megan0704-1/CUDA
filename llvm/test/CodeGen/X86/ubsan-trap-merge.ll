; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -O3 -mtriple x86_64 -filetype asm -o - %s | FileCheck %s
;
; This test shows that ubsantrap can, in the absence of nomerge, be merged by
; the backend into a single ud1 instruction (thus making debugging difficult).
;
; The LLVM IR was generated from clang/test/CodeGen/ubsan-trap-merge.c with
; 'nomerge' manually removed from ubsantraps.
;
; ModuleID = '../clang/test/CodeGen/ubsan-trap-merge.c'
source_filename = "../clang/test/CodeGen/ubsan-trap-merge.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local range(i32 -2147483523, -2147483648) i32 @f(i32 noundef %x) local_unnamed_addr #0 {
; CHECK-LABEL: f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addl $125, %edi
; CHECK-NEXT:    jo .LBB0_1
; CHECK-NEXT:  # %bb.2: # %cont
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB0_1: # %trap
; CHECK-NEXT:    ud1l (%eax), %eax
entry:
  %0 = tail call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %x, i32 125), !nosanitize !5
  %1 = extractvalue { i32, i1 } %0, 1, !nosanitize !5
  br i1 %1, label %trap, label %cont, !nosanitize !5

trap:                                             ; preds = %entry
  tail call void @llvm.ubsantrap(i8 0) #4, !nosanitize !5
  unreachable, !nosanitize !5

cont:                                             ; preds = %entry
  %2 = extractvalue { i32, i1 } %0, 0, !nosanitize !5
  ret i32 %2
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) #1

; Function Attrs: cold noreturn nounwind
declare void @llvm.ubsantrap(i8 immarg) #2

; Function Attrs: nounwind uwtable
define dso_local range(i32 -2147483521, -2147483648) i32 @g(i32 noundef %x) local_unnamed_addr #0 {
; CHECK-LABEL: g:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addl $127, %edi
; CHECK-NEXT:    jo .LBB1_1
; CHECK-NEXT:  # %bb.2: # %cont
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB1_1: # %trap
; CHECK-NEXT:    ud1l (%eax), %eax
entry:
  %0 = tail call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %x, i32 127), !nosanitize !5
  %1 = extractvalue { i32, i1 } %0, 1, !nosanitize !5
  br i1 %1, label %trap, label %cont, !nosanitize !5

trap:                                             ; preds = %entry
  tail call void @llvm.ubsantrap(i8 0) #4, !nosanitize !5
  unreachable, !nosanitize !5

cont:                                             ; preds = %entry
  %2 = extractvalue { i32, i1 } %0, 0, !nosanitize !5
  ret i32 %2
}

; Function Attrs: nounwind uwtable
define dso_local range(i32 -2147483521, -2147483648) i32 @h(i32 noundef %x, i32 noundef %y) local_unnamed_addr #0 {
; CHECK-LABEL: h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addl $127, %edi
; CHECK-NEXT:    jo .LBB2_3
; CHECK-NEXT:  # %bb.1: # %cont
; CHECK-NEXT:    addl $129, %esi
; CHECK-NEXT:    jo .LBB2_3
; CHECK-NEXT:  # %bb.2: # %cont2
; CHECK-NEXT:    cmpl %esi, %edi
; CHECK-NEXT:    cmovll %edi, %esi
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB2_3: # %trap
; CHECK-NEXT:    ud1l (%eax), %eax
entry:
  %0 = tail call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %x, i32 127), !nosanitize !5
  %1 = extractvalue { i32, i1 } %0, 1, !nosanitize !5
  br i1 %1, label %trap, label %cont, !nosanitize !5

trap:                                             ; preds = %entry
  tail call void @llvm.ubsantrap(i8 0) #4, !nosanitize !5
  unreachable, !nosanitize !5

cont:                                             ; preds = %entry
  %2 = tail call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %y, i32 129), !nosanitize !5
  %3 = extractvalue { i32, i1 } %2, 1, !nosanitize !5
  br i1 %3, label %trap1, label %cont2, !nosanitize !5

trap1:                                            ; preds = %cont
  tail call void @llvm.ubsantrap(i8 0) #4, !nosanitize !5
  unreachable, !nosanitize !5

cont2:                                            ; preds = %cont
  %4 = extractvalue { i32, i1 } %2, 0, !nosanitize !5
  %5 = extractvalue { i32, i1 } %0, 0, !nosanitize !5
  %cond = tail call i32 @llvm.smin.i32(i32 %5, i32 %4)
  ret i32 %cond
}

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @m(i32 noundef %x, i32 noundef %y) local_unnamed_addr #0 {
; CHECK-LABEL: m:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addl $125, %edi
; CHECK-NEXT:    jo .LBB3_4
; CHECK-NEXT:  # %bb.1: # %f.exit
; CHECK-NEXT:    addl $127, %esi
; CHECK-NEXT:    jo .LBB3_4
; CHECK-NEXT:  # %bb.2: # %g.exit
; CHECK-NEXT:    addl %esi, %edi
; CHECK-NEXT:    jo .LBB3_4
; CHECK-NEXT:  # %bb.3: # %cont
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB3_4: # %trap.i
; CHECK-NEXT:    ud1l (%eax), %eax
entry:
  %0 = tail call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %x, i32 125), !nosanitize !5
  %1 = extractvalue { i32, i1 } %0, 1, !nosanitize !5
  br i1 %1, label %trap.i, label %f.exit, !nosanitize !5

trap.i:                                           ; preds = %entry
  tail call void @llvm.ubsantrap(i8 0) #4, !nosanitize !5
  unreachable, !nosanitize !5

f.exit:                                           ; preds = %entry
  %2 = tail call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %y, i32 127), !nosanitize !5
  %3 = extractvalue { i32, i1 } %2, 1, !nosanitize !5
  br i1 %3, label %trap.i2, label %g.exit, !nosanitize !5

trap.i2:                                          ; preds = %f.exit
  tail call void @llvm.ubsantrap(i8 0) #4, !nosanitize !5
  unreachable, !nosanitize !5

g.exit:                                           ; preds = %f.exit
  %4 = extractvalue { i32, i1 } %0, 0, !nosanitize !5
  %5 = extractvalue { i32, i1 } %2, 0, !nosanitize !5
  %6 = tail call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %4, i32 %5), !nosanitize !5
  %7 = extractvalue { i32, i1 } %6, 1, !nosanitize !5
  br i1 %7, label %trap, label %cont, !nosanitize !5

trap:                                             ; preds = %g.exit
  tail call void @llvm.ubsantrap(i8 0) #4, !nosanitize !5
  unreachable, !nosanitize !5

cont:                                             ; preds = %g.exit
  %8 = extractvalue { i32, i1 } %6, 0, !nosanitize !5
  ret i32 %8
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { cold noreturn nounwind }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 20.0.0git (https://github.com/llvm/llvm-project.git fe3c23b439b9a2d00442d9bc6a4ca86f73066a3d)"}
!5 = !{}