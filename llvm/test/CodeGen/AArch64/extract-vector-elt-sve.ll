; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 -mattr=+sve -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64 -mattr=+sve -aarch64-enable-gisel-sve=1 -global-isel -global-isel-abort=2 -verify-machineinstrs %s -o - 2>&1 | FileCheck %s --check-prefixes=CHECK,CHECK-GI

; CHECK-GI:       warning: Instruction selection used fallback path for insert_vscale_8_i16_zero
; CHECK-GI-NEXT:  warning: Instruction selection used fallback path for insert_vscale_8_i16
; CHECK-GI-NEXT:  warning: Instruction selection used fallback path for insert_vscale_16_i8_zero
; CHECK-GI-NEXT:  warning: Instruction selection used fallback path for insert_vscale_16_i8
; CHECK-GI-NEXT:  warning: Instruction selection used fallback path for extract_vscale_16_i8
; CHECK-GI-NEXT:  warning: Instruction selection used fallback path for extract_vscale_16_i8_zero

define <vscale x 2 x i64> @insert_vscale_2_i64_zero(<vscale x 2 x i64> %vec, i64 %elt) {
; CHECK-SD-LABEL: insert_vscale_2_i64_zero:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    ptrue p0.d, vl1
; CHECK-SD-NEXT:    mov z0.d, p0/m, x0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: insert_vscale_2_i64_zero:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    mov x8, xzr
; CHECK-GI-NEXT:    index z1.d, #0, #1
; CHECK-GI-NEXT:    ptrue p0.d
; CHECK-GI-NEXT:    mov z2.d, x8
; CHECK-GI-NEXT:    cmpeq p0.d, p0/z, z1.d, z2.d
; CHECK-GI-NEXT:    mov z0.d, p0/m, x0
; CHECK-GI-NEXT:    ret
entry:
  %d = insertelement <vscale x 2 x i64> %vec, i64 %elt, i64 0
  ret <vscale x 2 x i64> %d
}

define <vscale x 2 x i64> @insert_vscale_2_i64(<vscale x 2 x i64> %vec, i64 %elt, i64 %idx) {
; CHECK-LABEL: insert_vscale_2_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    index z1.d, #0, #1
; CHECK-NEXT:    mov z2.d, x1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    cmpeq p0.d, p0/z, z1.d, z2.d
; CHECK-NEXT:    mov z0.d, p0/m, x0
; CHECK-NEXT:    ret
entry:
  %d = insertelement <vscale x  2 x i64> %vec, i64 %elt, i64 %idx
  ret <vscale x 2 x i64> %d
}

define <vscale x 4 x i32> @insert_vscale_4_i32_zero(<vscale x 4 x i32> %vec, i32 %elt) {
; CHECK-SD-LABEL: insert_vscale_4_i32_zero:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    ptrue p0.s, vl1
; CHECK-SD-NEXT:    mov z0.s, p0/m, w0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: insert_vscale_4_i32_zero:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    mov w8, wzr
; CHECK-GI-NEXT:    index z1.s, #0, #1
; CHECK-GI-NEXT:    ptrue p0.s
; CHECK-GI-NEXT:    mov z2.s, w8
; CHECK-GI-NEXT:    cmpeq p0.s, p0/z, z1.s, z2.s
; CHECK-GI-NEXT:    mov z0.s, p0/m, w0
; CHECK-GI-NEXT:    ret
entry:
  %d = insertelement <vscale x 4 x i32> %vec, i32 %elt, i64 0
  ret <vscale x 4 x i32> %d
}

define <vscale x 4 x i32> @insert_vscale_4_i32(<vscale x 4 x i32> %vec, i32 %elt, i64 %idx) {
; CHECK-LABEL: insert_vscale_4_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    index z1.s, #0, #1
; CHECK-NEXT:    mov z2.s, w1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    cmpeq p0.s, p0/z, z1.s, z2.s
; CHECK-NEXT:    mov z0.s, p0/m, w0
; CHECK-NEXT:    ret
entry:
  %d = insertelement <vscale x 4 x i32> %vec, i32 %elt, i64 %idx
  ret <vscale x 4 x i32> %d
}

define <vscale x 8 x i16> @insert_vscale_8_i16_zero(<vscale x 8 x i16> %vec, i16 %elt) {
; CHECK-LABEL: insert_vscale_8_i16_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.h, vl1
; CHECK-NEXT:    mov z0.h, p0/m, w0
; CHECK-NEXT:    ret
entry:
  %d = insertelement <vscale x 8 x i16> %vec, i16 %elt, i64 0
  ret <vscale x 8 x i16> %d
}

define <vscale x 8 x i16> @insert_vscale_8_i16(<vscale x 8 x i16> %vec, i16 %elt, i64 %idx) {
; CHECK-LABEL: insert_vscale_8_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    index z1.h, #0, #1
; CHECK-NEXT:    mov z2.h, w1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    cmpeq p0.h, p0/z, z1.h, z2.h
; CHECK-NEXT:    mov z0.h, p0/m, w0
; CHECK-NEXT:    ret
entry:
  %d = insertelement <vscale x 8 x i16> %vec, i16 %elt, i64 %idx
  ret <vscale x 8 x i16> %d
}

define <vscale x 16 x i8> @insert_vscale_16_i8_zero(<vscale x 16 x i8> %vec, i8 %elt) {
; CHECK-LABEL: insert_vscale_16_i8_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.b, vl1
; CHECK-NEXT:    mov z0.b, p0/m, w0
; CHECK-NEXT:    ret
entry:
  %d = insertelement <vscale x 16 x i8> %vec, i8 %elt, i64 0
  ret <vscale x 16 x i8> %d
}

define <vscale x 16 x i8> @insert_vscale_16_i8(<vscale x 16 x i8> %vec, i8 %elt, i64 %idx) {
; CHECK-LABEL: insert_vscale_16_i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    index z1.b, #0, #1
; CHECK-NEXT:    mov z2.b, w1
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    cmpeq p0.b, p0/z, z1.b, z2.b
; CHECK-NEXT:    mov z0.b, p0/m, w0
; CHECK-NEXT:    ret
entry:
  %d = insertelement <vscale x 16 x i8> %vec, i8 %elt, i64 %idx
  ret <vscale x 16 x i8> %d
}

define i64 @extract_vscale_2_i64(<vscale x 2 x i64> %vec, i64 %idx) {
; CHECK-SD-LABEL: extract_vscale_2_i64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    whilels p0.d, xzr, x0
; CHECK-SD-NEXT:    lastb x0, p0, z0.d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: extract_vscale_2_i64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    whilels p0.d, xzr, x0
; CHECK-GI-NEXT:    lastb d0, p0, z0.d
; CHECK-GI-NEXT:    fmov x0, d0
; CHECK-GI-NEXT:    ret
entry:
  %d = extractelement <vscale x 2 x i64> %vec, i64 %idx
  ret i64 %d
}

define i64 @extract_vscale_2_i64_zero(<vscale x 2 x i64> %vec, i64 %idx) {
; CHECK-LABEL: extract_vscale_2_i64_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
entry:
  %d = extractelement <vscale x 2 x i64> %vec, i64 0
  ret i64 %d
}

define i32 @extract_vscale_4_i32(<vscale x 4 x i32> %vec, i64 %idx) {
; CHECK-SD-LABEL: extract_vscale_4_i32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    whilels p0.s, xzr, x0
; CHECK-SD-NEXT:    lastb w0, p0, z0.s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: extract_vscale_4_i32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    whilels p0.s, xzr, x0
; CHECK-GI-NEXT:    lastb s0, p0, z0.s
; CHECK-GI-NEXT:    fmov w0, s0
; CHECK-GI-NEXT:    ret
entry:
  %d = extractelement <vscale x 4 x i32> %vec, i64 %idx
  ret i32 %d
}

define i32 @extract_vscale_4_i32_zero(<vscale x 4 x i32> %vec, i64 %idx) {
; CHECK-LABEL: extract_vscale_4_i32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %d = extractelement <vscale x 4 x i32> %vec, i64 0
  ret i32 %d
}

define i16 @extract_vscale_8_i16(<vscale x 8 x i16> %vec, i64 %idx) {
; CHECK-SD-LABEL: extract_vscale_8_i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    whilels p0.h, xzr, x0
; CHECK-SD-NEXT:    lastb w0, p0, z0.h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: extract_vscale_8_i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    whilels p0.h, xzr, x0
; CHECK-GI-NEXT:    lastb h0, p0, z0.h
; CHECK-GI-NEXT:    fmov w0, s0
; CHECK-GI-NEXT:    ret
entry:
  %d = extractelement <vscale x 8 x i16> %vec, i64 %idx
  ret i16 %d
}

define i16 @extract_vscale_8_i16_zero(<vscale x 8 x i16> %vec, i64 %idx) {
; CHECK-LABEL: extract_vscale_8_i16_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %d = extractelement <vscale x 8 x i16> %vec, i64 0
  ret i16 %d
}

define i8 @extract_vscale_16_i8(<vscale x 16 x i8> %vec, i64 %idx) {
; CHECK-LABEL: extract_vscale_16_i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    whilels p0.b, xzr, x0
; CHECK-NEXT:    lastb w0, p0, z0.b
; CHECK-NEXT:    ret
entry:
  %d = extractelement <vscale x 16 x i8> %vec, i64 %idx
  ret i8 %d
}

define i8 @extract_vscale_16_i8_zero(<vscale x 16 x i8> %vec, i64 %idx) {
; CHECK-LABEL: extract_vscale_16_i8_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %d = extractelement <vscale x 16 x i8> %vec, i64 0
  ret i8 %d
}