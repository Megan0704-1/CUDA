; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc < %s -verify-machineinstrs -mtriple=x86_64-unknown-unknown --show-mc-encoding -mattr=+movrs | FileCheck %s

define i8 @test_movrs_si8(ptr %__A) {
; CHECK-LABEL: test_movrs_si8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movrsb (%rdi), %al # encoding: [0x0f,0x38,0x8a,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = call i8 @llvm.x86.movrsqi(ptr %__A)
  ret i8 %0
}
declare i8 @llvm.x86.movrsqi(ptr)

define i16 @test_movrs_si16(ptr %__A) {
; CHECK-LABEL: test_movrs_si16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movrsw (%rdi), %ax # encoding: [0x66,0x0f,0x38,0x8b,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = call i16 @llvm.x86.movrshi(ptr %__A)
  ret i16 %0
}
declare i16 @llvm.x86.movrshi(ptr)

define i32 @test_movrs_si32(ptr %__A) {
; CHECK-LABEL: test_movrs_si32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movrsl (%rdi), %eax # encoding: [0x0f,0x38,0x8b,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = call i32 @llvm.x86.movrssi(ptr %__A)
  ret i32 %0
}
declare i32 @llvm.x86.movrssi(ptr)

define i64 @test_movrs_si64(ptr %__A) {
; CHECK-LABEL: test_movrs_si64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movrsq (%rdi), %rax # encoding: [0x48,0x0f,0x38,0x8b,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = call i64 @llvm.x86.movrsdi(ptr %__A)
  ret i64 %0
}
declare i64 @llvm.x86.movrsdi(ptr)