; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; Test longjmp load from jmp_buf.
; Frame pointer from Slot 1.
; Jump address from Slot 2.
; Backchain Value from Slot 3.
; Stack Pointer from Slot 4.
; Literal Pool Pointer from Slot 5.

; RUN: llc < %s -verify-machineinstrs -mtriple=s390x-linux-gnu | FileCheck %s

@buf = global [20 x ptr] zeroinitializer, align 8

define void @foo() {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    stmg %r11, %r15, 88(%r15)
; CHECK-NEXT:    .cfi_offset %r11, -72
; CHECK-NEXT:    .cfi_offset %r13, -56
; CHECK-NEXT:    .cfi_offset %r15, -40
; CHECK-NEXT:    lgrl %r1, buf@GOT
; CHECK-NEXT:    lg %r2, 8(%r1)
; CHECK-NEXT:    lg %r11, 0(%r1)
; CHECK-NEXT:    lg %r13, 32(%r1)
; CHECK-NEXT:    lg %r15, 24(%r1)
; CHECK-NEXT:    br %r2
entry:
  tail call void @llvm.eh.sjlj.longjmp(ptr nonnull @buf)
  unreachable
}

define void @bar()  "backchain" {
; CHECK-LABEL: bar:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    stmg %r11, %r15, 88(%r15)
; CHECK-NEXT:    .cfi_offset %r11, -72
; CHECK-NEXT:    .cfi_offset %r13, -56
; CHECK-NEXT:    .cfi_offset %r15, -40
; CHECK-NEXT:    lgrl %r1, buf@GOT
; CHECK-NEXT:    lg %r2, 8(%r1)
; CHECK-NEXT:    lg %r11, 0(%r1)
; CHECK-NEXT:    lg %r13, 32(%r1)
; CHECK-NEXT:    lg %r3, 16(%r1)
; CHECK-NEXT:    lg %r15, 24(%r1)
; CHECK-NEXT:    stg %r3, 0(%r15)
; CHECK-NEXT:    br %r2
entry:
  tail call void @llvm.eh.sjlj.longjmp(ptr nonnull @buf)
  unreachable
}