; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx950 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX950-SDAG %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx950 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX950-GISEL %s

declare <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.bf16(<32 x bfloat> %src, i32 %sr, float %scale)
declare <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.f16(<32 x half> %src, i32 %sr, float %scale)
declare <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.f32(<32 x float> %src, i32 %sr, float %scale)
declare <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.bf16(<32 x bfloat> %src, i32 %sr, float %scale)
declare <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.f16(<32 x half> %src, i32 %sr, float %scale)
declare <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.f32(<32 x float> %src, i32 %sr, float %scale)

define amdgpu_ps void @test_scalef32_sr_pk32_bf6_bf16_vv(<32 x bfloat> %src, i32 %sr, float %scale, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_bf6_bf16_vv:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_bf6_bf16 v[20:25], v[0:15], v16, v17
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[18:19], v[24:25], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[18:19], v[20:23], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_bf6_bf16_vv:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v20, 16, v0
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v21, 16, v1
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v22, 16, v2
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v23, 16, v3
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v24, 16, v4
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v25, 16, v5
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v26, 16, v6
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v27, 16, v7
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v28, 16, v8
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v29, 16, v9
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v30, 16, v10
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v31, 16, v11
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v32, 16, v12
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v33, 16, v13
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v34, 16, v14
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v35, 16, v15
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v0, v20 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v1, v21 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v2, v22 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v3, v23 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v4, v24 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v5, v25 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v6, v26 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v7, v27 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v8, v28 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v9, v29 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v10, v30 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v11, v31 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v12, v32 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v13, v33 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v14, v34 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v15, v35 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    s_nop 0
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_bf6_bf16 v[20:25], v[0:15], v16, v17
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[18:19], v[20:23], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[18:19], v[24:25], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.bf16(<32 x bfloat> %src, i32 %sr, float %scale)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_bf6_bf16_sl(<32 x bfloat> inreg %src, i32 inreg %sr, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_bf6_bf16_sl:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v4, s2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v5, s3
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v6, s4
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v7, s5
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v8, s6
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v9, s7
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v10, s8
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v11, s9
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v12, s10
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v13, s11
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v14, s12
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v15, s13
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v16, s14
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v17, s15
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v24, 0x42c80000
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_bf6_bf16 v[18:23], v[2:17], s16, v24
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[0:1], v[22:23], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[0:1], v[18:21], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_bf6_bf16_sl:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    s_lshr_b32 s17, s0, 16
; GFX950-GISEL-NEXT:    s_lshr_b32 s18, s1, 16
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s17, 16
; GFX950-GISEL-NEXT:    s_and_b32 s0, s0, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s19, s2, 16
; GFX950-GISEL-NEXT:    s_or_b32 s0, s17, s0
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s18, 16
; GFX950-GISEL-NEXT:    s_and_b32 s1, s1, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s20, s3, 16
; GFX950-GISEL-NEXT:    s_or_b32 s1, s17, s1
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s19, 16
; GFX950-GISEL-NEXT:    s_and_b32 s2, s2, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s21, s4, 16
; GFX950-GISEL-NEXT:    s_or_b32 s2, s17, s2
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s20, 16
; GFX950-GISEL-NEXT:    s_and_b32 s3, s3, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s22, s5, 16
; GFX950-GISEL-NEXT:    s_or_b32 s3, s17, s3
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s21, 16
; GFX950-GISEL-NEXT:    s_and_b32 s4, s4, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s23, s6, 16
; GFX950-GISEL-NEXT:    s_or_b32 s4, s17, s4
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s22, 16
; GFX950-GISEL-NEXT:    s_and_b32 s5, s5, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s24, s7, 16
; GFX950-GISEL-NEXT:    s_or_b32 s5, s17, s5
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s23, 16
; GFX950-GISEL-NEXT:    s_and_b32 s6, s6, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s25, s8, 16
; GFX950-GISEL-NEXT:    s_or_b32 s6, s17, s6
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s24, 16
; GFX950-GISEL-NEXT:    s_and_b32 s7, s7, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s26, s9, 16
; GFX950-GISEL-NEXT:    s_or_b32 s7, s17, s7
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s25, 16
; GFX950-GISEL-NEXT:    s_and_b32 s8, s8, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s27, s10, 16
; GFX950-GISEL-NEXT:    s_or_b32 s8, s17, s8
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s26, 16
; GFX950-GISEL-NEXT:    s_and_b32 s9, s9, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s28, s11, 16
; GFX950-GISEL-NEXT:    s_or_b32 s9, s17, s9
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s27, 16
; GFX950-GISEL-NEXT:    s_and_b32 s10, s10, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s29, s12, 16
; GFX950-GISEL-NEXT:    s_or_b32 s10, s17, s10
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s28, 16
; GFX950-GISEL-NEXT:    s_and_b32 s11, s11, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s30, s13, 16
; GFX950-GISEL-NEXT:    s_or_b32 s11, s17, s11
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s29, 16
; GFX950-GISEL-NEXT:    s_and_b32 s12, s12, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s31, s14, 16
; GFX950-GISEL-NEXT:    s_or_b32 s12, s17, s12
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s30, 16
; GFX950-GISEL-NEXT:    s_and_b32 s13, s13, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s33, s15, 16
; GFX950-GISEL-NEXT:    s_or_b32 s13, s17, s13
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s31, 16
; GFX950-GISEL-NEXT:    s_and_b32 s14, s14, 0xffff
; GFX950-GISEL-NEXT:    s_or_b32 s14, s17, s14
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s33, 16
; GFX950-GISEL-NEXT:    s_and_b32 s15, s15, 0xffff
; GFX950-GISEL-NEXT:    s_or_b32 s15, s17, s15
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[16:17], s[14:15]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[14:15], s[12:13]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[12:13], s[10:11]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[10:11], s[8:9]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[8:9], s[6:7]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[6:7], s[4:5]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[4:5], s[2:3]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[2:3], s[0:1]
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v24, 0x42c80000
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_bf6_bf16 v[18:23], v[2:17], s16, v24
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[0:1], v[18:21], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[0:1], v[22:23], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.bf16(<32 x bfloat> %src, i32 %sr, float 100.0)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_bf6_f16_vv(<32 x half> %src, i32 %sr, float %scale, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_bf6_f16_vv:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_bf6_f16 v[20:25], v[0:15], v16, v17
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[18:19], v[24:25], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[18:19], v[20:23], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_bf6_f16_vv:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_bf6_f16 v[20:25], v[0:15], v16, v17
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[18:19], v[20:23], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[18:19], v[24:25], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.f16(<32 x half> %src, i32 %sr, float %scale)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_bf6_f16_sl(<32 x half> inreg %src, i32 inreg %sr, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_bf6_f16_sl:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v4, s2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v5, s3
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v6, s4
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v7, s5
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v8, s6
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v9, s7
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v10, s8
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v11, s9
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v12, s10
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v13, s11
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v14, s12
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v15, s13
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v16, s14
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v17, s15
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v24, 0x42c80000
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_bf6_f16 v[18:23], v[2:17], s16, v24
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[0:1], v[22:23], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[0:1], v[18:21], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_bf6_f16_sl:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[16:17], s[14:15]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[14:15], s[12:13]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[12:13], s[10:11]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[10:11], s[8:9]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[8:9], s[6:7]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[6:7], s[4:5]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[4:5], s[2:3]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[2:3], s[0:1]
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v24, 0x42c80000
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_bf6_f16 v[18:23], v[2:17], s16, v24
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[0:1], v[18:21], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[0:1], v[22:23], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.f16(<32 x half> %src, i32 %sr, float 100.0)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_fp6_bf16_vv(<32 x bfloat> %src, i32 %sr, float %scale, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_fp6_bf16_vv:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_fp6_bf16 v[20:25], v[0:15], v16, v17
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[18:19], v[24:25], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[18:19], v[20:23], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_fp6_bf16_vv:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v20, 16, v0
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v21, 16, v1
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v22, 16, v2
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v23, 16, v3
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v24, 16, v4
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v25, 16, v5
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v26, 16, v6
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v27, 16, v7
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v28, 16, v8
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v29, 16, v9
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v30, 16, v10
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v31, 16, v11
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v32, 16, v12
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v33, 16, v13
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v34, 16, v14
; GFX950-GISEL-NEXT:    v_lshrrev_b32_e32 v35, 16, v15
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v0, v20 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v1, v21 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v2, v22 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v3, v23 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v4, v24 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v5, v25 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v6, v26 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v7, v27 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v8, v28 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v9, v29 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v10, v30 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v11, v31 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v12, v32 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v13, v33 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v14, v34 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    v_mov_b32_sdwa v15, v35 dst_sel:WORD_1 dst_unused:UNUSED_PRESERVE src0_sel:WORD_0
; GFX950-GISEL-NEXT:    s_nop 0
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_fp6_bf16 v[20:25], v[0:15], v16, v17
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[18:19], v[20:23], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[18:19], v[24:25], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.bf16(<32 x bfloat> %src, i32 %sr, float %scale)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_fp6_bf16_sl(<32 x bfloat> inreg %src, i32 inreg %sr, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_fp6_bf16_sl:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v4, s2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v5, s3
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v6, s4
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v7, s5
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v8, s6
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v9, s7
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v10, s8
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v11, s9
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v12, s10
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v13, s11
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v14, s12
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v15, s13
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v16, s14
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v17, s15
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v24, 0x42c80000
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_fp6_bf16 v[18:23], v[2:17], s16, v24
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[0:1], v[22:23], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[0:1], v[18:21], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_fp6_bf16_sl:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    s_lshr_b32 s17, s0, 16
; GFX950-GISEL-NEXT:    s_lshr_b32 s18, s1, 16
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s17, 16
; GFX950-GISEL-NEXT:    s_and_b32 s0, s0, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s19, s2, 16
; GFX950-GISEL-NEXT:    s_or_b32 s0, s17, s0
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s18, 16
; GFX950-GISEL-NEXT:    s_and_b32 s1, s1, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s20, s3, 16
; GFX950-GISEL-NEXT:    s_or_b32 s1, s17, s1
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s19, 16
; GFX950-GISEL-NEXT:    s_and_b32 s2, s2, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s21, s4, 16
; GFX950-GISEL-NEXT:    s_or_b32 s2, s17, s2
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s20, 16
; GFX950-GISEL-NEXT:    s_and_b32 s3, s3, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s22, s5, 16
; GFX950-GISEL-NEXT:    s_or_b32 s3, s17, s3
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s21, 16
; GFX950-GISEL-NEXT:    s_and_b32 s4, s4, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s23, s6, 16
; GFX950-GISEL-NEXT:    s_or_b32 s4, s17, s4
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s22, 16
; GFX950-GISEL-NEXT:    s_and_b32 s5, s5, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s24, s7, 16
; GFX950-GISEL-NEXT:    s_or_b32 s5, s17, s5
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s23, 16
; GFX950-GISEL-NEXT:    s_and_b32 s6, s6, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s25, s8, 16
; GFX950-GISEL-NEXT:    s_or_b32 s6, s17, s6
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s24, 16
; GFX950-GISEL-NEXT:    s_and_b32 s7, s7, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s26, s9, 16
; GFX950-GISEL-NEXT:    s_or_b32 s7, s17, s7
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s25, 16
; GFX950-GISEL-NEXT:    s_and_b32 s8, s8, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s27, s10, 16
; GFX950-GISEL-NEXT:    s_or_b32 s8, s17, s8
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s26, 16
; GFX950-GISEL-NEXT:    s_and_b32 s9, s9, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s28, s11, 16
; GFX950-GISEL-NEXT:    s_or_b32 s9, s17, s9
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s27, 16
; GFX950-GISEL-NEXT:    s_and_b32 s10, s10, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s29, s12, 16
; GFX950-GISEL-NEXT:    s_or_b32 s10, s17, s10
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s28, 16
; GFX950-GISEL-NEXT:    s_and_b32 s11, s11, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s30, s13, 16
; GFX950-GISEL-NEXT:    s_or_b32 s11, s17, s11
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s29, 16
; GFX950-GISEL-NEXT:    s_and_b32 s12, s12, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s31, s14, 16
; GFX950-GISEL-NEXT:    s_or_b32 s12, s17, s12
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s30, 16
; GFX950-GISEL-NEXT:    s_and_b32 s13, s13, 0xffff
; GFX950-GISEL-NEXT:    s_lshr_b32 s33, s15, 16
; GFX950-GISEL-NEXT:    s_or_b32 s13, s17, s13
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s31, 16
; GFX950-GISEL-NEXT:    s_and_b32 s14, s14, 0xffff
; GFX950-GISEL-NEXT:    s_or_b32 s14, s17, s14
; GFX950-GISEL-NEXT:    s_lshl_b32 s17, s33, 16
; GFX950-GISEL-NEXT:    s_and_b32 s15, s15, 0xffff
; GFX950-GISEL-NEXT:    s_or_b32 s15, s17, s15
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[16:17], s[14:15]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[14:15], s[12:13]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[12:13], s[10:11]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[10:11], s[8:9]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[8:9], s[6:7]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[6:7], s[4:5]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[4:5], s[2:3]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[2:3], s[0:1]
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v24, 0x42c80000
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_fp6_bf16 v[18:23], v[2:17], s16, v24
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[0:1], v[18:21], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[0:1], v[22:23], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.bf16(<32 x bfloat> %src, i32 %sr, float 100.0)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_fp6_f16_vv(<32 x half> %src, i32 %sr, float %scale, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_fp6_f16_vv:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_fp6_f16 v[20:25], v[0:15], v16, v17
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[18:19], v[24:25], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[18:19], v[20:23], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_fp6_f16_vv:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_fp6_f16 v[20:25], v[0:15], v16, v17
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[18:19], v[20:23], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[18:19], v[24:25], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.f16(<32 x half> %src, i32 %sr, float %scale)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_fp6_f16_sl(<32 x half> inreg %src, i32 inreg %sr, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_fp6_f16_sl:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v4, s2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v5, s3
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v6, s4
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v7, s5
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v8, s6
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v9, s7
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v10, s8
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v11, s9
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v12, s10
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v13, s11
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v14, s12
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v15, s13
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v16, s14
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v17, s15
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v24, 0x42c80000
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_fp6_f16 v[18:23], v[2:17], s16, v24
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[0:1], v[22:23], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[0:1], v[18:21], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_fp6_f16_sl:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[16:17], s[14:15]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[14:15], s[12:13]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[12:13], s[10:11]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[10:11], s[8:9]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[8:9], s[6:7]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[6:7], s[4:5]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[4:5], s[2:3]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[2:3], s[0:1]
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v24, 0x42c80000
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_fp6_f16 v[18:23], v[2:17], s16, v24
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[0:1], v[18:21], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[0:1], v[22:23], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.f16(<32 x half> %src, i32 %sr, float 100.0)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_bf6_f32_vv(<32 x float> %src, i32 %sr, float %scale, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_bf6_f32_vv:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_bf6_f32 v[36:41], v[0:31], v32, v33
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[34:35], v[40:41], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[34:35], v[36:39], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_bf6_f32_vv:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_bf6_f32 v[36:41], v[0:31], v32, v33
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[34:35], v[36:39], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[34:35], v[40:41], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.f32(<32 x float> %src, i32 %sr, float %scale)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_bf6_f32_sl(<32 x float> inreg %src, i32 inreg %sr, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_bf6_f32_sl:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v4, s2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v5, s3
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v6, s4
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v7, s5
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v8, s6
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v9, s7
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v10, s8
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v11, s9
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v12, s10
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v13, s11
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v14, s12
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v15, s13
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v16, s14
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v17, s15
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v18, s16
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v19, s17
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v20, s18
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v21, s19
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v22, s20
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v23, s21
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v24, s22
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v25, s23
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v26, s24
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v27, s25
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v28, s26
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v29, s27
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v30, s28
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v31, s29
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v32, s30
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v33, s31
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v40, 0x42c80000
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_bf6_f32 v[34:39], v[2:33], s32, v40
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[0:1], v[38:39], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[0:1], v[34:37], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_bf6_f32_sl:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[32:33], s[30:31]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[30:31], s[28:29]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[28:29], s[26:27]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[26:27], s[24:25]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[24:25], s[22:23]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[22:23], s[20:21]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[20:21], s[18:19]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[18:19], s[16:17]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[16:17], s[14:15]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[14:15], s[12:13]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[12:13], s[10:11]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[10:11], s[8:9]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[8:9], s[6:7]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[6:7], s[4:5]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[4:5], s[2:3]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[2:3], s[0:1]
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v40, 0x42c80000
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_bf6_f32 v[34:39], v[2:33], s32, v40
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[0:1], v[34:37], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[0:1], v[38:39], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.bf6.f32(<32 x float> %src, i32 %sr, float 100.0)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_fp6_f32_vv(<32 x float> %src, i32 %sr, float %scale, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_fp6_f32_vv:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_fp6_f32 v[36:41], v[0:31], v32, v33
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[34:35], v[40:41], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[34:35], v[36:39], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_fp6_f32_vv:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_fp6_f32 v[36:41], v[0:31], v32, v33
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[34:35], v[36:39], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[34:35], v[40:41], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.f32(<32 x float> %src, i32 %sr, float %scale)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}

define amdgpu_ps void @test_scalef32_sr_pk32_fp6_f32_sl(<32 x float> inreg %src, i32 inreg %sr, ptr addrspace(1) %out) {
; GFX950-SDAG-LABEL: test_scalef32_sr_pk32_fp6_f32_sl:
; GFX950-SDAG:       ; %bb.0:
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, s0
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, s1
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v4, s2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v5, s3
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v6, s4
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v7, s5
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v8, s6
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v9, s7
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v10, s8
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v11, s9
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v12, s10
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v13, s11
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v14, s12
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v15, s13
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v16, s14
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v17, s15
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v18, s16
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v19, s17
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v20, s18
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v21, s19
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v22, s20
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v23, s21
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v24, s22
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v25, s23
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v26, s24
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v27, s25
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v28, s26
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v29, s27
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v30, s28
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v31, s29
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v32, s30
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v33, s31
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v40, 0x42c80000
; GFX950-SDAG-NEXT:    v_cvt_scalef32_sr_pk32_fp6_f32 v[34:39], v[2:33], s32, v40
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[0:1], v[38:39], off offset:16
; GFX950-SDAG-NEXT:    global_store_dwordx4 v[0:1], v[34:37], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: test_scalef32_sr_pk32_fp6_f32_sl:
; GFX950-GISEL:       ; %bb.0:
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[32:33], s[30:31]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[30:31], s[28:29]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[28:29], s[26:27]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[26:27], s[24:25]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[24:25], s[22:23]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[22:23], s[20:21]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[20:21], s[18:19]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[18:19], s[16:17]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[16:17], s[14:15]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[14:15], s[12:13]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[12:13], s[10:11]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[10:11], s[8:9]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[8:9], s[6:7]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[6:7], s[4:5]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[4:5], s[2:3]
; GFX950-GISEL-NEXT:    v_mov_b64_e32 v[2:3], s[0:1]
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v40, 0x42c80000
; GFX950-GISEL-NEXT:    v_cvt_scalef32_sr_pk32_fp6_f32 v[34:39], v[2:33], s32, v40
; GFX950-GISEL-NEXT:    global_store_dwordx4 v[0:1], v[34:37], off
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[0:1], v[38:39], off offset:16
; GFX950-GISEL-NEXT:    s_endpgm
  %cvt = tail call <6 x i32> @llvm.amdgcn.cvt.scalef32.sr.pk32.fp6.f32(<32 x float> %src, i32 %sr, float 100.0)
  store <6 x i32> %cvt, ptr addrspace(1) %out, align 8
  ret void
}