; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s --check-prefix=X64

define void @PR118934(i1 %b, ptr %f, ptr %k) {
; X86-LABEL: PR118934:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    andb $1, %dl
; X86-NEXT:    addb %dl, %dl
; X86-NEXT:    addb $-2, %dl
; X86-NEXT:    movsbl %dl, %edx
; X86-NEXT:    addl $-6, %edx
; X86-NEXT:    addl $6, %edx
; X86-NEXT:    movl %edx, (%ecx)
; X86-NEXT:    addl %edx, %edx
; X86-NEXT:    movl %edx, (%eax)
;
; X64-LABEL: PR118934:
; X64:       # %bb.0: # %entry
; X64-NEXT:    andb $1, %dil
; X64-NEXT:    addb %dil, %dil
; X64-NEXT:    addb $-2, %dil
; X64-NEXT:    movsbl %dil, %eax
; X64-NEXT:    addl $-6, %eax
; X64-NEXT:    addl $6, %eax
; X64-NEXT:    movl %eax, (%rsi)
; X64-NEXT:    addl %eax, %eax
; X64-NEXT:    movl %eax, (%rdx)
entry:
  %0 = select i1 %b, i8 0, i8 -2
  br label %for.end

for.end:
  %n.i.i = select i1 poison, i32 6, i32 7
  %narrow = add nsw i8 %0, -6
  %add2.i = sext i8 %narrow to i32
  %conv5.i = add nsw i32 %n.i.i, %add2.i
  store i32 %conv5.i, ptr %f, align 4
  %add = shl nsw i32 %conv5.i, 1
  store i32 %add, ptr %k, align 4
  unreachable
}