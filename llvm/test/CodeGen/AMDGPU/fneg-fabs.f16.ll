; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=kaveri -verify-machineinstrs < %s | FileCheck --check-prefixes=CIVI,CI %s
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=tonga -verify-machineinstrs < %s | FileCheck --check-prefixes=CIVI,VI %s
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX9 %s
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX11 %s

define amdgpu_kernel void @fneg_fabs_fadd_f16(ptr addrspace(1) %out, half %x, half %y) {
; CI-LABEL: fneg_fabs_fadd_f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s0, s[8:9], 0x2
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_cvt_f32_f16_e64 v0, |s0|
; CI-NEXT:    s_lshr_b32 s0, s0, 16
; CI-NEXT:    v_cvt_f32_f16_e32 v1, s0
; CI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; CI-NEXT:    v_sub_f32_e32 v0, v1, v0
; CI-NEXT:    v_cvt_f16_f32_e32 v2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    flat_store_short v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_fadd_f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[8:9], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s3, s2, 16
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_sub_f16_e64 v2, s3, |v0|
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    flat_store_short v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: fneg_fabs_fadd_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[8:9], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshr_b32 s3, s2, 16
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    v_sub_f16_e64 v1, s3, |v1|
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: fneg_fabs_fadd_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s2, s[4:5], 0x8
; GFX11-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_lshr_b32 s3, s2, 16
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_sub_f16_e64 v1, s3, |s2|
; GFX11-NEXT:    global_store_b16 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %fabs = call half @llvm.fabs.f16(half %x)
  %fsub = fsub half -0.0, %fabs
  %fadd = fadd half %y, %fsub
  store half %fadd, ptr addrspace(1) %out, align 2
  ret void
}

define amdgpu_kernel void @fneg_fabs_fmul_f16(ptr addrspace(1) %out, half %x, half %y) {
; CI-LABEL: fneg_fabs_fmul_f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s0, s[8:9], 0x2
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_and_b32 s1, s0, 0x7fff
; CI-NEXT:    s_lshr_b32 s0, s0, 16
; CI-NEXT:    v_cvt_f32_f16_e32 v0, s0
; CI-NEXT:    v_cvt_f32_f16_e64 v1, -|s1|
; CI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; CI-NEXT:    v_mul_f32_e32 v0, v0, v1
; CI-NEXT:    v_cvt_f16_f32_e32 v2, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    flat_store_short v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_fmul_f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[8:9], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s3, s2, 16
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mul_f16_e64 v2, s3, -|v0|
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    flat_store_short v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: fneg_fabs_fmul_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[8:9], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshr_b32 s3, s2, 16
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    v_mul_f16_e64 v1, s3, -|v1|
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: fneg_fabs_fmul_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s2, s[4:5], 0x8
; GFX11-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_lshr_b32 s3, s2, 16
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_mul_f16_e64 v1, s3, -|s2|
; GFX11-NEXT:    global_store_b16 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %fabs = call half @llvm.fabs.f16(half %x)
  %fsub = fsub half -0.0, %fabs
  %fmul = fmul half %y, %fsub
  store half %fmul, ptr addrspace(1) %out, align 2
  ret void
}

; DAGCombiner will transform:
; (fabs (f16 bitcast (i16 a))) => (f16 bitcast (and (i16 a), 0x7FFFFFFF))
; unless isFabsFree returns true
define amdgpu_kernel void @fneg_fabs_free_f16(ptr addrspace(1) %out, i16 %in) {
; CI-LABEL: fneg_fabs_free_f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s2, s[8:9], 0x2
; CI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_bitset1_b32 s2, 15
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    flat_store_short v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_free_f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[8:9], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_bitset1_b32 s2, 15
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    flat_store_short v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: fneg_fabs_free_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[8:9], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_bitset1_b32 s2, 15
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: fneg_fabs_free_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s2, s[4:5], 0x8
; GFX11-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_bitset1_b32 s2, 15
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s2
; GFX11-NEXT:    global_store_b16 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %bc = bitcast i16 %in to half
  %fabs = call half @llvm.fabs.f16(half %bc)
  %fsub = fsub half -0.0, %fabs
  store half %fsub, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @fneg_fabs_f16(ptr addrspace(1) %out, half %in) {
; CI-LABEL: fneg_fabs_f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s2, s[8:9], 0x2
; CI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_bitset1_b32 s2, 15
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    flat_store_short v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: fneg_fabs_f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[8:9], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_bitset1_b32 s2, 15
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    flat_store_short v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: fneg_fabs_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[8:9], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_bitset1_b32 s2, 15
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: fneg_fabs_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s2, s[4:5], 0x8
; GFX11-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_bitset1_b32 s2, 15
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s2
; GFX11-NEXT:    global_store_b16 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %fabs = call half @llvm.fabs.f16(half %in)
  %fsub = fsub half -0.0, %fabs
  store half %fsub, ptr addrspace(1) %out, align 2
  ret void
}

define amdgpu_kernel void @v_fneg_fabs_f16(ptr addrspace(1) %out, ptr addrspace(1) %in) {
; CIVI-LABEL: v_fneg_fabs_f16:
; CIVI:       ; %bb.0:
; CIVI-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; CIVI-NEXT:    s_waitcnt lgkmcnt(0)
; CIVI-NEXT:    v_mov_b32_e32 v0, s2
; CIVI-NEXT:    v_mov_b32_e32 v1, s3
; CIVI-NEXT:    flat_load_ushort v2, v[0:1]
; CIVI-NEXT:    v_mov_b32_e32 v0, s0
; CIVI-NEXT:    v_mov_b32_e32 v1, s1
; CIVI-NEXT:    s_waitcnt vmcnt(0)
; CIVI-NEXT:    v_or_b32_e32 v2, 0x8000, v2
; CIVI-NEXT:    flat_store_short v[0:1], v2
; CIVI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_fneg_fabs_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_ushort v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_or_b32_e32 v1, 0x8000, v1
; GFX9-NEXT:    global_store_short v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: v_fneg_fabs_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_load_u16 v1, v0, s[2:3]
; GFX11-NEXT:    s_waitcnt vmcnt(0)
; GFX11-NEXT:    v_or_b32_e32 v1, 0x8000, v1
; GFX11-NEXT:    global_store_b16 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %val = load half, ptr addrspace(1) %in, align 2
  %fabs = call half @llvm.fabs.f16(half %val)
  %fsub = fsub half -0.0, %fabs
  store half %fsub, ptr addrspace(1) %out, align 2
  ret void
}

define amdgpu_kernel void @s_fneg_fabs_v2f16_non_bc_src(ptr addrspace(1) %out, <2 x half> %in) {
; CI-LABEL: s_fneg_fabs_v2f16_non_bc_src:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s0, s[8:9], 0x2
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_lshr_b32 s1, s0, 16
; CI-NEXT:    v_cvt_f32_f16_e32 v1, s1
; CI-NEXT:    v_cvt_f32_f16_e32 v0, s0
; CI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; CI-NEXT:    v_add_f32_e32 v1, 2.0, v1
; CI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; CI-NEXT:    v_cvt_f16_f32_e32 v1, v1
; CI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; CI-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; CI-NEXT:    v_or_b32_e32 v0, v0, v1
; CI-NEXT:    v_or_b32_e32 v2, 0x80008000, v0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    flat_store_dword v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: s_fneg_fabs_v2f16_non_bc_src:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[8:9], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; VI-NEXT:    v_mov_b32_e32 v0, 0x4000
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s3, s2, 16
; VI-NEXT:    v_mov_b32_e32 v2, s3
; VI-NEXT:    v_add_f16_e64 v1, s2, 1.0
; VI-NEXT:    v_add_f16_sdwa v0, v2, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v0, v1, v0
; VI-NEXT:    v_or_b32_e32 v2, 0x80008000, v0
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_fneg_fabs_v2f16_non_bc_src:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[8:9], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v1, 0x40003c00
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_pk_add_f16 v1, s2, v1
; GFX9-NEXT:    v_or_b32_e32 v1, 0x80008000, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: s_fneg_fabs_v2f16_non_bc_src:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s2, s[4:5], 0x8
; GFX11-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; GFX11-NEXT:    v_mov_b32_e32 v1, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    v_pk_add_f16 v0, 0x40003c00, s2
; GFX11-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX11-NEXT:    v_or_b32_e32 v0, 0x80008000, v0
; GFX11-NEXT:    global_store_b32 v1, v0, s[0:1]
; GFX11-NEXT:    s_endpgm
  %add = fadd <2 x half> %in, <half 1.0, half 2.0>
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %add)
  %fneg.fabs = fsub <2 x half> <half -0.0, half -0.0>, %fabs
  store <2 x half> %fneg.fabs, ptr addrspace(1) %out
  ret void
}

; FIXME: single bit op
; Combine turns this into integer op when bitcast source (from load)
define amdgpu_kernel void @s_fneg_fabs_v2f16_bc_src(ptr addrspace(1) %out, <2 x half> %in) {
; CI-LABEL: s_fneg_fabs_v2f16_bc_src:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s2, s[8:9], 0x2
; CI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_or_b32 s2, s2, 0x80008000
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    flat_store_dword v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: s_fneg_fabs_v2f16_bc_src:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[8:9], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_or_b32 s2, s2, 0x80008000
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_fneg_fabs_v2f16_bc_src:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[8:9], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_or_b32 s2, s2, 0x80008000
; GFX9-NEXT:    v_mov_b32_e32 v1, s2
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: s_fneg_fabs_v2f16_bc_src:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s2, s[4:5], 0x8
; GFX11-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_or_b32 s2, s2, 0x80008000
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s2
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %in)
  %fneg.fabs = fsub <2 x half> <half -0.0, half -0.0>, %fabs
  store <2 x half> %fneg.fabs, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @fneg_fabs_v4f16(ptr addrspace(1) %out, <4 x half> %in) {
; CIVI-LABEL: fneg_fabs_v4f16:
; CIVI:       ; %bb.0:
; CIVI-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; CIVI-NEXT:    s_waitcnt lgkmcnt(0)
; CIVI-NEXT:    s_or_b32 s3, s3, 0x80008000
; CIVI-NEXT:    s_or_b32 s2, s2, 0x80008000
; CIVI-NEXT:    v_mov_b32_e32 v3, s1
; CIVI-NEXT:    v_mov_b32_e32 v0, s2
; CIVI-NEXT:    v_mov_b32_e32 v1, s3
; CIVI-NEXT:    v_mov_b32_e32 v2, s0
; CIVI-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; CIVI-NEXT:    s_endpgm
;
; GFX9-LABEL: fneg_fabs_v4f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v2, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_or_b32 s3, s3, 0x80008000
; GFX9-NEXT:    s_or_b32 s2, s2, 0x80008000
; GFX9-NEXT:    v_mov_b32_e32 v0, s2
; GFX9-NEXT:    v_mov_b32_e32 v1, s3
; GFX9-NEXT:    global_store_dwordx2 v2, v[0:1], s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: fneg_fabs_v4f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_or_b32 s2, s2, 0x80008000
; GFX11-NEXT:    s_or_b32 s3, s3, 0x80008000
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v2, 0 :: v_dual_mov_b32 v1, s3
; GFX11-NEXT:    v_mov_b32_e32 v0, s2
; GFX11-NEXT:    global_store_b64 v2, v[0:1], s[0:1]
; GFX11-NEXT:    s_endpgm
  %fabs = call <4 x half> @llvm.fabs.v4f16(<4 x half> %in)
  %fsub = fsub <4 x half> <half -0.0, half -0.0, half -0.0, half -0.0>, %fabs
  store <4 x half> %fsub, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @fold_user_fneg_fabs_v2f16(ptr addrspace(1) %out, <2 x half> %in) #0 {
; CI-LABEL: fold_user_fneg_fabs_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dword s0, s[8:9], 0x2
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    s_lshr_b32 s1, s0, 16
; CI-NEXT:    v_cvt_f32_f16_e64 v1, |s1|
; CI-NEXT:    v_cvt_f32_f16_e64 v0, |s0|
; CI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; CI-NEXT:    v_mul_f32_e32 v1, -4.0, v1
; CI-NEXT:    v_mul_f32_e32 v0, -4.0, v0
; CI-NEXT:    v_cvt_f16_f32_e32 v1, v1
; CI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; CI-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; CI-NEXT:    v_or_b32_e32 v2, v0, v1
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    flat_store_dword v[0:1], v2
; CI-NEXT:    s_endpgm
;
; VI-LABEL: fold_user_fneg_fabs_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dword s2, s[8:9], 0x8
; VI-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; VI-NEXT:    v_mov_b32_e32 v0, 0xc400
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s3, s2, 16
; VI-NEXT:    v_mov_b32_e32 v2, s3
; VI-NEXT:    v_mul_f16_e64 v1, |s2|, -4.0
; VI-NEXT:    v_mul_f16_sdwa v0, |v2|, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v2, v1, v0
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: fold_user_fneg_fabs_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s2, s[8:9], 0x8
; GFX9-NEXT:    s_load_dwordx2 s[0:1], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; GFX9-NEXT:    v_pk_mul_f16 v1, s2, -4.0 op_sel_hi:[1,0]
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: fold_user_fneg_fabs_v2f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s2, s[4:5], 0x8
; GFX11-NEXT:    s_load_b64 s[0:1], s[4:5], 0x0
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_and_b32 s2, s2, 0x7fff7fff
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_pk_mul_f16 v1, s2, -4.0 op_sel_hi:[1,0]
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    s_endpgm
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %in)
  %fneg.fabs = fsub <2 x half> <half -0.0, half -0.0>, %fabs
  %mul = fmul <2 x half> %fneg.fabs, <half 4.0, half 4.0>
  store <2 x half> %mul, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @s_fneg_multi_use_fabs_v2f16(ptr addrspace(1) %out0, ptr addrspace(1) %out1, <2 x half> %in) {
; CI-LABEL: s_fneg_multi_use_fabs_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; CI-NEXT:    s_load_dword s4, s[8:9], 0x4
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    s_and_b32 s0, s4, 0x7fff7fff
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    s_or_b32 s1, s0, 0x80008000
; CI-NEXT:    v_mov_b32_e32 v4, s0
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    v_mov_b32_e32 v3, s3
; CI-NEXT:    flat_store_dword v[0:1], v4
; CI-NEXT:    v_mov_b32_e32 v0, s1
; CI-NEXT:    flat_store_dword v[2:3], v0
; CI-NEXT:    s_endpgm
;
; VI-LABEL: s_fneg_multi_use_fabs_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; VI-NEXT:    s_load_dword s4, s[8:9], 0x10
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    s_and_b32 s0, s4, 0x7fff7fff
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    s_xor_b32 s1, s0, 0x80008000
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    v_mov_b32_e32 v3, s3
; VI-NEXT:    flat_store_dword v[0:1], v4
; VI-NEXT:    v_mov_b32_e32 v0, s1
; VI-NEXT:    flat_store_dword v[2:3], v0
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_fneg_multi_use_fabs_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s4, s[8:9], 0x10
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_and_b32 s4, s4, 0x7fff7fff
; GFX9-NEXT:    s_xor_b32 s5, s4, 0x80008000
; GFX9-NEXT:    v_mov_b32_e32 v1, s4
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    v_mov_b32_e32 v1, s5
; GFX9-NEXT:    global_store_dword v0, v1, s[2:3]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: s_fneg_multi_use_fabs_v2f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s6, s[4:5], 0x10
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_and_b32 s4, s6, 0x7fff7fff
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(SKIP_1) | instid1(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s4
; GFX11-NEXT:    s_xor_b32 s5, s4, 0x80008000
; GFX11-NEXT:    v_mov_b32_e32 v2, s5
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    global_store_b32 v0, v2, s[2:3]
; GFX11-NEXT:    s_endpgm
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %in)
  %fneg = fsub <2 x half> <half -0.0, half -0.0>, %fabs
  store <2 x half> %fabs, ptr addrspace(1) %out0
  store <2 x half> %fneg, ptr addrspace(1) %out1
  ret void
}

define amdgpu_kernel void @s_fneg_multi_use_fabs_foldable_neg_v2f16(ptr addrspace(1) %out0, ptr addrspace(1) %out1, <2 x half> %in) {
; CI-LABEL: s_fneg_multi_use_fabs_foldable_neg_v2f16:
; CI:       ; %bb.0:
; CI-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; CI-NEXT:    s_load_dword s4, s[8:9], 0x4
; CI-NEXT:    s_waitcnt lgkmcnt(0)
; CI-NEXT:    v_mov_b32_e32 v0, s0
; CI-NEXT:    s_bfe_u32 s0, s4, 0xf0010
; CI-NEXT:    v_cvt_f32_f16_e32 v5, s0
; CI-NEXT:    v_cvt_f32_f16_e64 v4, |s4|
; CI-NEXT:    s_and_b32 s0, s4, 0x7fff7fff
; CI-NEXT:    v_mov_b32_e32 v1, s1
; CI-NEXT:    v_mul_f32_e32 v5, -4.0, v5
; CI-NEXT:    v_mul_f32_e32 v4, -4.0, v4
; CI-NEXT:    v_cvt_f16_f32_e32 v5, v5
; CI-NEXT:    v_cvt_f16_f32_e32 v4, v4
; CI-NEXT:    v_mov_b32_e32 v6, s0
; CI-NEXT:    v_mov_b32_e32 v2, s2
; CI-NEXT:    v_lshlrev_b32_e32 v5, 16, v5
; CI-NEXT:    v_mov_b32_e32 v3, s3
; CI-NEXT:    v_or_b32_e32 v4, v4, v5
; CI-NEXT:    flat_store_dword v[0:1], v6
; CI-NEXT:    flat_store_dword v[2:3], v4
; CI-NEXT:    s_endpgm
;
; VI-LABEL: s_fneg_multi_use_fabs_foldable_neg_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; VI-NEXT:    s_load_dword s4, s[8:9], 0x10
; VI-NEXT:    v_mov_b32_e32 v5, 0xc400
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    s_lshr_b32 s1, s4, 16
; VI-NEXT:    v_mov_b32_e32 v4, s1
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    s_and_b32 s0, s4, 0x7fff7fff
; VI-NEXT:    v_mul_f16_sdwa v4, |v4|, v5 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; VI-NEXT:    v_mul_f16_e64 v5, |s4|, -4.0
; VI-NEXT:    v_or_b32_e32 v4, v5, v4
; VI-NEXT:    v_mov_b32_e32 v5, s0
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    v_mov_b32_e32 v3, s3
; VI-NEXT:    flat_store_dword v[0:1], v5
; VI-NEXT:    flat_store_dword v[2:3], v4
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_fneg_multi_use_fabs_foldable_neg_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s4, s[8:9], 0x10
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[8:9], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_and_b32 s4, s4, 0x7fff7fff
; GFX9-NEXT:    v_mov_b32_e32 v2, s4
; GFX9-NEXT:    v_pk_mul_f16 v1, s4, -4.0 op_sel_hi:[1,0]
; GFX9-NEXT:    global_store_dword v0, v2, s[0:1]
; GFX9-NEXT:    global_store_dword v0, v1, s[2:3]
; GFX9-NEXT:    s_endpgm
;
; GFX11-LABEL: s_fneg_multi_use_fabs_foldable_neg_v2f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    s_load_b32 s6, s[4:5], 0x10
; GFX11-NEXT:    s_load_b128 s[0:3], s[4:5], 0x0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_and_b32 s4, s6, 0x7fff7fff
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v0, 0 :: v_dual_mov_b32 v1, s4
; GFX11-NEXT:    v_pk_mul_f16 v2, s4, -4.0 op_sel_hi:[1,0]
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    global_store_b32 v0, v1, s[0:1]
; GFX11-NEXT:    global_store_b32 v0, v2, s[2:3]
; GFX11-NEXT:    s_endpgm
  %fabs = call <2 x half> @llvm.fabs.v2f16(<2 x half> %in)
  %fneg = fsub <2 x half> <half -0.0, half -0.0>, %fabs
  %mul = fmul <2 x half> %fneg, <half 4.0, half 4.0>
  store <2 x half> %fabs, ptr addrspace(1) %out0
  store <2 x half> %mul, ptr addrspace(1) %out1
  ret void
}

declare half @llvm.fabs.f16(half) #1
declare <2 x half> @llvm.fabs.v2f16(<2 x half>) #1
declare <4 x half> @llvm.fabs.v4f16(<4 x half>) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }