; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=aarch64 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,NEON-FIXED
; RUN: llc -mtriple=aarch64 -mattr=+sve -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,SVE-FIXED

define i8 @extract_last_i8(<16 x i8> %data, <16 x i8> %mask, i8 %passthru) {
; NEON-FIXED-LABEL: extract_last_i8:
; NEON-FIXED:       // %bb.0:
; NEON-FIXED-NEXT:    sub sp, sp, #16
; NEON-FIXED-NEXT:    .cfi_def_cfa_offset 16
; NEON-FIXED-NEXT:    cmeq v2.16b, v1.16b, #0
; NEON-FIXED-NEXT:    adrp x8, .LCPI0_0
; NEON-FIXED-NEXT:    cmtst v1.16b, v1.16b, v1.16b
; NEON-FIXED-NEXT:    ldr q3, [x8, :lo12:.LCPI0_0]
; NEON-FIXED-NEXT:    mov x9, sp
; NEON-FIXED-NEXT:    str q0, [sp]
; NEON-FIXED-NEXT:    bic v2.16b, v3.16b, v2.16b
; NEON-FIXED-NEXT:    umaxv b1, v1.16b
; NEON-FIXED-NEXT:    umaxv b2, v2.16b
; NEON-FIXED-NEXT:    fmov w8, s2
; NEON-FIXED-NEXT:    bfxil x9, x8, #0, #4
; NEON-FIXED-NEXT:    ldrb w8, [x9]
; NEON-FIXED-NEXT:    fmov w9, s1
; NEON-FIXED-NEXT:    tst w9, #0x1
; NEON-FIXED-NEXT:    csel w0, w8, w0, ne
; NEON-FIXED-NEXT:    add sp, sp, #16
; NEON-FIXED-NEXT:    ret
;
; SVE-FIXED-LABEL: extract_last_i8:
; SVE-FIXED:       // %bb.0:
; SVE-FIXED-NEXT:    sub sp, sp, #16
; SVE-FIXED-NEXT:    .cfi_def_cfa_offset 16
; SVE-FIXED-NEXT:    index z2.b, #0, #1
; SVE-FIXED-NEXT:    cmeq v3.16b, v1.16b, #0
; SVE-FIXED-NEXT:    cmtst v1.16b, v1.16b, v1.16b
; SVE-FIXED-NEXT:    mov x9, sp
; SVE-FIXED-NEXT:    str q0, [sp]
; SVE-FIXED-NEXT:    bic v2.16b, v2.16b, v3.16b
; SVE-FIXED-NEXT:    umaxv b1, v1.16b
; SVE-FIXED-NEXT:    umaxv b2, v2.16b
; SVE-FIXED-NEXT:    fmov w8, s2
; SVE-FIXED-NEXT:    bfxil x9, x8, #0, #4
; SVE-FIXED-NEXT:    ldrb w8, [x9]
; SVE-FIXED-NEXT:    fmov w9, s1
; SVE-FIXED-NEXT:    tst w9, #0x1
; SVE-FIXED-NEXT:    csel w0, w8, w0, ne
; SVE-FIXED-NEXT:    add sp, sp, #16
; SVE-FIXED-NEXT:    ret
  %notzero = icmp ne <16 x i8> %mask, zeroinitializer
  %res = call i8 @llvm.experimental.vector.extract.last.active.v16i8(<16 x i8> %data, <16 x i1> %notzero, i8 %passthru)
  ret i8 %res
}

define i16 @extract_last_i16(<8 x i16> %data, <8 x i16> %mask, i16 %passthru) {
; NEON-FIXED-LABEL: extract_last_i16:
; NEON-FIXED:       // %bb.0:
; NEON-FIXED-NEXT:    sub sp, sp, #16
; NEON-FIXED-NEXT:    .cfi_def_cfa_offset 16
; NEON-FIXED-NEXT:    cmtst v1.8h, v1.8h, v1.8h
; NEON-FIXED-NEXT:    adrp x8, .LCPI1_0
; NEON-FIXED-NEXT:    mov x9, sp
; NEON-FIXED-NEXT:    ldr d3, [x8, :lo12:.LCPI1_0]
; NEON-FIXED-NEXT:    str q0, [sp]
; NEON-FIXED-NEXT:    xtn v2.8b, v1.8h
; NEON-FIXED-NEXT:    umaxv h1, v1.8h
; NEON-FIXED-NEXT:    and v2.8b, v2.8b, v3.8b
; NEON-FIXED-NEXT:    umaxv b2, v2.8b
; NEON-FIXED-NEXT:    fmov w8, s2
; NEON-FIXED-NEXT:    bfi x9, x8, #1, #3
; NEON-FIXED-NEXT:    ldrh w8, [x9]
; NEON-FIXED-NEXT:    fmov w9, s1
; NEON-FIXED-NEXT:    tst w9, #0x1
; NEON-FIXED-NEXT:    csel w0, w8, w0, ne
; NEON-FIXED-NEXT:    add sp, sp, #16
; NEON-FIXED-NEXT:    ret
;
; SVE-FIXED-LABEL: extract_last_i16:
; SVE-FIXED:       // %bb.0:
; SVE-FIXED-NEXT:    sub sp, sp, #16
; SVE-FIXED-NEXT:    .cfi_def_cfa_offset 16
; SVE-FIXED-NEXT:    cmtst v1.8h, v1.8h, v1.8h
; SVE-FIXED-NEXT:    index z3.b, #0, #1
; SVE-FIXED-NEXT:    mov x9, sp
; SVE-FIXED-NEXT:    str q0, [sp]
; SVE-FIXED-NEXT:    xtn v2.8b, v1.8h
; SVE-FIXED-NEXT:    umaxv h1, v1.8h
; SVE-FIXED-NEXT:    and v2.8b, v2.8b, v3.8b
; SVE-FIXED-NEXT:    umaxv b2, v2.8b
; SVE-FIXED-NEXT:    fmov w8, s2
; SVE-FIXED-NEXT:    bfi x9, x8, #1, #3
; SVE-FIXED-NEXT:    ldrh w8, [x9]
; SVE-FIXED-NEXT:    fmov w9, s1
; SVE-FIXED-NEXT:    tst w9, #0x1
; SVE-FIXED-NEXT:    csel w0, w8, w0, ne
; SVE-FIXED-NEXT:    add sp, sp, #16
; SVE-FIXED-NEXT:    ret
  %notzero = icmp ne <8 x i16> %mask, zeroinitializer
  %res = call i16 @llvm.experimental.vector.extract.last.active.v8i16(<8 x i16> %data, <8 x i1> %notzero, i16 %passthru)
  ret i16 %res
}

define i32 @extract_last_i32(<4 x i32> %data, <4 x i32> %mask, i32 %passthru) {
; NEON-FIXED-LABEL: extract_last_i32:
; NEON-FIXED:       // %bb.0:
; NEON-FIXED-NEXT:    sub sp, sp, #16
; NEON-FIXED-NEXT:    .cfi_def_cfa_offset 16
; NEON-FIXED-NEXT:    cmtst v1.4s, v1.4s, v1.4s
; NEON-FIXED-NEXT:    adrp x8, .LCPI2_0
; NEON-FIXED-NEXT:    mov x9, sp
; NEON-FIXED-NEXT:    ldr d3, [x8, :lo12:.LCPI2_0]
; NEON-FIXED-NEXT:    str q0, [sp]
; NEON-FIXED-NEXT:    xtn v2.4h, v1.4s
; NEON-FIXED-NEXT:    umaxv s1, v1.4s
; NEON-FIXED-NEXT:    and v2.8b, v2.8b, v3.8b
; NEON-FIXED-NEXT:    umaxv h2, v2.4h
; NEON-FIXED-NEXT:    fmov w8, s2
; NEON-FIXED-NEXT:    bfi x9, x8, #2, #2
; NEON-FIXED-NEXT:    ldr w8, [x9]
; NEON-FIXED-NEXT:    fmov w9, s1
; NEON-FIXED-NEXT:    tst w9, #0x1
; NEON-FIXED-NEXT:    csel w0, w8, w0, ne
; NEON-FIXED-NEXT:    add sp, sp, #16
; NEON-FIXED-NEXT:    ret
;
; SVE-FIXED-LABEL: extract_last_i32:
; SVE-FIXED:       // %bb.0:
; SVE-FIXED-NEXT:    sub sp, sp, #16
; SVE-FIXED-NEXT:    .cfi_def_cfa_offset 16
; SVE-FIXED-NEXT:    cmtst v1.4s, v1.4s, v1.4s
; SVE-FIXED-NEXT:    index z3.h, #0, #1
; SVE-FIXED-NEXT:    mov x9, sp
; SVE-FIXED-NEXT:    str q0, [sp]
; SVE-FIXED-NEXT:    xtn v2.4h, v1.4s
; SVE-FIXED-NEXT:    umaxv s1, v1.4s
; SVE-FIXED-NEXT:    and v2.8b, v2.8b, v3.8b
; SVE-FIXED-NEXT:    umaxv h2, v2.4h
; SVE-FIXED-NEXT:    fmov w8, s2
; SVE-FIXED-NEXT:    bfi x9, x8, #2, #2
; SVE-FIXED-NEXT:    ldr w8, [x9]
; SVE-FIXED-NEXT:    fmov w9, s1
; SVE-FIXED-NEXT:    tst w9, #0x1
; SVE-FIXED-NEXT:    csel w0, w8, w0, ne
; SVE-FIXED-NEXT:    add sp, sp, #16
; SVE-FIXED-NEXT:    ret
  %notzero = icmp ne <4 x i32> %mask, zeroinitializer
  %res = call i32 @llvm.experimental.vector.extract.last.active.v4i32(<4 x i32> %data, <4 x i1> %notzero, i32 %passthru)
  ret i32 %res
}

define i64 @extract_last_i64(<2 x i64> %data, <2 x i64> %mask, i64 %passthru) {
; NEON-FIXED-LABEL: extract_last_i64:
; NEON-FIXED:       // %bb.0:
; NEON-FIXED-NEXT:    sub sp, sp, #16
; NEON-FIXED-NEXT:    .cfi_def_cfa_offset 16
; NEON-FIXED-NEXT:    cmtst v1.2d, v1.2d, v1.2d
; NEON-FIXED-NEXT:    adrp x8, .LCPI3_0
; NEON-FIXED-NEXT:    mov x9, sp
; NEON-FIXED-NEXT:    ldr d3, [x8, :lo12:.LCPI3_0]
; NEON-FIXED-NEXT:    str q0, [sp]
; NEON-FIXED-NEXT:    xtn v2.2s, v1.2d
; NEON-FIXED-NEXT:    umaxv s1, v1.4s
; NEON-FIXED-NEXT:    and v2.8b, v2.8b, v3.8b
; NEON-FIXED-NEXT:    umaxp v2.2s, v2.2s, v2.2s
; NEON-FIXED-NEXT:    fmov w8, s2
; NEON-FIXED-NEXT:    bfi x9, x8, #3, #1
; NEON-FIXED-NEXT:    ldr x8, [x9]
; NEON-FIXED-NEXT:    fmov w9, s1
; NEON-FIXED-NEXT:    tst w9, #0x1
; NEON-FIXED-NEXT:    csel x0, x8, x0, ne
; NEON-FIXED-NEXT:    add sp, sp, #16
; NEON-FIXED-NEXT:    ret
;
; SVE-FIXED-LABEL: extract_last_i64:
; SVE-FIXED:       // %bb.0:
; SVE-FIXED-NEXT:    sub sp, sp, #16
; SVE-FIXED-NEXT:    .cfi_def_cfa_offset 16
; SVE-FIXED-NEXT:    cmtst v1.2d, v1.2d, v1.2d
; SVE-FIXED-NEXT:    index z3.s, #0, #1
; SVE-FIXED-NEXT:    mov x9, sp
; SVE-FIXED-NEXT:    str q0, [sp]
; SVE-FIXED-NEXT:    xtn v2.2s, v1.2d
; SVE-FIXED-NEXT:    umaxv s1, v1.4s
; SVE-FIXED-NEXT:    and v2.8b, v2.8b, v3.8b
; SVE-FIXED-NEXT:    umaxp v2.2s, v2.2s, v2.2s
; SVE-FIXED-NEXT:    fmov w8, s2
; SVE-FIXED-NEXT:    bfi x9, x8, #3, #1
; SVE-FIXED-NEXT:    ldr x8, [x9]
; SVE-FIXED-NEXT:    fmov w9, s1
; SVE-FIXED-NEXT:    tst w9, #0x1
; SVE-FIXED-NEXT:    csel x0, x8, x0, ne
; SVE-FIXED-NEXT:    add sp, sp, #16
; SVE-FIXED-NEXT:    ret
  %notzero = icmp ne <2 x i64> %mask, zeroinitializer
  %res = call i64 @llvm.experimental.vector.extract.last.active.v2i64(<2 x i64> %data, <2 x i1> %notzero, i64 %passthru)
  ret i64 %res
}

define float @extract_last_float(<4 x float> %data, <4 x i32> %mask, float %passthru) {
; NEON-FIXED-LABEL: extract_last_float:
; NEON-FIXED:       // %bb.0:
; NEON-FIXED-NEXT:    sub sp, sp, #16
; NEON-FIXED-NEXT:    .cfi_def_cfa_offset 16
; NEON-FIXED-NEXT:    cmtst v1.4s, v1.4s, v1.4s
; NEON-FIXED-NEXT:    adrp x8, .LCPI4_0
; NEON-FIXED-NEXT:    mov x9, sp
; NEON-FIXED-NEXT:    ldr d4, [x8, :lo12:.LCPI4_0]
; NEON-FIXED-NEXT:    str q0, [sp]
; NEON-FIXED-NEXT:    xtn v3.4h, v1.4s
; NEON-FIXED-NEXT:    umaxv s1, v1.4s
; NEON-FIXED-NEXT:    and v3.8b, v3.8b, v4.8b
; NEON-FIXED-NEXT:    umaxv h3, v3.4h
; NEON-FIXED-NEXT:    fmov w8, s3
; NEON-FIXED-NEXT:    bfi x9, x8, #2, #2
; NEON-FIXED-NEXT:    fmov w8, s1
; NEON-FIXED-NEXT:    ldr s0, [x9]
; NEON-FIXED-NEXT:    tst w8, #0x1
; NEON-FIXED-NEXT:    fcsel s0, s0, s2, ne
; NEON-FIXED-NEXT:    add sp, sp, #16
; NEON-FIXED-NEXT:    ret
;
; SVE-FIXED-LABEL: extract_last_float:
; SVE-FIXED:       // %bb.0:
; SVE-FIXED-NEXT:    sub sp, sp, #16
; SVE-FIXED-NEXT:    .cfi_def_cfa_offset 16
; SVE-FIXED-NEXT:    cmtst v1.4s, v1.4s, v1.4s
; SVE-FIXED-NEXT:    index z4.h, #0, #1
; SVE-FIXED-NEXT:    mov x9, sp
; SVE-FIXED-NEXT:    str q0, [sp]
; SVE-FIXED-NEXT:    xtn v3.4h, v1.4s
; SVE-FIXED-NEXT:    umaxv s1, v1.4s
; SVE-FIXED-NEXT:    and v3.8b, v3.8b, v4.8b
; SVE-FIXED-NEXT:    umaxv h3, v3.4h
; SVE-FIXED-NEXT:    fmov w8, s3
; SVE-FIXED-NEXT:    bfi x9, x8, #2, #2
; SVE-FIXED-NEXT:    fmov w8, s1
; SVE-FIXED-NEXT:    ldr s0, [x9]
; SVE-FIXED-NEXT:    tst w8, #0x1
; SVE-FIXED-NEXT:    fcsel s0, s0, s2, ne
; SVE-FIXED-NEXT:    add sp, sp, #16
; SVE-FIXED-NEXT:    ret
  %notzero = icmp ne <4 x i32> %mask, zeroinitializer
  %res = call float @llvm.experimental.vector.extract.last.active.v4f32(<4 x float> %data, <4 x i1> %notzero, float %passthru)
  ret float %res
}

define double @extract_last_double(<2 x double> %data, <2 x i64> %mask, double %passthru) {
; NEON-FIXED-LABEL: extract_last_double:
; NEON-FIXED:       // %bb.0:
; NEON-FIXED-NEXT:    sub sp, sp, #16
; NEON-FIXED-NEXT:    .cfi_def_cfa_offset 16
; NEON-FIXED-NEXT:    cmtst v1.2d, v1.2d, v1.2d
; NEON-FIXED-NEXT:    adrp x8, .LCPI5_0
; NEON-FIXED-NEXT:    mov x9, sp
; NEON-FIXED-NEXT:    ldr d4, [x8, :lo12:.LCPI5_0]
; NEON-FIXED-NEXT:    str q0, [sp]
; NEON-FIXED-NEXT:    xtn v3.2s, v1.2d
; NEON-FIXED-NEXT:    umaxv s1, v1.4s
; NEON-FIXED-NEXT:    and v3.8b, v3.8b, v4.8b
; NEON-FIXED-NEXT:    umaxp v3.2s, v3.2s, v3.2s
; NEON-FIXED-NEXT:    fmov w8, s3
; NEON-FIXED-NEXT:    bfi x9, x8, #3, #1
; NEON-FIXED-NEXT:    fmov w8, s1
; NEON-FIXED-NEXT:    ldr d0, [x9]
; NEON-FIXED-NEXT:    tst w8, #0x1
; NEON-FIXED-NEXT:    fcsel d0, d0, d2, ne
; NEON-FIXED-NEXT:    add sp, sp, #16
; NEON-FIXED-NEXT:    ret
;
; SVE-FIXED-LABEL: extract_last_double:
; SVE-FIXED:       // %bb.0:
; SVE-FIXED-NEXT:    sub sp, sp, #16
; SVE-FIXED-NEXT:    .cfi_def_cfa_offset 16
; SVE-FIXED-NEXT:    cmtst v1.2d, v1.2d, v1.2d
; SVE-FIXED-NEXT:    index z4.s, #0, #1
; SVE-FIXED-NEXT:    mov x9, sp
; SVE-FIXED-NEXT:    str q0, [sp]
; SVE-FIXED-NEXT:    xtn v3.2s, v1.2d
; SVE-FIXED-NEXT:    umaxv s1, v1.4s
; SVE-FIXED-NEXT:    and v3.8b, v3.8b, v4.8b
; SVE-FIXED-NEXT:    umaxp v3.2s, v3.2s, v3.2s
; SVE-FIXED-NEXT:    fmov w8, s3
; SVE-FIXED-NEXT:    bfi x9, x8, #3, #1
; SVE-FIXED-NEXT:    fmov w8, s1
; SVE-FIXED-NEXT:    ldr d0, [x9]
; SVE-FIXED-NEXT:    tst w8, #0x1
; SVE-FIXED-NEXT:    fcsel d0, d0, d2, ne
; SVE-FIXED-NEXT:    add sp, sp, #16
; SVE-FIXED-NEXT:    ret
  %notzero = icmp ne <2 x i64> %mask, zeroinitializer
  %res = call double @llvm.experimental.vector.extract.last.active.v2f64(<2 x double> %data, <2 x i1> %notzero, double %passthru)
  ret double %res
}

define i8 @extract_last_i8_scalable(<vscale x 16 x i8> %data, <vscale x 16 x i1> %mask, i8 %passthru) #0 {
; CHECK-LABEL: extract_last_i8_scalable:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z1.b, #0, #1
; CHECK-NEXT:    mov z2.b, #0 // =0x0
; CHECK-NEXT:    ptrue p1.b
; CHECK-NEXT:    sel z1.b, p0, z1.b, z2.b
; CHECK-NEXT:    umaxv b1, p1, z1.b
; CHECK-NEXT:    fmov w8, s1
; CHECK-NEXT:    and x8, x8, #0xff
; CHECK-NEXT:    whilels p1.b, xzr, x8
; CHECK-NEXT:    ptest p0, p0.b
; CHECK-NEXT:    lastb w8, p1, z0.b
; CHECK-NEXT:    csel w0, w8, w0, ne
; CHECK-NEXT:    ret
  %res = call i8 @llvm.experimental.vector.extract.last.active.nxv16i8(<vscale x 16 x i8> %data, <vscale x 16 x i1> %mask, i8 %passthru)
  ret i8 %res
}

define i16 @extract_last_i16_scalable(<vscale x 8 x i16> %data, <vscale x 8 x i1> %mask, i16 %passthru) #0 {
; CHECK-LABEL: extract_last_i16_scalable:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z1.h, #0, #1
; CHECK-NEXT:    mov z2.h, #0 // =0x0
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    sel z1.h, p0, z1.h, z2.h
; CHECK-NEXT:    umaxv h1, p1, z1.h
; CHECK-NEXT:    fmov w8, s1
; CHECK-NEXT:    and x8, x8, #0xff
; CHECK-NEXT:    whilels p2.h, xzr, x8
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    lastb w8, p2, z0.h
; CHECK-NEXT:    csel w0, w8, w0, ne
; CHECK-NEXT:    ret
  %res = call i16 @llvm.experimental.vector.extract.last.active.nxv8i16(<vscale x 8 x i16> %data, <vscale x 8 x i1> %mask, i16 %passthru)
  ret i16 %res
}

define i32 @extract_last_i32_scalable(<vscale x 4 x i32> %data, <vscale x 4 x i1> %mask, i32 %passthru) #0 {
; CHECK-LABEL: extract_last_i32_scalable:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z1.s, #0, #1
; CHECK-NEXT:    mov z2.s, #0 // =0x0
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    sel z1.s, p0, z1.s, z2.s
; CHECK-NEXT:    umaxv s1, p1, z1.s
; CHECK-NEXT:    fmov w8, s1
; CHECK-NEXT:    and x8, x8, #0xff
; CHECK-NEXT:    whilels p2.s, xzr, x8
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    lastb w8, p2, z0.s
; CHECK-NEXT:    csel w0, w8, w0, ne
; CHECK-NEXT:    ret
  %res = call i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32> %data, <vscale x 4 x i1> %mask, i32 %passthru)
  ret i32 %res
}

define i64 @extract_last_i64_scalable(<vscale x 2 x i64> %data, <vscale x 2 x i1> %mask, i64 %passthru) #0 {
; CHECK-LABEL: extract_last_i64_scalable:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z1.d, #0, #1
; CHECK-NEXT:    mov z2.d, #0 // =0x0
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    sel z1.d, p0, z1.d, z2.d
; CHECK-NEXT:    umaxv d1, p1, z1.d
; CHECK-NEXT:    fmov x8, d1
; CHECK-NEXT:    and x8, x8, #0xff
; CHECK-NEXT:    whilels p2.d, xzr, x8
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    lastb x8, p2, z0.d
; CHECK-NEXT:    csel x0, x8, x0, ne
; CHECK-NEXT:    ret
  %res = call i64 @llvm.experimental.vector.extract.last.active.nxv2i64(<vscale x 2 x i64> %data, <vscale x 2 x i1> %mask, i64 %passthru)
  ret i64 %res
}

define float @extract_last_float_scalable(<vscale x 4 x float> %data, <vscale x 4 x i1> %mask, float %passthru) #0 {
; CHECK-LABEL: extract_last_float_scalable:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z2.s, #0, #1
; CHECK-NEXT:    mov z3.s, #0 // =0x0
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    sel z2.s, p0, z2.s, z3.s
; CHECK-NEXT:    umaxv s2, p1, z2.s
; CHECK-NEXT:    fmov w8, s2
; CHECK-NEXT:    and x8, x8, #0xff
; CHECK-NEXT:    whilels p2.s, xzr, x8
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    lastb s0, p2, z0.s
; CHECK-NEXT:    fcsel s0, s0, s1, ne
; CHECK-NEXT:    ret
  %res = call float @llvm.experimental.vector.extract.last.active.nxv4f32(<vscale x 4 x float> %data, <vscale x 4 x i1> %mask, float %passthru)
  ret float %res
}

define double @extract_last_double_scalable(<vscale x 2 x double> %data, <vscale x 2 x i1> %mask, double %passthru) #0 {
; CHECK-LABEL: extract_last_double_scalable:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z2.d, #0, #1
; CHECK-NEXT:    mov z3.d, #0 // =0x0
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    sel z2.d, p0, z2.d, z3.d
; CHECK-NEXT:    umaxv d2, p1, z2.d
; CHECK-NEXT:    fmov x8, d2
; CHECK-NEXT:    and x8, x8, #0xff
; CHECK-NEXT:    whilels p2.d, xzr, x8
; CHECK-NEXT:    ptest p1, p0.b
; CHECK-NEXT:    lastb d0, p2, z0.d
; CHECK-NEXT:    fcsel d0, d0, d1, ne
; CHECK-NEXT:    ret
  %res = call double @llvm.experimental.vector.extract.last.active.nxv2f64(<vscale x 2 x double> %data, <vscale x 2 x i1> %mask, double %passthru)
  ret double %res
}

declare i8 @llvm.experimental.vector.extract.last.active.v16i8(<16 x i8>, <16 x i1>, i8)
declare i16 @llvm.experimental.vector.extract.last.active.v8i16(<8 x i16>, <8 x i1>, i16)
declare i32 @llvm.experimental.vector.extract.last.active.v4i32(<4 x i32>, <4 x i1>, i32)
declare i64 @llvm.experimental.vector.extract.last.active.v2i64(<2 x i64>, <2 x i1>, i64)
declare float @llvm.experimental.vector.extract.last.active.v4f32(<4 x float>, <4 x i1>, float)
declare double @llvm.experimental.vector.extract.last.active.v2f64(<2 x double>, <2 x i1>, double)
declare i8 @llvm.experimental.vector.extract.last.active.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i1>, i8)
declare i16 @llvm.experimental.vector.extract.last.active.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i1>, i16)
declare i32 @llvm.experimental.vector.extract.last.active.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i1>, i32)
declare i64 @llvm.experimental.vector.extract.last.active.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i1>, i64)
declare float @llvm.experimental.vector.extract.last.active.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, float)
declare double @llvm.experimental.vector.extract.last.active.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, double)

attributes #0 = { "target-features"="+sve" vscale_range(1, 16) }