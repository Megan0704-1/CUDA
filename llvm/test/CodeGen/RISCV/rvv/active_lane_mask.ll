; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK

define <vscale x 1 x i1> @get_lane_mask(ptr %p, i64 %index, i64 %tc) {
; CHECK-LABEL: get_lane_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v0, v8, a2
; CHECK-NEXT:    ret
  %mask = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64 %index, i64 %tc)
  ret <vscale x 1 x i1> %mask
}

define <vscale x 1 x i1> @constant_zero_index(ptr %p, i64 %tc) {
; CHECK-LABEL: constant_zero_index:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vmsltu.vx v0, v8, a1
; CHECK-NEXT:    ret
  %mask = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64 0, i64 %tc)
  ret <vscale x 1 x i1> %mask
}

define <vscale x 1 x i1> @constant_nonzero_index(ptr %p, i64 %tc) {
; CHECK-LABEL: constant_nonzero_index:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    li a0, 24
; CHECK-NEXT:    vsaddu.vx v8, v8, a0
; CHECK-NEXT:    vmsltu.vx v0, v8, a1
; CHECK-NEXT:    ret
  %mask = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64 24, i64 %tc)
  ret <vscale x 1 x i1> %mask
}

define <vscale x 1 x i1> @constant_tripcount(ptr %p, i64 %index) {
; CHECK-LABEL: constant_tripcount:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    li a0, 1024
; CHECK-NEXT:    vmsltu.vx v0, v8, a0
; CHECK-NEXT:    ret
  %mask = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64 %index, i64 1024)
  ret <vscale x 1 x i1> %mask
}

define <vscale x 1 x i1> @constant_both(ptr %p) {
; CHECK-LABEL: constant_both:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    li a0, 1024
; CHECK-NEXT:    vmsltu.vx v0, v8, a0
; CHECK-NEXT:    ret
  %mask = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64 0, i64 1024)
  ret <vscale x 1 x i1> %mask
}

; Architectural max VLEN=64k, so result is "as-if" TC=1024
define <vscale x 1 x i1> @above_maxvl(ptr %p) {
; CHECK-LABEL: above_maxvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    li a0, 1
; CHECK-NEXT:    slli a0, a0, 11
; CHECK-NEXT:    vmsltu.vx v0, v8, a0
; CHECK-NEXT:    ret
  %mask = call <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64 0, i64 2048)
  ret <vscale x 1 x i1> %mask
}

define <2 x i1> @fv2(ptr %p, i64 %index, i64 %tc) {
; CHECK-LABEL: fv2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v0, v8, a2
; CHECK-NEXT:    ret
  %mask = call <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64 %index, i64 %tc)
  ret <2 x i1> %mask
}

define <8 x i1> @fv8(ptr %p, i64 %index, i64 %tc) {
; CHECK-LABEL: fv8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v0, v8, a2
; CHECK-NEXT:    ret
  %mask = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64 %index, i64 %tc)
  ret <8 x i1> %mask
}

define <32 x i1> @fv32(ptr %p, i64 %index, i64 %tc) {
; CHECK-LABEL: fv32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI8_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI8_0)
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vid.v v16
; CHECK-NEXT:    vsaddu.vx v16, v16, a1
; CHECK-NEXT:    vmsltu.vx v0, v16, a2
; CHECK-NEXT:    vsext.vf8 v16, v8
; CHECK-NEXT:    vsaddu.vx v8, v16, a1
; CHECK-NEXT:    vmsltu.vx v16, v8, a2
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vslideup.vi v0, v16, 2
; CHECK-NEXT:    ret
  %mask = call <32 x i1> @llvm.get.active.lane.mask.v32i1.i64(i64 %index, i64 %tc)
  ret <32 x i1> %mask
}

define <64 x i1> @fv64(ptr %p, i64 %index, i64 %tc) {
; CHECK-LABEL: fv64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    lui a0, %hi(.LCPI9_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI9_0)
; CHECK-NEXT:    vle8.v v16, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI9_1)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI9_1)
; CHECK-NEXT:    vle8.v v17, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI9_2)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI9_2)
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vle8.v v18, (a0)
; CHECK-NEXT:    vmsltu.vx v0, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v16
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v16, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v17
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v17, v8, a2
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v0, v16, 2
; CHECK-NEXT:    vsetivli zero, 6, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v0, v17, 4
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vsext.vf8 v8, v18
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v16, v8, a2
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vslideup.vi v0, v16, 6
; CHECK-NEXT:    ret
  %mask = call <64 x i1> @llvm.get.active.lane.mask.v64i1.i64(i64 %index, i64 %tc)
  ret <64 x i1> %mask
}

define <128 x i1> @fv128(ptr %p, i64 %index, i64 %tc) {
; CHECK-LABEL: fv128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI10_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI10_0)
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle8.v v16, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI10_1)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI10_1)
; CHECK-NEXT:    vle8.v v17, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI10_2)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI10_2)
; CHECK-NEXT:    vle8.v v18, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI10_3)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI10_3)
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vle8.v v19, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI10_4)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI10_4)
; CHECK-NEXT:    vle8.v v20, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI10_5)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI10_5)
; CHECK-NEXT:    vle8.v v21, (a0)
; CHECK-NEXT:    lui a0, %hi(.LCPI10_6)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI10_6)
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vle8.v v22, (a0)
; CHECK-NEXT:    vmsltu.vx v0, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v16
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v16, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v17
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v17, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v18
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v18, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v19
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v19, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v20
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v20, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v21
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v21, v8, a2
; CHECK-NEXT:    vsext.vf8 v8, v22
; CHECK-NEXT:    vsaddu.vx v8, v8, a1
; CHECK-NEXT:    vmsltu.vx v22, v8, a2
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v17, v16, 2
; CHECK-NEXT:    vslideup.vi v0, v20, 2
; CHECK-NEXT:    vsetivli zero, 6, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v17, v18, 4
; CHECK-NEXT:    vslideup.vi v0, v21, 4
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vslideup.vi v17, v19, 6
; CHECK-NEXT:    vslideup.vi v0, v22, 6
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vslideup.vi v0, v17, 8
; CHECK-NEXT:    ret
  %mask = call <128 x i1> @llvm.get.active.lane.mask.v128i1.i64(i64 %index, i64 %tc)
  ret <128 x i1> %mask
}


declare <vscale x 1 x i1> @llvm.get.active.lane.mask.nxv1i1.i64(i64, i64)
declare <2 x i1> @llvm.get.active.lane.mask.v2i1.i64(i64, i64)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i64(i64, i64)
declare <32 x i1> @llvm.get.active.lane.mask.v32i1.i64(i64, i64)
declare <64 x i1> @llvm.get.active.lane.mask.v64i1.i64(i64, i64)
declare <128 x i1> @llvm.get.active.lane.mask.v128i1.i64(i64, i64)