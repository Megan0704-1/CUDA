; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define <4 x i64> @m2_splat_0(<4 x i64> %v1) vscale_range(2,2) {
; CHECK-LABEL: m2_splat_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vrgather.vi v10, v8, 0
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> poison, <4 x i32> <i32 0, i32 0, i32 0, i32 0>
  ret <4 x i64> %res
}

define <4 x i64> @m2_splat_in_chunks(<4 x i64> %v1) vscale_range(2,2) {
; CHECK-LABEL: m2_splat_in_chunks:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v10, v8, 0
; CHECK-NEXT:    vrgather.vi v11, v9, 0
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> poison, <4 x i32> <i32 0, i32 0, i32 2, i32 2>
  ret <4 x i64> %res
}

define <8 x i64> @m4_splat_in_chunks(<8 x i64> %v1) vscale_range(2,2) {
; CHECK-LABEL: m4_splat_in_chunks:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v12, v8, 0
; CHECK-NEXT:    vrgather.vi v13, v9, 0
; CHECK-NEXT:    vrgather.vi v14, v10, 0
; CHECK-NEXT:    vrgather.vi v15, v11, 1
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i64> %v1, <8 x i64> poison, <8 x i32> <i32 0, i32 0, i32 2, i32 2, i32 4, i32 4, i32 7, i32 7>
  ret <8 x i64> %res
}


define <4 x i64> @m2_splat_with_tail(<4 x i64> %v1) vscale_range(2,2) {
; CHECK-LABEL: m2_splat_with_tail:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v10, v8, 0
; CHECK-NEXT:    vmv1r.v v11, v9
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> poison, <4 x i32> <i32 0, i32 0, i32 2, i32 3>
  ret <4 x i64> %res
}

define <4 x i64> @m2_pair_swap_vl4(<4 x i64> %v1) vscale_range(2,2) {
; CHECK-LABEL: m2_pair_swap_vl4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v11, v9, 1
; CHECK-NEXT:    vslideup.vi v11, v9, 1
; CHECK-NEXT:    vslidedown.vi v10, v8, 1
; CHECK-NEXT:    vslideup.vi v10, v8, 1
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> poison, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  ret <4 x i64> %res
}

define <8 x i32> @m2_pair_swap_vl8(<8 x i32> %v1) vscale_range(2,2) {
; RV32-LABEL: m2_pair_swap_vl8:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; RV32-NEXT:    vmv.v.i v10, 0
; RV32-NEXT:    li a0, 32
; RV32-NEXT:    li a1, 63
; RV32-NEXT:    vwsubu.vx v12, v10, a0
; RV32-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; RV32-NEXT:    vmv.v.x v10, a0
; RV32-NEXT:    vand.vx v12, v12, a1
; RV32-NEXT:    vand.vx v10, v10, a1
; RV32-NEXT:    vsrl.vv v12, v8, v12
; RV32-NEXT:    vsll.vv v8, v8, v10
; RV32-NEXT:    vor.vv v8, v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: m2_pair_swap_vl8:
; RV64:       # %bb.0:
; RV64-NEXT:    li a0, 32
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    vsrl.vx v10, v8, a0
; RV64-NEXT:    vsll.vx v8, v8, a0
; RV64-NEXT:    vor.vv v8, v8, v10
; RV64-NEXT:    ret
  %res = shufflevector <8 x i32> %v1, <8 x i32> poison, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  ret <8 x i32> %res
}

define <4 x i64> @m2_splat_into_identity(<4 x i64> %v1) vscale_range(2,2) {
; CHECK-LABEL: m2_splat_into_identity:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v10, v8, 0
; CHECK-NEXT:    vmv1r.v v11, v9
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> poison, <4 x i32> <i32 0, i32 0, i32 2, i32 3>
  ret <4 x i64> %res
}

define <4 x i64> @m2_broadcast_i128(<4 x i64> %v1) vscale_range(2,2) {
; CHECK-LABEL: m2_broadcast_i128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv1r.v v9, v8
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  ret <4 x i64> %res
}

define <8 x i64> @m4_broadcast_i128(<8 x i64> %v1) vscale_range(2,2) {
; CHECK-LABEL: m4_broadcast_i128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv1r.v v9, v8
; CHECK-NEXT:    vmv1r.v v10, v8
; CHECK-NEXT:    vmv1r.v v11, v8
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i64> %v1, <8 x i64> poison, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  ret <8 x i64> %res
}


define <4 x i64> @m2_splat_two_source(<4 x i64> %v1, <4 x i64> %v2) vscale_range(2,2) {
; CHECK-LABEL: m2_splat_two_source:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v12, v8, 0
; CHECK-NEXT:    vrgather.vi v13, v11, 1
; CHECK-NEXT:    vmv2r.v v8, v12
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> %v2, <4 x i32> <i32 0, i32 0, i32 7, i32 7>
  ret <4 x i64> %res
}

define <4 x i64> @m2_splat_into_identity_two_source_v2_hi(<4 x i64> %v1, <4 x i64> %v2) vscale_range(2,2) {
; CHECK-LABEL: m2_splat_into_identity_two_source_v2_hi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v10, v8, 0
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> %v2, <4 x i32> <i32 0, i32 0, i32 6, i32 7>
  ret <4 x i64> %res
}

define <4 x i64> @m2_splat_into_slide_two_source_v2_lo(<4 x i64> %v1, <4 x i64> %v2) vscale_range(2,2) {
; CHECK-LABEL: m2_splat_into_slide_two_source_v2_lo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vrgather.vi v12, v8, 0
; CHECK-NEXT:    vmv1r.v v13, v10
; CHECK-NEXT:    vmv2r.v v8, v12
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> %v2, <4 x i32> <i32 0, i32 0, i32 4, i32 5>
  ret <4 x i64> %res
}

define <4 x i64> @m2_splat_into_slide_two_source(<4 x i64> %v1, <4 x i64> %v2) vscale_range(2,2) {
; CHECK-LABEL: m2_splat_into_slide_two_source:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 12
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, mu
; CHECK-NEXT:    vrgather.vi v12, v8, 0
; CHECK-NEXT:    vslideup.vi v12, v10, 1, v0.t
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
  %res = shufflevector <4 x i64> %v1, <4 x i64> %v2, <4 x i32> <i32 0, i32 0, i32 5, i32 6>
  ret <4 x i64> %res
}

define void @shuffle1(ptr %explicit_0, ptr %explicit_1) vscale_range(2,2) {
; CHECK-LABEL: shuffle1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, a0, 252
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    li a0, 175
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vsrl.vi v8, v8, 1
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vadd.vi v8, v8, 1
; CHECK-NEXT:    vrgather.vv v11, v9, v8
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v10, 0, v0
; CHECK-NEXT:    addi a0, a1, 672
; CHECK-NEXT:    vs2r.v v8, (a0)
; CHECK-NEXT:    ret
  %1 = getelementptr i32, ptr %explicit_0, i64 63
  %2 = load <3 x i32>, ptr %1, align 1
  %3 = shufflevector <3 x i32> %2, <3 x i32> undef, <2 x i32> <i32 1, i32 2>
  %4 = shufflevector <2 x i32> %3, <2 x i32> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %5 = shufflevector <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 undef, i32 0, i32 undef, i32 0>, <8 x i32> %4, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 5, i32 9, i32 7>
  %6 = getelementptr inbounds <8 x i32>, ptr %explicit_1, i64 21
  store <8 x i32> %5, ptr %6, align 32
  ret void
}

define <16 x float> @shuffle2(<4 x float> %a) vscale_range(2,2) {
; CHECK-LABEL: shuffle2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    li a0, -97
; CHECK-NEXT:    vadd.vv v9, v9, v9
; CHECK-NEXT:    vrsub.vi v9, v9, 4
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vrgather.vv v13, v8, v9
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v12, 0, v0
; CHECK-NEXT:    ret
  %b = extractelement <4 x float> %a, i32 2
  %c = insertelement <16 x float> <float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float undef, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float 0.000000e+00>, float %b, i32 5
  %b1 = extractelement <4 x float> %a, i32 0
  %c1 = insertelement <16 x float> %c, float %b1, i32 6
  ret <16 x float>%c1
}

define i64 @extract_any_extend_vector_inreg_v16i64(<16 x i64> %a0, i32 %a1) vscale_range(2,2) {
; RV32-LABEL: extract_any_extend_vector_inreg_v16i64:
; RV32:       # %bb.0:
; RV32-NEXT:    li a1, 16
; RV32-NEXT:    vsetivli zero, 16, e64, m8, ta, mu
; RV32-NEXT:    vmv.v.i v16, 0
; RV32-NEXT:    vmv.s.x v0, a1
; RV32-NEXT:    li a1, 32
; RV32-NEXT:    vrgather.vi v16, v8, 15, v0.t
; RV32-NEXT:    vsetvli zero, zero, e64, m8, ta, ma
; RV32-NEXT:    vslidedown.vx v8, v16, a0
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    vsetivli zero, 1, e64, m8, ta, ma
; RV32-NEXT:    vsrl.vx v8, v8, a1
; RV32-NEXT:    vmv.x.s a1, v8
; RV32-NEXT:    ret
;
; RV64-LABEL: extract_any_extend_vector_inreg_v16i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -256
; RV64-NEXT:    .cfi_def_cfa_offset 256
; RV64-NEXT:    sd ra, 248(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 240(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s2, 232(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    .cfi_offset s2, -24
; RV64-NEXT:    addi s0, sp, 256
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    andi sp, sp, -128
; RV64-NEXT:    li a1, -17
; RV64-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; RV64-NEXT:    vmv.s.x v0, a1
; RV64-NEXT:    vrgather.vi v16, v8, 15
; RV64-NEXT:    vmerge.vim v8, v16, 0, v0
; RV64-NEXT:    mv s2, sp
; RV64-NEXT:    vs8r.v v8, (s2)
; RV64-NEXT:    andi a0, a0, 15
; RV64-NEXT:    li a1, 8
; RV64-NEXT:    call __muldi3
; RV64-NEXT:    add a0, s2, a0
; RV64-NEXT:    ld a0, 0(a0)
; RV64-NEXT:    addi sp, s0, -256
; RV64-NEXT:    .cfi_def_cfa sp, 256
; RV64-NEXT:    ld ra, 248(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 240(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s2, 232(sp) # 8-byte Folded Reload
; RV64-NEXT:    .cfi_restore ra
; RV64-NEXT:    .cfi_restore s0
; RV64-NEXT:    .cfi_restore s2
; RV64-NEXT:    addi sp, sp, 256
; RV64-NEXT:    .cfi_def_cfa_offset 0
; RV64-NEXT:    ret
  %1 = extractelement <16 x i64> %a0, i32 15
  %2 = insertelement <16 x i64> zeroinitializer, i64 %1, i32 4
  %3 = extractelement <16 x i64> %2, i32 %a1
  ret i64 %3
}

define <4 x double> @shuffles_add(<4 x double> %0, <4 x double> %1) vscale_range(2,2) {
; CHECK-LABEL: shuffles_add:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vrgather.vi v12, v8, 2
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vid.v v14
; CHECK-NEXT:    vmv.v.i v0, 12
; CHECK-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; CHECK-NEXT:    vrgather.vi v16, v8, 3
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vadd.vv v8, v14, v14
; CHECK-NEXT:    vadd.vi v9, v8, -4
; CHECK-NEXT:    vadd.vi v8, v8, -3
; CHECK-NEXT:    vsetvli zero, zero, e64, m2, ta, mu
; CHECK-NEXT:    vrgatherei16.vv v12, v10, v9, v0.t
; CHECK-NEXT:    vrgatherei16.vv v16, v10, v8, v0.t
; CHECK-NEXT:    vfadd.vv v8, v12, v16
; CHECK-NEXT:    ret
  %3 = shufflevector <4 x double> %0, <4 x double> %1, <4 x i32> <i32 undef, i32 2, i32 4, i32 6>
  %4 = shufflevector <4 x double> %0, <4 x double> %1, <4 x i32> <i32 undef, i32 3, i32 5, i32 7>
  %5 = fadd <4 x double> %3, %4
  ret <4 x double> %5
}

define <16 x i32> @m4_square_num_of_shuffles_in_chunks(<16 x i32> %0) vscale_range(2,2) {
; CHECK-LABEL: m4_square_num_of_shuffles_in_chunks:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a0, %hi(.LCPI17_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI17_0)
; CHECK-NEXT:    vl1r.v v12, (a0)
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vsext.vf2 v16, v12
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v12, v8, v16
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %1 = shufflevector <16 x i32> %0, <16 x i32> poison, <16 x i32> <i32 0, i32 5, i32 8, i32 12, i32 1, i32 4, i32 9, i32 13, i32 2, i32 6, i32 10, i32 14, i32 3, i32 7, i32 11, i32 15>
  ret <16 x i32> %1
}

define <16 x i32> @m4_linear_num_of_shuffles_in_chunks(<16 x i32> %0) vscale_range(2,2) {
; CHECK-LABEL: m4_linear_num_of_shuffles_in_chunks:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a0, %hi(.LCPI18_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI18_0)
; CHECK-NEXT:    vl2re16.v v16, (a0)
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vrgatherei16.vv v12, v8, v16
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %1 = shufflevector <16 x i32> %0, <16 x i32> poison, <16 x i32> <i32 poison, i32 poison, i32 8, i32 12, i32 poison, i32 poison, i32 poison, i32 poison, i32 2, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 11, i32 poison>
  ret <16 x i32> %1
}

define i64 @multi_chunks_shuffle(<32 x i32> %0) vscale_range(8,8) {
; RV32-LABEL: multi_chunks_shuffle:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetivli zero, 16, e32, m1, ta, ma
; RV32-NEXT:    vmv.v.i v10, 0
; RV32-NEXT:    li a0, 32
; RV32-NEXT:    li a1, 63
; RV32-NEXT:    vwsubu.vx v12, v10, a0
; RV32-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; RV32-NEXT:    vmv.v.x v10, a0
; RV32-NEXT:    lui a0, 61681
; RV32-NEXT:    addi a0, a0, -241
; RV32-NEXT:    vand.vx v12, v12, a1
; RV32-NEXT:    vand.vx v10, v10, a1
; RV32-NEXT:    vsrl.vv v12, v8, v12
; RV32-NEXT:    vsll.vv v8, v8, v10
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vor.vv v8, v8, v12
; RV32-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; RV32-NEXT:    vmv.v.i v10, 0
; RV32-NEXT:    vmerge.vvm v8, v10, v8, v0
; RV32-NEXT:    vrgather.vi v10, v8, 2
; RV32-NEXT:    vor.vv v8, v8, v10
; RV32-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v8, 1
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    srai a1, a0, 31
; RV32-NEXT:    ret
;
; RV64-LABEL: multi_chunks_shuffle:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    li a0, 32
; RV64-NEXT:    vsetivli zero, 16, e64, m2, ta, ma
; RV64-NEXT:    vsrl.vx v10, v8, a0
; RV64-NEXT:    vsll.vx v8, v8, a0
; RV64-NEXT:    lui a0, 61681
; RV64-NEXT:    addi a0, a0, -241
; RV64-NEXT:    vor.vv v8, v8, v10
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; RV64-NEXT:    vmv.v.i v10, 0
; RV64-NEXT:    vmerge.vvm v8, v10, v8, v0
; RV64-NEXT:    vrgather.vi v10, v8, 2
; RV64-NEXT:    vor.vv v8, v8, v10
; RV64-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v8, 1
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    ret
entry:
  %1 = shufflevector <32 x i32> %0, <32 x i32> zeroinitializer, <32 x i32> <i32 1, i32 0, i32 3, i32 2, i32 37, i32 36, i32 39, i32 38, i32 9, i32 8, i32 11, i32 10, i32 45, i32 44, i32 47, i32 46, i32 17, i32 16, i32 19, i32 18, i32 53, i32 52, i32 55, i32 54, i32 25, i32 24, i32 27, i32 26, i32 61, i32 60, i32 63, i32 62>
  %2 = shufflevector <32 x i32> zeroinitializer, <32 x i32> %1, <32 x i32> <i32 3, i32 34, i32 33, i32 0, i32 7, i32 38, i32 37, i32 4, i32 11, i32 42, i32 41, i32 8, i32 15, i32 46, i32 45, i32 12, i32 19, i32 50, i32 49, i32 16, i32 23, i32 54, i32 53, i32 20, i32 27, i32 58, i32 57, i32 24, i32 31, i32 62, i32 61, i32 28>
  %3 = or <32 x i32> %1, %2
  %4 = extractelement <32 x i32> %3, i64 1
  %conv199 = sext i32 %4 to i64
  ret i64 %conv199
}

define void @shuffle_i128_ldst(ptr %p) vscale_range(2,2) {
; RV32-LABEL: shuffle_i128_ldst:
; RV32:       # %bb.0:
; RV32-NEXT:    lw a1, 48(a0)
; RV32-NEXT:    lw a2, 52(a0)
; RV32-NEXT:    lw a3, 56(a0)
; RV32-NEXT:    lw a4, 60(a0)
; RV32-NEXT:    lw a5, 0(a0)
; RV32-NEXT:    lw a6, 4(a0)
; RV32-NEXT:    lw a7, 8(a0)
; RV32-NEXT:    lw t0, 12(a0)
; RV32-NEXT:    lw t1, 32(a0)
; RV32-NEXT:    lw t2, 36(a0)
; RV32-NEXT:    lw t3, 40(a0)
; RV32-NEXT:    lw t4, 44(a0)
; RV32-NEXT:    sw t1, 48(a0)
; RV32-NEXT:    sw t2, 52(a0)
; RV32-NEXT:    sw t3, 56(a0)
; RV32-NEXT:    sw t4, 60(a0)
; RV32-NEXT:    sw a5, 16(a0)
; RV32-NEXT:    sw a6, 20(a0)
; RV32-NEXT:    sw a7, 24(a0)
; RV32-NEXT:    sw t0, 28(a0)
; RV32-NEXT:    sw a1, 32(a0)
; RV32-NEXT:    sw a2, 36(a0)
; RV32-NEXT:    sw a3, 40(a0)
; RV32-NEXT:    sw a4, 44(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: shuffle_i128_ldst:
; RV64:       # %bb.0:
; RV64-NEXT:    ld a1, 0(a0)
; RV64-NEXT:    ld a2, 8(a0)
; RV64-NEXT:    ld a3, 32(a0)
; RV64-NEXT:    ld a4, 40(a0)
; RV64-NEXT:    ld a5, 48(a0)
; RV64-NEXT:    ld a6, 56(a0)
; RV64-NEXT:    sd a3, 48(a0)
; RV64-NEXT:    sd a4, 56(a0)
; RV64-NEXT:    sd a1, 16(a0)
; RV64-NEXT:    sd a2, 24(a0)
; RV64-NEXT:    sd a5, 32(a0)
; RV64-NEXT:    sd a6, 40(a0)
; RV64-NEXT:    ret
  %a = load <4 x i128>, ptr %p
  %res = shufflevector <4 x i128> %a, <4 x i128> poison, <4 x i32> <i32 0, i32 0, i32 3, i32 2>
  store <4 x i128> %res, ptr %p
  ret void
}

define void @shuffle_i256_ldst(ptr %p) vscale_range(2,2) {
; RV32-LABEL: shuffle_i256_ldst:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -48
; RV32-NEXT:    .cfi_def_cfa_offset 48
; RV32-NEXT:    sw s0, 44(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s1, 40(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s2, 36(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s3, 32(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s4, 28(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s5, 24(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s6, 20(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s7, 16(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s8, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s9, 8(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset s0, -4
; RV32-NEXT:    .cfi_offset s1, -8
; RV32-NEXT:    .cfi_offset s2, -12
; RV32-NEXT:    .cfi_offset s3, -16
; RV32-NEXT:    .cfi_offset s4, -20
; RV32-NEXT:    .cfi_offset s5, -24
; RV32-NEXT:    .cfi_offset s6, -28
; RV32-NEXT:    .cfi_offset s7, -32
; RV32-NEXT:    .cfi_offset s8, -36
; RV32-NEXT:    .cfi_offset s9, -40
; RV32-NEXT:    lw a1, 0(a0)
; RV32-NEXT:    lw a2, 4(a0)
; RV32-NEXT:    lw a3, 8(a0)
; RV32-NEXT:    lw a4, 12(a0)
; RV32-NEXT:    lw a5, 16(a0)
; RV32-NEXT:    lw a6, 20(a0)
; RV32-NEXT:    lw a7, 24(a0)
; RV32-NEXT:    lw t0, 28(a0)
; RV32-NEXT:    lw t1, 96(a0)
; RV32-NEXT:    lw t2, 100(a0)
; RV32-NEXT:    lw t3, 104(a0)
; RV32-NEXT:    lw t4, 108(a0)
; RV32-NEXT:    lw t5, 112(a0)
; RV32-NEXT:    lw t6, 116(a0)
; RV32-NEXT:    lw s0, 120(a0)
; RV32-NEXT:    lw s1, 124(a0)
; RV32-NEXT:    lw s2, 64(a0)
; RV32-NEXT:    lw s3, 68(a0)
; RV32-NEXT:    lw s4, 72(a0)
; RV32-NEXT:    lw s5, 76(a0)
; RV32-NEXT:    lw s6, 80(a0)
; RV32-NEXT:    lw s7, 84(a0)
; RV32-NEXT:    lw s8, 88(a0)
; RV32-NEXT:    lw s9, 92(a0)
; RV32-NEXT:    sw s6, 112(a0)
; RV32-NEXT:    sw s7, 116(a0)
; RV32-NEXT:    sw s8, 120(a0)
; RV32-NEXT:    sw s9, 124(a0)
; RV32-NEXT:    sw s2, 96(a0)
; RV32-NEXT:    sw s3, 100(a0)
; RV32-NEXT:    sw s4, 104(a0)
; RV32-NEXT:    sw s5, 108(a0)
; RV32-NEXT:    sw t5, 80(a0)
; RV32-NEXT:    sw t6, 84(a0)
; RV32-NEXT:    sw s0, 88(a0)
; RV32-NEXT:    sw s1, 92(a0)
; RV32-NEXT:    sw t1, 64(a0)
; RV32-NEXT:    sw t2, 68(a0)
; RV32-NEXT:    sw t3, 72(a0)
; RV32-NEXT:    sw t4, 76(a0)
; RV32-NEXT:    sw a5, 48(a0)
; RV32-NEXT:    sw a6, 52(a0)
; RV32-NEXT:    sw a7, 56(a0)
; RV32-NEXT:    sw t0, 60(a0)
; RV32-NEXT:    sw a1, 32(a0)
; RV32-NEXT:    sw a2, 36(a0)
; RV32-NEXT:    sw a3, 40(a0)
; RV32-NEXT:    sw a4, 44(a0)
; RV32-NEXT:    lw s0, 44(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s1, 40(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s2, 36(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s3, 32(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s4, 28(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s5, 24(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s6, 20(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s7, 16(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s8, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s9, 8(sp) # 4-byte Folded Reload
; RV32-NEXT:    .cfi_restore s0
; RV32-NEXT:    .cfi_restore s1
; RV32-NEXT:    .cfi_restore s2
; RV32-NEXT:    .cfi_restore s3
; RV32-NEXT:    .cfi_restore s4
; RV32-NEXT:    .cfi_restore s5
; RV32-NEXT:    .cfi_restore s6
; RV32-NEXT:    .cfi_restore s7
; RV32-NEXT:    .cfi_restore s8
; RV32-NEXT:    .cfi_restore s9
; RV32-NEXT:    addi sp, sp, 48
; RV32-NEXT:    .cfi_def_cfa_offset 0
; RV32-NEXT:    ret
;
; RV64-LABEL: shuffle_i256_ldst:
; RV64:       # %bb.0:
; RV64-NEXT:    ld a1, 96(a0)
; RV64-NEXT:    ld a2, 104(a0)
; RV64-NEXT:    ld a3, 112(a0)
; RV64-NEXT:    ld a4, 120(a0)
; RV64-NEXT:    ld a5, 0(a0)
; RV64-NEXT:    ld a6, 8(a0)
; RV64-NEXT:    ld a7, 16(a0)
; RV64-NEXT:    ld t0, 24(a0)
; RV64-NEXT:    ld t1, 64(a0)
; RV64-NEXT:    ld t2, 72(a0)
; RV64-NEXT:    ld t3, 80(a0)
; RV64-NEXT:    ld t4, 88(a0)
; RV64-NEXT:    sd t1, 96(a0)
; RV64-NEXT:    sd t2, 104(a0)
; RV64-NEXT:    sd t3, 112(a0)
; RV64-NEXT:    sd t4, 120(a0)
; RV64-NEXT:    sd a5, 32(a0)
; RV64-NEXT:    sd a6, 40(a0)
; RV64-NEXT:    sd a7, 48(a0)
; RV64-NEXT:    sd t0, 56(a0)
; RV64-NEXT:    sd a1, 64(a0)
; RV64-NEXT:    sd a2, 72(a0)
; RV64-NEXT:    sd a3, 80(a0)
; RV64-NEXT:    sd a4, 88(a0)
; RV64-NEXT:    ret
  %a = load <4 x i256>, ptr %p
  %res = shufflevector <4 x i256> %a, <4 x i256> poison, <4 x i32> <i32 0, i32 0, i32 3, i32 2>
  store <4 x i256> %res, ptr %p
  ret void
}