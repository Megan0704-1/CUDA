; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f -verify-machineinstrs | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f,+egpr --show-mc-encoding -verify-machineinstrs | FileCheck %s --check-prefix=EGPR

define dso_local void @test1(ptr%buf) nounwind {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $4056, %rsp # imm = 0xFD8
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movl $64, %eax
; CHECK-NEXT:    movw $8, %bp
; CHECK-NEXT:    tileloadd (%rdi,%rax), %tmm3
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB0_3
; CHECK-NEXT:  # %bb.1: # %loop.header.preheader
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    xorl %r14d, %r14d
; CHECK-NEXT:    movl $32, %r15d
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_2: # %loop.header
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tilestored %tmm3, 3024(%rsp,%rax) # 1024-byte Folded Spill
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq foo
; CHECK-NEXT:    ldtilecfg {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tileloadd 3024(%rsp,%rax), %tmm3 # 1024-byte Folded Reload
; CHECK-NEXT:    tileloadd (%rbx,%r15), %tmm0
; CHECK-NEXT:    tileloadd (%rbx,%r15), %tmm1
; CHECK-NEXT:    tilestored %tmm3, 1024(%rsp,%rax) # 1024-byte Folded Spill
; CHECK-NEXT:    tileloadd 1024(%rsp,%rax), %tmm2 # 1024-byte Folded Reload
; CHECK-NEXT:    tdpbssd %tmm1, %tmm0, %tmm2
; CHECK-NEXT:    tilestored %tmm2, (%rbx,%r15)
; CHECK-NEXT:    incl %r14d
; CHECK-NEXT:    cmpw $100, %r14w
; CHECK-NEXT:    jl .LBB0_2
; CHECK-NEXT:  .LBB0_3: # %exit
; CHECK-NEXT:    addq $4056, %rsp # imm = 0xFD8
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
;
; EGPR-LABEL: test1:
; EGPR:       # %bb.0: # %entry
; EGPR-NEXT:    pushq %rbp # encoding: [0x55]
; EGPR-NEXT:    pushq %r15 # encoding: [0x41,0x57]
; EGPR-NEXT:    pushq %r14 # encoding: [0x41,0x56]
; EGPR-NEXT:    pushq %rbx # encoding: [0x53]
; EGPR-NEXT:    subq $4056, %rsp # encoding: [0x48,0x81,0xec,0xd8,0x0f,0x00,0x00]
; EGPR-NEXT:    # imm = 0xFD8
; EGPR-NEXT:    vxorps %xmm0, %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x57,0xc0]
; EGPR-NEXT:    vmovups %zmm0, {{[0-9]+}}(%rsp) # encoding: [0x62,0xf1,0x7c,0x48,0x11,0x44,0x24,0x0f]
; EGPR-NEXT:    movb $1, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x84,0x24,0xc0,0x03,0x00,0x00,0x01]
; EGPR-NEXT:    movb $8, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x84,0x24,0xf0,0x03,0x00,0x00,0x08]
; EGPR-NEXT:    movw $8, {{[0-9]+}}(%rsp) # encoding: [0x66,0xc7,0x84,0x24,0xd0,0x03,0x00,0x00,0x08,0x00]
; EGPR-NEXT:    movb $8, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x84,0x24,0xf1,0x03,0x00,0x00,0x08]
; EGPR-NEXT:    movw $8, {{[0-9]+}}(%rsp) # encoding: [0x66,0xc7,0x84,0x24,0xd2,0x03,0x00,0x00,0x08,0x00]
; EGPR-NEXT:    movb $8, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x84,0x24,0xf2,0x03,0x00,0x00,0x08]
; EGPR-NEXT:    movw $8, {{[0-9]+}}(%rsp) # encoding: [0x66,0xc7,0x84,0x24,0xd4,0x03,0x00,0x00,0x08,0x00]
; EGPR-NEXT:    movb $8, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x84,0x24,0xf3,0x03,0x00,0x00,0x08]
; EGPR-NEXT:    movw $8, {{[0-9]+}}(%rsp) # encoding: [0x66,0xc7,0x84,0x24,0xd6,0x03,0x00,0x00,0x08,0x00]
; EGPR-NEXT:    ldtilecfg {{[0-9]+}}(%rsp) # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x78,0x49,0x84,0x24,0xc0,0x03,0x00,0x00]
; EGPR-NEXT:    movl $64, %eax # encoding: [0xb8,0x40,0x00,0x00,0x00]
; EGPR-NEXT:    movw $8, %bp # encoding: [0x66,0xbd,0x08,0x00]
; EGPR-NEXT:    tileloadd (%rdi,%rax), %tmm3 # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x7b,0x4b,0x1c,0x07]
; EGPR-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; EGPR-NEXT:    testb %al, %al # encoding: [0x84,0xc0]
; EGPR-NEXT:    jne .LBB0_3 # encoding: [0x75,A]
; EGPR-NEXT:    # fixup A - offset: 1, value: .LBB0_3-1, kind: FK_PCRel_1
; EGPR-NEXT:  # %bb.1: # %loop.header.preheader
; EGPR-NEXT:    movq %rdi, %rbx # encoding: [0x48,0x89,0xfb]
; EGPR-NEXT:    xorl %r14d, %r14d # encoding: [0x45,0x31,0xf6]
; EGPR-NEXT:    movl $32, %r15d # encoding: [0x41,0xbf,0x20,0x00,0x00,0x00]
; EGPR-NEXT:    .p2align 4
; EGPR-NEXT:  .LBB0_2: # %loop.header
; EGPR-NEXT:    # =>This Inner Loop Header: Depth=1
; EGPR-NEXT:    movabsq $64, %rax # encoding: [0x48,0xb8,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
; EGPR-NEXT:    tilestored %tmm3, 3024(%rsp,%rax) # 1024-byte Folded Spill
; EGPR-NEXT:    # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x7a,0x4b,0x9c,0x04,0xd0,0x0b,0x00,0x00]
; EGPR-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; EGPR-NEXT:    callq foo # encoding: [0xe8,A,A,A,A]
; EGPR-NEXT:    # fixup A - offset: 1, value: foo-4, kind: reloc_branch_4byte_pcrel
; EGPR-NEXT:    ldtilecfg {{[0-9]+}}(%rsp) # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x78,0x49,0x84,0x24,0xc0,0x03,0x00,0x00]
; EGPR-NEXT:    movabsq $64, %rax # encoding: [0x48,0xb8,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
; EGPR-NEXT:    tileloadd 3024(%rsp,%rax), %tmm3 # 1024-byte Folded Reload
; EGPR-NEXT:    # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x7b,0x4b,0x9c,0x04,0xd0,0x0b,0x00,0x00]
; EGPR-NEXT:    tileloadd (%rbx,%r15), %tmm0 # EVEX TO VEX Compression encoding: [0xc4,0xa2,0x7b,0x4b,0x04,0x3b]
; EGPR-NEXT:    tileloadd (%rbx,%r15), %tmm1 # EVEX TO VEX Compression encoding: [0xc4,0xa2,0x7b,0x4b,0x0c,0x3b]
; EGPR-NEXT:    tilestored %tmm3, 1024(%rsp,%rax) # 1024-byte Folded Spill
; EGPR-NEXT:    # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x7a,0x4b,0x9c,0x04,0x00,0x04,0x00,0x00]
; EGPR-NEXT:    tileloadd 1024(%rsp,%rax), %tmm2 # 1024-byte Folded Reload
; EGPR-NEXT:    # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x7b,0x4b,0x94,0x04,0x00,0x04,0x00,0x00]
; EGPR-NEXT:    tdpbssd %tmm1, %tmm0, %tmm2 # encoding: [0xc4,0xe2,0x73,0x5e,0xd0]
; EGPR-NEXT:    tilestored %tmm2, (%rbx,%r15) # EVEX TO VEX Compression encoding: [0xc4,0xa2,0x7a,0x4b,0x14,0x3b]
; EGPR-NEXT:    incl %r14d # encoding: [0x41,0xff,0xc6]
; EGPR-NEXT:    cmpw $100, %r14w # encoding: [0x66,0x41,0x83,0xfe,0x64]
; EGPR-NEXT:    jl .LBB0_2 # encoding: [0x7c,A]
; EGPR-NEXT:    # fixup A - offset: 1, value: .LBB0_2-1, kind: FK_PCRel_1
; EGPR-NEXT:  .LBB0_3: # %exit
; EGPR-NEXT:    addq $4056, %rsp # encoding: [0x48,0x81,0xc4,0xd8,0x0f,0x00,0x00]
; EGPR-NEXT:    # imm = 0xFD8
; EGPR-NEXT:    popq %rbx # encoding: [0x5b]
; EGPR-NEXT:    popq %r14 # encoding: [0x41,0x5e]
; EGPR-NEXT:    popq %r15 # encoding: [0x41,0x5f]
; EGPR-NEXT:    popq %rbp # encoding: [0x5d]
; EGPR-NEXT:    tilerelease # encoding: [0xc4,0xe2,0x78,0x49,0xc0]
; EGPR-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; EGPR-NEXT:    retq # encoding: [0xc3]
entry:
  %t1 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 8, ptr %buf, i64 64)
  br i1 undef, label %loop.header, label %exit

loop.header:
  %ivphi = phi i16 [0, %entry], [%iv, %loop.latch]
  call void @foo()
  br label %loop.body

loop.body:
  %t2 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 8, ptr %buf, i64 32)
  %t3 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 8, ptr %buf, i64 32)
  %t4 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 8, i16 8, i16 8, x86_amx %t1, x86_amx %t2, x86_amx %t3)
  tail call void @llvm.x86.tilestored64.internal(i16 8, i16 8, ptr %buf, i64 32, x86_amx %t4)
  br label %loop.latch

loop.latch:
  %iv = add i16 %ivphi, 1
  %c = icmp slt i16 %iv, 100
  br i1 %c, label %loop.header, label %exit

exit:
  ret void
}

define dso_local void @test2(ptr%buf) nounwind {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $72, %rsp
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovups %zmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, %bp
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    jne .LBB1_3
; CHECK-NEXT:  # %bb.1: # %loop.header.preheader
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    xorl %r14d, %r14d
; CHECK-NEXT:    movl $32, %r15d
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB1_2: # %loop.header
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    tilezero %tmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq foo
; CHECK-NEXT:    ldtilecfg {{[0-9]+}}(%rsp)
; CHECK-NEXT:    tilezero %tmm2
; CHECK-NEXT:    tileloadd (%rbx,%r15), %tmm0
; CHECK-NEXT:    tileloadd (%rbx,%r15), %tmm1
; CHECK-NEXT:    tdpbssd %tmm1, %tmm0, %tmm2
; CHECK-NEXT:    tilestored %tmm2, (%rbx,%r15)
; CHECK-NEXT:    incl %r14d
; CHECK-NEXT:    cmpw $100, %r14w
; CHECK-NEXT:    jl .LBB1_2
; CHECK-NEXT:  .LBB1_3: # %exit
; CHECK-NEXT:    addq $72, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
;
; EGPR-LABEL: test2:
; EGPR:       # %bb.0: # %entry
; EGPR-NEXT:    pushq %rbp # encoding: [0x55]
; EGPR-NEXT:    pushq %r15 # encoding: [0x41,0x57]
; EGPR-NEXT:    pushq %r14 # encoding: [0x41,0x56]
; EGPR-NEXT:    pushq %rbx # encoding: [0x53]
; EGPR-NEXT:    subq $72, %rsp # encoding: [0x48,0x83,0xec,0x48]
; EGPR-NEXT:    vxorps %xmm0, %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x57,0xc0]
; EGPR-NEXT:    vmovups %zmm0, {{[0-9]+}}(%rsp) # encoding: [0x62,0xf1,0x7c,0x48,0x11,0x84,0x24,0x08,0x00,0x00,0x00]
; EGPR-NEXT:    movb $1, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x44,0x24,0x08,0x01]
; EGPR-NEXT:    movb $8, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x44,0x24,0x38,0x08]
; EGPR-NEXT:    movw $8, {{[0-9]+}}(%rsp) # encoding: [0x66,0xc7,0x44,0x24,0x18,0x08,0x00]
; EGPR-NEXT:    movb $8, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x44,0x24,0x39,0x08]
; EGPR-NEXT:    movw $8, {{[0-9]+}}(%rsp) # encoding: [0x66,0xc7,0x44,0x24,0x1a,0x08,0x00]
; EGPR-NEXT:    movb $8, {{[0-9]+}}(%rsp) # encoding: [0xc6,0x44,0x24,0x3a,0x08]
; EGPR-NEXT:    movw $8, {{[0-9]+}}(%rsp) # encoding: [0x66,0xc7,0x44,0x24,0x1c,0x08,0x00]
; EGPR-NEXT:    ldtilecfg {{[0-9]+}}(%rsp) # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x78,0x49,0x44,0x24,0x08]
; EGPR-NEXT:    movw $8, %bp # encoding: [0x66,0xbd,0x08,0x00]
; EGPR-NEXT:    tilezero %tmm0 # encoding: [0xc4,0xe2,0x7b,0x49,0xc0]
; EGPR-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; EGPR-NEXT:    testb %al, %al # encoding: [0x84,0xc0]
; EGPR-NEXT:    jne .LBB1_3 # encoding: [0x75,A]
; EGPR-NEXT:    # fixup A - offset: 1, value: .LBB1_3-1, kind: FK_PCRel_1
; EGPR-NEXT:  # %bb.1: # %loop.header.preheader
; EGPR-NEXT:    movq %rdi, %rbx # encoding: [0x48,0x89,0xfb]
; EGPR-NEXT:    xorl %r14d, %r14d # encoding: [0x45,0x31,0xf6]
; EGPR-NEXT:    movl $32, %r15d # encoding: [0x41,0xbf,0x20,0x00,0x00,0x00]
; EGPR-NEXT:    .p2align 4
; EGPR-NEXT:  .LBB1_2: # %loop.header
; EGPR-NEXT:    # =>This Inner Loop Header: Depth=1
; EGPR-NEXT:    tilezero %tmm0 # encoding: [0xc4,0xe2,0x7b,0x49,0xc0]
; EGPR-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; EGPR-NEXT:    callq foo # encoding: [0xe8,A,A,A,A]
; EGPR-NEXT:    # fixup A - offset: 1, value: foo-4, kind: reloc_branch_4byte_pcrel
; EGPR-NEXT:    ldtilecfg {{[0-9]+}}(%rsp) # EVEX TO VEX Compression encoding: [0xc4,0xe2,0x78,0x49,0x44,0x24,0x08]
; EGPR-NEXT:    tilezero %tmm2 # encoding: [0xc4,0xe2,0x7b,0x49,0xd0]
; EGPR-NEXT:    tileloadd (%rbx,%r15), %tmm0 # EVEX TO VEX Compression encoding: [0xc4,0xa2,0x7b,0x4b,0x04,0x3b]
; EGPR-NEXT:    tileloadd (%rbx,%r15), %tmm1 # EVEX TO VEX Compression encoding: [0xc4,0xa2,0x7b,0x4b,0x0c,0x3b]
; EGPR-NEXT:    tdpbssd %tmm1, %tmm0, %tmm2 # encoding: [0xc4,0xe2,0x73,0x5e,0xd0]
; EGPR-NEXT:    tilestored %tmm2, (%rbx,%r15) # EVEX TO VEX Compression encoding: [0xc4,0xa2,0x7a,0x4b,0x14,0x3b]
; EGPR-NEXT:    incl %r14d # encoding: [0x41,0xff,0xc6]
; EGPR-NEXT:    cmpw $100, %r14w # encoding: [0x66,0x41,0x83,0xfe,0x64]
; EGPR-NEXT:    jl .LBB1_2 # encoding: [0x7c,A]
; EGPR-NEXT:    # fixup A - offset: 1, value: .LBB1_2-1, kind: FK_PCRel_1
; EGPR-NEXT:  .LBB1_3: # %exit
; EGPR-NEXT:    addq $72, %rsp # encoding: [0x48,0x83,0xc4,0x48]
; EGPR-NEXT:    popq %rbx # encoding: [0x5b]
; EGPR-NEXT:    popq %r14 # encoding: [0x41,0x5e]
; EGPR-NEXT:    popq %r15 # encoding: [0x41,0x5f]
; EGPR-NEXT:    popq %rbp # encoding: [0x5d]
; EGPR-NEXT:    tilerelease # encoding: [0xc4,0xe2,0x78,0x49,0xc0]
; EGPR-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; EGPR-NEXT:    retq # encoding: [0xc3]
entry:
  %t1 = tail call x86_amx @llvm.x86.tilezero.internal(i16 8, i16 8)
  br i1 undef, label %loop.header, label %exit

loop.header:
  %ivphi = phi i16 [0, %entry], [%iv, %loop.latch]
  call void @foo()
  br label %loop.body

loop.body:
  %t2 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 8, ptr %buf, i64 32)
  %t3 = tail call x86_amx @llvm.x86.tileloadd64.internal(i16 8, i16 8, ptr %buf, i64 32)
  %t4 = tail call x86_amx @llvm.x86.tdpbssd.internal(i16 8, i16 8, i16 8, x86_amx %t1, x86_amx %t2, x86_amx %t3)
  tail call void @llvm.x86.tilestored64.internal(i16 8, i16 8, ptr %buf, i64 32, x86_amx %t4)
  br label %loop.latch

loop.latch:
  %iv = add i16 %ivphi, 1
  %c = icmp slt i16 %iv, 100
  br i1 %c, label %loop.header, label %exit

exit:
  ret void
}

declare dso_local void @foo()
declare x86_amx @llvm.x86.tilezero.internal(i16, i16)
declare x86_amx @llvm.x86.tileloadd64.internal(i16, i16, ptr, i64)
declare x86_amx @llvm.x86.tdpbssd.internal(i16, i16, i16, x86_amx, x86_amx, x86_amx)
declare void @llvm.x86.tilestored64.internal(i16, i16, ptr, i64, x86_amx)