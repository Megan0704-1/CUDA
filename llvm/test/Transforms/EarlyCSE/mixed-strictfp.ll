; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes=early-cse -earlycse-debug-hash | FileCheck %s
; RUN: opt < %s -S -passes='early-cse<memssa>' | FileCheck %s

; Test use of constrained floating point intrinsics mixing the default
; floating point environment with alternate modes. None of the tests
; should trigger CSE.

define double @mixed_fadd_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fadd_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A]], double [[B]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fadd_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fadd_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fadd_strict(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fadd_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fadd.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fadd.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fsub_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fsub_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A]], double [[B]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fsub_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fsub_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fsub_strict(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fsub_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fsub.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fsub.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fmul_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fmul_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A]], double [[B]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}
define double @mixed_fmul_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fmul_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fmul_strict(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fmul_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fmul.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fmul.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fdiv_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fdiv_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A]], double [[B]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fdiv_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fdiv_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_fdiv_strict(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fdiv_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.fdiv.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.fdiv.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_frem_neginf(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_frem_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A]], double [[B]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_frem_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_frem_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define double @mixed_frem_strict(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_frem_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A:%.*]], double [[B:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.frem.f64(double [[A]], double [[B]], metadata !"round.tonearest", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP2]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.frem.f64(double %a, double %b, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %3 = call double @foo.f64(double %1, double %2) #0
  ret double %2
}

define i32 @mixed_fptoui_maytrap(double %a) #0 {
; CHECK-LABEL: @mixed_fptoui_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double [[A]], metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %2 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.maytrap") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define i32 @mixed_fptoui_strict(double %a) #0 {
; CHECK-LABEL: @mixed_fptoui_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double [[A]], metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %2 = call i32 @llvm.experimental.constrained.fptoui.i32.f64(double %a, metadata !"fpexcept.strict") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define double @mixed_uitofp_neginf(i32 %a) #0 {
; CHECK-LABEL: @mixed_uitofp_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @mixed_uitofp_maytrap(i32 %a) #0 {
; CHECK-LABEL: @mixed_uitofp_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @mixed_uitofp_strict(i32 %a) #0 {
; CHECK-LABEL: @mixed_uitofp_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 [[A]], metadata !"round.tonearest", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.uitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define i32 @mixed_fptosi_maytrap(double %a) #0 {
; CHECK-LABEL: @mixed_fptosi_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double [[A]], metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %2 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.maytrap") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define i32 @mixed_fptosi_strict(double %a) #0 {
; CHECK-LABEL: @mixed_fptosi_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double [[A:%.*]], metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double [[A]], metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @bar.i32(i32 [[TMP1]], i32 [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.ignore") #0
  %2 = call i32 @llvm.experimental.constrained.fptosi.i32.f64(double %a, metadata !"fpexcept.strict") #0
  %3 = call i32 @bar.i32(i32 %1, i32 %1) #0
  ret i32 %2
}

define double @mixed_sitofp_neginf(i32 %a) #0 {
; CHECK-LABEL: @mixed_sitofp_neginf(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A]], metadata !"round.downward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.downward", metadata !"fpexcept.ignore") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @mixed_sitofp_maytrap(i32 %a) #0 {
; CHECK-LABEL: @mixed_sitofp_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define double @mixed_sitofp_strict(i32 %a) #0 {
; CHECK-LABEL: @mixed_sitofp_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 [[A]], metadata !"round.tonearest", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = call double @foo.f64(double [[TMP1]], double [[TMP1]]) #[[ATTR0]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %1 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %2 = call double @llvm.experimental.constrained.sitofp.f64.i32(i32 %a, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %3 = call double @foo.f64(double %1, double %1) #0
  ret double %2
}

define i1 @mixed_fcmp_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fcmp_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmp.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i1 @llvm.experimental.constrained.fcmp.f64(double [[A]], double [[B]], metadata !"oeq", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @bar.i32(i32 [[TMP3]], i32 [[TMP4]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmp.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %2 = call i1 @llvm.experimental.constrained.fcmp.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.maytrap") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @mixed_fcmp_strict(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fcmp_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmp.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i1 @llvm.experimental.constrained.fcmp.f64(double [[A]], double [[B]], metadata !"oeq", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @bar.i32(i32 [[TMP3]], i32 [[TMP4]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmp.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %2 = call i1 @llvm.experimental.constrained.fcmp.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.strict") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @mixed_fcmps_maytrap(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fcmps_maytrap(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double [[A]], double [[B]], metadata !"oeq", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @bar.i32(i32 [[TMP3]], i32 [[TMP4]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmps.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %2 = call i1 @llvm.experimental.constrained.fcmps.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.maytrap") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

define i1 @mixed_fcmps_strict(double %a, double %b) #0 {
; CHECK-LABEL: @mixed_fcmps_strict(
; CHECK-NEXT:    [[TMP1:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double [[A:%.*]], double [[B:%.*]], metadata !"oeq", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double [[A]], double [[B]], metadata !"oeq", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[TMP3:%.*]] = zext i1 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = zext i1 [[TMP2]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @bar.i32(i32 [[TMP3]], i32 [[TMP4]]) #[[ATTR0]]
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = call i1 @llvm.experimental.constrained.fcmps.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.ignore") #0
  %2 = call i1 @llvm.experimental.constrained.fcmps.f64(double %a, double %b, metadata !"oeq", metadata !"fpexcept.strict") #0
  %3 = zext i1 %1 to i32
  %4 = zext i1 %2 to i32
  %5 = call i32 @bar.i32(i32 %3, i32 %4) #0
  ret i1 %2
}

attributes #0 = { strictfp }

declare void @arbitraryfunc() #0
declare double @foo.f64(double, double) #0
declare i32 @bar.i32(i32, i32) #0

declare double @llvm.experimental.constrained.fadd.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fsub.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fmul.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.fdiv.f64(double, double, metadata, metadata)
declare double @llvm.experimental.constrained.frem.f64(double, double, metadata, metadata)
declare i32 @llvm.experimental.constrained.fptoui.i32.f64(double, metadata)
declare double @llvm.experimental.constrained.uitofp.f64.i32(i32, metadata, metadata)
declare i32 @llvm.experimental.constrained.fptosi.i32.f64(double, metadata)
declare double @llvm.experimental.constrained.sitofp.f64.i32(i32, metadata, metadata)
declare i1 @llvm.experimental.constrained.fcmp.f64(double, double, metadata, metadata)
declare i1 @llvm.experimental.constrained.fcmps.f64(double, double, metadata, metadata)