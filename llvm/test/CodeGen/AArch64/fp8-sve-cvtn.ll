; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mattr=+sve2,+fp8 < %s | FileCheck %s
; RUN: llc -mattr=+sme2,+fp8 --force-streaming < %s | FileCheck %s

target triple = "aarch64-linux"

define <vscale x 16 x i8> @cvtn_bf16(<vscale x 8 x bfloat> %s1, <vscale x 8 x bfloat> %s2) {
; CHECK-LABEL: cvtn_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    bfcvtn z0.b, { z0.h, z1.h }
; CHECK-NEXT:    ret
    %r = call <vscale x 16 x i8> @llvm.aarch64.sve.fp8.cvtn.nxv8bf16(<vscale x 8 x bfloat> %s1, <vscale x 8 x bfloat> %s2)
    ret <vscale x 16 x i8> %r
}

define <vscale x 16 x i8> @cvtn_f16(<vscale x 8 x half> %s1, <vscale x 8 x half> %s2) {
; CHECK-LABEL: cvtn_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    fcvtn z0.b, { z0.h, z1.h }
; CHECK-NEXT:    ret
    %r = call <vscale x 16 x i8> @llvm.aarch64.sve.fp8.cvtn.nxv8f16(<vscale x 8 x half> %s1, <vscale x 8 x half> %s2)
    ret <vscale x 16 x i8> %r
}

define <vscale x 16 x i8> @cvtnb_f32(<vscale x 4 x float> %s1, <vscale x 4 x float> %s2) {
; CHECK-LABEL: cvtnb_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    fcvtnb z0.b, { z0.s, z1.s }
; CHECK-NEXT:    ret
    %r = call <vscale x 16 x i8> @llvm.aarch64.sve.fp8.cvtnb.nxv4f32(<vscale x 4 x float> %s1, <vscale x 4 x float> %s2)
    ret <vscale x 16 x i8> %r
}

define <vscale x 16 x i8> @cvtnt_f32(<vscale x 16 x i8> %d, <vscale x 4 x float> %s1, <vscale x 4 x float> %s2) {
; CHECK-LABEL: cvtnt_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z3.d, z2.d
; CHECK-NEXT:    mov z2.d, z1.d
; CHECK-NEXT:    fcvtnt z0.b, { z2.s, z3.s }
; CHECK-NEXT:    ret
    %r = call <vscale x 16 x i8> @llvm.aarch64.sve.fp8.cvtnt.nxv4f32(<vscale x 16 x i8> %d, <vscale x 4 x float> %s1, <vscale x 4 x float> %s2)
    ret <vscale x 16 x i8> %r
}