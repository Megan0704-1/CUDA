; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s

; Reported on D129765
define void @simplify_assertzext(ptr %0) {
; CHECK-LABEL: simplify_assertzext:
; CHECK:       # %bb.0: # %BB
; CHECK-NEXT:    movl $275047, %eax # imm = 0x43267
; CHECK-NEXT:    movb $1, %cl
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_1: # %CF246
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    testb %cl, %cl
; CHECK-NEXT:    jne .LBB0_1
; CHECK-NEXT:  # %bb.2: # %CF260
; CHECK-NEXT:    orl $278403, %eax # imm = 0x43F83
; CHECK-NEXT:    movl %eax, (%rdi)
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_3: # %CF242
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    jmp .LBB0_3
BB:
  br label %CF246

CF246:                                            ; preds = %CF246, %BB
  %Sl23 = select i1 true, i32 275047, i32 355835
  %Cmp24 = fcmp ule float 0x3841668540000000, undef
  br i1 %Cmp24, label %CF246, label %CF260

CF260:                                            ; preds = %CF246
  %B29 = or i32 %Sl23, 278403
  store i32 %B29, ptr %0, align 4
  %L40 = load <4 x i1>, ptr %0, align 1
  br label %CF242

CF242:                                            ; preds = %CF242, %CF260
  %Sl53 = select i1 undef, <4 x i1> %L40, <4 x i1> undef
  br label %CF242
}