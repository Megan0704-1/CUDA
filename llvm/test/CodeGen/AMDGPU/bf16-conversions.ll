; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=amdgcn -mcpu=gfx940 < %s | FileCheck --check-prefixes=GCN,GFX-940 %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx950 < %s | FileCheck --check-prefixes=GCN,GFX-950 %s

; TODO: Add global-isel when it can support bf16

define amdgpu_ps float @v_test_cvt_bf16_f32_v(bfloat %v) {
; GCN-LABEL: v_test_cvt_bf16_f32_v:
; GCN:       ; %bb.0:
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 16, v0
; GCN-NEXT:    ; return to shader part epilog
  %cvt = fpext bfloat %v to float
  ret float %cvt
}

define amdgpu_ps float @v_test_cvt_bf16_f32_s(bfloat inreg %v) {
; GCN-LABEL: v_test_cvt_bf16_f32_s:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_lshl_b32 s0, s0, 16
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    ; return to shader part epilog
  %cvt = fpext bfloat %v to float
  ret float %cvt
}

define amdgpu_ps float @v_test_cvt_v2f32_v2bf16_v(<2 x float> %src) {
; GFX-940-LABEL: v_test_cvt_v2f32_v2bf16_v:
; GFX-940:       ; %bb.0:
; GFX-940-NEXT:    v_bfe_u32 v2, v0, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v2, v2, v0, s0
; GFX-940-NEXT:    v_or_b32_e32 v3, 0x400000, v0
; GFX-940-NEXT:    v_cmp_u_f32_e32 vcc, v0, v0
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v2, v3, vcc
; GFX-940-NEXT:    v_bfe_u32 v2, v1, 16, 1
; GFX-940-NEXT:    v_add3_u32 v2, v2, v1, s0
; GFX-940-NEXT:    v_or_b32_e32 v3, 0x400000, v1
; GFX-940-NEXT:    v_cmp_u_f32_e32 vcc, v1, v1
; GFX-940-NEXT:    s_mov_b32 s0, 0x7060302
; GFX-940-NEXT:    s_nop 0
; GFX-940-NEXT:    v_cndmask_b32_e32 v1, v2, v3, vcc
; GFX-940-NEXT:    v_perm_b32 v0, v1, v0, s0
; GFX-940-NEXT:    ; return to shader part epilog
;
; GFX-950-LABEL: v_test_cvt_v2f32_v2bf16_v:
; GFX-950:       ; %bb.0:
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, v0, v1
; GFX-950-NEXT:    ; return to shader part epilog
  %res = fptrunc <2 x float> %src to <2 x bfloat>
  %cast = bitcast <2 x bfloat> %res to float
  ret float %cast
}

define amdgpu_ps float @v_test_cvt_v2f32_v2bf16_s(<2 x float> inreg %src) {
; GFX-940-LABEL: v_test_cvt_v2f32_v2bf16_s:
; GFX-940:       ; %bb.0:
; GFX-940-NEXT:    s_bfe_u32 s2, s1, 0x10010
; GFX-940-NEXT:    s_add_i32 s2, s2, s1
; GFX-940-NEXT:    s_or_b32 s4, s1, 0x400000
; GFX-940-NEXT:    s_add_i32 s5, s2, 0x7fff
; GFX-940-NEXT:    v_cmp_u_f32_e64 s[2:3], s1, s1
; GFX-940-NEXT:    s_and_b64 s[2:3], s[2:3], exec
; GFX-940-NEXT:    s_cselect_b32 s1, s4, s5
; GFX-940-NEXT:    s_lshr_b32 s2, s1, 16
; GFX-940-NEXT:    s_bfe_u32 s1, s0, 0x10010
; GFX-940-NEXT:    s_add_i32 s1, s1, s0
; GFX-940-NEXT:    s_or_b32 s3, s0, 0x400000
; GFX-940-NEXT:    s_add_i32 s4, s1, 0x7fff
; GFX-940-NEXT:    v_cmp_u_f32_e64 s[0:1], s0, s0
; GFX-940-NEXT:    s_and_b64 s[0:1], s[0:1], exec
; GFX-940-NEXT:    s_cselect_b32 s0, s3, s4
; GFX-940-NEXT:    s_lshr_b32 s0, s0, 16
; GFX-940-NEXT:    s_pack_ll_b32_b16 s0, s0, s2
; GFX-940-NEXT:    v_mov_b32_e32 v0, s0
; GFX-940-NEXT:    ; return to shader part epilog
;
; GFX-950-LABEL: v_test_cvt_v2f32_v2bf16_s:
; GFX-950:       ; %bb.0:
; GFX-950-NEXT:    v_mov_b32_e32 v0, s1
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, s0, v0
; GFX-950-NEXT:    ; return to shader part epilog
  %res = fptrunc <2 x float> %src to <2 x bfloat>
  %cast = bitcast <2 x bfloat> %res to float
  ret float %cast
}

define amdgpu_ps float @v_test_cvt_f32_bf16_v(float %src) {
; GFX-940-LABEL: v_test_cvt_f32_bf16_v:
; GFX-940:       ; %bb.0:
; GFX-940-NEXT:    v_bfe_u32 v1, v0, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v1, v1, v0, s0
; GFX-940-NEXT:    v_or_b32_e32 v2, 0x400000, v0
; GFX-940-NEXT:    v_cmp_u_f32_e32 vcc, v0, v0
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GFX-940-NEXT:    v_and_b32_e32 v0, 0xffff0000, v0
; GFX-940-NEXT:    ; return to shader part epilog
;
; GFX-950-LABEL: v_test_cvt_f32_bf16_v:
; GFX-950:       ; %bb.0:
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, v0, s0
; GFX-950-NEXT:    v_lshlrev_b32_e32 v0, 16, v0
; GFX-950-NEXT:    ; return to shader part epilog
  %trunc = fptrunc float %src to bfloat
  %ext = fpext bfloat %trunc to float
  ret float %ext
}

define amdgpu_ps float @v_test_cvt_v2f64_v2bf16_v(<2 x double> %src) {
; GFX-940-LABEL: v_test_cvt_v2f64_v2bf16_v:
; GFX-940:       ; %bb.0:
; GFX-940-NEXT:    v_cvt_f32_f64_e64 v6, |v[0:1]|
; GFX-940-NEXT:    v_cvt_f64_f32_e32 v[4:5], v6
; GFX-940-NEXT:    v_and_b32_e32 v7, 1, v6
; GFX-940-NEXT:    v_cmp_gt_f64_e64 s[2:3], |v[0:1]|, v[4:5]
; GFX-940-NEXT:    v_cmp_nlg_f64_e64 s[0:1], |v[0:1]|, v[4:5]
; GFX-940-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v7
; GFX-940-NEXT:    v_cndmask_b32_e64 v4, -1, 1, s[2:3]
; GFX-940-NEXT:    v_add_u32_e32 v4, v6, v4
; GFX-940-NEXT:    s_or_b64 vcc, s[0:1], vcc
; GFX-940-NEXT:    v_cndmask_b32_e32 v4, v4, v6, vcc
; GFX-940-NEXT:    s_brev_b32 s4, 1
; GFX-940-NEXT:    v_and_or_b32 v5, v1, s4, v4
; GFX-940-NEXT:    v_bfe_u32 v4, v4, 16, 1
; GFX-940-NEXT:    s_movk_i32 s5, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v4, v4, v5, s5
; GFX-940-NEXT:    v_or_b32_e32 v5, 0x400000, v5
; GFX-940-NEXT:    v_cmp_u_f64_e32 vcc, v[0:1], v[0:1]
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v4, v4, v5, vcc
; GFX-940-NEXT:    v_cvt_f32_f64_e64 v5, |v[2:3]|
; GFX-940-NEXT:    v_cvt_f64_f32_e32 v[0:1], v5
; GFX-940-NEXT:    v_and_b32_e32 v6, 1, v5
; GFX-940-NEXT:    v_cmp_gt_f64_e64 s[2:3], |v[2:3]|, v[0:1]
; GFX-940-NEXT:    v_cmp_nlg_f64_e64 s[0:1], |v[2:3]|, v[0:1]
; GFX-940-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v6
; GFX-940-NEXT:    v_cndmask_b32_e64 v0, -1, 1, s[2:3]
; GFX-940-NEXT:    v_add_u32_e32 v0, v5, v0
; GFX-940-NEXT:    s_or_b64 vcc, s[0:1], vcc
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v0, v5, vcc
; GFX-940-NEXT:    v_and_or_b32 v1, v3, s4, v0
; GFX-940-NEXT:    v_bfe_u32 v0, v0, 16, 1
; GFX-940-NEXT:    v_add3_u32 v0, v0, v1, s5
; GFX-940-NEXT:    v_or_b32_e32 v1, 0x400000, v1
; GFX-940-NEXT:    v_cmp_u_f64_e32 vcc, v[2:3], v[2:3]
; GFX-940-NEXT:    s_mov_b32 s0, 0x7060302
; GFX-940-NEXT:    s_nop 0
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GFX-940-NEXT:    v_perm_b32 v0, v0, v4, s0
; GFX-940-NEXT:    ; return to shader part epilog
;
; GFX-950-LABEL: v_test_cvt_v2f64_v2bf16_v:
; GFX-950:       ; %bb.0:
; GFX-950-NEXT:    v_cvt_f32_f64_e32 v2, v[2:3]
; GFX-950-NEXT:    v_cvt_f32_f64_e32 v0, v[0:1]
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, v0, v2
; GFX-950-NEXT:    ; return to shader part epilog
  %res = fptrunc <2 x double> %src to <2 x bfloat>
  %cast = bitcast <2 x bfloat> %res to float
  ret float %cast
}

define amdgpu_ps float @fptrunc_f32_f32_to_v2bf16(float %a, float %b) {
; GFX-940-LABEL: fptrunc_f32_f32_to_v2bf16:
; GFX-940:       ; %bb.0: ; %entry
; GFX-940-NEXT:    v_bfe_u32 v2, v0, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v2, v2, v0, s0
; GFX-940-NEXT:    v_or_b32_e32 v3, 0x400000, v0
; GFX-940-NEXT:    v_cmp_u_f32_e32 vcc, v0, v0
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v2, v3, vcc
; GFX-940-NEXT:    v_bfe_u32 v2, v1, 16, 1
; GFX-940-NEXT:    v_add3_u32 v2, v2, v1, s0
; GFX-940-NEXT:    v_or_b32_e32 v3, 0x400000, v1
; GFX-940-NEXT:    v_cmp_u_f32_e32 vcc, v1, v1
; GFX-940-NEXT:    s_mov_b32 s0, 0x7060302
; GFX-940-NEXT:    s_nop 0
; GFX-940-NEXT:    v_cndmask_b32_e32 v1, v2, v3, vcc
; GFX-940-NEXT:    v_perm_b32 v0, v1, v0, s0
; GFX-940-NEXT:    ; return to shader part epilog
;
; GFX-950-LABEL: fptrunc_f32_f32_to_v2bf16:
; GFX-950:       ; %bb.0: ; %entry
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, v0, v1
; GFX-950-NEXT:    ; return to shader part epilog
entry:
  %a.cvt = fptrunc float %a to bfloat
  %b.cvt = fptrunc float %b to bfloat
  %v2.1 = insertelement <2 x bfloat> undef, bfloat %a.cvt, i32 0
  %v2.2 = insertelement <2 x bfloat> %v2.1, bfloat %b.cvt, i32 1
  %ret = bitcast <2 x bfloat> %v2.2 to float
  ret float %ret
}

define amdgpu_ps float @fptrunc_f32_f32_to_v2bf16_mods(float %a, float %b) {
; GFX-940-LABEL: fptrunc_f32_f32_to_v2bf16_mods:
; GFX-940:       ; %bb.0: ; %entry
; GFX-940-NEXT:    v_xor_b32_e32 v2, 0x80000000, v0
; GFX-940-NEXT:    v_bfe_u32 v3, v2, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v3, v3, v2, s0
; GFX-940-NEXT:    v_or_b32_e32 v2, 0x400000, v2
; GFX-940-NEXT:    v_cmp_u_f32_e64 vcc, -v0, -v0
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v3, v2, vcc
; GFX-940-NEXT:    v_and_b32_e32 v2, 0x7fffffff, v1
; GFX-940-NEXT:    v_bfe_u32 v3, v2, 16, 1
; GFX-940-NEXT:    v_add3_u32 v3, v3, v2, s0
; GFX-940-NEXT:    v_or_b32_e32 v2, 0x400000, v2
; GFX-940-NEXT:    v_cmp_u_f32_e64 vcc, |v1|, |v1|
; GFX-940-NEXT:    s_mov_b32 s0, 0x7060302
; GFX-940-NEXT:    s_nop 0
; GFX-940-NEXT:    v_cndmask_b32_e32 v1, v3, v2, vcc
; GFX-940-NEXT:    v_perm_b32 v0, v1, v0, s0
; GFX-940-NEXT:    ; return to shader part epilog
;
; GFX-950-LABEL: fptrunc_f32_f32_to_v2bf16_mods:
; GFX-950:       ; %bb.0: ; %entry
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, -v0, |v1|
; GFX-950-NEXT:    ; return to shader part epilog
entry:
  %a.neg = fneg float %a
  %a.cvt = fptrunc float %a.neg to bfloat
  %b.abs = call float @llvm.fabs.f32(float %b)
  %b.cvt = fptrunc float %b.abs to bfloat
  %v2.1 = insertelement <2 x bfloat> undef, bfloat %a.cvt, i32 0
  %v2.2 = insertelement <2 x bfloat> %v2.1, bfloat %b.cvt, i32 1
  %ret = bitcast <2 x bfloat> %v2.2 to float
  ret float %ret
}

define amdgpu_ps void @fptrunc_f32_to_bf16(float %a, ptr %out) {
; GFX-940-LABEL: fptrunc_f32_to_bf16:
; GFX-940:       ; %bb.0: ; %entry
; GFX-940-NEXT:    v_mov_b32_e32 v3, v2
; GFX-940-NEXT:    v_mov_b32_e32 v2, v1
; GFX-940-NEXT:    v_bfe_u32 v1, v0, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v1, v1, v0, s0
; GFX-940-NEXT:    v_or_b32_e32 v4, 0x400000, v0
; GFX-940-NEXT:    v_cmp_u_f32_e32 vcc, v0, v0
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v1, v4, vcc
; GFX-940-NEXT:    flat_store_short_d16_hi v[2:3], v0 sc0 sc1
; GFX-940-NEXT:    s_endpgm
;
; GFX-950-LABEL: fptrunc_f32_to_bf16:
; GFX-950:       ; %bb.0: ; %entry
; GFX-950-NEXT:    v_mov_b32_e32 v3, v2
; GFX-950-NEXT:    v_mov_b32_e32 v2, v1
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, v0, s0
; GFX-950-NEXT:    flat_store_short v[2:3], v0
; GFX-950-NEXT:    s_endpgm
entry:
  %a.cvt = fptrunc float %a to bfloat
  store bfloat %a.cvt, ptr %out
  ret void
}

define amdgpu_ps void @fptrunc_f32_to_bf16_abs(float %a, ptr %out) {
; GFX-940-LABEL: fptrunc_f32_to_bf16_abs:
; GFX-940:       ; %bb.0: ; %entry
; GFX-940-NEXT:    v_mov_b32_e32 v3, v2
; GFX-940-NEXT:    v_mov_b32_e32 v2, v1
; GFX-940-NEXT:    v_and_b32_e32 v1, 0x7fffffff, v0
; GFX-940-NEXT:    v_bfe_u32 v4, v1, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v4, v4, v1, s0
; GFX-940-NEXT:    v_or_b32_e32 v1, 0x400000, v1
; GFX-940-NEXT:    v_cmp_u_f32_e64 vcc, |v0|, |v0|
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v4, v1, vcc
; GFX-940-NEXT:    flat_store_short_d16_hi v[2:3], v0 sc0 sc1
; GFX-940-NEXT:    s_endpgm
;
; GFX-950-LABEL: fptrunc_f32_to_bf16_abs:
; GFX-950:       ; %bb.0: ; %entry
; GFX-950-NEXT:    v_mov_b32_e32 v3, v2
; GFX-950-NEXT:    v_mov_b32_e32 v2, v1
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, |v0|, s0
; GFX-950-NEXT:    flat_store_short v[2:3], v0
; GFX-950-NEXT:    s_endpgm
entry:
  %a.abs = call float @llvm.fabs.f32(float %a)
  %a.cvt = fptrunc float %a.abs to bfloat
  store bfloat %a.cvt, ptr %out
  ret void
}

define amdgpu_ps void @fptrunc_f32_to_bf16_neg(float %a, ptr %out) {
; GFX-940-LABEL: fptrunc_f32_to_bf16_neg:
; GFX-940:       ; %bb.0: ; %entry
; GFX-940-NEXT:    v_mov_b32_e32 v3, v2
; GFX-940-NEXT:    v_mov_b32_e32 v2, v1
; GFX-940-NEXT:    v_xor_b32_e32 v1, 0x80000000, v0
; GFX-940-NEXT:    v_bfe_u32 v4, v1, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v4, v4, v1, s0
; GFX-940-NEXT:    v_or_b32_e32 v1, 0x400000, v1
; GFX-940-NEXT:    v_cmp_u_f32_e64 vcc, -v0, -v0
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v4, v1, vcc
; GFX-940-NEXT:    flat_store_short_d16_hi v[2:3], v0 sc0 sc1
; GFX-940-NEXT:    s_endpgm
;
; GFX-950-LABEL: fptrunc_f32_to_bf16_neg:
; GFX-950:       ; %bb.0: ; %entry
; GFX-950-NEXT:    v_mov_b32_e32 v3, v2
; GFX-950-NEXT:    v_mov_b32_e32 v2, v1
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, -v0, s0
; GFX-950-NEXT:    flat_store_short v[2:3], v0
; GFX-950-NEXT:    s_endpgm
entry:
  %a.neg = fneg float %a
  %a.cvt = fptrunc float %a.neg to bfloat
  store bfloat %a.cvt, ptr %out
  ret void
}

define amdgpu_ps void @fptrunc_f64_to_bf16(double %a, ptr %out) {
; GFX-940-LABEL: fptrunc_f64_to_bf16:
; GFX-940:       ; %bb.0: ; %entry
; GFX-940-NEXT:    v_cvt_f32_f64_e64 v6, |v[0:1]|
; GFX-940-NEXT:    v_cvt_f64_f32_e32 v[4:5], v6
; GFX-940-NEXT:    v_and_b32_e32 v7, 1, v6
; GFX-940-NEXT:    v_cmp_gt_f64_e64 s[2:3], |v[0:1]|, v[4:5]
; GFX-940-NEXT:    v_cmp_nlg_f64_e64 s[0:1], |v[0:1]|, v[4:5]
; GFX-940-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v7
; GFX-940-NEXT:    v_cndmask_b32_e64 v4, -1, 1, s[2:3]
; GFX-940-NEXT:    v_add_u32_e32 v4, v6, v4
; GFX-940-NEXT:    s_or_b64 vcc, s[0:1], vcc
; GFX-940-NEXT:    v_cndmask_b32_e32 v4, v4, v6, vcc
; GFX-940-NEXT:    s_brev_b32 s0, 1
; GFX-940-NEXT:    v_and_or_b32 v5, v1, s0, v4
; GFX-940-NEXT:    v_bfe_u32 v4, v4, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v4, v4, v5, s0
; GFX-940-NEXT:    v_or_b32_e32 v5, 0x400000, v5
; GFX-940-NEXT:    v_cmp_u_f64_e32 vcc, v[0:1], v[0:1]
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v4, v5, vcc
; GFX-940-NEXT:    flat_store_short_d16_hi v[2:3], v0 sc0 sc1
; GFX-940-NEXT:    s_endpgm
;
; GFX-950-LABEL: fptrunc_f64_to_bf16:
; GFX-950:       ; %bb.0: ; %entry
; GFX-950-NEXT:    v_cvt_f32_f64_e32 v0, v[0:1]
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, v0, s0
; GFX-950-NEXT:    flat_store_short v[2:3], v0
; GFX-950-NEXT:    s_endpgm
entry:
  %a.cvt = fptrunc double %a to bfloat
  store bfloat %a.cvt, ptr %out
  ret void
}

define amdgpu_ps void @fptrunc_f64_to_bf16_neg(double %a, ptr %out) {
; GFX-940-LABEL: fptrunc_f64_to_bf16_neg:
; GFX-940:       ; %bb.0: ; %entry
; GFX-940-NEXT:    v_cvt_f32_f64_e64 v7, |v[0:1]|
; GFX-940-NEXT:    v_cvt_f64_f32_e32 v[4:5], v7
; GFX-940-NEXT:    v_and_b32_e32 v8, 1, v7
; GFX-940-NEXT:    v_cmp_gt_f64_e64 s[2:3], |v[0:1]|, v[4:5]
; GFX-940-NEXT:    v_cmp_nlg_f64_e64 s[0:1], |v[0:1]|, v[4:5]
; GFX-940-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v8
; GFX-940-NEXT:    v_cndmask_b32_e64 v4, -1, 1, s[2:3]
; GFX-940-NEXT:    v_add_u32_e32 v4, v7, v4
; GFX-940-NEXT:    s_or_b64 vcc, s[0:1], vcc
; GFX-940-NEXT:    s_brev_b32 s4, 1
; GFX-940-NEXT:    v_xor_b32_e32 v6, 0x80000000, v1
; GFX-940-NEXT:    v_cndmask_b32_e32 v4, v4, v7, vcc
; GFX-940-NEXT:    v_and_or_b32 v5, v6, s4, v4
; GFX-940-NEXT:    v_bfe_u32 v4, v4, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v4, v4, v5, s0
; GFX-940-NEXT:    v_or_b32_e32 v5, 0x400000, v5
; GFX-940-NEXT:    v_cmp_u_f64_e64 vcc, -v[0:1], -v[0:1]
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v4, v5, vcc
; GFX-940-NEXT:    flat_store_short_d16_hi v[2:3], v0 sc0 sc1
; GFX-940-NEXT:    s_endpgm
;
; GFX-950-LABEL: fptrunc_f64_to_bf16_neg:
; GFX-950:       ; %bb.0: ; %entry
; GFX-950-NEXT:    v_cvt_f32_f64_e64 v0, -v[0:1]
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, v0, s0
; GFX-950-NEXT:    flat_store_short v[2:3], v0
; GFX-950-NEXT:    s_endpgm
entry:
  %a.neg = fneg double %a
  %a.cvt = fptrunc double %a.neg to bfloat
  store bfloat %a.cvt, ptr %out
  ret void
}

define amdgpu_ps void @fptrunc_f64_to_bf16_abs(double %a, ptr %out) {
; GFX-940-LABEL: fptrunc_f64_to_bf16_abs:
; GFX-940:       ; %bb.0: ; %entry
; GFX-940-NEXT:    v_cvt_f32_f64_e64 v7, |v[0:1]|
; GFX-940-NEXT:    v_cvt_f64_f32_e32 v[4:5], v7
; GFX-940-NEXT:    v_and_b32_e32 v8, 1, v7
; GFX-940-NEXT:    v_cmp_gt_f64_e64 s[2:3], |v[0:1]|, v[4:5]
; GFX-940-NEXT:    v_cmp_nlg_f64_e64 s[0:1], |v[0:1]|, v[4:5]
; GFX-940-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v8
; GFX-940-NEXT:    v_cndmask_b32_e64 v4, -1, 1, s[2:3]
; GFX-940-NEXT:    v_add_u32_e32 v4, v7, v4
; GFX-940-NEXT:    s_or_b64 vcc, s[0:1], vcc
; GFX-940-NEXT:    v_and_b32_e32 v6, 0x7fffffff, v1
; GFX-940-NEXT:    v_cndmask_b32_e32 v4, v4, v7, vcc
; GFX-940-NEXT:    s_brev_b32 s0, 1
; GFX-940-NEXT:    v_and_or_b32 v5, v6, s0, v4
; GFX-940-NEXT:    v_bfe_u32 v4, v4, 16, 1
; GFX-940-NEXT:    s_movk_i32 s0, 0x7fff
; GFX-940-NEXT:    v_add3_u32 v4, v4, v5, s0
; GFX-940-NEXT:    v_or_b32_e32 v5, 0x400000, v5
; GFX-940-NEXT:    v_cmp_u_f64_e64 vcc, |v[0:1]|, |v[0:1]|
; GFX-940-NEXT:    s_nop 1
; GFX-940-NEXT:    v_cndmask_b32_e32 v0, v4, v5, vcc
; GFX-940-NEXT:    flat_store_short_d16_hi v[2:3], v0 sc0 sc1
; GFX-940-NEXT:    s_endpgm
;
; GFX-950-LABEL: fptrunc_f64_to_bf16_abs:
; GFX-950:       ; %bb.0: ; %entry
; GFX-950-NEXT:    v_cvt_f32_f64_e64 v0, |v[0:1]|
; GFX-950-NEXT:    v_cvt_pk_bf16_f32 v0, v0, s0
; GFX-950-NEXT:    flat_store_short v[2:3], v0
; GFX-950-NEXT:    s_endpgm
entry:
  %a.abs = call double @llvm.fabs.f64(double %a)
  %a.cvt = fptrunc double %a.abs to bfloat
  store bfloat %a.cvt, ptr %out
  ret void
}

declare float @llvm.fabs.f32(float)
declare double @llvm.fabs.f64(double)