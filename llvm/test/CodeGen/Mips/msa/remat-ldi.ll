; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O3 -mtriple=mipsel-elf -mcpu=mips32r6 -mattr=+fp64,+msa %s -o - | FileCheck %s

; Test that checks if spill for ldi can be avoided and instruction will be
; rematerialized.

declare dso_local void @foo()

define dso_local void @test_ldi_b() {
; CHECK-LABEL: test_ldi_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addiu $sp, $sp, -24
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset 31, -4
; CHECK-NEXT:    ldi.b $w0, 1
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    jal foo
; CHECK-NEXT:    nop
; CHECK-NEXT:    ldi.b $w0, 1
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    addiu $sp, $sp, 24
entry:
  tail call void asm sideeffect "", "f,~{memory},~{$1}"(<16 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>)
  tail call void @foo()
  tail call void asm sideeffect "", "f,~{memory},~{$1}"(<16 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>)
  ret void
}

define dso_local void @test_ldi_h() {
; CHECK-LABEL: test_ldi_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addiu $sp, $sp, -24
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset 31, -4
; CHECK-NEXT:    ldi.h $w0, 2
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    jal foo
; CHECK-NEXT:    nop
; CHECK-NEXT:    ldi.h $w0, 2
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    addiu $sp, $sp, 24
entry:
  tail call void asm sideeffect "", "f,~{memory},~{$1}"(<8 x i16> <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>)
  tail call void @foo()
  tail call void asm sideeffect "", "f,~{memory},~{$1}"(<8 x i16> <i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2, i16 2>)
  ret void
}

define dso_local void @test_ldi_w() {
; CHECK-LABEL: test_ldi_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addiu $sp, $sp, -24
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset 31, -4
; CHECK-NEXT:    ldi.w $w0, 3
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    jal foo
; CHECK-NEXT:    nop
; CHECK-NEXT:    ldi.w $w0, 3
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    addiu $sp, $sp, 24
entry:
  tail call void asm sideeffect "", "f,~{memory},~{$1}"(<4 x i32> <i32 3, i32 3, i32 3, i32 3>)
  tail call void @foo()
  tail call void asm sideeffect "", "f,~{memory},~{$1}"(<4 x i32> <i32 3, i32 3, i32 3, i32 3>)
  ret void
}

define dso_local void @test_ldi_d() {
; CHECK-LABEL: test_ldi_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addiu $sp, $sp, -24
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    sw $ra, 20($sp) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset 31, -4
; CHECK-NEXT:    ldi.d $w0, 4
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    jal foo
; CHECK-NEXT:    nop
; CHECK-NEXT:    ldi.d $w0, 4
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    lw $ra, 20($sp) # 4-byte Folded Reload
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    addiu $sp, $sp, 24
entry:
  tail call void asm sideeffect "", "f,~{memory},~{$1}"(<2 x i64> <i64 4, i64 4>)
  tail call void @foo()
  tail call void asm sideeffect "", "f,~{memory},~{$1}"(<2 x i64> <i64 4, i64 4>)
  ret void
}