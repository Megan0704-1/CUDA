; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+m -O2 < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I
; RUN: llc -mtriple=riscv32 -mattr=+m -O2 < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

; Tests copied from PowerPC.

; Free probe
define i8 @f0() #0 {
; RV64I-LABEL: f0:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -64
; RV64I-NEXT:    .cfi_def_cfa_offset 64
; RV64I-NEXT:    li a0, 3
; RV64I-NEXT:    sb a0, 0(sp)
; RV64I-NEXT:    lbu a0, 0(sp)
; RV64I-NEXT:    addi sp, sp, 64
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f0:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -64
; RV32I-NEXT:    .cfi_def_cfa_offset 64
; RV32I-NEXT:    li a0, 3
; RV32I-NEXT:    sb a0, 0(sp)
; RV32I-NEXT:    lbu a0, 0(sp)
; RV32I-NEXT:    addi sp, sp, 64
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
entry:
  %a = alloca i8, i64 64
  %b = getelementptr inbounds i8, ptr %a, i64 63
  store volatile i8 3, ptr %a
  %c = load volatile i8, ptr %a
  ret i8 %c
}

define i8 @f1() #0 {
; RV64I-LABEL: f1:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    lui a0, 1
; RV64I-NEXT:    sub sp, sp, a0
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    .cfi_def_cfa_offset 4096
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    .cfi_def_cfa_offset 4112
; RV64I-NEXT:    li a0, 3
; RV64I-NEXT:    sb a0, 16(sp)
; RV64I-NEXT:    lbu a0, 16(sp)
; RV64I-NEXT:    lui a1, 1
; RV64I-NEXT:    addiw a1, a1, 16
; RV64I-NEXT:    add sp, sp, a1
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f1:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    lui a0, 1
; RV32I-NEXT:    sub sp, sp, a0
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    .cfi_def_cfa_offset 4096
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    .cfi_def_cfa_offset 4112
; RV32I-NEXT:    li a0, 3
; RV32I-NEXT:    sb a0, 16(sp)
; RV32I-NEXT:    lbu a0, 16(sp)
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    addi a1, a1, 16
; RV32I-NEXT:    add sp, sp, a1
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
entry:
  %a = alloca i8, i64 4096
  %b = getelementptr inbounds i8, ptr %a, i64 63
  store volatile i8 3, ptr %a
  %c = load volatile i8, ptr %a
  ret i8 %c
}

define i8 @f2() #0 {
; RV64I-LABEL: f2:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    lui a0, 16
; RV64I-NEXT:    sub t1, sp, a0
; RV64I-NEXT:    .cfi_def_cfa t1, 65536
; RV64I-NEXT:    lui t2, 1
; RV64I-NEXT:  .LBB2_1: # %entry
; RV64I-NEXT:    # =>This Inner Loop Header: Depth=1
; RV64I-NEXT:    sub sp, sp, t2
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    bne sp, t1, .LBB2_1
; RV64I-NEXT:  # %bb.2: # %entry
; RV64I-NEXT:    .cfi_def_cfa_register sp
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    .cfi_def_cfa_offset 65552
; RV64I-NEXT:    li a0, 3
; RV64I-NEXT:    sb a0, 16(sp)
; RV64I-NEXT:    lbu a0, 16(sp)
; RV64I-NEXT:    lui a1, 16
; RV64I-NEXT:    addiw a1, a1, 16
; RV64I-NEXT:    add sp, sp, a1
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f2:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    lui a0, 16
; RV32I-NEXT:    sub t1, sp, a0
; RV32I-NEXT:    .cfi_def_cfa t1, 65536
; RV32I-NEXT:    lui t2, 1
; RV32I-NEXT:  .LBB2_1: # %entry
; RV32I-NEXT:    # =>This Inner Loop Header: Depth=1
; RV32I-NEXT:    sub sp, sp, t2
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    bne sp, t1, .LBB2_1
; RV32I-NEXT:  # %bb.2: # %entry
; RV32I-NEXT:    .cfi_def_cfa_register sp
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    .cfi_def_cfa_offset 65552
; RV32I-NEXT:    li a0, 3
; RV32I-NEXT:    sb a0, 16(sp)
; RV32I-NEXT:    lbu a0, 16(sp)
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, 16
; RV32I-NEXT:    add sp, sp, a1
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
entry:
  %a = alloca i8, i64 65536
  %b = getelementptr inbounds i8, ptr %a, i64 63
  store volatile i8 3, ptr %a
  %c = load volatile i8, ptr %a
  ret i8 %c
}

define i8 @f3() #0 "stack-probe-size"="32768" {
; RV64I-LABEL: f3:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    lui a0, 8
; RV64I-NEXT:    sub sp, sp, a0
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    .cfi_def_cfa_offset 32768
; RV64I-NEXT:    lui a0, 8
; RV64I-NEXT:    sub sp, sp, a0
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    .cfi_def_cfa_offset 65536
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    .cfi_def_cfa_offset 65552
; RV64I-NEXT:    li a0, 3
; RV64I-NEXT:    sb a0, 16(sp)
; RV64I-NEXT:    lbu a0, 16(sp)
; RV64I-NEXT:    lui a1, 16
; RV64I-NEXT:    addiw a1, a1, 16
; RV64I-NEXT:    add sp, sp, a1
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f3:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    lui a0, 8
; RV32I-NEXT:    sub sp, sp, a0
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    .cfi_def_cfa_offset 32768
; RV32I-NEXT:    lui a0, 8
; RV32I-NEXT:    sub sp, sp, a0
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    .cfi_def_cfa_offset 65536
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    .cfi_def_cfa_offset 65552
; RV32I-NEXT:    li a0, 3
; RV32I-NEXT:    sb a0, 16(sp)
; RV32I-NEXT:    lbu a0, 16(sp)
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, 16
; RV32I-NEXT:    add sp, sp, a1
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
entry:
  %a = alloca i8, i64 65536
  %b = getelementptr inbounds i8, ptr %a, i64 63
  store volatile i8 3, ptr %a
  %c = load volatile i8, ptr %a
  ret i8 %c
}

; Same as f2, but without protection.
define i8 @f4() {
; RV64I-LABEL: f4:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    lui a0, 16
; RV64I-NEXT:    addiw a0, a0, 16
; RV64I-NEXT:    sub sp, sp, a0
; RV64I-NEXT:    .cfi_def_cfa_offset 65552
; RV64I-NEXT:    li a0, 3
; RV64I-NEXT:    sb a0, 16(sp)
; RV64I-NEXT:    lbu a0, 16(sp)
; RV64I-NEXT:    lui a1, 16
; RV64I-NEXT:    addiw a1, a1, 16
; RV64I-NEXT:    add sp, sp, a1
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f4:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    lui a0, 16
; RV32I-NEXT:    addi a0, a0, 16
; RV32I-NEXT:    sub sp, sp, a0
; RV32I-NEXT:    .cfi_def_cfa_offset 65552
; RV32I-NEXT:    li a0, 3
; RV32I-NEXT:    sb a0, 16(sp)
; RV32I-NEXT:    lbu a0, 16(sp)
; RV32I-NEXT:    lui a1, 16
; RV32I-NEXT:    addi a1, a1, 16
; RV32I-NEXT:    add sp, sp, a1
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
entry:
  %a = alloca i8, i64 65536
  %b = getelementptr inbounds i8, ptr %a, i64 63
  store volatile i8 3, ptr %a
  %c = load volatile i8, ptr %a
  ret i8 %c
}

define i8 @f5() #0 "stack-probe-size"="65536" {
; RV64I-LABEL: f5:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    lui a0, 256
; RV64I-NEXT:    sub t1, sp, a0
; RV64I-NEXT:    .cfi_def_cfa t1, 1048576
; RV64I-NEXT:    lui t2, 16
; RV64I-NEXT:  .LBB5_1: # %entry
; RV64I-NEXT:    # =>This Inner Loop Header: Depth=1
; RV64I-NEXT:    sub sp, sp, t2
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    bne sp, t1, .LBB5_1
; RV64I-NEXT:  # %bb.2: # %entry
; RV64I-NEXT:    .cfi_def_cfa_register sp
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    .cfi_def_cfa_offset 1048592
; RV64I-NEXT:    li a0, 3
; RV64I-NEXT:    sb a0, 16(sp)
; RV64I-NEXT:    lbu a0, 16(sp)
; RV64I-NEXT:    lui a1, 256
; RV64I-NEXT:    addiw a1, a1, 16
; RV64I-NEXT:    add sp, sp, a1
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f5:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    lui a0, 256
; RV32I-NEXT:    sub t1, sp, a0
; RV32I-NEXT:    .cfi_def_cfa t1, 1048576
; RV32I-NEXT:    lui t2, 16
; RV32I-NEXT:  .LBB5_1: # %entry
; RV32I-NEXT:    # =>This Inner Loop Header: Depth=1
; RV32I-NEXT:    sub sp, sp, t2
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    bne sp, t1, .LBB5_1
; RV32I-NEXT:  # %bb.2: # %entry
; RV32I-NEXT:    .cfi_def_cfa_register sp
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    .cfi_def_cfa_offset 1048592
; RV32I-NEXT:    li a0, 3
; RV32I-NEXT:    sb a0, 16(sp)
; RV32I-NEXT:    lbu a0, 16(sp)
; RV32I-NEXT:    lui a1, 256
; RV32I-NEXT:    addi a1, a1, 16
; RV32I-NEXT:    add sp, sp, a1
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
entry:
  %a = alloca i8, i64 1048576
  %b = getelementptr inbounds i8, ptr %a, i64 63
  store volatile i8 3, ptr %a
  %c = load volatile i8, ptr %a
  ret i8 %c
}

define i8 @f6() #0 {
; RV64I-LABEL: f6:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    lui a0, 262144
; RV64I-NEXT:    sub t1, sp, a0
; RV64I-NEXT:    .cfi_def_cfa t1, 1073741824
; RV64I-NEXT:    lui t2, 1
; RV64I-NEXT:  .LBB6_1: # %entry
; RV64I-NEXT:    # =>This Inner Loop Header: Depth=1
; RV64I-NEXT:    sub sp, sp, t2
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    bne sp, t1, .LBB6_1
; RV64I-NEXT:  # %bb.2: # %entry
; RV64I-NEXT:    .cfi_def_cfa_register sp
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    .cfi_def_cfa_offset 1073741840
; RV64I-NEXT:    li a0, 3
; RV64I-NEXT:    sb a0, 16(sp)
; RV64I-NEXT:    lbu a0, 16(sp)
; RV64I-NEXT:    lui a1, 262144
; RV64I-NEXT:    addiw a1, a1, 16
; RV64I-NEXT:    add sp, sp, a1
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f6:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    lui a0, 262144
; RV32I-NEXT:    sub t1, sp, a0
; RV32I-NEXT:    .cfi_def_cfa t1, 1073741824
; RV32I-NEXT:    lui t2, 1
; RV32I-NEXT:  .LBB6_1: # %entry
; RV32I-NEXT:    # =>This Inner Loop Header: Depth=1
; RV32I-NEXT:    sub sp, sp, t2
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    bne sp, t1, .LBB6_1
; RV32I-NEXT:  # %bb.2: # %entry
; RV32I-NEXT:    .cfi_def_cfa_register sp
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    .cfi_def_cfa_offset 1073741840
; RV32I-NEXT:    li a0, 3
; RV32I-NEXT:    sb a0, 16(sp)
; RV32I-NEXT:    lbu a0, 16(sp)
; RV32I-NEXT:    lui a1, 262144
; RV32I-NEXT:    addi a1, a1, 16
; RV32I-NEXT:    add sp, sp, a1
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
entry:
  %a = alloca i8, i64 1073741824
  %b = getelementptr inbounds i8, ptr %a, i64 63
  store volatile i8 3, ptr %a
  %c = load volatile i8, ptr %a
  ret i8 %c
}

define i8 @f7() #0 "stack-probe-size"="65536" {
; RV64I-LABEL: f7:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    lui a0, 244128
; RV64I-NEXT:    sub t1, sp, a0
; RV64I-NEXT:    .cfi_def_cfa t1, 999948288
; RV64I-NEXT:    lui t2, 16
; RV64I-NEXT:  .LBB7_1: # %entry
; RV64I-NEXT:    # =>This Inner Loop Header: Depth=1
; RV64I-NEXT:    sub sp, sp, t2
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    bne sp, t1, .LBB7_1
; RV64I-NEXT:  # %bb.2: # %entry
; RV64I-NEXT:    .cfi_def_cfa_register sp
; RV64I-NEXT:    lui a0, 13
; RV64I-NEXT:    addiw a0, a0, -1520
; RV64I-NEXT:    sub sp, sp, a0
; RV64I-NEXT:    .cfi_def_cfa_offset 1000000016
; RV64I-NEXT:    li a0, 3
; RV64I-NEXT:    sb a0, 9(sp)
; RV64I-NEXT:    lbu a0, 9(sp)
; RV64I-NEXT:    lui a1, 244141
; RV64I-NEXT:    addiw a1, a1, -1520
; RV64I-NEXT:    add sp, sp, a1
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f7:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    lui a0, 244128
; RV32I-NEXT:    sub t1, sp, a0
; RV32I-NEXT:    .cfi_def_cfa t1, 999948288
; RV32I-NEXT:    lui t2, 16
; RV32I-NEXT:  .LBB7_1: # %entry
; RV32I-NEXT:    # =>This Inner Loop Header: Depth=1
; RV32I-NEXT:    sub sp, sp, t2
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    bne sp, t1, .LBB7_1
; RV32I-NEXT:  # %bb.2: # %entry
; RV32I-NEXT:    .cfi_def_cfa_register sp
; RV32I-NEXT:    lui a0, 13
; RV32I-NEXT:    addi a0, a0, -1520
; RV32I-NEXT:    sub sp, sp, a0
; RV32I-NEXT:    .cfi_def_cfa_offset 1000000016
; RV32I-NEXT:    li a0, 3
; RV32I-NEXT:    sb a0, 9(sp)
; RV32I-NEXT:    lbu a0, 9(sp)
; RV32I-NEXT:    lui a1, 244141
; RV32I-NEXT:    addi a1, a1, -1520
; RV32I-NEXT:    add sp, sp, a1
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
entry:
  %a = alloca i8, i64 1000000007
  %b = getelementptr inbounds i8, ptr %a, i64 101
  store volatile i8 3, ptr %a
  %c = load volatile i8, ptr %a
  ret i8 %c
}

; alloca + align < probe_size
define i32 @f8(i64 %i) local_unnamed_addr #0 {
; RV64I-LABEL: f8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -832
; RV64I-NEXT:    .cfi_def_cfa_offset 832
; RV64I-NEXT:    sd ra, 824(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 816(sp) # 8-byte Folded Spill
; RV64I-NEXT:    .cfi_offset ra, -8
; RV64I-NEXT:    .cfi_offset s0, -16
; RV64I-NEXT:    addi s0, sp, 832
; RV64I-NEXT:    .cfi_def_cfa s0, 0
; RV64I-NEXT:    andi sp, sp, -64
; RV64I-NEXT:    slli a0, a0, 2
; RV64I-NEXT:    mv a1, sp
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    li a1, 1
; RV64I-NEXT:    sw a1, 0(a0)
; RV64I-NEXT:    lw a0, 0(sp)
; RV64I-NEXT:    addi sp, s0, -832
; RV64I-NEXT:    .cfi_def_cfa sp, 832
; RV64I-NEXT:    ld ra, 824(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 816(sp) # 8-byte Folded Reload
; RV64I-NEXT:    .cfi_restore ra
; RV64I-NEXT:    .cfi_restore s0
; RV64I-NEXT:    addi sp, sp, 832
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -832
; RV32I-NEXT:    .cfi_def_cfa_offset 832
; RV32I-NEXT:    sw ra, 828(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 824(sp) # 4-byte Folded Spill
; RV32I-NEXT:    .cfi_offset ra, -4
; RV32I-NEXT:    .cfi_offset s0, -8
; RV32I-NEXT:    addi s0, sp, 832
; RV32I-NEXT:    .cfi_def_cfa s0, 0
; RV32I-NEXT:    andi sp, sp, -64
; RV32I-NEXT:    slli a0, a0, 2
; RV32I-NEXT:    mv a1, sp
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    li a1, 1
; RV32I-NEXT:    sw a1, 0(a0)
; RV32I-NEXT:    lw a0, 0(sp)
; RV32I-NEXT:    addi sp, s0, -832
; RV32I-NEXT:    .cfi_def_cfa sp, 832
; RV32I-NEXT:    lw ra, 828(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 824(sp) # 4-byte Folded Reload
; RV32I-NEXT:    .cfi_restore ra
; RV32I-NEXT:    .cfi_restore s0
; RV32I-NEXT:    addi sp, sp, 832
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
  %a = alloca i32, i32 200, align 64
  %b = getelementptr inbounds i32, ptr %a, i64 %i
  store volatile i32 1, ptr %b
  %c = load volatile i32, ptr %a
  ret i32 %c
}

; alloca > probe_size, align > probe_size
define i32 @f9(i64 %i) local_unnamed_addr #0 {
; RV64I-LABEL: f9:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -2032
; RV64I-NEXT:    .cfi_def_cfa_offset 2032
; RV64I-NEXT:    sd ra, 2024(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 2016(sp) # 8-byte Folded Spill
; RV64I-NEXT:    .cfi_offset ra, -8
; RV64I-NEXT:    .cfi_offset s0, -16
; RV64I-NEXT:    addi s0, sp, 2032
; RV64I-NEXT:    .cfi_def_cfa s0, 0
; RV64I-NEXT:    lui a1, 1
; RV64I-NEXT:    sub sp, sp, a1
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    sub sp, sp, a1
; RV64I-NEXT:    sd zero, 0(sp)
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    andi sp, sp, -2048
; RV64I-NEXT:    slli a0, a0, 2
; RV64I-NEXT:    addi a1, sp, 2047
; RV64I-NEXT:    addi a1, a1, 1
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    li a1, 1
; RV64I-NEXT:    sw a1, 0(a0)
; RV64I-NEXT:    lui a0, 1
; RV64I-NEXT:    add a0, sp, a0
; RV64I-NEXT:    lw a0, -2048(a0)
; RV64I-NEXT:    addi sp, s0, -2032
; RV64I-NEXT:    .cfi_def_cfa sp, 2032
; RV64I-NEXT:    ld ra, 2024(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 2016(sp) # 8-byte Folded Reload
; RV64I-NEXT:    .cfi_restore ra
; RV64I-NEXT:    .cfi_restore s0
; RV64I-NEXT:    addi sp, sp, 2032
; RV64I-NEXT:    .cfi_def_cfa_offset 0
; RV64I-NEXT:    ret
;
; RV32I-LABEL: f9:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -2032
; RV32I-NEXT:    .cfi_def_cfa_offset 2032
; RV32I-NEXT:    sw ra, 2028(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 2024(sp) # 4-byte Folded Spill
; RV32I-NEXT:    .cfi_offset ra, -4
; RV32I-NEXT:    .cfi_offset s0, -8
; RV32I-NEXT:    addi s0, sp, 2032
; RV32I-NEXT:    .cfi_def_cfa s0, 0
; RV32I-NEXT:    lui a1, 1
; RV32I-NEXT:    sub sp, sp, a1
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    sub sp, sp, a1
; RV32I-NEXT:    sw zero, 0(sp)
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    andi sp, sp, -2048
; RV32I-NEXT:    slli a0, a0, 2
; RV32I-NEXT:    addi a1, sp, 2047
; RV32I-NEXT:    addi a1, a1, 1
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    li a1, 1
; RV32I-NEXT:    sw a1, 0(a0)
; RV32I-NEXT:    lui a0, 1
; RV32I-NEXT:    add a0, sp, a0
; RV32I-NEXT:    lw a0, -2048(a0)
; RV32I-NEXT:    addi sp, s0, -2032
; RV32I-NEXT:    .cfi_def_cfa sp, 2032
; RV32I-NEXT:    lw ra, 2028(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 2024(sp) # 4-byte Folded Reload
; RV32I-NEXT:    .cfi_restore ra
; RV32I-NEXT:    .cfi_restore s0
; RV32I-NEXT:    addi sp, sp, 2032
; RV32I-NEXT:    .cfi_def_cfa_offset 0
; RV32I-NEXT:    ret
  %a = alloca i32, i32 2000, align 2048
  %b = getelementptr inbounds i32, ptr %a, i64 %i
  store volatile i32 1, ptr %b
  %c = load volatile i32, ptr %a
  ret i32 %c
}

attributes #0 = { "probe-stack"="inline-asm" }