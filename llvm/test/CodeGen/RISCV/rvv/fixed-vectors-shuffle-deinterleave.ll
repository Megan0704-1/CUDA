; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+v \
; RUN:   -lower-interleaved-accesses=false -verify-machineinstrs \
; RUN:   | FileCheck %s --check-prefix=CHECK
; RUN: llc < %s -mtriple=riscv64 -mattr=+v \
; RUN:   -lower-interleaved-accesses=false -verify-machineinstrs \
; RUN:   | FileCheck %s --check-prefix=CHECK

define void @deinterleave3_0_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave3_0_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI0_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI0_0)
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    li a0, 73
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    vrgather.vv v10, v8, v9
; CHECK-NEXT:    vse8.v v10, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 3, i32 6, i32 9, i32 12, i32 15, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave3_8_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave3_8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI1_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI1_0)
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    li a0, 146
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    vrgather.vv v10, v8, v9
; CHECK-NEXT:    vse8.v v10, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 1, i32 4, i32 7, i32 10, i32 13, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave4_0_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave4_0_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave4_8_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave4_8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 8
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave5_0_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave5_0_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    li a0, 33
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    lui a0, 28704
; CHECK-NEXT:    addi a0, a0, 1280
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vrgather.vv v10, v8, v9
; CHECK-NEXT:    vse8.v v10, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 5, i32 10, i32 15, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave5_8_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave5_8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    li a0, 66
; CHECK-NEXT:    vmv.v.i v0, 4
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vcompress.vm v10, v8, v9
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vrgather.vi v10, v8, 3, v0.t
; CHECK-NEXT:    vse8.v v10, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 1, i32 6, i32 11, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave6_0_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave6_0_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    li a0, 65
; CHECK-NEXT:    vmv.v.i v0, 4
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vcompress.vm v10, v8, v9
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vrgather.vi v10, v8, 4, v0.t
; CHECK-NEXT:    vse8.v v10, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 6, i32 12, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave6_8_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave6_8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    li a0, 130
; CHECK-NEXT:    vmv.v.i v0, 4
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vcompress.vm v10, v8, v9
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vrgather.vi v10, v8, 5, v0.t
; CHECK-NEXT:    vse8.v v10, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 1, i32 7, i32 13, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave7_0_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave7_0_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    li a0, 129
; CHECK-NEXT:    vmv.v.i v0, 4
; CHECK-NEXT:    vmv.s.x v9, a0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vcompress.vm v10, v8, v9
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vrgather.vi v10, v8, 6, v0.t
; CHECK-NEXT:    vse8.v v10, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 7, i32 14, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave7_8_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave7_8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, -6
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    li a0, 6
; CHECK-NEXT:    vmv.v.i v0, 6
; CHECK-NEXT:    vmadd.vx v10, a0, v9
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vrgather.vi v11, v8, 1
; CHECK-NEXT:    vrgather.vv v11, v9, v10, v0.t
; CHECK-NEXT:    vse8.v v11, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 1, i32 8, i32 14, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave8_0_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave8_0_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 0, i32 8, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

define void @deinterleave8_8_i8(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave8_8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <8 x i32> <i32 1, i32 9, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

; Exercise the high lmul case
define void @deinterleave7_0_i64(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave7_0_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    li a0, 129
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 4
; CHECK-NEXT:    vmv.s.x v16, a0
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vcompress.vm v20, v8, v16
; CHECK-NEXT:    vsetivli zero, 8, e64, m8, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; CHECK-NEXT:    vrgather.vi v20, v8, 6, v0.t
; CHECK-NEXT:    vse64.v v20, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i64>, ptr %in
  %shuffle.i5 = shufflevector <16 x i64> %0, <16 x i64> poison, <8 x i32> <i32 0, i32 7, i32 14, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  store <8 x i64> %shuffle.i5, ptr %out
  ret void
}

; Store back only the active subvector
define void @deinterleave4_0_i8_subvec(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave4_0_i8_subvec:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  store <4 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}

; Store back only the active subvector
define void @deinterleave7_0_i32_subvec(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave7_0_i32_subvec:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    li a0, 129
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 4
; CHECK-NEXT:    vmv.s.x v12, a0
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vcompress.vm v14, v8, v12
; CHECK-NEXT:    vsetivli zero, 8, e32, m4, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 8
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; CHECK-NEXT:    vrgather.vi v14, v8, 6, v0.t
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v14, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i32>, ptr %in
  %shuffle.i5 = shufflevector <16 x i32> %0, <16 x i32> poison, <3 x i32> <i32 0, i32 7, i32 14>
  store <3 x i32> %shuffle.i5, ptr %out
  ret void
}

; Store back only the active subvector
define void @deinterleave8_0_i8_subvec(ptr %in, ptr %out) {
; CHECK-LABEL: deinterleave8_0_i8_subvec:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vslidedown.vi v9, v8, 8
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    vmv.x.s a2, v9
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a2
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
entry:
  %0 = load <16 x i8>, ptr %in, align 1
  %shuffle.i5 = shufflevector <16 x i8> %0, <16 x i8> poison, <2 x i32> <i32 0, i32 8>
  store <2 x i8> %shuffle.i5, ptr %out, align 1
  ret void
}