; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

declare <32 x i8> @llvm.loongarch.lasx.xvbitset.b(<32 x i8>, <32 x i8>)

define <32 x i8> @lasx_xvbitset_b(<32 x i8> %va, <32 x i8> %vb) nounwind {
; CHECK-LABEL: lasx_xvbitset_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitset.b $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvbitset.b(<32 x i8> %va, <32 x i8> %vb)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvbitset.h(<16 x i16>, <16 x i16>)

define <16 x i16> @lasx_xvbitset_h(<16 x i16> %va, <16 x i16> %vb) nounwind {
; CHECK-LABEL: lasx_xvbitset_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitset.h $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvbitset.h(<16 x i16> %va, <16 x i16> %vb)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvbitset.w(<8 x i32>, <8 x i32>)

define <8 x i32> @lasx_xvbitset_w(<8 x i32> %va, <8 x i32> %vb) nounwind {
; CHECK-LABEL: lasx_xvbitset_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitset.w $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvbitset.w(<8 x i32> %va, <8 x i32> %vb)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvbitset.d(<4 x i64>, <4 x i64>)

define <4 x i64> @lasx_xvbitset_d(<4 x i64> %va, <4 x i64> %vb) nounwind {
; CHECK-LABEL: lasx_xvbitset_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitset.d $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvbitset.d(<4 x i64> %va, <4 x i64> %vb)
  ret <4 x i64> %res
}

declare <32 x i8> @llvm.loongarch.lasx.xvbitseti.b(<32 x i8>, i32)

define <32 x i8> @lasx_xvbitseti_b(<32 x i8> %va) nounwind {
; CHECK-LABEL: lasx_xvbitseti_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitseti.b $xr0, $xr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvbitseti.b(<32 x i8> %va, i32 1)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvbitseti.h(<16 x i16>, i32)

define <16 x i16> @lasx_xvbitseti_h(<16 x i16> %va) nounwind {
; CHECK-LABEL: lasx_xvbitseti_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitseti.h $xr0, $xr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvbitseti.h(<16 x i16> %va, i32 1)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvbitseti.w(<8 x i32>, i32)

define <8 x i32> @lasx_xvbitseti_w(<8 x i32> %va) nounwind {
; CHECK-LABEL: lasx_xvbitseti_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitseti.w $xr0, $xr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvbitseti.w(<8 x i32> %va, i32 1)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvbitseti.d(<4 x i64>, i32)

define <4 x i64> @lasx_xvbitseti_d(<4 x i64> %va) nounwind {
; CHECK-LABEL: lasx_xvbitseti_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitseti.d $xr0, $xr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvbitseti.d(<4 x i64> %va, i32 1)
  ret <4 x i64> %res
}