; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -O0 -mtriple=x86_64-unknown-unknown -mattr=+amx-transpose,+amx-movrs | FileCheck %s --check-prefixes=CHECK,O0
; RUN: llc < %s -O2 -mtriple=x86_64-unknown-unknown -mattr=+amx-transpose,+amx-movrs | FileCheck %s --check-prefixes=CHECK,O2

define void @test_amx(i64 %stride, i8* %addr1) #0 {
; CHECK-LABEL: test_amx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    t2rpntlvwz0rs (%rsi,%rdi), %tmm0
; CHECK-NEXT:    t2rpntlvwz0rst1 (%rsi,%rdi), %tmm2
; CHECK-NEXT:    t2rpntlvwz1rs (%rsi,%rdi), %tmm0
; CHECK-NEXT:    t2rpntlvwz1rst1 (%rsi,%rdi), %tmm2
; CHECK-NEXT:    retq
  call void @llvm.x86.t2rpntlvwz0rs(i8 1, i8* %addr1, i64 %stride)
  call void @llvm.x86.t2rpntlvwz0rst1(i8 2, i8* %addr1, i64 %stride)
  call void @llvm.x86.t2rpntlvwz1rs(i8 1, i8* %addr1, i64 %stride)
  call void @llvm.x86.t2rpntlvwz1rst1(i8 2, i8* %addr1, i64 %stride)
  ret void
}
declare void @llvm.x86.t2rpntlvwz0rs(i8 , i8* , i64 )
declare void @llvm.x86.t2rpntlvwz0rst1(i8 , i8* , i64 )
declare void @llvm.x86.t2rpntlvwz1rs(i8 , i8* , i64 )
declare void @llvm.x86.t2rpntlvwz1rst1(i8 , i8* , i64 )

define void @test_amx2(i8* %base, i64 %stride) #0 {
; O0-LABEL: test_amx2:
; O0:       # %bb.0:
; O0-NEXT:    xorps %xmm0, %xmm0
; O0-NEXT:    movups %xmm0, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movups %xmm0, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movups %xmm0, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movups %xmm0, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movb $1, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movw $8, %ax
; O0-NEXT:    # implicit-def: $al
; O0-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; O0-NEXT:    # implicit-def: $al
; O0-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; O0-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; O0-NEXT:    t2rpntlvwz0rst1 (%rdi,%rsi), %tmm4
; O0-NEXT:    movw $8, %ax
; O0-NEXT:    # implicit-def: $al
; O0-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; O0-NEXT:    # implicit-def: $al
; O0-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; O0-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; O0-NEXT:    t2rpntlvwz1rs (%rdi,%rsi), %tmm4
; O0-NEXT:    movw $8, %ax
; O0-NEXT:    # implicit-def: $al
; O0-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; O0-NEXT:    # implicit-def: $al
; O0-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; O0-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; O0-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; O0-NEXT:    t2rpntlvwz1rst1 (%rdi,%rsi), %tmm4
; O0-NEXT:    tilerelease
; O0-NEXT:    retq
;
; O2-LABEL: test_amx2:
; O2:       # %bb.0:
; O2-NEXT:    xorps %xmm0, %xmm0
; O2-NEXT:    movups %xmm0, -{{[0-9]+}}(%rsp)
; O2-NEXT:    movups %xmm0, -{{[0-9]+}}(%rsp)
; O2-NEXT:    movups %xmm0, -{{[0-9]+}}(%rsp)
; O2-NEXT:    movups %xmm0, -{{[0-9]+}}(%rsp)
; O2-NEXT:    movb $1, -{{[0-9]+}}(%rsp)
; O2-NEXT:    movb $8, -{{[0-9]+}}(%rsp)
; O2-NEXT:    movw $8, -{{[0-9]+}}(%rsp)
; O2-NEXT:    movb $8, -{{[0-9]+}}(%rsp)
; O2-NEXT:    movw $8, -{{[0-9]+}}(%rsp)
; O2-NEXT:    ldtilecfg -{{[0-9]+}}(%rsp)
; O2-NEXT:    movw $8, %ax
; O2-NEXT:    t2rpntlvwz0rs (%rdi,%rsi), %tmm4
; O2-NEXT:    t2rpntlvwz0rst1 (%rdi,%rsi), %tmm4
; O2-NEXT:    t2rpntlvwz1rs (%rdi,%rsi), %tmm4
; O2-NEXT:    t2rpntlvwz1rst1 (%rdi,%rsi), %tmm4
; O2-NEXT:    tilerelease
; O2-NEXT:    retq
  call { x86_amx, x86_amx } @llvm.x86.t2rpntlvwz0rs.internal(i16 8, i16 8, i16 8, i8* %base, i64 %stride)
  call { x86_amx, x86_amx } @llvm.x86.t2rpntlvwz0rst1.internal(i16 8, i16 8, i16 8, i8* %base, i64 %stride)
  call { x86_amx, x86_amx } @llvm.x86.t2rpntlvwz1rs.internal(i16 8, i16 8, i16 8, i8* %base, i64 %stride)
  call { x86_amx, x86_amx } @llvm.x86.t2rpntlvwz1rst1.internal(i16 8, i16 8, i16 8, i8* %base, i64 %stride)
  ret void
}
declare { x86_amx, x86_amx } @llvm.x86.t2rpntlvwz0rs.internal(i16, i16, i16, i8*, i64)
declare { x86_amx, x86_amx } @llvm.x86.t2rpntlvwz0rst1.internal(i16, i16, i16, i8*, i64)
declare { x86_amx, x86_amx } @llvm.x86.t2rpntlvwz1rs.internal(i16, i16, i16, i8*, i64)
declare { x86_amx, x86_amx } @llvm.x86.t2rpntlvwz1rst1.internal(i16, i16, i16, i8*, i64)