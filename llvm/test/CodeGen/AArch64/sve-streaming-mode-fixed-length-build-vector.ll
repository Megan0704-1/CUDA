; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve -force-streaming-compatible  < %s | FileCheck %s
; RUN: llc -mattr=+sme -force-streaming  < %s | FileCheck %s
; RUN: llc -force-streaming-compatible < %s | FileCheck %s --check-prefix=NONEON-NOSVE

target triple = "aarch64-unknown-linux-gnu"

define void @build_vector_7_inc1_v4i1(ptr %a) {
; CHECK-LABEL: build_vector_7_inc1_v4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #5 // =0x5
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_7_inc1_v4i1:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    mov w8, #5 // =0x5
; NONEON-NOSVE-NEXT:    strb w8, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <4 x i1> <i1 true, i1 false, i1 true, i1 false>, ptr %a, align 1
  ret void
}

define void @build_vector_7_inc1_v32i8(ptr %a) {
; CHECK-LABEL: build_vector_7_inc1_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.b, #0, #1
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    add z0.b, z0.b, #7 // =0x7
; CHECK-NEXT:    add z1.b, z1.b, #23 // =0x17
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_7_inc1_v32i8:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI1_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI1_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI1_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI1_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <32 x i8> <i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15, i8 16, i8 17, i8 18, i8 19, i8 20, i8 21, i8 22, i8 23, i8 24, i8 25, i8 26, i8 27, i8 28, i8 29, i8 30, i8 31, i8 32, i8 33, i8 34, i8 35, i8 36, i8 37, i8 38>, ptr %a, align 1
  ret void
}

define void @build_vector_0_inc2_v16i16(ptr %a) {
; CHECK-LABEL: build_vector_0_inc2_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.h, #0, #2
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    add z0.h, z0.h, #16 // =0x10
; CHECK-NEXT:    str q0, [x0, #16]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_0_inc2_v16i16:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI2_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI2_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI2_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI2_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <16 x i16> <i16 0, i16 2, i16 4, i16 6, i16 8, i16 10, i16 12, i16 14, i16 16, i16 18, i16 20, i16 22, i16 24, i16 26, i16 28, i16 30>, ptr %a, align 2
  ret void
}

; Negative const stride.
define void @build_vector_0_dec3_v8i32(ptr %a) {
; CHECK-LABEL: build_vector_0_dec3_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.s, #0, #-3
; CHECK-NEXT:    mov z1.s, #-12 // =0xfffffffffffffff4
; CHECK-NEXT:    add z1.s, z0.s, z1.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_0_dec3_v8i32:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI3_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI3_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI3_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI3_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <8 x i32> <i32 0, i32 -3, i32 -6, i32 -9, i32 -12, i32 -15, i32 -18, i32 -21>, ptr %a, align 4
  ret void
}

; Constant stride that's too big to be directly encoded into the index.
define void @build_vector_minus2_dec32_v4i64(ptr %a) {
; CHECK-LABEL: build_vector_minus2_dec32_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-32 // =0xffffffffffffffe0
; CHECK-NEXT:    mov z1.d, #-66 // =0xffffffffffffffbe
; CHECK-NEXT:    mov z2.d, #-2 // =0xfffffffffffffffe
; CHECK-NEXT:    index z0.d, #0, x8
; CHECK-NEXT:    add z1.d, z0.d, z1.d
; CHECK-NEXT:    add z0.d, z0.d, z2.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_minus2_dec32_v4i64:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI4_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI4_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI4_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI4_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <4 x i64> <i64 -2, i64 -34, i64 -66, i64 -98>, ptr %a, align 8
  ret void
}

; Constant but not a sequence.
define void @build_vector_no_stride_v4i64(ptr %a) {
; CHECK-LABEL: build_vector_no_stride_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.d, #1, #7
; CHECK-NEXT:    index z1.d, #0, #4
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_no_stride_v4i64:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI5_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI5_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI5_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI5_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <4 x i64> <i64 0, i64 4, i64 1, i64 8>, ptr %a, align 8
  ret void
}

define void @build_vector_0_inc2_v16f16(ptr %a) {
; CHECK-LABEL: build_vector_0_inc2_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI6_0
; CHECK-NEXT:    adrp x9, .LCPI6_1
; CHECK-NEXT:    ldr q0, [x8, :lo12:.LCPI6_0]
; CHECK-NEXT:    ldr q1, [x9, :lo12:.LCPI6_1]
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_0_inc2_v16f16:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI6_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI6_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI6_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI6_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <16 x half> <half 0.0, half 2.0, half 4.0, half 6.0, half 8.0, half 10.0, half 12.0, half 14.0, half 16.0, half 18.0, half 20.0, half 22.0, half 24.0, half 26.0, half 28.0, half 30.0>, ptr %a, align 2
  ret void
}

; Negative const stride.
define void @build_vector_0_dec3_v8f32(ptr %a) {
; CHECK-LABEL: build_vector_0_dec3_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI7_0
; CHECK-NEXT:    adrp x9, .LCPI7_1
; CHECK-NEXT:    ldr q0, [x8, :lo12:.LCPI7_0]
; CHECK-NEXT:    ldr q1, [x9, :lo12:.LCPI7_1]
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_0_dec3_v8f32:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI7_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI7_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI7_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI7_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <8 x float> <float 0.0, float -3.0, float -6.0, float -9.0, float -12.0, float -15.0, float -18.0, float -21.0>, ptr %a, align 4
  ret void
}

; Constant stride that's too big to be directly encoded into the index.
define void @build_vector_minus2_dec32_v4f64(ptr %a) {
; CHECK-LABEL: build_vector_minus2_dec32_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI8_0
; CHECK-NEXT:    adrp x9, .LCPI8_1
; CHECK-NEXT:    ldr q0, [x8, :lo12:.LCPI8_0]
; CHECK-NEXT:    ldr q1, [x9, :lo12:.LCPI8_1]
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_minus2_dec32_v4f64:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI8_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI8_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI8_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI8_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <4 x double> <double -2.0, double -34.0, double -66.0, double -98.0>, ptr %a, align 8
  ret void
}

; Constant but not a sequence.
define void @build_vector_no_stride_v4f64(ptr %a) {
; CHECK-LABEL: build_vector_no_stride_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI9_0
; CHECK-NEXT:    adrp x9, .LCPI9_1
; CHECK-NEXT:    ldr q0, [x8, :lo12:.LCPI9_0]
; CHECK-NEXT:    ldr q1, [x9, :lo12:.LCPI9_1]
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_no_stride_v4f64:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    adrp x8, .LCPI9_0
; NONEON-NOSVE-NEXT:    adrp x9, .LCPI9_1
; NONEON-NOSVE-NEXT:    ldr q0, [x8, :lo12:.LCPI9_0]
; NONEON-NOSVE-NEXT:    ldr q1, [x9, :lo12:.LCPI9_1]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    ret
  store <4 x double> <double 0.0, double 4.0, double 1.0, double 8.0>, ptr %a, align 8
  ret void
}

define void @build_vector_non_const_v4i1(i1 %a, i1 %b, i1 %c, i1 %d, ptr %out) {
; CHECK-LABEL: build_vector_non_const_v4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    orr w8, w0, w1, lsl #1
; CHECK-NEXT:    orr w8, w8, w2, lsl #2
; CHECK-NEXT:    orr w8, w8, w3, lsl #3
; CHECK-NEXT:    strb w8, [x4]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_non_const_v4i1:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    orr w8, w0, w1, lsl #1
; NONEON-NOSVE-NEXT:    orr w8, w8, w2, lsl #2
; NONEON-NOSVE-NEXT:    orr w8, w8, w3, lsl #3
; NONEON-NOSVE-NEXT:    strb w8, [x4]
; NONEON-NOSVE-NEXT:    ret
  %1 = insertelement <4 x i1> undef, i1 %a, i64 0
  %2 = insertelement <4 x i1>    %1, i1 %b, i64 1
  %3 = insertelement <4 x i1>    %2, i1 %c, i64 2
  %4 = insertelement <4 x i1>    %3, i1 %d, i64 3
  store <4 x i1> %4, ptr %out
  ret void
}

define void @build_vector_non_const_v2f64(double %a, double %b, ptr %out) {
; CHECK-LABEL: build_vector_non_const_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    zip1 z0.d, z0.d, z1.d
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_non_const_v2f64:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    stp d0, d1, [sp, #-16]!
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 16
; NONEON-NOSVE-NEXT:    ldr q0, [sp]
; NONEON-NOSVE-NEXT:    str q0, [x0]
; NONEON-NOSVE-NEXT:    add sp, sp, #16
; NONEON-NOSVE-NEXT:    ret
  %1 = insertelement <2 x double> undef, double %a, i64 0
  %2 = insertelement <2 x double>    %1, double %b, i64 1
  store <2 x double> %2, ptr %out
  ret void
}

define void @build_vector_non_const_v2f32(float %a, float %b, ptr %out) {
; CHECK-LABEL: build_vector_non_const_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $z0
; CHECK-NEXT:    // kill: def $s1 killed $s1 def $z1
; CHECK-NEXT:    zip1 z0.s, z0.s, z1.s
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_non_const_v2f32:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    sub sp, sp, #16
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 16
; NONEON-NOSVE-NEXT:    stp s0, s1, [sp, #8]
; NONEON-NOSVE-NEXT:    ldr d0, [sp, #8]
; NONEON-NOSVE-NEXT:    str d0, [x0]
; NONEON-NOSVE-NEXT:    add sp, sp, #16
; NONEON-NOSVE-NEXT:    ret
  %1 = insertelement <2 x float> undef, float %a, i64 0
  %2 = insertelement <2 x float>    %1, float %b, i64 1
  store <2 x float> %2, ptr %out
  ret void
}

define void @build_vector_non_const_v4f32(float %a, float %b, float %c, float %d, ptr %out)  {
; CHECK-LABEL: build_vector_non_const_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s2 killed $s2 def $z2
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $z0
; CHECK-NEXT:    // kill: def $s3 killed $s3 def $z3
; CHECK-NEXT:    // kill: def $s1 killed $s1 def $z1
; CHECK-NEXT:    zip1 z2.s, z2.s, z3.s
; CHECK-NEXT:    zip1 z0.s, z0.s, z1.s
; CHECK-NEXT:    zip1 z0.d, z0.d, z2.d
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_non_const_v4f32:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    sub sp, sp, #16
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 16
; NONEON-NOSVE-NEXT:    stp s2, s3, [sp, #8]
; NONEON-NOSVE-NEXT:    stp s0, s1, [sp]
; NONEON-NOSVE-NEXT:    ldr q0, [sp]
; NONEON-NOSVE-NEXT:    str q0, [x0]
; NONEON-NOSVE-NEXT:    add sp, sp, #16
; NONEON-NOSVE-NEXT:    ret
  %1 = insertelement <4 x float> undef, float %a, i64 0
  %2 = insertelement <4 x float>    %1, float %b, i64 1
  %3 = insertelement <4 x float>    %2, float %c, i64 2
  %4 = insertelement <4 x float>    %3, float %d, i64 3
  store <4 x float> %4, ptr %out
  ret void
}

define void @build_vector_non_const_v4f64(double %a, double %b, double %c, double %d, ptr %out)  {
; CHECK-LABEL: build_vector_non_const_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d2 killed $d2 def $z2
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    // kill: def $d3 killed $d3 def $z3
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $z1
; CHECK-NEXT:    zip1 z2.d, z2.d, z3.d
; CHECK-NEXT:    zip1 z0.d, z0.d, z1.d
; CHECK-NEXT:    stp q0, q2, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_non_const_v4f64:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    stp d0, d1, [sp, #-32]!
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 32
; NONEON-NOSVE-NEXT:    stp d2, d3, [sp, #16]
; NONEON-NOSVE-NEXT:    ldp q1, q0, [sp]
; NONEON-NOSVE-NEXT:    stp q1, q0, [x0]
; NONEON-NOSVE-NEXT:    add sp, sp, #32
; NONEON-NOSVE-NEXT:    ret
  %1 = insertelement <4 x double> undef, double %a, i64 0
  %2 = insertelement <4 x double>    %1, double %b, i64 1
  %3 = insertelement <4 x double>    %2, double %c, i64 2
  %4 = insertelement <4 x double>    %3, double %d, i64 3
  store <4 x double> %4, ptr %out
  ret void
}

define void @build_vector_non_const_v8f16(half %a, half %b, half %c, half %d, half %e, half %f, half %g, half %h, ptr %out) {
; CHECK-LABEL: build_vector_non_const_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h6 killed $h6 def $z6
; CHECK-NEXT:    // kill: def $h4 killed $h4 def $z4
; CHECK-NEXT:    // kill: def $h2 killed $h2 def $z2
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    // kill: def $h7 killed $h7 def $z7
; CHECK-NEXT:    // kill: def $h5 killed $h5 def $z5
; CHECK-NEXT:    // kill: def $h3 killed $h3 def $z3
; CHECK-NEXT:    // kill: def $h1 killed $h1 def $z1
; CHECK-NEXT:    zip1 z6.h, z6.h, z7.h
; CHECK-NEXT:    zip1 z4.h, z4.h, z5.h
; CHECK-NEXT:    zip1 z2.h, z2.h, z3.h
; CHECK-NEXT:    zip1 z0.h, z0.h, z1.h
; CHECK-NEXT:    zip1 z1.s, z4.s, z6.s
; CHECK-NEXT:    zip1 z0.s, z0.s, z2.s
; CHECK-NEXT:    zip1 z0.d, z0.d, z1.d
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_non_const_v8f16:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    sub sp, sp, #16
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 16
; NONEON-NOSVE-NEXT:    str h7, [sp, #14]
; NONEON-NOSVE-NEXT:    str h6, [sp, #12]
; NONEON-NOSVE-NEXT:    str h5, [sp, #10]
; NONEON-NOSVE-NEXT:    str h4, [sp, #8]
; NONEON-NOSVE-NEXT:    str h3, [sp, #6]
; NONEON-NOSVE-NEXT:    str h2, [sp, #4]
; NONEON-NOSVE-NEXT:    str h1, [sp, #2]
; NONEON-NOSVE-NEXT:    str h0, [sp]
; NONEON-NOSVE-NEXT:    ldr q0, [sp]
; NONEON-NOSVE-NEXT:    str q0, [x0]
; NONEON-NOSVE-NEXT:    add sp, sp, #16
; NONEON-NOSVE-NEXT:    ret
  %1 = insertelement <8 x half> undef, half %a, i64 0
  %2 = insertelement <8 x half>    %1, half %b, i64 1
  %3 = insertelement <8 x half>    %2, half %c, i64 2
  %4 = insertelement <8 x half>    %3, half %d, i64 3
  %5 = insertelement <8 x half>    %4, half %e, i64 4
  %6 = insertelement <8 x half>    %5, half %f, i64 5
  %7 = insertelement <8 x half>    %6, half %g, i64 6
  %8 = insertelement <8 x half>    %7, half %h, i64 7
  store <8 x half> %8, ptr %out
  ret void
}

define void @build_vector_non_const_v2i32(i32 %a, i32 %b, ptr %out) {
; CHECK-LABEL: build_vector_non_const_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s0, w1
; CHECK-NEXT:    fmov s1, w0
; CHECK-NEXT:    zip1 z0.s, z1.s, z0.s
; CHECK-NEXT:    str d0, [x2]
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_non_const_v2i32:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    sub sp, sp, #16
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 16
; NONEON-NOSVE-NEXT:    stp w0, w1, [sp, #8]
; NONEON-NOSVE-NEXT:    ldr d0, [sp, #8]
; NONEON-NOSVE-NEXT:    str d0, [x2]
; NONEON-NOSVE-NEXT:    add sp, sp, #16
; NONEON-NOSVE-NEXT:    ret
  %1 = insertelement <2 x i32> undef, i32 %a, i64 0
  %2 = insertelement <2 x i32>    %1, i32 %b, i64 1
  store <2 x i32> %2, ptr %out
  ret void
}

define void @build_vector_non_const_v8i8(i8 %a, i8 %b, i8 %c, i8 %d, i8 %e, i8 %f, i8 %g, i8 %h, ptr %out) {
; CHECK-LABEL: build_vector_non_const_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    strb w7, [sp, #15]
; CHECK-NEXT:    ldr x8, [sp, #16]
; CHECK-NEXT:    strb w6, [sp, #14]
; CHECK-NEXT:    strb w5, [sp, #13]
; CHECK-NEXT:    strb w4, [sp, #12]
; CHECK-NEXT:    strb w3, [sp, #11]
; CHECK-NEXT:    strb w2, [sp, #10]
; CHECK-NEXT:    strb w1, [sp, #9]
; CHECK-NEXT:    strb w0, [sp, #8]
; CHECK-NEXT:    ldr d0, [sp, #8]
; CHECK-NEXT:    str d0, [x8]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
;
; NONEON-NOSVE-LABEL: build_vector_non_const_v8i8:
; NONEON-NOSVE:       // %bb.0:
; NONEON-NOSVE-NEXT:    sub sp, sp, #16
; NONEON-NOSVE-NEXT:    .cfi_def_cfa_offset 16
; NONEON-NOSVE-NEXT:    strb w7, [sp, #15]
; NONEON-NOSVE-NEXT:    ldr x8, [sp, #16]
; NONEON-NOSVE-NEXT:    strb w6, [sp, #14]
; NONEON-NOSVE-NEXT:    strb w5, [sp, #13]
; NONEON-NOSVE-NEXT:    strb w4, [sp, #12]
; NONEON-NOSVE-NEXT:    strb w3, [sp, #11]
; NONEON-NOSVE-NEXT:    strb w2, [sp, #10]
; NONEON-NOSVE-NEXT:    strb w1, [sp, #9]
; NONEON-NOSVE-NEXT:    strb w0, [sp, #8]
; NONEON-NOSVE-NEXT:    ldr d0, [sp, #8]
; NONEON-NOSVE-NEXT:    str d0, [x8]
; NONEON-NOSVE-NEXT:    add sp, sp, #16
; NONEON-NOSVE-NEXT:    ret
  %1 = insertelement <8 x i8> undef, i8 %a, i64 0
  %2 = insertelement <8 x i8>    %1, i8 %b, i64 1
  %3 = insertelement <8 x i8>    %2, i8 %c, i64 2
  %4 = insertelement <8 x i8>    %3, i8 %d, i64 3
  %5 = insertelement <8 x i8>    %4, i8 %e, i64 4
  %6 = insertelement <8 x i8>    %5, i8 %f, i64 5
  %7 = insertelement <8 x i8>    %6, i8 %g, i64 6
  %8 = insertelement <8 x i8>    %7, i8 %h, i64 7
  store <8 x i8> %8, ptr %out
  ret void
}