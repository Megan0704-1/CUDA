; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -global-isel=1 -mtriple=riscv32 -o - %s | FileCheck %s --check-prefix=RV32
; RUN: llc -global-isel=1 -mtriple=riscv64 -o - %s | FileCheck %s --check-prefix=RV64

declare void @use_addr(ptr)

define void @test_scoped_alloca(i64 %n) {
; RV32-LABEL: test_scoped_alloca:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    .cfi_offset s1, -12
; RV32-NEXT:    addi s0, sp, 16
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    addi a0, a0, 15
; RV32-NEXT:    andi a0, a0, -16
; RV32-NEXT:    sub a0, sp, a0
; RV32-NEXT:    mv s1, sp
; RV32-NEXT:    mv sp, a0
; RV32-NEXT:    call use_addr
; RV32-NEXT:    mv sp, s1
; RV32-NEXT:    addi sp, s0, -16
; RV32-NEXT:    .cfi_def_cfa sp, 16
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32-NEXT:    .cfi_restore ra
; RV32-NEXT:    .cfi_restore s0
; RV32-NEXT:    .cfi_restore s1
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    .cfi_def_cfa_offset 0
; RV32-NEXT:    ret
;
; RV64-LABEL: test_scoped_alloca:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -32
; RV64-NEXT:    .cfi_def_cfa_offset 32
; RV64-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    .cfi_offset s1, -24
; RV64-NEXT:    addi s0, sp, 32
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    addi a0, a0, 15
; RV64-NEXT:    andi a0, a0, -16
; RV64-NEXT:    sub a0, sp, a0
; RV64-NEXT:    mv s1, sp
; RV64-NEXT:    mv sp, a0
; RV64-NEXT:    call use_addr
; RV64-NEXT:    mv sp, s1
; RV64-NEXT:    addi sp, s0, -32
; RV64-NEXT:    .cfi_def_cfa sp, 32
; RV64-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    .cfi_restore ra
; RV64-NEXT:    .cfi_restore s0
; RV64-NEXT:    .cfi_restore s1
; RV64-NEXT:    addi sp, sp, 32
; RV64-NEXT:    .cfi_def_cfa_offset 0
; RV64-NEXT:    ret
  %sp = call ptr @llvm.stacksave.p0()
  %addr = alloca i8, i64 %n
  call void @use_addr(ptr %addr)
  call void @llvm.stackrestore.p0(ptr %sp)
  ret void
}