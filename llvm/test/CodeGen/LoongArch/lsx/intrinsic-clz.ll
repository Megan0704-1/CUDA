; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vclz.b(<16 x i8>)

define <16 x i8> @lsx_vclz_b(<16 x i8> %va) nounwind {
; CHECK-LABEL: lsx_vclz_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vclz.b $vr0, $vr0
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vclz.b(<16 x i8> %va)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vclz.h(<8 x i16>)

define <8 x i16> @lsx_vclz_h(<8 x i16> %va) nounwind {
; CHECK-LABEL: lsx_vclz_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vclz.h $vr0, $vr0
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vclz.h(<8 x i16> %va)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vclz.w(<4 x i32>)

define <4 x i32> @lsx_vclz_w(<4 x i32> %va) nounwind {
; CHECK-LABEL: lsx_vclz_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vclz.w $vr0, $vr0
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vclz.w(<4 x i32> %va)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vclz.d(<2 x i64>)

define <2 x i64> @lsx_vclz_d(<2 x i64> %va) nounwind {
; CHECK-LABEL: lsx_vclz_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vclz.d $vr0, $vr0
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vclz.d(<2 x i64> %va)
  ret <2 x i64> %res
}