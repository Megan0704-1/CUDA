; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 -mattr=+d < %s | FileCheck %s

%Box = type [6 x i64]

define void @box(ptr noalias nocapture noundef writeonly sret(%Box) align 16 dereferenceable(48) %b, i64 %i) {
; CHECK-LABEL: box:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -96
; CHECK-NEXT:    .cfi_def_cfa_offset 96
; CHECK-NEXT:    slli.d $a2, $a1, 5
; CHECK-NEXT:    alsl.d $a1, $a1, $a2, 4
; CHECK-NEXT:    addi.d $a2, $sp, 0
; CHECK-NEXT:    add.d $a3, $a2, $a1
; CHECK-NEXT:    vldx $vr0, $a1, $a2
; CHECK-NEXT:    vld $vr1, $a3, 32
; CHECK-NEXT:    vld $vr2, $a3, 16
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    vst $vr1, $a0, 32
; CHECK-NEXT:    vst $vr2, $a0, 16
; CHECK-NEXT:    addi.d $sp, $sp, 96
; CHECK-NEXT:    ret
  %1 = alloca [2 x %Box], align 16
  %2 = getelementptr inbounds [2 x %Box], ptr %1, i64 0, i64 %i
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(48) %b, ptr noundef nonnull align 16 dereferenceable(48) %2, i64 48, i1 false)
  ret void
}