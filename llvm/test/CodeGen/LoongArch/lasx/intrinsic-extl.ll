; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

declare <4 x i64> @llvm.loongarch.lasx.xvextl.q.d(<4 x i64>)

define <4 x i64> @lasx_xvextl_q_d(<4 x i64> %va) nounwind {
; CHECK-LABEL: lasx_xvextl_q_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvextl.q.d $xr0, $xr0
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvextl.q.d(<4 x i64> %va)
  ret <4 x i64> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvextl.qu.du(<4 x i64>)

define <4 x i64> @lasx_xvextl_qu_du(<4 x i64> %va) nounwind {
; CHECK-LABEL: lasx_xvextl_qu_du:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvextl.qu.du $xr0, $xr0
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvextl.qu.du(<4 x i64> %va)
  ret <4 x i64> %res
}