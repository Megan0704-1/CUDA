; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc < %s -mcpu=ppc -mtriple=powerpc-ibm-aix-xcoff | FileCheck %s
define void @test_oversized(ptr %dst, i32 %cond) {
; CHECK-LABEL: test_oversized:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    stw 31, -4(1)
; CHECK-NEXT:    stwu 1, -80(1)
; CHECK-NEXT:    cmplwi 4, 0
; CHECK-NEXT:    mr 31, 1
; CHECK-NEXT:    beq 0, L..BB0_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    li 4, 0
; CHECK-NEXT:    addi 5, 31, 80
; CHECK-NEXT:    stwux 5, 1, 4
; CHECK-NEXT:    addi 4, 1, 32
; CHECK-NEXT:    b L..BB0_3
; CHECK-NEXT:  L..BB0_2:
; CHECK-NEXT:    addi 4, 31, 44
; CHECK-NEXT:  L..BB0_3: # %if.end
; CHECK-NEXT:    stw 4, 0(3)
; CHECK-NEXT:    lwz 1, 0(1)
; CHECK-NEXT:    lwz 31, -4(1)
; CHECK-NEXT:    blr
entry:
  %0 = alloca [8 x i32], i32 1, align 4
  %tobool = icmp ne i32 %cond, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:
  %vla1 = alloca [4294967295 x i32], i32 1, align 4
  br label %if.end

if.end:
  %arr = phi ptr [%0, %entry], [%vla1, %if.then]
  store ptr %arr, ptr %dst
  ret void
}