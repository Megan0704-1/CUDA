; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx950 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX950-SDAG %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx950 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX950-GISEL %s

declare <2 x i32>    @llvm.amdgcn.ds.read.tr4.b64.v2i32.p3(ptr addrspace(3))
declare <2 x i32>    @llvm.amdgcn.ds.read.tr8.b64.v2i32.p3(ptr addrspace(3))
declare <3 x i32>    @llvm.amdgcn.ds.read.tr6.b64.v3i32.p3(ptr addrspace(3))
declare <4 x i16>    @llvm.amdgcn.ds.read.tr16.b64.v4i16.p3(ptr addrspace(3))
declare <4 x half>    @llvm.amdgcn.ds.read.tr16.b64.v4f16.p3(ptr addrspace(3))
declare <4 x bfloat>    @llvm.amdgcn.ds.read.tr16.b64.v4bf16.p3(ptr addrspace(3))

define amdgpu_ps void @ds_read_b64_tr_b4(ptr addrspace(3) %addr, ptr addrspace(1) %use) {
; GFX950-SDAG-LABEL: ds_read_b64_tr_b4:
; GFX950-SDAG:       ; %bb.0: ; %entry
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, v2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, v1
; GFX950-SDAG-NEXT:    ds_read_b64_tr_b4 v[0:1], v0 offset:32
; GFX950-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[2:3], v[0:1], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: ds_read_b64_tr_b4:
; GFX950-GISEL:       ; %bb.0: ; %entry
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v4, v1
; GFX950-GISEL-NEXT:    ds_read_b64_tr_b4 v[0:1], v0 offset:32
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v5, v2
; GFX950-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[4:5], v[0:1], off
; GFX950-GISEL-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(3) %addr, i32 4
  %val = call <2 x i32> @llvm.amdgcn.ds.read.tr4.b64.v2i32.p3(ptr addrspace(3) %gep)
  store <2 x i32> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_ps void @ds_read_b96_tr_b6(ptr addrspace(3) %addr, ptr addrspace(1) %use) {
; GFX950-SDAG-LABEL: ds_read_b96_tr_b6:
; GFX950-SDAG:       ; %bb.0: ; %entry
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v5, v2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v4, v1
; GFX950-SDAG-NEXT:    ds_read_b96_tr_b6 v[0:2], v0 offset:32
; GFX950-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-SDAG-NEXT:    global_store_dwordx3 v[4:5], v[0:2], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: ds_read_b96_tr_b6:
; GFX950-GISEL:       ; %bb.0: ; %entry
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v4, v1
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v5, v2
; GFX950-GISEL-NEXT:    ds_read_b96_tr_b6 v[0:2], v0 offset:32
; GFX950-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-GISEL-NEXT:    global_store_dwordx3 v[4:5], v[0:2], off
; GFX950-GISEL-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(3) %addr, i32 4
  %val = call <3 x i32> @llvm.amdgcn.ds.read.tr6.b96.v3i32.p3(ptr addrspace(3) %gep)
  store <3 x i32> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_ps void @ds_read_b64_tr_b8(ptr addrspace(3) %addr, ptr addrspace(1) %use) {
; GFX950-SDAG-LABEL: ds_read_b64_tr_b8:
; GFX950-SDAG:       ; %bb.0: ; %entry
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, v2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, v1
; GFX950-SDAG-NEXT:    ds_read_b64_tr_b8 v[0:1], v0 offset:32
; GFX950-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[2:3], v[0:1], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: ds_read_b64_tr_b8:
; GFX950-GISEL:       ; %bb.0: ; %entry
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v4, v1
; GFX950-GISEL-NEXT:    ds_read_b64_tr_b8 v[0:1], v0 offset:32
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v5, v2
; GFX950-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[4:5], v[0:1], off
; GFX950-GISEL-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(3) %addr, i32 4
  %val = call <2 x i32> @llvm.amdgcn.ds.read.tr8.b64.v2i32.p3(ptr addrspace(3) %gep)
  store <2 x i32> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_ps void @ds_read_b64_tr_b16(ptr addrspace(3) %addr, ptr addrspace(1) %use) {
; GFX950-SDAG-LABEL: ds_read_b64_tr_b16:
; GFX950-SDAG:       ; %bb.0: ; %entry
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, v2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, v1
; GFX950-SDAG-NEXT:    ds_read_b64_tr_b16 v[0:1], v0 offset:32
; GFX950-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[2:3], v[0:1], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: ds_read_b64_tr_b16:
; GFX950-GISEL:       ; %bb.0: ; %entry
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v4, v1
; GFX950-GISEL-NEXT:    ds_read_b64_tr_b16 v[0:1], v0 offset:32
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v5, v2
; GFX950-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[4:5], v[0:1], off
; GFX950-GISEL-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(3) %addr, i32 4
  %val = call <4 x i16> @llvm.amdgcn.ds.read.tr16.b64.v4i16.p3(ptr addrspace(3) %gep)
  store <4 x i16> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_ps void @ds_read_b64_tr_b16_v4f16(ptr addrspace(3) %addr, ptr addrspace(1) %use) {
; GFX950-SDAG-LABEL: ds_read_b64_tr_b16_v4f16:
; GFX950-SDAG:       ; %bb.0: ; %entry
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, v2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, v1
; GFX950-SDAG-NEXT:    ds_read_b64_tr_b16 v[0:1], v0 offset:32
; GFX950-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[2:3], v[0:1], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: ds_read_b64_tr_b16_v4f16:
; GFX950-GISEL:       ; %bb.0: ; %entry
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v4, v1
; GFX950-GISEL-NEXT:    ds_read_b64_tr_b16 v[0:1], v0 offset:32
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v5, v2
; GFX950-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[4:5], v[0:1], off
; GFX950-GISEL-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(3) %addr, i32 4
  %val = call <4 x half> @llvm.amdgcn.ds.read.tr16.b64.v4f16.p3(ptr addrspace(3) %gep)
  store <4 x half> %val, ptr addrspace(1) %use
  ret void
}

define amdgpu_ps void @ds_read_b64_tr_b16_v4bf16(ptr addrspace(3) %addr, ptr addrspace(1) %use) {
; GFX950-SDAG-LABEL: ds_read_b64_tr_b16_v4bf16:
; GFX950-SDAG:       ; %bb.0: ; %entry
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v3, v2
; GFX950-SDAG-NEXT:    v_mov_b32_e32 v2, v1
; GFX950-SDAG-NEXT:    ds_read_b64_tr_b16 v[0:1], v0 offset:32
; GFX950-SDAG-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-SDAG-NEXT:    global_store_dwordx2 v[2:3], v[0:1], off
; GFX950-SDAG-NEXT:    s_endpgm
;
; GFX950-GISEL-LABEL: ds_read_b64_tr_b16_v4bf16:
; GFX950-GISEL:       ; %bb.0: ; %entry
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v4, v1
; GFX950-GISEL-NEXT:    ds_read_b64_tr_b16 v[0:1], v0 offset:32
; GFX950-GISEL-NEXT:    v_mov_b32_e32 v5, v2
; GFX950-GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GFX950-GISEL-NEXT:    global_store_dwordx2 v[4:5], v[0:1], off
; GFX950-GISEL-NEXT:    s_endpgm
entry:
  %gep = getelementptr i64, ptr addrspace(3) %addr, i32 4
  %val = call <4 x bfloat> @llvm.amdgcn.ds.read.tr16.b64.v4bf16.p3(ptr addrspace(3) %gep)
  store <4 x bfloat> %val, ptr addrspace(1) %use
  ret void
}