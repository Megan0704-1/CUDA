; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define <8 x i8> @vaaddu_vv_v8i8_floor(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_floor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i16>
  %yzv = zext <8 x i8> %y to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %div = lshr <8 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i8> @vaaddu_vx_v8i8_floor(<8 x i8> %x, i8 %y) {
; CHECK-LABEL: vaaddu_vx_v8i8_floor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vaaddu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i16>
  %yhead = insertelement <8 x i8> poison, i8 %y, i32 0
  %ysplat = shufflevector <8 x i8> %yhead, <8 x i8> poison, <8 x i32> zeroinitializer
  %yzv = zext <8 x i8> %ysplat to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %div = lshr <8 x i16> %add, splat (i16 1)
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}


define <8 x i8> @vaaddu_vv_v8i8_floor_sexti16(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_floor_sexti16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vaadd.vv v8, v8, v9
; CHECK-NEXT:    ret
  %xzv = sext <8 x i8> %x to <8 x i16>
  %yzv = sext <8 x i8> %y to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %div = lshr <8 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i8> @vaaddu_vv_v8i8_floor_zexti32(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_floor_zexti32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i32>
  %yzv = zext <8 x i8> %y to <8 x i32>
  %add = add nuw nsw <8 x i32> %xzv, %yzv
  %div = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %ret = trunc <8 x i32> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i8> @vaaddu_vv_v8i8_floor_lshr2(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_floor_lshr2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    vnsrl.wi v8, v10, 2
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i16>
  %yzv = zext <8 x i8> %y to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %div = lshr <8 x i16> %add, <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i16> @vaaddu_vv_v8i16_floor(<8 x i16> %x, <8 x i16> %y) {
; CHECK-LABEL: vaaddu_vv_v8i16_floor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %xzv = zext <8 x i16> %x to <8 x i32>
  %yzv = zext <8 x i16> %y to <8 x i32>
  %add = add nuw nsw <8 x i32> %xzv, %yzv
  %div = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %ret = trunc <8 x i32> %div to <8 x i16>
  ret <8 x i16> %ret
}

define <8 x i16> @vaaddu_vx_v8i16_floor(<8 x i16> %x, i16 %y) {
; CHECK-LABEL: vaaddu_vx_v8i16_floor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vaaddu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i16> %x to <8 x i32>
  %yhead = insertelement <8 x i16> poison, i16 %y, i16 0
  %ysplat = shufflevector <8 x i16> %yhead, <8 x i16> poison, <8 x i32> zeroinitializer
  %yzv = zext <8 x i16> %ysplat to <8 x i32>
  %add = add nuw nsw <8 x i32> %xzv, %yzv
  %div = lshr <8 x i32> %add, splat (i32 1)
  %ret = trunc <8 x i32> %div to <8 x i16>
  ret <8 x i16> %ret
}

define <8 x i32> @vaaddu_vv_v8i32_floor(<8 x i32> %x, <8 x i32> %y) {
; CHECK-LABEL: vaaddu_vv_v8i32_floor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v10
; CHECK-NEXT:    ret
  %xzv = zext <8 x i32> %x to <8 x i64>
  %yzv = zext <8 x i32> %y to <8 x i64>
  %add = add nuw nsw <8 x i64> %xzv, %yzv
  %div = lshr <8 x i64> %add, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %ret = trunc <8 x i64> %div to <8 x i32>
  ret <8 x i32> %ret
}

define <8 x i32> @vaaddu_vx_v8i32_floor(<8 x i32> %x, i32 %y) {
; CHECK-LABEL: vaaddu_vx_v8i32_floor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vaaddu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i32> %x to <8 x i64>
  %yhead = insertelement <8 x i32> poison, i32 %y, i32 0
  %ysplat = shufflevector <8 x i32> %yhead, <8 x i32> poison, <8 x i32> zeroinitializer
  %yzv = zext <8 x i32> %ysplat to <8 x i64>
  %add = add nuw nsw <8 x i64> %xzv, %yzv
  %div = lshr <8 x i64> %add, splat (i64 1)
  %ret = trunc <8 x i64> %div to <8 x i32>
  ret <8 x i32> %ret
}

define <8 x i64> @vaaddu_vv_v8i64_floor(<8 x i64> %x, <8 x i64> %y) {
; CHECK-LABEL: vaaddu_vv_v8i64_floor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v12
; CHECK-NEXT:    ret
  %xzv = zext <8 x i64> %x to <8 x i128>
  %yzv = zext <8 x i64> %y to <8 x i128>
  %add = add nuw nsw <8 x i128> %xzv, %yzv
  %div = lshr <8 x i128> %add, <i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1>
  %ret = trunc <8 x i128> %div to <8 x i64>
  ret <8 x i64> %ret
}

define <8 x i1> @vaaddu_vv_v8i1_floor(<8 x i1> %x, <8 x i1> %y) {
; CHECK-LABEL: vaaddu_vv_v8i1_floor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v10, v9, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vmerge.vim v8, v9, 1, v0
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vaaddu.vv v8, v10, v8
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i1> %x to <8 x i8>
  %yzv = zext <8 x i1> %y to <8 x i8>
  %add = add nuw nsw <8 x i8> %xzv, %yzv
  %div = lshr <8 x i8> %add, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %ret = trunc <8 x i8> %div to <8 x i1>
  ret <8 x i1> %ret
}

define <8 x i64> @vaaddu_vx_v8i64_floor(<8 x i64> %x, i64 %y) {
; RV32-LABEL: vaaddu_vx_v8i64_floor:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vlse64.v v12, (a0), zero
; RV32-NEXT:    csrwi vxrm, 2
; RV32-NEXT:    vaaddu.vv v8, v8, v12
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    .cfi_def_cfa_offset 0
; RV32-NEXT:    ret
;
; RV64-LABEL: vaaddu_vx_v8i64_floor:
; RV64:       # %bb.0:
; RV64-NEXT:    csrwi vxrm, 2
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vaaddu.vx v8, v8, a0
; RV64-NEXT:    ret
  %xzv = zext <8 x i64> %x to <8 x i128>
  %yhead = insertelement <8 x i64> poison, i64 %y, i64 0
  %ysplat = shufflevector <8 x i64> %yhead, <8 x i64> poison, <8 x i32> zeroinitializer
  %yzv = zext <8 x i64> %ysplat to <8 x i128>
  %add = add nuw nsw <8 x i128> %xzv, %yzv
  %div = lshr <8 x i128> %add, splat (i128 1)
  %ret = trunc <8 x i128> %div to <8 x i64>
  ret <8 x i64> %ret
}

define <8 x i8> @vaaddu_vv_v8i8_ceil(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_ceil:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i16>
  %yzv = zext <8 x i8> %y to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %add1 = add nuw nsw <8 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %div = lshr <8 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i8> @vaaddu_vx_v8i8_ceil(<8 x i8> %x, i8 %y) {
; CHECK-LABEL: vaaddu_vx_v8i8_ceil:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vaaddu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i16>
  %yhead = insertelement <8 x i8> poison, i8 %y, i32 0
  %ysplat = shufflevector <8 x i8> %yhead, <8 x i8> poison, <8 x i32> zeroinitializer
  %yzv = zext <8 x i8> %ysplat to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %add1 = add nuw nsw <8 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %div = lshr <8 x i16> %add1, splat (i16 1)
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i8> @vaaddu_vv_v8i8_ceil_sexti16(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_ceil_sexti16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vaadd.vv v8, v8, v9
; CHECK-NEXT:    ret
  %xzv = sext <8 x i8> %x to <8 x i16>
  %yzv = sext <8 x i8> %y to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %add1 = add nuw nsw <8 x i16> %add, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %div = lshr <8 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i8> @vaaddu_vv_v8i8_ceil_zexti32(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_ceil_zexti32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i32>
  %yzv = zext <8 x i8> %y to <8 x i32>
  %add = add nuw nsw <8 x i32> %xzv, %yzv
  %add1 = add nuw nsw <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %div = lshr <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %ret = trunc <8 x i32> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i8> @vaaddu_vv_v8i8_ceil_lshr2(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_ceil_lshr2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vadd.vi v8, v10, 2
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 2
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i16>
  %yzv = zext <8 x i8> %y to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %add1 = add nuw nsw <8 x i16> %add, <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
  %div = lshr <8 x i16> %add1, <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i8> @vaaddu_vv_v8i8_ceil_add2(<8 x i8> %x, <8 x i8> %y) {
; CHECK-LABEL: vaaddu_vv_v8i8_ceil_add2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    csrwi vxrm, 2
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vaaddu.vx v8, v10, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i8> %x to <8 x i16>
  %yzv = zext <8 x i8> %y to <8 x i16>
  %add = add nuw nsw <8 x i16> %xzv, %yzv
  %add1 = add nuw nsw <8 x i16> %add, <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>
  %div = lshr <8 x i16> %add1, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %ret = trunc <8 x i16> %div to <8 x i8>
  ret <8 x i8> %ret
}

define <8 x i16> @vaaddu_vv_v8i16_ceil(<8 x i16> %x, <8 x i16> %y) {
; CHECK-LABEL: vaaddu_vv_v8i16_ceil:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v9
; CHECK-NEXT:    ret
  %xzv = zext <8 x i16> %x to <8 x i32>
  %yzv = zext <8 x i16> %y to <8 x i32>
  %add = add nuw nsw <8 x i32> %xzv, %yzv
  %add1 = add nuw nsw <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %div = lshr <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %ret = trunc <8 x i32> %div to <8 x i16>
  ret <8 x i16> %ret
}

define <8 x i16> @vaaddu_vx_v8i16_ceil(<8 x i16> %x, i16 %y) {
; CHECK-LABEL: vaaddu_vx_v8i16_ceil:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vaaddu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i16> %x to <8 x i32>
  %yhead = insertelement <8 x i16> poison, i16 %y, i16 0
  %ysplat = shufflevector <8 x i16> %yhead, <8 x i16> poison, <8 x i32> zeroinitializer
  %yzv = zext <8 x i16> %ysplat to <8 x i32>
  %add = add nuw nsw <8 x i32> %xzv, %yzv
  %add1 = add nuw nsw <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %div = lshr <8 x i32> %add1, splat (i32 1)
  %ret = trunc <8 x i32> %div to <8 x i16>
  ret <8 x i16> %ret
}

define <8 x i32> @vaaddu_vv_v8i32_ceil(<8 x i32> %x, <8 x i32> %y) {
; CHECK-LABEL: vaaddu_vv_v8i32_ceil:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v10
; CHECK-NEXT:    ret
  %xzv = zext <8 x i32> %x to <8 x i64>
  %yzv = zext <8 x i32> %y to <8 x i64>
  %add = add nuw nsw <8 x i64> %xzv, %yzv
  %add1 = add nuw nsw <8 x i64> %add, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %div = lshr <8 x i64> %add1, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %ret = trunc <8 x i64> %div to <8 x i32>
  ret <8 x i32> %ret
}

define <8 x i32> @vaaddu_vx_v8i32_ceil(<8 x i32> %x, i32 %y) {
; CHECK-LABEL: vaaddu_vx_v8i32_ceil:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vaaddu.vx v8, v8, a0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i32> %x to <8 x i64>
  %yhead = insertelement <8 x i32> poison, i32 %y, i32 0
  %ysplat = shufflevector <8 x i32> %yhead, <8 x i32> poison, <8 x i32> zeroinitializer
  %yzv = zext <8 x i32> %ysplat to <8 x i64>
  %add = add nuw nsw <8 x i64> %xzv, %yzv
  %add1 = add nuw nsw <8 x i64> %add, <i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1, i64 1>
  %div = lshr <8 x i64> %add1, splat (i64 1)
  %ret = trunc <8 x i64> %div to <8 x i32>
  ret <8 x i32> %ret
}

define <8 x i64> @vaaddu_vv_v8i64_ceil(<8 x i64> %x, <8 x i64> %y) {
; CHECK-LABEL: vaaddu_vv_v8i64_ceil:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vaaddu.vv v8, v8, v12
; CHECK-NEXT:    ret
  %xzv = zext <8 x i64> %x to <8 x i128>
  %yzv = zext <8 x i64> %y to <8 x i128>
  %add = add nuw nsw <8 x i128> %xzv, %yzv
  %add1 = add nuw nsw <8 x i128> %add, <i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1>
  %div = lshr <8 x i128> %add1, <i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1>
  %ret = trunc <8 x i128> %div to <8 x i64>
  ret <8 x i64> %ret
}

define <8 x i1> @vaaddu_vv_v8i1_ceil(<8 x i1> %x, <8 x i1> %y) {
; CHECK-LABEL: vaaddu_vv_v8i1_ceil:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v10, v9, 1, v0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vmerge.vim v8, v9, 1, v0
; CHECK-NEXT:    csrwi vxrm, 0
; CHECK-NEXT:    vaaddu.vv v8, v10, v8
; CHECK-NEXT:    vand.vi v8, v8, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %xzv = zext <8 x i1> %x to <8 x i8>
  %yzv = zext <8 x i1> %y to <8 x i8>
  %add = add nuw nsw <8 x i8> %xzv, %yzv
  %add1 = add nuw nsw <8 x i8> %add, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %div = lshr <8 x i8> %add1, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  %ret = trunc <8 x i8> %div to <8 x i1>
  ret <8 x i1> %ret
}

define <8 x i64> @vaaddu_vx_v8i64_ceil(<8 x i64> %x, i64 %y) {
; RV32-LABEL: vaaddu_vx_v8i64_ceil:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    sw a1, 12(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vlse64.v v12, (a0), zero
; RV32-NEXT:    csrwi vxrm, 0
; RV32-NEXT:    vaaddu.vv v8, v8, v12
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    .cfi_def_cfa_offset 0
; RV32-NEXT:    ret
;
; RV64-LABEL: vaaddu_vx_v8i64_ceil:
; RV64:       # %bb.0:
; RV64-NEXT:    csrwi vxrm, 0
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vaaddu.vx v8, v8, a0
; RV64-NEXT:    ret
  %xzv = zext <8 x i64> %x to <8 x i128>
  %yhead = insertelement <8 x i64> poison, i64 %y, i64 0
  %ysplat = shufflevector <8 x i64> %yhead, <8 x i64> poison, <8 x i32> zeroinitializer
  %yzv = zext <8 x i64> %ysplat to <8 x i128>
  %add = add nuw nsw <8 x i128> %xzv, %yzv
  %add1 = add nuw nsw <8 x i128> %add, <i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1, i128 1>
  %div = lshr <8 x i128> %add1, splat (i128 1)
  %ret = trunc <8 x i128> %div to <8 x i64>
  ret <8 x i64> %ret
}