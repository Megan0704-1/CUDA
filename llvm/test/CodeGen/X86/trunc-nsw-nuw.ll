; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=x86_64 | FileCheck %s

define zeroext i32 @trunc_nuw_nsw_urem(i64 %x) nounwind {
; CHECK-LABEL: trunc_nuw_nsw_urem:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    movl $3518437209, %ecx # imm = 0xD1B71759
; CHECK-NEXT:    imulq %rdi, %rcx
; CHECK-NEXT:    shrq $45, %rcx
; CHECK-NEXT:    imull $10000, %ecx, %ecx # imm = 0x2710
; CHECK-NEXT:    subl %ecx, %eax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
entry:
  %trunc = trunc nuw nsw i64 %x to i32
  %rem = urem i32 %trunc, 10000
  ret i32 %rem
}

define i64 @zext_nneg_udiv_trunc_nuw(i64 %x) nounwind {
; CHECK-LABEL: zext_nneg_udiv_trunc_nuw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imull $52429, %edi, %eax # imm = 0xCCCD
; CHECK-NEXT:    shrl $23, %eax
; CHECK-NEXT:    retq
entry:
  %trunc = trunc nuw i64 %x to i16
  %div = udiv i16 %trunc, 160
  %ext = zext nneg i16 %div to i64
  ret i64 %ext
}

define i64 @sext_udiv_trunc_nuw(i64 %x) nounwind {
; CHECK-LABEL: sext_udiv_trunc_nuw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    imull $52429, %edi, %eax # imm = 0xCCCD
; CHECK-NEXT:    shrl $23, %eax
; CHECK-NEXT:    retq
entry:
  %trunc = trunc nuw i64 %x to i16
  %div = udiv i16 %trunc, 160
  %ext = sext i16 %div to i64
  ret i64 %ext
}

define ptr @gep_nusw_zext_nneg_add_trunc_nuw_nsw(ptr %p, i64 %x) nounwind {
; CHECK-LABEL: gep_nusw_zext_nneg_add_trunc_nuw_nsw:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    leaq 20(%rdi,%rsi,4), %rax
; CHECK-NEXT:    retq
entry:
  %trunc = trunc nuw nsw i64 %x to i32
  %add = add nuw nsw i32 %trunc, 5
  %offset = zext nneg i32 %add to i64
  %gep = getelementptr nusw float, ptr %p, i64 %offset
  ret ptr %gep
}

; Make sure nsw flag is dropped after we simplify the operand of TRUNCATE.

define i32 @simplify_demanded_bits_drop_flag(i1 zeroext %x, i1 zeroext %y) nounwind {
; CHECK-LABEL: simplify_demanded_bits_drop_flag:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    negl %edi
; CHECK-NEXT:    shll $2, %esi
; CHECK-NEXT:    xorl %edi, %esi
; CHECK-NEXT:    movslq %esi, %rax
; CHECK-NEXT:    imulq $-1634202141, %rax, %rax # imm = 0x9E980DE3
; CHECK-NEXT:    movq %rax, %rcx
; CHECK-NEXT:    shrq $63, %rcx
; CHECK-NEXT:    sarq $44, %rax
; CHECK-NEXT:    addl %ecx, %eax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
entry:
  %sel = select i1 %y, i64 4, i64 0
  %conv0 = sext i1 %x to i64
  %xor = xor i64 %sel, %conv0
  %conv1 = trunc nsw i64 %xor to i32
  %div = sdiv i32 %conv1, -10765
  ret i32 %div
}