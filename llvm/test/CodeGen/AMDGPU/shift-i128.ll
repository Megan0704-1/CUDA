; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=kaveri -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

define i128 @v_shl_i128_vv(i128 %lhs, i128 %rhs) {
; GCN-LABEL: v_shl_i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v7, vcc, 64, v4
; GCN-NEXT:    v_lshl_b64 v[5:6], v[2:3], v4
; GCN-NEXT:    v_lshr_b64 v[7:8], v[0:1], v7
; GCN-NEXT:    v_cmp_eq_u32_e64 s[4:5], 0, v4
; GCN-NEXT:    v_or_b32_e32 v7, v5, v7
; GCN-NEXT:    v_subrev_i32_e32 v5, vcc, 64, v4
; GCN-NEXT:    v_or_b32_e32 v8, v6, v8
; GCN-NEXT:    v_lshl_b64 v[5:6], v[0:1], v5
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v4
; GCN-NEXT:    v_cndmask_b32_e32 v5, v5, v7, vcc
; GCN-NEXT:    v_lshl_b64 v[0:1], v[0:1], v4
; GCN-NEXT:    v_cndmask_b32_e64 v2, v5, v2, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v5, v6, v8, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v3, v5, v3, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i128 %lhs, %rhs
  ret i128 %shl
}

define i128 @v_lshr_i128_vv(i128 %lhs, i128 %rhs) {
; GCN-LABEL: v_lshr_i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v7, vcc, 64, v4
; GCN-NEXT:    v_lshr_b64 v[5:6], v[0:1], v4
; GCN-NEXT:    v_lshl_b64 v[7:8], v[2:3], v7
; GCN-NEXT:    v_cmp_eq_u32_e64 s[4:5], 0, v4
; GCN-NEXT:    v_or_b32_e32 v7, v5, v7
; GCN-NEXT:    v_subrev_i32_e32 v5, vcc, 64, v4
; GCN-NEXT:    v_or_b32_e32 v8, v6, v8
; GCN-NEXT:    v_lshr_b64 v[5:6], v[2:3], v5
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v4
; GCN-NEXT:    v_cndmask_b32_e32 v5, v5, v7, vcc
; GCN-NEXT:    v_lshr_b64 v[2:3], v[2:3], v4
; GCN-NEXT:    v_cndmask_b32_e64 v0, v5, v0, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v5, v6, v8, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v1, v5, v1, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v2, 0, v2, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v3, 0, v3, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]

  %shl = lshr i128 %lhs, %rhs
  ret i128 %shl
}

define i128 @v_ashr_i128_vv(i128 %lhs, i128 %rhs) {
; GCN-LABEL: v_ashr_i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v7, vcc, 64, v4
; GCN-NEXT:    v_lshr_b64 v[5:6], v[0:1], v4
; GCN-NEXT:    v_lshl_b64 v[7:8], v[2:3], v7
; GCN-NEXT:    v_cmp_eq_u32_e64 s[4:5], 0, v4
; GCN-NEXT:    v_or_b32_e32 v7, v5, v7
; GCN-NEXT:    v_subrev_i32_e32 v5, vcc, 64, v4
; GCN-NEXT:    v_or_b32_e32 v8, v6, v8
; GCN-NEXT:    v_ashr_i64 v[5:6], v[2:3], v5
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v4
; GCN-NEXT:    v_cndmask_b32_e32 v5, v5, v7, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v0, v5, v0, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v5, v6, v8, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v1, v5, v1, s[4:5]
; GCN-NEXT:    v_ashr_i64 v[4:5], v[2:3], v4
; GCN-NEXT:    v_ashrrev_i32_e32 v3, 31, v3
; GCN-NEXT:    v_cndmask_b32_e32 v2, v3, v4, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v3, v3, v5, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = ashr i128 %lhs, %rhs
  ret i128 %shl
}


define i128 @v_shl_i128_vk(i128 %lhs) {
; GCN-LABEL: v_shl_i128_vk:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_lshl_b64 v[2:3], v[2:3], 17
; GCN-NEXT:    v_lshrrev_b32_e32 v4, 15, v1
; GCN-NEXT:    v_or_b32_e32 v2, v2, v4
; GCN-NEXT:    v_alignbit_b32 v1, v1, v0, 15
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 17, v0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i128 %lhs, 17
  ret i128 %shl
}

define i128 @v_lshr_i128_vk(i128 %lhs) {
; GCN-LABEL: v_lshr_i128_vk:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_alignbit_b32 v0, v3, v2, 1
; GCN-NEXT:    v_lshrrev_b32_e32 v1, 1, v3
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = lshr i128 %lhs, 65
  ret i128 %shl
}

define i128 @v_ashr_i128_vk(i128 %lhs) {
; GCN-LABEL: v_ashr_i128_vk:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v4, v1
; GCN-NEXT:    v_lshl_b64 v[0:1], v[2:3], 31
; GCN-NEXT:    v_lshrrev_b32_e32 v4, 1, v4
; GCN-NEXT:    v_ashr_i64 v[2:3], v[2:3], 33
; GCN-NEXT:    v_or_b32_e32 v0, v4, v0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = ashr i128 %lhs, 33
  ret i128 %shl
}

define i128 @v_shl_i128_kv(i128 %rhs) {
; GCN-LABEL: v_shl_i128_kv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v1, vcc, 64, v0
; GCN-NEXT:    v_lshr_b64 v[2:3], 17, v1
; GCN-NEXT:    v_subrev_i32_e32 v1, vcc, 64, v0
; GCN-NEXT:    v_lshl_b64 v[4:5], 17, v1
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v0
; GCN-NEXT:    v_cndmask_b32_e32 v1, v4, v2, vcc
; GCN-NEXT:    v_cmp_ne_u32_e64 s[4:5], 0, v0
; GCN-NEXT:    v_cndmask_b32_e64 v2, 0, v1, s[4:5]
; GCN-NEXT:    v_lshl_b64 v[0:1], 17, v0
; GCN-NEXT:    v_cndmask_b32_e32 v3, v5, v3, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v3, 0, v3, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i128 17, %rhs
  ret i128 %shl
}

define i128 @v_lshr_i128_kv(i128 %rhs) {
; GCN-LABEL: v_lshr_i128_kv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_mov_b64 s[4:5], 0x41
; GCN-NEXT:    v_lshr_b64 v[1:2], s[4:5], v0
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v0
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v2, 0x41
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v2, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = lshr i128 65, %rhs
  ret i128 %shl
}

define i128 @v_ashr_i128_kv(i128 %rhs) {
; GCN-LABEL: v_ashr_i128_kv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_lshr_b64 v[1:2], 33, v0
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v0
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 0, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, 33, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = ashr i128 33, %rhs
  ret i128 %shl
}

define amdgpu_kernel void @s_shl_i128_ss(i128 %lhs, i128 %rhs) {
; GCN-LABEL: s_shl_i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[0:7], s[8:9], 0x0
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_sub_i32 s5, s4, 64
; GCN-NEXT:    s_sub_i32 s12, 64, s4
; GCN-NEXT:    s_lshl_b64 s[6:7], s[2:3], s4
; GCN-NEXT:    s_lshl_b64 s[8:9], s[0:1], s4
; GCN-NEXT:    s_lshl_b64 s[10:11], s[0:1], s5
; GCN-NEXT:    s_lshr_b64 s[0:1], s[0:1], s12
; GCN-NEXT:    s_or_b64 s[0:1], s[6:7], s[0:1]
; GCN-NEXT:    s_cmp_lt_u32 s4, 64
; GCN-NEXT:    s_cselect_b32 s0, s0, s10
; GCN-NEXT:    s_cselect_b32 s1, s1, s11
; GCN-NEXT:    s_cselect_b32 s5, s9, 0
; GCN-NEXT:    s_cselect_b32 s6, s8, 0
; GCN-NEXT:    s_cmp_eq_u32 s4, 0
; GCN-NEXT:    s_cselect_b32 s1, s3, s1
; GCN-NEXT:    s_cselect_b32 s0, s2, s0
; GCN-NEXT:    v_mov_b32_e32 v0, s6
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    v_mov_b32_e32 v3, s1
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
  %shift = shl i128 %lhs, %rhs
  store i128 %shift, ptr addrspace(1) null
  ret void
}

define amdgpu_kernel void @s_lshr_i128_ss(i128 %lhs, i128 %rhs) {
; GCN-LABEL: s_lshr_i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[0:7], s[8:9], 0x0
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_sub_i32 s5, s4, 64
; GCN-NEXT:    s_sub_i32 s12, 64, s4
; GCN-NEXT:    s_lshr_b64 s[6:7], s[0:1], s4
; GCN-NEXT:    s_lshr_b64 s[8:9], s[2:3], s4
; GCN-NEXT:    s_lshr_b64 s[10:11], s[2:3], s5
; GCN-NEXT:    s_lshl_b64 s[2:3], s[2:3], s12
; GCN-NEXT:    s_or_b64 s[2:3], s[6:7], s[2:3]
; GCN-NEXT:    s_cmp_lt_u32 s4, 64
; GCN-NEXT:    s_cselect_b32 s2, s2, s10
; GCN-NEXT:    s_cselect_b32 s3, s3, s11
; GCN-NEXT:    s_cselect_b32 s5, s9, 0
; GCN-NEXT:    s_cselect_b32 s6, s8, 0
; GCN-NEXT:    s_cmp_eq_u32 s4, 0
; GCN-NEXT:    s_cselect_b32 s1, s1, s3
; GCN-NEXT:    s_cselect_b32 s0, s0, s2
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s6
; GCN-NEXT:    v_mov_b32_e32 v3, s5
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
  %shift = lshr i128 %lhs, %rhs
  store i128 %shift, ptr addrspace(1) null
  ret void
}

define amdgpu_kernel void @s_ashr_i128_ss(i128 %lhs, i128 %rhs) {
; GCN-LABEL: s_ashr_i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[0:7], s[8:9], 0x0
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_sub_i32 s5, 64, s4
; GCN-NEXT:    s_lshr_b64 s[6:7], s[0:1], s4
; GCN-NEXT:    s_sub_i32 s10, s4, 64
; GCN-NEXT:    s_lshl_b64 s[8:9], s[2:3], s5
; GCN-NEXT:    s_ashr_i32 s12, s3, 31
; GCN-NEXT:    s_ashr_i64 s[10:11], s[2:3], s10
; GCN-NEXT:    s_or_b64 s[6:7], s[6:7], s[8:9]
; GCN-NEXT:    s_ashr_i64 s[2:3], s[2:3], s4
; GCN-NEXT:    s_cmp_lt_u32 s4, 64
; GCN-NEXT:    s_cselect_b32 s3, s3, s12
; GCN-NEXT:    s_cselect_b32 s2, s2, s12
; GCN-NEXT:    s_cselect_b32 s5, s6, s10
; GCN-NEXT:    s_cselect_b32 s6, s7, s11
; GCN-NEXT:    s_cmp_eq_u32 s4, 0
; GCN-NEXT:    s_cselect_b32 s1, s1, s6
; GCN-NEXT:    s_cselect_b32 s0, s0, s5
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v3, s3
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
  %shift = ashr i128 %lhs, %rhs
  store i128 %shift, ptr addrspace(1) null
  ret void
}

define <2 x i128> @v_shl_v2i128_vv(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: v_shl_v2i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v16, vcc, 64, v8
; GCN-NEXT:    v_lshr_b64 v[16:17], v[0:1], v16
; GCN-NEXT:    v_lshl_b64 v[18:19], v[2:3], v8
; GCN-NEXT:    v_cmp_gt_u64_e32 vcc, 64, v[8:9]
; GCN-NEXT:    v_or_b32_e32 v18, v18, v16
; GCN-NEXT:    v_cmp_eq_u64_e64 s[4:5], 0, v[10:11]
; GCN-NEXT:    v_subrev_i32_e64 v16, s[6:7], 64, v8
; GCN-NEXT:    v_or_b32_e32 v19, v19, v17
; GCN-NEXT:    v_lshl_b64 v[16:17], v[0:1], v16
; GCN-NEXT:    v_or_b32_e32 v11, v9, v11
; GCN-NEXT:    v_or_b32_e32 v10, v8, v10
; GCN-NEXT:    s_and_b64 vcc, s[4:5], vcc
; GCN-NEXT:    v_cmp_eq_u64_e64 s[4:5], 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e32 v16, v16, v18, vcc
; GCN-NEXT:    v_sub_i32_e64 v9, s[6:7], 64, v12
; GCN-NEXT:    v_cndmask_b32_e64 v2, v16, v2, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v11, v17, v19, vcc
; GCN-NEXT:    v_lshr_b64 v[9:10], v[4:5], v9
; GCN-NEXT:    v_lshl_b64 v[16:17], v[6:7], v12
; GCN-NEXT:    v_cndmask_b32_e64 v3, v11, v3, s[4:5]
; GCN-NEXT:    v_or_b32_e32 v16, v16, v9
; GCN-NEXT:    v_cmp_gt_u64_e64 s[4:5], 64, v[12:13]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[6:7], 0, v[14:15]
; GCN-NEXT:    v_subrev_i32_e64 v9, s[8:9], 64, v12
; GCN-NEXT:    v_or_b32_e32 v11, v17, v10
; GCN-NEXT:    v_lshl_b64 v[9:10], v[4:5], v9
; GCN-NEXT:    v_or_b32_e32 v15, v13, v15
; GCN-NEXT:    v_or_b32_e32 v14, v12, v14
; GCN-NEXT:    s_and_b64 s[4:5], s[6:7], s[4:5]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[6:7], 0, v[14:15]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v9, v16, s[4:5]
; GCN-NEXT:    v_lshl_b64 v[0:1], v[0:1], v8
; GCN-NEXT:    v_lshl_b64 v[4:5], v[4:5], v12
; GCN-NEXT:    v_cndmask_b32_e64 v6, v9, v6, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v10, v11, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v7, v9, v7, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v4, 0, v4, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v5, 0, v5, s[4:5]
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl <2 x i128> %lhs, %rhs
  ret <2 x i128> %shl
}

define <2 x i128> @v_lshr_v2i128_vv(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: v_lshr_v2i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v16, vcc, 64, v8
; GCN-NEXT:    v_lshl_b64 v[16:17], v[2:3], v16
; GCN-NEXT:    v_lshr_b64 v[18:19], v[0:1], v8
; GCN-NEXT:    v_cmp_gt_u64_e32 vcc, 64, v[8:9]
; GCN-NEXT:    v_or_b32_e32 v18, v18, v16
; GCN-NEXT:    v_cmp_eq_u64_e64 s[4:5], 0, v[10:11]
; GCN-NEXT:    v_subrev_i32_e64 v16, s[6:7], 64, v8
; GCN-NEXT:    v_or_b32_e32 v19, v19, v17
; GCN-NEXT:    v_lshr_b64 v[16:17], v[2:3], v16
; GCN-NEXT:    v_or_b32_e32 v11, v9, v11
; GCN-NEXT:    v_or_b32_e32 v10, v8, v10
; GCN-NEXT:    s_and_b64 vcc, s[4:5], vcc
; GCN-NEXT:    v_cmp_eq_u64_e64 s[4:5], 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e32 v16, v16, v18, vcc
; GCN-NEXT:    v_sub_i32_e64 v9, s[6:7], 64, v12
; GCN-NEXT:    v_cndmask_b32_e64 v0, v16, v0, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v11, v17, v19, vcc
; GCN-NEXT:    v_lshl_b64 v[9:10], v[6:7], v9
; GCN-NEXT:    v_lshr_b64 v[16:17], v[4:5], v12
; GCN-NEXT:    v_cndmask_b32_e64 v1, v11, v1, s[4:5]
; GCN-NEXT:    v_or_b32_e32 v16, v16, v9
; GCN-NEXT:    v_cmp_gt_u64_e64 s[4:5], 64, v[12:13]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[6:7], 0, v[14:15]
; GCN-NEXT:    v_subrev_i32_e64 v9, s[8:9], 64, v12
; GCN-NEXT:    v_or_b32_e32 v11, v17, v10
; GCN-NEXT:    v_lshr_b64 v[9:10], v[6:7], v9
; GCN-NEXT:    v_or_b32_e32 v15, v13, v15
; GCN-NEXT:    v_or_b32_e32 v14, v12, v14
; GCN-NEXT:    s_and_b64 s[4:5], s[6:7], s[4:5]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[6:7], 0, v[14:15]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v9, v16, s[4:5]
; GCN-NEXT:    v_lshr_b64 v[2:3], v[2:3], v8
; GCN-NEXT:    v_lshr_b64 v[6:7], v[6:7], v12
; GCN-NEXT:    v_cndmask_b32_e64 v4, v9, v4, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v10, v11, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v5, v9, v5, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v2, 0, v2, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v3, 0, v3, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v6, 0, v6, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v7, 0, v7, s[4:5]
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = lshr <2 x i128> %lhs, %rhs
  ret <2 x i128> %shl
}

define <2 x i128> @v_ashr_v2i128_vv(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: v_ashr_v2i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v16, vcc, 64, v8
; GCN-NEXT:    v_lshl_b64 v[16:17], v[2:3], v16
; GCN-NEXT:    v_lshr_b64 v[18:19], v[0:1], v8
; GCN-NEXT:    v_cmp_gt_u64_e32 vcc, 64, v[8:9]
; GCN-NEXT:    v_or_b32_e32 v18, v18, v16
; GCN-NEXT:    v_cmp_eq_u64_e64 s[4:5], 0, v[10:11]
; GCN-NEXT:    v_subrev_i32_e64 v16, s[6:7], 64, v8
; GCN-NEXT:    v_or_b32_e32 v19, v19, v17
; GCN-NEXT:    v_ashr_i64 v[16:17], v[2:3], v16
; GCN-NEXT:    v_or_b32_e32 v11, v9, v11
; GCN-NEXT:    v_or_b32_e32 v10, v8, v10
; GCN-NEXT:    s_and_b64 vcc, s[4:5], vcc
; GCN-NEXT:    v_cmp_eq_u64_e64 s[4:5], 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e32 v16, v16, v18, vcc
; GCN-NEXT:    v_sub_i32_e64 v9, s[6:7], 64, v12
; GCN-NEXT:    v_cndmask_b32_e64 v0, v16, v0, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v11, v17, v19, vcc
; GCN-NEXT:    v_lshl_b64 v[9:10], v[6:7], v9
; GCN-NEXT:    v_lshr_b64 v[16:17], v[4:5], v12
; GCN-NEXT:    v_cndmask_b32_e64 v1, v11, v1, s[4:5]
; GCN-NEXT:    v_or_b32_e32 v16, v16, v9
; GCN-NEXT:    v_cmp_gt_u64_e64 s[4:5], 64, v[12:13]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[6:7], 0, v[14:15]
; GCN-NEXT:    v_subrev_i32_e64 v9, s[8:9], 64, v12
; GCN-NEXT:    v_or_b32_e32 v11, v17, v10
; GCN-NEXT:    v_ashr_i64 v[9:10], v[6:7], v9
; GCN-NEXT:    v_or_b32_e32 v15, v13, v15
; GCN-NEXT:    v_or_b32_e32 v14, v12, v14
; GCN-NEXT:    s_and_b64 s[4:5], s[6:7], s[4:5]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[6:7], 0, v[14:15]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v9, v16, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v4, v9, v4, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v10, v11, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v5, v9, v5, s[6:7]
; GCN-NEXT:    v_ashr_i64 v[8:9], v[2:3], v8
; GCN-NEXT:    v_ashrrev_i32_e32 v3, 31, v3
; GCN-NEXT:    v_cndmask_b32_e32 v2, v3, v8, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v3, v3, v9, vcc
; GCN-NEXT:    v_ashr_i64 v[8:9], v[6:7], v12
; GCN-NEXT:    v_ashrrev_i32_e32 v7, 31, v7
; GCN-NEXT:    v_cndmask_b32_e64 v6, v7, v8, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e64 v7, v7, v9, s[4:5]
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = ashr <2 x i128> %lhs, %rhs
  ret <2 x i128> %shl
}

define amdgpu_kernel void @s_shl_v2i128ss(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: s_shl_v2i128ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx16 s[0:15], s[8:9], 0x0
; GCN-NEXT:    v_mov_b32_e32 v6, 16
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v7, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_cmp_lt_u64_e64 s[16:17], s[8:9], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[10:11], 0
; GCN-NEXT:    s_sub_i32 s22, 64, s8
; GCN-NEXT:    s_sub_i32 s20, s8, 64
; GCN-NEXT:    s_lshr_b64 s[22:23], s[0:1], s22
; GCN-NEXT:    s_and_b64 s[16:17], s[18:19], s[16:17]
; GCN-NEXT:    s_lshl_b64 s[18:19], s[2:3], s8
; GCN-NEXT:    s_lshl_b64 s[20:21], s[0:1], s20
; GCN-NEXT:    s_or_b64 s[18:19], s[18:19], s[22:23]
; GCN-NEXT:    s_and_b64 s[22:23], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s19, s19, s21
; GCN-NEXT:    s_or_b64 s[10:11], s[8:9], s[10:11]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[10:11], s[10:11], 0
; GCN-NEXT:    s_and_b64 s[22:23], s[10:11], exec
; GCN-NEXT:    s_cselect_b32 s9, s3, s19
; GCN-NEXT:    s_and_b64 s[22:23], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s3, s18, s20
; GCN-NEXT:    s_and_b64 s[10:11], s[10:11], exec
; GCN-NEXT:    v_cmp_lt_u64_e64 s[10:11], s[12:13], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[14:15], 0
; GCN-NEXT:    s_cselect_b32 s22, s2, s3
; GCN-NEXT:    s_and_b64 s[2:3], s[18:19], s[10:11]
; GCN-NEXT:    s_sub_i32 s18, 64, s12
; GCN-NEXT:    s_sub_i32 s10, s12, 64
; GCN-NEXT:    s_lshr_b64 s[18:19], s[4:5], s18
; GCN-NEXT:    s_lshl_b64 s[20:21], s[6:7], s12
; GCN-NEXT:    s_lshl_b64 s[10:11], s[4:5], s10
; GCN-NEXT:    s_or_b64 s[18:19], s[20:21], s[18:19]
; GCN-NEXT:    s_and_b64 s[20:21], s[2:3], exec
; GCN-NEXT:    s_cselect_b32 s11, s19, s11
; GCN-NEXT:    s_or_b64 s[14:15], s[12:13], s[14:15]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[14:15], s[14:15], 0
; GCN-NEXT:    s_and_b64 s[20:21], s[14:15], exec
; GCN-NEXT:    s_cselect_b32 s13, s7, s11
; GCN-NEXT:    s_and_b64 s[20:21], s[2:3], exec
; GCN-NEXT:    s_cselect_b32 s7, s18, s10
; GCN-NEXT:    s_and_b64 s[10:11], s[14:15], exec
; GCN-NEXT:    s_cselect_b32 s10, s6, s7
; GCN-NEXT:    s_lshl_b64 s[0:1], s[0:1], s8
; GCN-NEXT:    s_and_b64 s[6:7], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s6, s1, 0
; GCN-NEXT:    s_cselect_b32 s7, s0, 0
; GCN-NEXT:    s_lshl_b64 s[0:1], s[4:5], s12
; GCN-NEXT:    s_and_b64 s[2:3], s[2:3], exec
; GCN-NEXT:    s_cselect_b32 s1, s1, 0
; GCN-NEXT:    s_cselect_b32 s0, s0, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s10
; GCN-NEXT:    v_mov_b32_e32 v3, s13
; GCN-NEXT:    flat_store_dwordx4 v[6:7], v[0:3]
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    v_mov_b32_e32 v0, s7
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    v_mov_b32_e32 v2, s22
; GCN-NEXT:    v_mov_b32_e32 v3, s9
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
  %shift = shl <2 x i128> %lhs, %rhs
  store <2 x i128> %shift, ptr addrspace(1) null
  ret void
}

define amdgpu_kernel void @s_lshr_v2i128_ss(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: s_lshr_v2i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx16 s[0:15], s[8:9], 0x0
; GCN-NEXT:    v_mov_b32_e32 v6, 16
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v7, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_cmp_lt_u64_e64 s[16:17], s[8:9], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[10:11], 0
; GCN-NEXT:    s_sub_i32 s22, 64, s8
; GCN-NEXT:    s_sub_i32 s20, s8, 64
; GCN-NEXT:    s_lshl_b64 s[22:23], s[2:3], s22
; GCN-NEXT:    s_and_b64 s[16:17], s[18:19], s[16:17]
; GCN-NEXT:    s_lshr_b64 s[18:19], s[0:1], s8
; GCN-NEXT:    s_lshr_b64 s[20:21], s[2:3], s20
; GCN-NEXT:    s_or_b64 s[18:19], s[18:19], s[22:23]
; GCN-NEXT:    s_and_b64 s[22:23], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s19, s19, s21
; GCN-NEXT:    s_or_b64 s[10:11], s[8:9], s[10:11]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[10:11], s[10:11], 0
; GCN-NEXT:    s_and_b64 s[22:23], s[10:11], exec
; GCN-NEXT:    s_cselect_b32 s9, s1, s19
; GCN-NEXT:    s_and_b64 s[22:23], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s1, s18, s20
; GCN-NEXT:    s_and_b64 s[10:11], s[10:11], exec
; GCN-NEXT:    v_cmp_lt_u64_e64 s[10:11], s[12:13], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[14:15], 0
; GCN-NEXT:    s_cselect_b32 s22, s0, s1
; GCN-NEXT:    s_and_b64 s[0:1], s[18:19], s[10:11]
; GCN-NEXT:    s_sub_i32 s18, 64, s12
; GCN-NEXT:    s_sub_i32 s10, s12, 64
; GCN-NEXT:    s_lshl_b64 s[18:19], s[6:7], s18
; GCN-NEXT:    s_lshr_b64 s[20:21], s[4:5], s12
; GCN-NEXT:    s_lshr_b64 s[10:11], s[6:7], s10
; GCN-NEXT:    s_or_b64 s[18:19], s[20:21], s[18:19]
; GCN-NEXT:    s_and_b64 s[20:21], s[0:1], exec
; GCN-NEXT:    s_cselect_b32 s11, s19, s11
; GCN-NEXT:    s_or_b64 s[14:15], s[12:13], s[14:15]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[14:15], s[14:15], 0
; GCN-NEXT:    s_and_b64 s[20:21], s[14:15], exec
; GCN-NEXT:    s_cselect_b32 s13, s5, s11
; GCN-NEXT:    s_and_b64 s[20:21], s[0:1], exec
; GCN-NEXT:    s_cselect_b32 s5, s18, s10
; GCN-NEXT:    s_and_b64 s[10:11], s[14:15], exec
; GCN-NEXT:    s_cselect_b32 s10, s4, s5
; GCN-NEXT:    s_lshr_b64 s[2:3], s[2:3], s8
; GCN-NEXT:    s_and_b64 s[4:5], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s4, s3, 0
; GCN-NEXT:    s_cselect_b32 s5, s2, 0
; GCN-NEXT:    s_lshr_b64 s[2:3], s[6:7], s12
; GCN-NEXT:    s_and_b64 s[0:1], s[0:1], exec
; GCN-NEXT:    s_cselect_b32 s0, s3, 0
; GCN-NEXT:    s_cselect_b32 s1, s2, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s10
; GCN-NEXT:    v_mov_b32_e32 v1, s13
; GCN-NEXT:    v_mov_b32_e32 v2, s1
; GCN-NEXT:    v_mov_b32_e32 v3, s0
; GCN-NEXT:    flat_store_dwordx4 v[6:7], v[0:3]
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    v_mov_b32_e32 v0, s22
; GCN-NEXT:    v_mov_b32_e32 v1, s9
; GCN-NEXT:    v_mov_b32_e32 v2, s5
; GCN-NEXT:    v_mov_b32_e32 v3, s4
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
  %shift = lshr <2 x i128> %lhs, %rhs
  store <2 x i128> %shift, ptr addrspace(1) null
  ret void
}

define amdgpu_kernel void @s_ashr_v2i128_ss(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: s_ashr_v2i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx16 s[0:15], s[8:9], 0x0
; GCN-NEXT:    v_mov_b32_e32 v6, 16
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v7, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_cmp_lt_u64_e64 s[16:17], s[8:9], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[10:11], 0
; GCN-NEXT:    s_sub_i32 s22, 64, s8
; GCN-NEXT:    s_sub_i32 s20, s8, 64
; GCN-NEXT:    s_lshl_b64 s[22:23], s[2:3], s22
; GCN-NEXT:    s_and_b64 s[16:17], s[18:19], s[16:17]
; GCN-NEXT:    s_lshr_b64 s[18:19], s[0:1], s8
; GCN-NEXT:    s_ashr_i64 s[20:21], s[2:3], s20
; GCN-NEXT:    s_or_b64 s[18:19], s[18:19], s[22:23]
; GCN-NEXT:    s_and_b64 s[22:23], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s19, s19, s21
; GCN-NEXT:    s_or_b64 s[10:11], s[8:9], s[10:11]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[10:11], s[10:11], 0
; GCN-NEXT:    s_and_b64 s[22:23], s[10:11], exec
; GCN-NEXT:    s_cselect_b32 s9, s1, s19
; GCN-NEXT:    s_and_b64 s[22:23], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s1, s18, s20
; GCN-NEXT:    s_and_b64 s[10:11], s[10:11], exec
; GCN-NEXT:    v_cmp_lt_u64_e64 s[10:11], s[12:13], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[14:15], 0
; GCN-NEXT:    s_cselect_b32 s22, s0, s1
; GCN-NEXT:    s_and_b64 s[0:1], s[18:19], s[10:11]
; GCN-NEXT:    s_sub_i32 s18, 64, s12
; GCN-NEXT:    s_sub_i32 s10, s12, 64
; GCN-NEXT:    s_lshl_b64 s[18:19], s[6:7], s18
; GCN-NEXT:    s_lshr_b64 s[20:21], s[4:5], s12
; GCN-NEXT:    s_ashr_i64 s[10:11], s[6:7], s10
; GCN-NEXT:    s_or_b64 s[18:19], s[20:21], s[18:19]
; GCN-NEXT:    s_and_b64 s[20:21], s[0:1], exec
; GCN-NEXT:    s_cselect_b32 s11, s19, s11
; GCN-NEXT:    s_or_b64 s[14:15], s[12:13], s[14:15]
; GCN-NEXT:    v_cmp_eq_u64_e64 s[14:15], s[14:15], 0
; GCN-NEXT:    s_and_b64 s[20:21], s[14:15], exec
; GCN-NEXT:    s_cselect_b32 s13, s5, s11
; GCN-NEXT:    s_and_b64 s[20:21], s[0:1], exec
; GCN-NEXT:    s_cselect_b32 s5, s18, s10
; GCN-NEXT:    s_and_b64 s[10:11], s[14:15], exec
; GCN-NEXT:    s_cselect_b32 s10, s4, s5
; GCN-NEXT:    s_ashr_i32 s11, s3, 31
; GCN-NEXT:    s_ashr_i64 s[2:3], s[2:3], s8
; GCN-NEXT:    s_and_b64 s[4:5], s[16:17], exec
; GCN-NEXT:    s_cselect_b32 s4, s3, s11
; GCN-NEXT:    s_cselect_b32 s5, s2, s11
; GCN-NEXT:    s_ashr_i32 s8, s7, 31
; GCN-NEXT:    s_ashr_i64 s[2:3], s[6:7], s12
; GCN-NEXT:    s_and_b64 s[0:1], s[0:1], exec
; GCN-NEXT:    s_cselect_b32 s0, s3, s8
; GCN-NEXT:    s_cselect_b32 s1, s2, s8
; GCN-NEXT:    v_mov_b32_e32 v0, s10
; GCN-NEXT:    v_mov_b32_e32 v1, s13
; GCN-NEXT:    v_mov_b32_e32 v2, s1
; GCN-NEXT:    v_mov_b32_e32 v3, s0
; GCN-NEXT:    flat_store_dwordx4 v[6:7], v[0:3]
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    v_mov_b32_e32 v0, s22
; GCN-NEXT:    v_mov_b32_e32 v1, s9
; GCN-NEXT:    v_mov_b32_e32 v2, s5
; GCN-NEXT:    v_mov_b32_e32 v3, s4
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
  %shift = ashr <2 x i128> %lhs, %rhs
  store <2 x i128> %shift, ptr addrspace(1) null
  ret void
}
