; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 -stop-after=amdgpu-isel < %s | FileCheck %s

@external_constant1 = external addrspace(4) constant float, align 4
@external_constant2 = external addrspace(1) constant float, align 4
@const.ptr = external addrspace(4) constant ptr, align 4

define void @test() {
  ; CHECK-LABEL: name: test
  ; CHECK: bb.0.entry:
  ; CHECK-NEXT:   successors: %bb.1(0x30000000), %bb.3(0x50000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[SI_PC_ADD_REL_OFFSET:%[0-9]+]]:sreg_64 = SI_PC_ADD_REL_OFFSET target-flags(amdgpu-gotprel32-lo) @external_constant1, target-flags(amdgpu-gotprel32-hi) @external_constant1, implicit-def dead $scc
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM:%[0-9]+]]:sreg_64_xexec = S_LOAD_DWORDX2_IMM killed [[SI_PC_ADD_REL_OFFSET]], 0, 0 :: (dereferenceable invariant load (s64) from got, addrspace 4)
  ; CHECK-NEXT:   [[S_LOAD_DWORD_IMM:%[0-9]+]]:sreg_32_xm0_xexec = S_LOAD_DWORD_IMM killed [[S_LOAD_DWORDX2_IMM]], 0, 0 :: (dereferenceable invariant load (s32) from @external_constant1, addrspace 4)
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sgpr_32 = S_MOV_B32 0
  ; CHECK-NEXT:   nofpexcept S_CMP_LG_F32 killed [[S_LOAD_DWORD_IMM]], killed [[S_MOV_B32_]], implicit-def $scc, implicit $mode
  ; CHECK-NEXT:   S_CBRANCH_SCC1 %bb.3, implicit $scc
  ; CHECK-NEXT:   S_BRANCH %bb.1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.1.bb1:
  ; CHECK-NEXT:   successors: %bb.2(0x40000000), %bb.4(0x40000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[SI_PC_ADD_REL_OFFSET1:%[0-9]+]]:sreg_64 = SI_PC_ADD_REL_OFFSET target-flags(amdgpu-gotprel32-lo) @const.ptr, target-flags(amdgpu-gotprel32-hi) @const.ptr, implicit-def dead $scc
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM1:%[0-9]+]]:sreg_64_xexec = S_LOAD_DWORDX2_IMM killed [[SI_PC_ADD_REL_OFFSET1]], 0, 0 :: (dereferenceable invariant load (s64) from got, addrspace 4)
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM2:%[0-9]+]]:sreg_64_xexec_xnull = S_LOAD_DWORDX2_IMM killed [[S_LOAD_DWORDX2_IMM1]], 0, 0 :: (invariant load (s64) from @const.ptr, addrspace 4)
  ; CHECK-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; CHECK-NEXT:   [[GLOBAL_LOAD_DWORD_SADDR:%[0-9]+]]:vgpr_32 = GLOBAL_LOAD_DWORD_SADDR killed [[S_LOAD_DWORDX2_IMM2]], killed [[V_MOV_B32_e32_]], 0, 0, implicit $exec :: (load (s32) from %ir.0, addrspace 1)
  ; CHECK-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sgpr_32 = S_MOV_B32 1092616192
  ; CHECK-NEXT:   [[S_MOV_B32_2:%[0-9]+]]:sgpr_32 = S_MOV_B32 1065353216
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY [[GLOBAL_LOAD_DWORD_SADDR]]
  ; CHECK-NEXT:   nofpexcept S_CMP_LT_F32 killed [[COPY]], killed [[S_MOV_B32_2]], implicit-def $scc, implicit $mode
  ; CHECK-NEXT:   S_CBRANCH_SCC1 %bb.4, implicit $scc
  ; CHECK-NEXT:   S_BRANCH %bb.2
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.2.bb2:
  ; CHECK-NEXT:   successors: %bb.4(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[S_MOV_B32_3:%[0-9]+]]:sgpr_32 = S_MOV_B32 0
  ; CHECK-NEXT:   S_BRANCH %bb.4
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.3.Flow1:
  ; CHECK-NEXT:   successors: %bb.7(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   S_BRANCH %bb.7
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.4.bb3:
  ; CHECK-NEXT:   successors: %bb.5(0x50000000), %bb.6(0x30000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[PHI:%[0-9]+]]:sgpr_32 = PHI [[S_MOV_B32_1]], %bb.1, [[S_MOV_B32_3]], %bb.2
  ; CHECK-NEXT:   [[S_MOV_B32_4:%[0-9]+]]:sgpr_32 = S_MOV_B32 0
  ; CHECK-NEXT:   nofpexcept S_CMP_NEQ_F32 [[PHI]], killed [[S_MOV_B32_4]], implicit-def $scc, implicit $mode
  ; CHECK-NEXT:   S_CBRANCH_SCC1 %bb.6, implicit $scc
  ; CHECK-NEXT:   S_BRANCH %bb.5
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.5.bb4:
  ; CHECK-NEXT:   successors: %bb.6(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[SI_PC_ADD_REL_OFFSET2:%[0-9]+]]:sreg_64 = SI_PC_ADD_REL_OFFSET target-flags(amdgpu-gotprel32-lo) @external_constant2, target-flags(amdgpu-gotprel32-hi) @external_constant2, implicit-def dead $scc
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM3:%[0-9]+]]:sreg_64_xexec_xnull = S_LOAD_DWORDX2_IMM killed [[SI_PC_ADD_REL_OFFSET2]], 0, 0 :: (dereferenceable invariant load (s64) from got, addrspace 4)
  ; CHECK-NEXT:   [[V_MOV_B32_e32_1:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; CHECK-NEXT:   [[V_MOV_B32_e32_2:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 1082130432, implicit $exec
  ; CHECK-NEXT:   GLOBAL_STORE_DWORD_SADDR killed [[V_MOV_B32_e32_1]], killed [[V_MOV_B32_e32_2]], killed [[S_LOAD_DWORDX2_IMM3]], 0, 0, implicit $exec :: (store (s32) into @external_constant2, addrspace 1)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.6.Flow:
  ; CHECK-NEXT:   successors: %bb.3(0x80000000)
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   S_BRANCH %bb.3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT: bb.7.bb5:
  ; CHECK-NEXT:   SI_RETURN
entry:
  %ld1 = load float, ptr addrspace(4) @external_constant1
  %cmp1 = fcmp one float %ld1, 0.0
  br i1 %cmp1, label %bb5, label %bb1, !amdgpu.uniform !0

bb1:
  %ptr = load ptr, ptr addrspace(4) @const.ptr
  %ld2 = load float, ptr %ptr, align 4
  %cmp2 = fcmp olt float %ld2, 1.0
  %or = or i1 %cmp2, false
  br i1 %or, label %bb3, label %bb2, !amdgpu.uniform !0

bb2:
  br label %bb3

bb3:
  %phi = phi float [ 10.0, %bb1 ], [ 0.0, %bb2 ]
  %cmp3 = fcmp oeq float %phi, 0.0
  br i1 %cmp3, label %bb4, label %bb5, !amdgpu.uniform !0

bb4:
  store float 4.0, ptr addrspace(1) @external_constant2
  br label %bb5

bb5:
  ret void
}

!0 = !{}