; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=aarch64-none-eabi -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64-none-eabi -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI

define i8 @i8(i8 %a, i8 %b) {
; CHECK-LABEL: i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub w0, w0, w1
; CHECK-NEXT:    ret
entry:
  %s = sub i8 %a, %b
  ret i8 %s
}

define i16 @i16(i16 %a, i16 %b) {
; CHECK-LABEL: i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub w0, w0, w1
; CHECK-NEXT:    ret
entry:
  %s = sub i16 %a, %b
  ret i16 %s
}

define i32 @i32(i32 %a, i32 %b) {
; CHECK-LABEL: i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub w0, w0, w1
; CHECK-NEXT:    ret
entry:
  %s = sub i32 %a, %b
  ret i32 %s
}

define i64 @i64(i64 %a, i64 %b) {
; CHECK-LABEL: i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub x0, x0, x1
; CHECK-NEXT:    ret
entry:
  %s = sub i64 %a, %b
  ret i64 %s
}

define i128 @i128(i128 %a, i128 %b) {
; CHECK-LABEL: i128:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    subs x0, x0, x2
; CHECK-NEXT:    sbc x1, x1, x3
; CHECK-NEXT:    ret
entry:
  %s = sub i128 %a, %b
  ret i128 %s
}

define void @v2i8(ptr %p1, ptr %p2) {
; CHECK-SD-LABEL: v2i8:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    ld1 { v0.b }[0], [x0]
; CHECK-SD-NEXT:    ld1 { v1.b }[0], [x1]
; CHECK-SD-NEXT:    add x8, x0, #1
; CHECK-SD-NEXT:    add x9, x1, #1
; CHECK-SD-NEXT:    ld1 { v0.b }[4], [x8]
; CHECK-SD-NEXT:    ld1 { v1.b }[4], [x9]
; CHECK-SD-NEXT:    sub v0.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    mov w8, v0.s[1]
; CHECK-SD-NEXT:    fmov w9, s0
; CHECK-SD-NEXT:    strb w9, [x0]
; CHECK-SD-NEXT:    strb w8, [x0, #1]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v2i8:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ld1 { v0.b }[0], [x0]
; CHECK-GI-NEXT:    ld1 { v1.b }[0], [x1]
; CHECK-GI-NEXT:    ldr b2, [x0, #1]
; CHECK-GI-NEXT:    ldr b3, [x1, #1]
; CHECK-GI-NEXT:    mov v0.s[1], v2.s[0]
; CHECK-GI-NEXT:    mov v1.s[1], v3.s[0]
; CHECK-GI-NEXT:    sub v0.2s, v0.2s, v1.2s
; CHECK-GI-NEXT:    mov s1, v0.s[1]
; CHECK-GI-NEXT:    str b0, [x0]
; CHECK-GI-NEXT:    str b1, [x0, #1]
; CHECK-GI-NEXT:    ret
entry:
  %d = load <2 x i8>, ptr %p1
  %e = load <2 x i8>, ptr %p2
  %s = sub <2 x i8> %d, %e
  store <2 x i8> %s, ptr %p1
  ret void
}

define void @v3i8(ptr %p1, ptr %p2) {
; CHECK-SD-LABEL: v3i8:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    sub sp, sp, #16
; CHECK-SD-NEXT:    .cfi_def_cfa_offset 16
; CHECK-SD-NEXT:    ldr s0, [x0]
; CHECK-SD-NEXT:    ldr s1, [x1]
; CHECK-SD-NEXT:    zip1 v0.8b, v0.8b, v0.8b
; CHECK-SD-NEXT:    zip1 v1.8b, v1.8b, v0.8b
; CHECK-SD-NEXT:    sub v0.4h, v0.4h, v1.4h
; CHECK-SD-NEXT:    uzp1 v1.8b, v0.8b, v0.8b
; CHECK-SD-NEXT:    umov w8, v0.h[2]
; CHECK-SD-NEXT:    str s1, [sp, #12]
; CHECK-SD-NEXT:    ldrh w9, [sp, #12]
; CHECK-SD-NEXT:    strb w8, [x0, #2]
; CHECK-SD-NEXT:    strh w9, [x0]
; CHECK-SD-NEXT:    add sp, sp, #16
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v3i8:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ldrb w8, [x0]
; CHECK-GI-NEXT:    ldrb w9, [x1]
; CHECK-GI-NEXT:    ldrb w10, [x0, #1]
; CHECK-GI-NEXT:    ldrb w11, [x1, #1]
; CHECK-GI-NEXT:    fmov s0, w8
; CHECK-GI-NEXT:    fmov s1, w9
; CHECK-GI-NEXT:    ldrb w8, [x0, #2]
; CHECK-GI-NEXT:    ldrb w9, [x1, #2]
; CHECK-GI-NEXT:    mov v0.h[1], w10
; CHECK-GI-NEXT:    mov v1.h[1], w11
; CHECK-GI-NEXT:    mov v0.h[2], w8
; CHECK-GI-NEXT:    mov v1.h[2], w9
; CHECK-GI-NEXT:    sub v0.4h, v0.4h, v1.4h
; CHECK-GI-NEXT:    mov h1, v0.h[1]
; CHECK-GI-NEXT:    mov h2, v0.h[2]
; CHECK-GI-NEXT:    str b0, [x0]
; CHECK-GI-NEXT:    str b1, [x0, #1]
; CHECK-GI-NEXT:    str b2, [x0, #2]
; CHECK-GI-NEXT:    ret
entry:
  %d = load <3 x i8>, ptr %p1
  %e = load <3 x i8>, ptr %p2
  %s = sub <3 x i8> %d, %e
  store <3 x i8> %s, ptr %p1
  ret void
}

define void @v4i8(ptr %p1, ptr %p2) {
; CHECK-SD-LABEL: v4i8:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    ldr s0, [x0]
; CHECK-SD-NEXT:    ldr s1, [x1]
; CHECK-SD-NEXT:    usubl v0.8h, v0.8b, v1.8b
; CHECK-SD-NEXT:    uzp1 v0.8b, v0.8b, v0.8b
; CHECK-SD-NEXT:    str s0, [x0]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v4i8:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ldr w8, [x0]
; CHECK-GI-NEXT:    ldr w9, [x1]
; CHECK-GI-NEXT:    fmov s0, w8
; CHECK-GI-NEXT:    fmov s1, w9
; CHECK-GI-NEXT:    mov b2, v0.b[1]
; CHECK-GI-NEXT:    mov b3, v1.b[1]
; CHECK-GI-NEXT:    mov b4, v0.b[2]
; CHECK-GI-NEXT:    mov b5, v0.b[3]
; CHECK-GI-NEXT:    fmov w8, s2
; CHECK-GI-NEXT:    mov b2, v1.b[2]
; CHECK-GI-NEXT:    fmov w9, s3
; CHECK-GI-NEXT:    mov b3, v1.b[3]
; CHECK-GI-NEXT:    mov v0.h[1], w8
; CHECK-GI-NEXT:    mov v1.h[1], w9
; CHECK-GI-NEXT:    fmov w8, s4
; CHECK-GI-NEXT:    fmov w9, s2
; CHECK-GI-NEXT:    mov v0.h[2], w8
; CHECK-GI-NEXT:    mov v1.h[2], w9
; CHECK-GI-NEXT:    fmov w8, s5
; CHECK-GI-NEXT:    fmov w9, s3
; CHECK-GI-NEXT:    mov v0.h[3], w8
; CHECK-GI-NEXT:    mov v1.h[3], w9
; CHECK-GI-NEXT:    sub v0.4h, v0.4h, v1.4h
; CHECK-GI-NEXT:    uzp1 v0.8b, v0.8b, v0.8b
; CHECK-GI-NEXT:    fmov w8, s0
; CHECK-GI-NEXT:    str w8, [x0]
; CHECK-GI-NEXT:    ret
entry:
  %d = load <4 x i8>, ptr %p1
  %e = load <4 x i8>, ptr %p2
  %s = sub <4 x i8> %d, %e
  store <4 x i8> %s, ptr %p1
  ret void
}

define <8 x i8> @v8i8(<8 x i8> %d, <8 x i8> %e) {
; CHECK-LABEL: v8i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    ret
entry:
  %s = sub <8 x i8> %d, %e
  ret <8 x i8> %s
}

define <16 x i8> @v16i8(<16 x i8> %d, <16 x i8> %e) {
; CHECK-LABEL: v16i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
entry:
  %s = sub <16 x i8> %d, %e
  ret <16 x i8> %s
}

define <32 x i8> @v32i8(<32 x i8> %d, <32 x i8> %e) {
; CHECK-SD-LABEL: v32i8:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    sub v1.16b, v1.16b, v3.16b
; CHECK-SD-NEXT:    sub v0.16b, v0.16b, v2.16b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v32i8:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    sub v0.16b, v0.16b, v2.16b
; CHECK-GI-NEXT:    sub v1.16b, v1.16b, v3.16b
; CHECK-GI-NEXT:    ret
entry:
  %s = sub <32 x i8> %d, %e
  ret <32 x i8> %s
}

define void @v2i16(ptr %p1, ptr %p2) {
; CHECK-SD-LABEL: v2i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    ld1 { v0.h }[0], [x0]
; CHECK-SD-NEXT:    ld1 { v1.h }[0], [x1]
; CHECK-SD-NEXT:    add x8, x0, #2
; CHECK-SD-NEXT:    add x9, x1, #2
; CHECK-SD-NEXT:    ld1 { v0.h }[2], [x8]
; CHECK-SD-NEXT:    ld1 { v1.h }[2], [x9]
; CHECK-SD-NEXT:    sub v0.2s, v0.2s, v1.2s
; CHECK-SD-NEXT:    mov w8, v0.s[1]
; CHECK-SD-NEXT:    fmov w9, s0
; CHECK-SD-NEXT:    strh w9, [x0]
; CHECK-SD-NEXT:    strh w8, [x0, #2]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v2i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ld1 { v0.h }[0], [x0]
; CHECK-GI-NEXT:    ld1 { v1.h }[0], [x1]
; CHECK-GI-NEXT:    ldr h2, [x0, #2]
; CHECK-GI-NEXT:    ldr h3, [x1, #2]
; CHECK-GI-NEXT:    mov v0.s[1], v2.s[0]
; CHECK-GI-NEXT:    mov v1.s[1], v3.s[0]
; CHECK-GI-NEXT:    sub v0.2s, v0.2s, v1.2s
; CHECK-GI-NEXT:    mov s1, v0.s[1]
; CHECK-GI-NEXT:    str h0, [x0]
; CHECK-GI-NEXT:    str h1, [x0, #2]
; CHECK-GI-NEXT:    ret
entry:
  %d = load <2 x i16>, ptr %p1
  %e = load <2 x i16>, ptr %p2
  %s = sub <2 x i16> %d, %e
  store <2 x i16> %s, ptr %p1
  ret void
}

define void @v3i16(ptr %p1, ptr %p2) {
; CHECK-SD-LABEL: v3i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    ldr d0, [x0]
; CHECK-SD-NEXT:    ldr d1, [x1]
; CHECK-SD-NEXT:    add x8, x0, #4
; CHECK-SD-NEXT:    sub v0.4h, v0.4h, v1.4h
; CHECK-SD-NEXT:    st1 { v0.h }[2], [x8]
; CHECK-SD-NEXT:    str s0, [x0]
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v3i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ldr h0, [x0]
; CHECK-GI-NEXT:    ldr h1, [x1]
; CHECK-GI-NEXT:    add x8, x0, #2
; CHECK-GI-NEXT:    add x9, x1, #2
; CHECK-GI-NEXT:    add x10, x1, #4
; CHECK-GI-NEXT:    ld1 { v0.h }[1], [x8]
; CHECK-GI-NEXT:    ld1 { v1.h }[1], [x9]
; CHECK-GI-NEXT:    add x9, x0, #4
; CHECK-GI-NEXT:    ld1 { v0.h }[2], [x9]
; CHECK-GI-NEXT:    ld1 { v1.h }[2], [x10]
; CHECK-GI-NEXT:    sub v0.4h, v0.4h, v1.4h
; CHECK-GI-NEXT:    str h0, [x0]
; CHECK-GI-NEXT:    st1 { v0.h }[1], [x8]
; CHECK-GI-NEXT:    st1 { v0.h }[2], [x9]
; CHECK-GI-NEXT:    ret
entry:
  %d = load <3 x i16>, ptr %p1
  %e = load <3 x i16>, ptr %p2
  %s = sub <3 x i16> %d, %e
  store <3 x i16> %s, ptr %p1
  ret void
}

define <4 x i16> @v4i16(<4 x i16> %d, <4 x i16> %e) {
; CHECK-LABEL: v4i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %s = sub <4 x i16> %d, %e
  ret <4 x i16> %s
}

define <8 x i16> @v8i16(<8 x i16> %d, <8 x i16> %e) {
; CHECK-LABEL: v8i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
entry:
  %s = sub <8 x i16> %d, %e
  ret <8 x i16> %s
}

define <16 x i16> @v16i16(<16 x i16> %d, <16 x i16> %e) {
; CHECK-SD-LABEL: v16i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    sub v1.8h, v1.8h, v3.8h
; CHECK-SD-NEXT:    sub v0.8h, v0.8h, v2.8h
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v16i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    sub v0.8h, v0.8h, v2.8h
; CHECK-GI-NEXT:    sub v1.8h, v1.8h, v3.8h
; CHECK-GI-NEXT:    ret
entry:
  %s = sub <16 x i16> %d, %e
  ret <16 x i16> %s
}

define <2 x i32> @v2i32(<2 x i32> %d, <2 x i32> %e) {
; CHECK-LABEL: v2i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %s = sub <2 x i32> %d, %e
  ret <2 x i32> %s
}

define <3 x i32> @v3i32(<3 x i32> %d, <3 x i32> %e) {
; CHECK-LABEL: v3i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %s = sub <3 x i32> %d, %e
  ret <3 x i32> %s
}

define <4 x i32> @v4i32(<4 x i32> %d, <4 x i32> %e) {
; CHECK-LABEL: v4i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %s = sub <4 x i32> %d, %e
  ret <4 x i32> %s
}

define <8 x i32> @v8i32(<8 x i32> %d, <8 x i32> %e) {
; CHECK-SD-LABEL: v8i32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    sub v1.4s, v1.4s, v3.4s
; CHECK-SD-NEXT:    sub v0.4s, v0.4s, v2.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v8i32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    sub v0.4s, v0.4s, v2.4s
; CHECK-GI-NEXT:    sub v1.4s, v1.4s, v3.4s
; CHECK-GI-NEXT:    ret
entry:
  %s = sub <8 x i32> %d, %e
  ret <8 x i32> %s
}

define <2 x i64> @v2i64(<2 x i64> %d, <2 x i64> %e) {
; CHECK-LABEL: v2i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sub v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
entry:
  %s = sub <2 x i64> %d, %e
  ret <2 x i64> %s
}

define <3 x i64> @v3i64(<3 x i64> %d, <3 x i64> %e) {
; CHECK-SD-LABEL: v3i64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    sub d0, d0, d3
; CHECK-SD-NEXT:    sub d1, d1, d4
; CHECK-SD-NEXT:    sub d2, d2, d5
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v3i64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d3 killed $d3 def $q3
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    // kill: def $d4 killed $d4 def $q4
; CHECK-GI-NEXT:    fmov x8, d2
; CHECK-GI-NEXT:    fmov x9, d5
; CHECK-GI-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-GI-NEXT:    mov v3.d[1], v4.d[0]
; CHECK-GI-NEXT:    sub x8, x8, x9
; CHECK-GI-NEXT:    fmov d2, x8
; CHECK-GI-NEXT:    sub v0.2d, v0.2d, v3.2d
; CHECK-GI-NEXT:    mov d1, v0.d[1]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %s = sub <3 x i64> %d, %e
  ret <3 x i64> %s
}

define <4 x i64> @v4i64(<4 x i64> %d, <4 x i64> %e) {
; CHECK-SD-LABEL: v4i64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    sub v1.2d, v1.2d, v3.2d
; CHECK-SD-NEXT:    sub v0.2d, v0.2d, v2.2d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v4i64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    sub v0.2d, v0.2d, v2.2d
; CHECK-GI-NEXT:    sub v1.2d, v1.2d, v3.2d
; CHECK-GI-NEXT:    ret
entry:
  %s = sub <4 x i64> %d, %e
  ret <4 x i64> %s
}

define <2 x i128> @v2i128(<2 x i128> %d, <2 x i128> %e) {
; CHECK-LABEL: v2i128:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    subs x0, x0, x4
; CHECK-NEXT:    sbc x1, x1, x5
; CHECK-NEXT:    subs x2, x2, x6
; CHECK-NEXT:    sbc x3, x3, x7
; CHECK-NEXT:    ret
entry:
  %s = sub <2 x i128> %d, %e
  ret <2 x i128> %s
}

define <3 x i128> @v3i128(<3 x i128> %d, <3 x i128> %e) {
; CHECK-LABEL: v3i128:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldp x8, x9, [sp]
; CHECK-NEXT:    subs x0, x0, x6
; CHECK-NEXT:    ldp x10, x11, [sp, #16]
; CHECK-NEXT:    sbc x1, x1, x7
; CHECK-NEXT:    subs x2, x2, x8
; CHECK-NEXT:    sbc x3, x3, x9
; CHECK-NEXT:    subs x4, x4, x10
; CHECK-NEXT:    sbc x5, x5, x11
; CHECK-NEXT:    ret
entry:
  %s = sub <3 x i128> %d, %e
  ret <3 x i128> %s
}

define <4 x i128> @v4i128(<4 x i128> %d, <4 x i128> %e) {
; CHECK-SD-LABEL: v4i128:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    ldp x8, x9, [sp]
; CHECK-SD-NEXT:    ldp x11, x10, [sp, #16]
; CHECK-SD-NEXT:    ldp x13, x12, [sp, #32]
; CHECK-SD-NEXT:    subs x0, x0, x8
; CHECK-SD-NEXT:    sbc x1, x1, x9
; CHECK-SD-NEXT:    ldp x8, x9, [sp, #48]
; CHECK-SD-NEXT:    subs x2, x2, x11
; CHECK-SD-NEXT:    sbc x3, x3, x10
; CHECK-SD-NEXT:    subs x4, x4, x13
; CHECK-SD-NEXT:    sbc x5, x5, x12
; CHECK-SD-NEXT:    subs x6, x6, x8
; CHECK-SD-NEXT:    sbc x7, x7, x9
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: v4i128:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ldp x8, x9, [sp]
; CHECK-GI-NEXT:    ldp x10, x11, [sp, #16]
; CHECK-GI-NEXT:    ldp x12, x13, [sp, #32]
; CHECK-GI-NEXT:    subs x0, x0, x8
; CHECK-GI-NEXT:    sbc x1, x1, x9
; CHECK-GI-NEXT:    ldp x8, x9, [sp, #48]
; CHECK-GI-NEXT:    subs x2, x2, x10
; CHECK-GI-NEXT:    sbc x3, x3, x11
; CHECK-GI-NEXT:    subs x4, x4, x12
; CHECK-GI-NEXT:    sbc x5, x5, x13
; CHECK-GI-NEXT:    subs x6, x6, x8
; CHECK-GI-NEXT:    sbc x7, x7, x9
; CHECK-GI-NEXT:    ret
entry:
  %s = sub <4 x i128> %d, %e
  ret <4 x i128> %s
}