; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 5
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx90a -verify-machineinstrs -stop-after=instruction-select < %s | FileCheck --check-prefix=GFX9 %s

define ptr @buffer_load_p0(ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_load_p0
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX9-NEXT:   [[BUFFER_LOAD_DWORDX2_OFFSET:%[0-9]+]]:vreg_64_align2 = BUFFER_LOAD_DWORDX2_OFFSET [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable load (s64) from %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX2_OFFSET]].sub0
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX2_OFFSET]].sub1
  ; GFX9-NEXT:   $vgpr0 = COPY [[COPY4]]
  ; GFX9-NEXT:   $vgpr1 = COPY [[COPY5]]
  ; GFX9-NEXT:   SI_RETURN implicit $vgpr0, implicit $vgpr1
  %ret = call ptr @llvm.amdgcn.raw.ptr.buffer.load.p0(ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret ptr %ret
}

define void @buffer_store_p0(ptr %data, ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_store_p0
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19, $vgpr0, $vgpr1
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY5]], %subreg.sub3
  ; GFX9-NEXT:   BUFFER_STORE_DWORDX2_OFFSET_exact [[REG_SEQUENCE]], [[REG_SEQUENCE1]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable store (s64) into %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   SI_RETURN
  call void @llvm.amdgcn.raw.ptr.buffer.store.p0(ptr %data, ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret void
}

define ptr addrspace(1) @buffer_load_p1(ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_load_p1
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX9-NEXT:   [[BUFFER_LOAD_DWORDX2_OFFSET:%[0-9]+]]:vreg_64_align2 = BUFFER_LOAD_DWORDX2_OFFSET [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable load (s64) from %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX2_OFFSET]].sub0
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX2_OFFSET]].sub1
  ; GFX9-NEXT:   $vgpr0 = COPY [[COPY4]]
  ; GFX9-NEXT:   $vgpr1 = COPY [[COPY5]]
  ; GFX9-NEXT:   SI_RETURN implicit $vgpr0, implicit $vgpr1
  %ret = call ptr addrspace(1) @llvm.amdgcn.raw.ptr.buffer.load.p1(ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret ptr addrspace(1) %ret
}

define void @buffer_store_p1(ptr addrspace(1) %data, ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_store_p1
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19, $vgpr0, $vgpr1
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY5]], %subreg.sub3
  ; GFX9-NEXT:   BUFFER_STORE_DWORDX2_OFFSET_exact [[REG_SEQUENCE]], [[REG_SEQUENCE1]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable store (s64) into %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   SI_RETURN
  call void @llvm.amdgcn.raw.ptr.buffer.store.p1(ptr addrspace(1) %data, ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret void
}

define ptr addrspace(4) @buffer_load_p4(ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_load_p4
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX9-NEXT:   [[BUFFER_LOAD_DWORDX2_OFFSET:%[0-9]+]]:vreg_64_align2 = BUFFER_LOAD_DWORDX2_OFFSET [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable load (s64) from %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX2_OFFSET]].sub0
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX2_OFFSET]].sub1
  ; GFX9-NEXT:   $vgpr0 = COPY [[COPY4]]
  ; GFX9-NEXT:   $vgpr1 = COPY [[COPY5]]
  ; GFX9-NEXT:   SI_RETURN implicit $vgpr0, implicit $vgpr1
  %ret = call ptr addrspace(4) @llvm.amdgcn.raw.ptr.buffer.load.p4(ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret ptr addrspace(4) %ret
}

define void @buffer_store_p4(ptr addrspace(4) %data, ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_store_p4
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19, $vgpr0, $vgpr1
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1, [[COPY4]], %subreg.sub2, [[COPY5]], %subreg.sub3
  ; GFX9-NEXT:   BUFFER_STORE_DWORDX2_OFFSET_exact [[REG_SEQUENCE]], [[REG_SEQUENCE1]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable store (s64) into %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   SI_RETURN
  call void @llvm.amdgcn.raw.ptr.buffer.store.p4(ptr addrspace(4) %data, ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret void
}

define ptr addrspace(5) @buffer_load_p5(ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_load_p5
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX9-NEXT:   [[BUFFER_LOAD_DWORD_OFFSET:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_DWORD_OFFSET [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable load (s32) from %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   $vgpr0 = COPY [[BUFFER_LOAD_DWORD_OFFSET]]
  ; GFX9-NEXT:   SI_RETURN implicit $vgpr0
  %ret = call ptr addrspace(5) @llvm.amdgcn.raw.ptr.buffer.load.p5(ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret ptr addrspace(5) %ret
}

define void @buffer_store_p5(ptr addrspace(5) %data, ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_store_p5
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19, $vgpr0
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY1]], %subreg.sub0, [[COPY2]], %subreg.sub1, [[COPY3]], %subreg.sub2, [[COPY4]], %subreg.sub3
  ; GFX9-NEXT:   BUFFER_STORE_DWORD_OFFSET_exact [[COPY]], [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable store (s32) into %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   SI_RETURN
  call void @llvm.amdgcn.raw.ptr.buffer.store.p5(ptr addrspace(5) %data, ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret void
}

define <2 x ptr addrspace(1)> @buffer_load_v2p1(ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_load_v2p1
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX9-NEXT:   [[BUFFER_LOAD_DWORDX4_OFFSET:%[0-9]+]]:vreg_128_align2 = BUFFER_LOAD_DWORDX4_OFFSET [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable load (<2 x s64>) from %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX4_OFFSET]].sub0
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX4_OFFSET]].sub1
  ; GFX9-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX4_OFFSET]].sub2
  ; GFX9-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX4_OFFSET]].sub3
  ; GFX9-NEXT:   $vgpr0 = COPY [[COPY4]]
  ; GFX9-NEXT:   $vgpr1 = COPY [[COPY5]]
  ; GFX9-NEXT:   $vgpr2 = COPY [[COPY6]]
  ; GFX9-NEXT:   $vgpr3 = COPY [[COPY7]]
  ; GFX9-NEXT:   SI_RETURN implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %ret = call <2 x ptr addrspace(1)> @llvm.amdgcn.raw.ptr.buffer.load.v2p1(ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret <2 x ptr addrspace(1)> %ret
}

define void @buffer_store_v2p5(<2 x ptr addrspace(1)> %data, ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_store_v2p5
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1
  ; GFX9-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64_align2 = REG_SEQUENCE [[COPY2]], %subreg.sub0, [[COPY3]], %subreg.sub1
  ; GFX9-NEXT:   [[REG_SEQUENCE2:%[0-9]+]]:vreg_128_align2 = REG_SEQUENCE [[REG_SEQUENCE]], %subreg.sub0_sub1, [[REG_SEQUENCE1]], %subreg.sub2_sub3
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1, [[COPY6]], %subreg.sub2, [[COPY7]], %subreg.sub3
  ; GFX9-NEXT:   BUFFER_STORE_DWORDX4_OFFSET_exact [[REG_SEQUENCE2]], [[REG_SEQUENCE3]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable store (<2 x s64>) into %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   SI_RETURN
  call void @llvm.amdgcn.raw.ptr.buffer.store.v2p1(<2 x ptr addrspace(1)> %data, ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret void
}

define <3 x ptr addrspace(5)> @buffer_load_v3p5(ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_load_v3p5
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX9-NEXT:   [[BUFFER_LOAD_DWORDX3_OFFSET:%[0-9]+]]:vreg_96_align2 = BUFFER_LOAD_DWORDX3_OFFSET [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable load (<3 x s32>) from %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX3_OFFSET]].sub0
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX3_OFFSET]].sub1
  ; GFX9-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX3_OFFSET]].sub2
  ; GFX9-NEXT:   $vgpr0 = COPY [[COPY4]]
  ; GFX9-NEXT:   $vgpr1 = COPY [[COPY5]]
  ; GFX9-NEXT:   $vgpr2 = COPY [[COPY6]]
  ; GFX9-NEXT:   SI_RETURN implicit $vgpr0, implicit $vgpr1, implicit $vgpr2
  %ret = call <3 x ptr addrspace(5)> @llvm.amdgcn.raw.ptr.buffer.load.v3p5(ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret <3 x ptr addrspace(5)> %ret
}

define void @buffer_store_v3p5(<3 x ptr addrspace(5)> %data, ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_store_v3p5
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19, $vgpr0, $vgpr1, $vgpr2
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_96_align2 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY3]], %subreg.sub0, [[COPY4]], %subreg.sub1, [[COPY5]], %subreg.sub2, [[COPY6]], %subreg.sub3
  ; GFX9-NEXT:   BUFFER_STORE_DWORDX3_OFFSET_exact [[REG_SEQUENCE]], [[REG_SEQUENCE1]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable store (<3 x s32>) into %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   SI_RETURN
  call void @llvm.amdgcn.raw.ptr.buffer.store.v3p5(<3 x ptr addrspace(5)> %data, ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret void
}

define <4 x ptr addrspace(5)> @buffer_load_v4p5(ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_load_v4p5
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX9-NEXT:   [[BUFFER_LOAD_DWORDX4_OFFSET:%[0-9]+]]:vreg_128_align2 = BUFFER_LOAD_DWORDX4_OFFSET [[REG_SEQUENCE]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable load (<4 x s32>) from %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX4_OFFSET]].sub0
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX4_OFFSET]].sub1
  ; GFX9-NEXT:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX4_OFFSET]].sub2
  ; GFX9-NEXT:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_DWORDX4_OFFSET]].sub3
  ; GFX9-NEXT:   $vgpr0 = COPY [[COPY4]]
  ; GFX9-NEXT:   $vgpr1 = COPY [[COPY5]]
  ; GFX9-NEXT:   $vgpr2 = COPY [[COPY6]]
  ; GFX9-NEXT:   $vgpr3 = COPY [[COPY7]]
  ; GFX9-NEXT:   SI_RETURN implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %ret = call <4 x ptr addrspace(5)> @llvm.amdgcn.raw.ptr.buffer.load.v4p5(ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret <4 x ptr addrspace(5)> %ret
}

define void @buffer_store_v4p5(<4 x ptr addrspace(5)> %data, ptr addrspace(8) inreg %buf) {
  ; GFX9-LABEL: name: buffer_store_v4p5
  ; GFX9: bb.1 (%ir-block.0):
  ; GFX9-NEXT:   liveins: $sgpr16, $sgpr17, $sgpr18, $sgpr19, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; GFX9-NEXT: {{  $}}
  ; GFX9-NEXT:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; GFX9-NEXT:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; GFX9-NEXT:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; GFX9-NEXT:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; GFX9-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128_align2 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; GFX9-NEXT:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr16
  ; GFX9-NEXT:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr17
  ; GFX9-NEXT:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr18
  ; GFX9-NEXT:   [[COPY7:%[0-9]+]]:sreg_32 = COPY $sgpr19
  ; GFX9-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 0
  ; GFX9-NEXT:   [[REG_SEQUENCE1:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1, [[COPY6]], %subreg.sub2, [[COPY7]], %subreg.sub3
  ; GFX9-NEXT:   BUFFER_STORE_DWORDX4_OFFSET_exact [[REG_SEQUENCE]], [[REG_SEQUENCE1]], [[S_MOV_B32_]], 0, 0, 0, implicit $exec :: (dereferenceable store (<4 x s32>) into %ir.buf, align 1, addrspace 8)
  ; GFX9-NEXT:   SI_RETURN
  call void @llvm.amdgcn.raw.ptr.buffer.store.v4p5(<4 x ptr addrspace(5)> %data, ptr addrspace(8) inreg %buf, i32 0, i32 0, i32 0)
  ret void
}