; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -mtriple=amdgcn-- -passes=amdgpu-atomic-optimizer %s | FileCheck -check-prefix=IR %s
; RUN: llc -global-isel -mtriple=amdgcn-- -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

declare i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32, <4 x i32>, i32, i32, i32, i32 immarg)
declare i32 @llvm.amdgcn.struct.buffer.atomic.sub.i32(i32, <4 x i32>, i32, i32, i32, i32 immarg)
declare i32 @llvm.amdgcn.struct.buffer.atomic.xor.i32(i32, <4 x i32>, i32, i32, i32, i32 immarg)
declare void @llvm.amdgcn.struct.buffer.store.format.v4i32(<4 x i32>, <4 x i32>, i32, i32, i32, i32 immarg)

declare i32 @llvm.amdgcn.struct.ptr.buffer.atomic.add.i32(i32, ptr addrspace(8), i32, i32, i32, i32 immarg)
declare i32 @llvm.amdgcn.struct.ptr.buffer.atomic.sub.i32(i32, ptr addrspace (8), i32, i32, i32, i32 immarg)
declare i32 @llvm.amdgcn.struct.ptr.buffer.atomic.xor.i32(i32, ptr addrspace(8), i32, i32, i32, i32 immarg)
declare void @llvm.amdgcn.struct.ptr.buffer.store.format.v4i32(<4 x i32>, ptr addrspace(8), i32, i32, i32, i32 immarg)


define amdgpu_cs void @atomic_add(<4 x i32> inreg %arg)  {
; IR-LABEL: define amdgpu_cs void @atomic_add(
; IR-SAME: <4 x i32> inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP8]], label %[[BB9:.*]], label %[[BB11:.*]]
; IR:       [[BB9]]:
; IR-NEXT:    [[TMP10:%.*]] = call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 [[TMP7]], <4 x i32> [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB11]]
; IR:       [[BB11]]:
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_add:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[4:5], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s4, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s5, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], vcc
; GCN-NEXT:    s_cbranch_execz .LBB0_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s4, s[4:5]
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    buffer_atomic_add v1, v0, s[0:3], 0 idxen
; GCN-NEXT:  .LBB0_2:
; GCN-NEXT:    s_endpgm
.entry:
  call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 1, <4 x i32> %arg, i32 0, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_add_and_format(<4 x i32> inreg %arg) {
; IR-LABEL: define amdgpu_cs void @atomic_add_and_format(
; IR-SAME: <4 x i32> inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP8]], label %[[TMP9:.*]], label %[[BB11:.*]]
; IR:       [[TMP9]]:
; IR-NEXT:    [[TMP10:%.*]] = call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 [[TMP7]], <4 x i32> [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB11]]
; IR:       [[BB11]]:
; IR-NEXT:    [[TMP12:%.*]] = phi i32 [ poison, [[DOTENTRY:%.*]] ], [ [[TMP10]], %[[TMP9]] ]
; IR-NEXT:    [[TMP13:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[TMP12]])
; IR-NEXT:    [[TMP14:%.*]] = add i32 [[TMP13]], [[TMP5]]
; IR-NEXT:    call void @llvm.amdgcn.struct.buffer.store.format.v4i32(<4 x i32> [[ARG]], <4 x i32> [[ARG]], i32 [[TMP14]], i32 0, i32 0, i32 0)
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_add_and_format:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[6:7], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s6, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s7, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    ; implicit-def: $vgpr1
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execz .LBB1_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s6, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    buffer_atomic_add v1, v2, s[0:3], 0 idxen glc
; GCN-NEXT:  .LBB1_2:
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readfirstlane_b32 s4, v1
; GCN-NEXT:    v_add_i32_e32 v4, vcc, s4, v0
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v3, s3
; GCN-NEXT:    buffer_store_format_xyzw v[0:3], v4, s[0:3], 0 idxen
; GCN-NEXT:    s_endpgm
.entry:
  %a = call i32 @llvm.amdgcn.struct.buffer.atomic.add.i32(i32 1, <4 x i32> %arg, i32 0, i32 0, i32 0, i32 0)
  call void @llvm.amdgcn.struct.buffer.store.format.v4i32(<4 x i32> %arg, <4 x i32> %arg, i32 %a, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_sub(<4 x i32> inreg %arg)  {
; IR-LABEL: define amdgpu_cs void @atomic_sub(
; IR-SAME: <4 x i32> inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP8]], label %[[BB9:.*]], label %[[BB11:.*]]
; IR:       [[BB9]]:
; IR-NEXT:    [[TMP10:%.*]] = call i32 @llvm.amdgcn.struct.buffer.atomic.sub.i32(i32 [[TMP7]], <4 x i32> [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB11]]
; IR:       [[BB11]]:
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_sub:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[4:5], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s4, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s5, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], vcc
; GCN-NEXT:    s_cbranch_execz .LBB2_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s4, s[4:5]
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    buffer_atomic_sub v1, v0, s[0:3], 0 idxen
; GCN-NEXT:  .LBB2_2:
; GCN-NEXT:    s_endpgm
.entry:
  call i32 @llvm.amdgcn.struct.buffer.atomic.sub.i32(i32 1, <4 x i32> %arg, i32 0, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_sub_and_format(<4 x i32> inreg %arg) {
; IR-LABEL: define amdgpu_cs void @atomic_sub_and_format(
; IR-SAME: <4 x i32> inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP8]], label %[[TMP9:.*]], label %[[BB11:.*]]
; IR:       [[TMP9]]:
; IR-NEXT:    [[TMP10:%.*]] = call i32 @llvm.amdgcn.struct.buffer.atomic.sub.i32(i32 [[TMP7]], <4 x i32> [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB11]]
; IR:       [[BB11]]:
; IR-NEXT:    [[TMP12:%.*]] = phi i32 [ poison, [[DOTENTRY:%.*]] ], [ [[TMP10]], %[[TMP9]] ]
; IR-NEXT:    [[TMP13:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[TMP12]])
; IR-NEXT:    [[TMP14:%.*]] = sub i32 [[TMP13]], [[TMP5]]
; IR-NEXT:    call void @llvm.amdgcn.struct.buffer.store.format.v4i32(<4 x i32> [[ARG]], <4 x i32> [[ARG]], i32 [[TMP14]], i32 0, i32 0, i32 0)
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_sub_and_format:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[6:7], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s6, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s7, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    ; implicit-def: $vgpr1
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execz .LBB3_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s6, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    buffer_atomic_sub v1, v2, s[0:3], 0 idxen glc
; GCN-NEXT:  .LBB3_2:
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readfirstlane_b32 s4, v1
; GCN-NEXT:    v_sub_i32_e32 v4, vcc, s4, v0
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v3, s3
; GCN-NEXT:    buffer_store_format_xyzw v[0:3], v4, s[0:3], 0 idxen
; GCN-NEXT:    s_endpgm
.entry:
  %a = call i32 @llvm.amdgcn.struct.buffer.atomic.sub.i32(i32 1, <4 x i32> %arg, i32 0, i32 0, i32 0, i32 0)
  call void @llvm.amdgcn.struct.buffer.store.format.v4i32(<4 x i32> %arg, <4 x i32> %arg, i32 %a, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_xor(<4 x i32> inreg %arg)  {
; IR-LABEL: define amdgpu_cs void @atomic_xor(
; IR-SAME: <4 x i32> inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = and i32 [[TMP7]], 1
; IR-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP9]], label %[[BB10:.*]], label %[[BB12:.*]]
; IR:       [[BB10]]:
; IR-NEXT:    [[TMP11:%.*]] = call i32 @llvm.amdgcn.struct.buffer.atomic.xor.i32(i32 [[TMP8]], <4 x i32> [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB12]]
; IR:       [[BB12]]:
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_xor:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[4:5], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s4, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s5, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], vcc
; GCN-NEXT:    s_cbranch_execz .LBB4_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s4, s[4:5]
; GCN-NEXT:    s_and_b32 s4, s4, 1
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    buffer_atomic_xor v1, v0, s[0:3], 0 idxen
; GCN-NEXT:  .LBB4_2:
; GCN-NEXT:    s_endpgm
.entry:
  call i32 @llvm.amdgcn.struct.buffer.atomic.xor.i32(i32 1, <4 x i32> %arg, i32 0, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_xor_and_format(<4 x i32> inreg %arg) {
; IR-LABEL: define amdgpu_cs void @atomic_xor_and_format(
; IR-SAME: <4 x i32> inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = and i32 [[TMP7]], 1
; IR-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP9]], label %[[TMP10:.*]], label %[[BB12:.*]]
; IR:       [[TMP10]]:
; IR-NEXT:    [[TMP11:%.*]] = call i32 @llvm.amdgcn.struct.buffer.atomic.xor.i32(i32 [[TMP8]], <4 x i32> [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB12]]
; IR:       [[BB12]]:
; IR-NEXT:    [[TMP13:%.*]] = phi i32 [ poison, [[DOTENTRY:%.*]] ], [ [[TMP11]], %[[TMP10]] ]
; IR-NEXT:    [[TMP14:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[TMP13]])
; IR-NEXT:    [[TMP15:%.*]] = and i32 [[TMP5]], 1
; IR-NEXT:    [[TMP16:%.*]] = xor i32 [[TMP14]], [[TMP15]]
; IR-NEXT:    call void @llvm.amdgcn.struct.buffer.store.format.v4i32(<4 x i32> [[ARG]], <4 x i32> [[ARG]], i32 [[TMP16]], i32 0, i32 0, i32 0)
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_xor_and_format:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[6:7], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s6, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s7, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    ; implicit-def: $vgpr1
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execz .LBB5_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s6, s[6:7]
; GCN-NEXT:    s_and_b32 s6, s6, 1
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    buffer_atomic_xor v1, v2, s[0:3], 0 idxen glc
; GCN-NEXT:  .LBB5_2:
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readfirstlane_b32 s4, v1
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_xor_b32_e32 v4, s4, v0
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v3, s3
; GCN-NEXT:    buffer_store_format_xyzw v[0:3], v4, s[0:3], 0 idxen
; GCN-NEXT:    s_endpgm
.entry:
  %a = call i32 @llvm.amdgcn.struct.buffer.atomic.xor.i32(i32 1, <4 x i32> %arg, i32 0, i32 0, i32 0, i32 0)
  call void @llvm.amdgcn.struct.buffer.store.format.v4i32(<4 x i32> %arg, <4 x i32> %arg, i32 %a, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_ptr_add(ptr addrspace(8) inreg %arg)  {
; IR-LABEL: define amdgpu_cs void @atomic_ptr_add(
; IR-SAME: ptr addrspace(8) inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP8]], label %[[BB9:.*]], label %[[BB11:.*]]
; IR:       [[BB9]]:
; IR-NEXT:    [[TMP10:%.*]] = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.add.i32(i32 [[TMP7]], ptr addrspace(8) [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB11]]
; IR:       [[BB11]]:
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_ptr_add:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[4:5], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s4, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s5, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], vcc
; GCN-NEXT:    s_cbranch_execz .LBB6_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s4, s[4:5]
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    buffer_atomic_add v1, v0, s[0:3], 0 idxen
; GCN-NEXT:  .LBB6_2:
; GCN-NEXT:    s_endpgm
.entry:
  call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.add.i32(i32 1, ptr addrspace(8) %arg, i32 0, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_ptr_add_and_format(ptr addrspace(8) inreg %arg) {
; IR-LABEL: define amdgpu_cs void @atomic_ptr_add_and_format(
; IR-SAME: ptr addrspace(8) inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP8]], label %[[TMP9:.*]], label %[[BB11:.*]]
; IR:       [[TMP9]]:
; IR-NEXT:    [[TMP10:%.*]] = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.add.i32(i32 [[TMP7]], ptr addrspace(8) [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB11]]
; IR:       [[BB11]]:
; IR-NEXT:    [[TMP12:%.*]] = phi i32 [ poison, [[DOTENTRY:%.*]] ], [ [[TMP10]], %[[TMP9]] ]
; IR-NEXT:    [[TMP13:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[TMP12]])
; IR-NEXT:    [[TMP14:%.*]] = add i32 [[TMP13]], [[TMP5]]
; IR-NEXT:    [[ARG_INT:%.*]] = ptrtoint ptr addrspace(8) [[ARG]] to i128
; IR-NEXT:    [[ARG_VEC:%.*]] = bitcast i128 [[ARG_INT]] to <4 x i32>
; IR-NEXT:    call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4i32(<4 x i32> [[ARG_VEC]], ptr addrspace(8) [[ARG]], i32 [[TMP14]], i32 0, i32 0, i32 0)
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_ptr_add_and_format:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[6:7], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s6, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s7, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    ; implicit-def: $vgpr1
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execz .LBB7_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s6, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    buffer_atomic_add v1, v2, s[0:3], 0 idxen glc
; GCN-NEXT:  .LBB7_2:
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readfirstlane_b32 s4, v1
; GCN-NEXT:    v_add_i32_e32 v4, vcc, s4, v0
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v3, s3
; GCN-NEXT:    buffer_store_format_xyzw v[0:3], v4, s[0:3], 0 idxen
; GCN-NEXT:    s_endpgm
.entry:
  %a = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.add.i32(i32 1, ptr addrspace(8) %arg, i32 0, i32 0, i32 0, i32 0)
  %arg.int = ptrtoint ptr addrspace(8) %arg to i128
  %arg.vec = bitcast i128 %arg.int to <4 x i32>
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4i32(<4 x i32> %arg.vec, ptr addrspace(8) %arg, i32 %a, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_ptr_sub(ptr addrspace(8) inreg %arg)  {
; IR-LABEL: define amdgpu_cs void @atomic_ptr_sub(
; IR-SAME: ptr addrspace(8) inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP8]], label %[[BB9:.*]], label %[[BB11:.*]]
; IR:       [[BB9]]:
; IR-NEXT:    [[TMP10:%.*]] = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.sub.i32(i32 [[TMP7]], ptr addrspace(8) [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB11]]
; IR:       [[BB11]]:
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_ptr_sub:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[4:5], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s4, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s5, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], vcc
; GCN-NEXT:    s_cbranch_execz .LBB8_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s4, s[4:5]
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    buffer_atomic_sub v1, v0, s[0:3], 0 idxen
; GCN-NEXT:  .LBB8_2:
; GCN-NEXT:    s_endpgm
.entry:
  call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.sub.i32(i32 1, ptr addrspace(8) %arg, i32 0, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_ptr_sub_and_format(ptr addrspace(8) inreg %arg) {
; IR-LABEL: define amdgpu_cs void @atomic_ptr_sub_and_format(
; IR-SAME: ptr addrspace(8) inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP8]], label %[[TMP9:.*]], label %[[BB11:.*]]
; IR:       [[TMP9]]:
; IR-NEXT:    [[TMP10:%.*]] = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.sub.i32(i32 [[TMP7]], ptr addrspace(8) [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB11]]
; IR:       [[BB11]]:
; IR-NEXT:    [[TMP12:%.*]] = phi i32 [ poison, [[DOTENTRY:%.*]] ], [ [[TMP10]], %[[TMP9]] ]
; IR-NEXT:    [[TMP13:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[TMP12]])
; IR-NEXT:    [[TMP14:%.*]] = sub i32 [[TMP13]], [[TMP5]]
; IR-NEXT:    [[ARG_INT:%.*]] = ptrtoint ptr addrspace(8) [[ARG]] to i128
; IR-NEXT:    [[ARG_VEC:%.*]] = bitcast i128 [[ARG_INT]] to <4 x i32>
; IR-NEXT:    call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4i32(<4 x i32> [[ARG_VEC]], ptr addrspace(8) [[ARG]], i32 [[TMP14]], i32 0, i32 0, i32 0)
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_ptr_sub_and_format:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[6:7], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s6, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s7, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    ; implicit-def: $vgpr1
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execz .LBB9_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s6, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    buffer_atomic_sub v1, v2, s[0:3], 0 idxen glc
; GCN-NEXT:  .LBB9_2:
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readfirstlane_b32 s4, v1
; GCN-NEXT:    v_sub_i32_e32 v4, vcc, s4, v0
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v3, s3
; GCN-NEXT:    buffer_store_format_xyzw v[0:3], v4, s[0:3], 0 idxen
; GCN-NEXT:    s_endpgm
.entry:
  %a = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.sub.i32(i32 1, ptr addrspace(8) %arg, i32 0, i32 0, i32 0, i32 0)
  %arg.int = ptrtoint ptr addrspace(8) %arg to i128
  %arg.vec = bitcast i128 %arg.int to <4 x i32>
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4i32(<4 x i32> %arg.vec, ptr addrspace(8) %arg, i32 %a, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_ptr_xor(ptr addrspace(8) inreg %arg)  {
; IR-LABEL: define amdgpu_cs void @atomic_ptr_xor(
; IR-SAME: ptr addrspace(8) inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = and i32 [[TMP7]], 1
; IR-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP9]], label %[[BB10:.*]], label %[[BB12:.*]]
; IR:       [[BB10]]:
; IR-NEXT:    [[TMP11:%.*]] = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.xor.i32(i32 [[TMP8]], ptr addrspace(8) [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB12]]
; IR:       [[BB12]]:
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_ptr_xor:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[4:5], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s4, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s5, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    s_and_saveexec_b64 s[6:7], vcc
; GCN-NEXT:    s_cbranch_execz .LBB10_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s4, s[4:5]
; GCN-NEXT:    s_and_b32 s4, s4, 1
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    buffer_atomic_xor v1, v0, s[0:3], 0 idxen
; GCN-NEXT:  .LBB10_2:
; GCN-NEXT:    s_endpgm
.entry:
  call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.xor.i32(i32 1, ptr addrspace(8) %arg, i32 0, i32 0, i32 0, i32 0)
  ret void
}

define amdgpu_cs void @atomic_ptr_xor_and_format(ptr addrspace(8) inreg %arg) {
; IR-LABEL: define amdgpu_cs void @atomic_ptr_xor_and_format(
; IR-SAME: ptr addrspace(8) inreg [[ARG:%.*]]) {
; IR-NEXT:  [[_ENTRY:.*:]]
; IR-NEXT:    [[TMP0:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 true)
; IR-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; IR-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0]], 32
; IR-NEXT:    [[TMP3:%.*]] = trunc i64 [[TMP2]] to i32
; IR-NEXT:    [[TMP4:%.*]] = call i32 @llvm.amdgcn.mbcnt.lo(i32 [[TMP1]], i32 0)
; IR-NEXT:    [[TMP5:%.*]] = call i32 @llvm.amdgcn.mbcnt.hi(i32 [[TMP3]], i32 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = call i64 @llvm.ctpop.i64(i64 [[TMP0]])
; IR-NEXT:    [[TMP7:%.*]] = trunc i64 [[TMP6]] to i32
; IR-NEXT:    [[TMP8:%.*]] = and i32 [[TMP7]], 1
; IR-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP5]], 0
; IR-NEXT:    br i1 [[TMP9]], label %[[TMP10:.*]], label %[[BB12:.*]]
; IR:       [[TMP10]]:
; IR-NEXT:    [[TMP11:%.*]] = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.xor.i32(i32 [[TMP8]], ptr addrspace(8) [[ARG]], i32 0, i32 0, i32 0, i32 0)
; IR-NEXT:    br label %[[BB12]]
; IR:       [[BB12]]:
; IR-NEXT:    [[TMP13:%.*]] = phi i32 [ poison, [[DOTENTRY:%.*]] ], [ [[TMP11]], %[[TMP10]] ]
; IR-NEXT:    [[TMP14:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[TMP13]])
; IR-NEXT:    [[TMP15:%.*]] = and i32 [[TMP5]], 1
; IR-NEXT:    [[TMP16:%.*]] = xor i32 [[TMP14]], [[TMP15]]
; IR-NEXT:    [[ARG_INT:%.*]] = ptrtoint ptr addrspace(8) [[ARG]] to i128
; IR-NEXT:    [[ARG_VEC:%.*]] = bitcast i128 [[ARG_INT]] to <4 x i32>
; IR-NEXT:    call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4i32(<4 x i32> [[ARG_VEC]], ptr addrspace(8) [[ARG]], i32 [[TMP16]], i32 0, i32 0, i32 0)
; IR-NEXT:    ret void
;
; GCN-LABEL: atomic_ptr_xor_and_format:
; GCN:       ; %bb.0: ; %.entry
; GCN-NEXT:    s_mov_b64 s[6:7], exec
; GCN-NEXT:    v_mbcnt_lo_u32_b32_e64 v0, s6, 0
; GCN-NEXT:    v_mbcnt_hi_u32_b32_e32 v0, s7, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v0
; GCN-NEXT:    ; implicit-def: $vgpr1
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execz .LBB11_2
; GCN-NEXT:  ; %bb.1:
; GCN-NEXT:    s_bcnt1_i32_b64 s6, s[6:7]
; GCN-NEXT:    s_and_b32 s6, s6, 1
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    buffer_atomic_xor v1, v2, s[0:3], 0 idxen glc
; GCN-NEXT:  .LBB11_2:
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readfirstlane_b32 s4, v1
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_xor_b32_e32 v4, s4, v0
; GCN-NEXT:    s_waitcnt expcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_mov_b32_e32 v1, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v3, s3
; GCN-NEXT:    buffer_store_format_xyzw v[0:3], v4, s[0:3], 0 idxen
; GCN-NEXT:    s_endpgm
.entry:
  %a = call i32 @llvm.amdgcn.struct.ptr.buffer.atomic.xor.i32(i32 1, ptr addrspace(8) %arg, i32 0, i32 0, i32 0, i32 0)
  %arg.int = ptrtoint ptr addrspace(8) %arg to i128
  %arg.vec = bitcast i128 %arg.int to <4 x i32>
  call void @llvm.amdgcn.struct.ptr.buffer.store.format.v4i32(<4 x i32> %arg.vec, ptr addrspace(8) %arg, i32 %a, i32 0, i32 0, i32 0)
  ret void
}