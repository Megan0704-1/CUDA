; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple riscv32 -mattr=+experimental-zicfilp < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple riscv64 -mattr=+experimental-zicfilp < %s | FileCheck %s --check-prefixes=CHECK,RV64
; RUN: llc -mtriple riscv32 -mattr=+experimental-zicfilp \
; RUN: -riscv-landing-pad-label=1 < %s | FileCheck %s --check-prefixes=FIXED-ONE,FIXED-ONE-RV32
; RUN: llc -mtriple riscv64 -mattr=+experimental-zicfilp \
; RUN: -riscv-landing-pad-label=1 < %s | FileCheck %s --check-prefixes=FIXED-ONE,FIXED-ONE-RV64

; Check indirectbr.
@__const.indirctbr.addr = private unnamed_addr constant [2 x ptr] [ptr blockaddress(@indirctbr, %labelA), ptr blockaddress(@indirctbr, %labelB)], align 8
define void @indirctbr(i32 %i, ptr %p) {
; RV32-LABEL: indirctbr:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lpad 0
; RV32-NEXT:    slli a0, a0, 2
; RV32-NEXT:    lui a2, %hi(.L__const.indirctbr.addr)
; RV32-NEXT:    addi a2, a2, %lo(.L__const.indirctbr.addr)
; RV32-NEXT:    add a0, a2, a0
; RV32-NEXT:    lw a0, 0(a0)
; RV32-NEXT:    jr a0
; RV32-NEXT:    .p2align 2
; RV32-NEXT:  .Ltmp3: # Block address taken
; RV32-NEXT:  .LBB0_1: # %labelA
; RV32-NEXT:    lpad 0
; RV32-NEXT:    li a0, 1
; RV32-NEXT:    sw a0, 0(a1)
; RV32-NEXT:    .p2align 2
; RV32-NEXT:  .Ltmp4: # Block address taken
; RV32-NEXT:  .LBB0_2: # %labelB
; RV32-NEXT:    lpad 0
; RV32-NEXT:    li a0, 2
; RV32-NEXT:    sw a0, 0(a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: indirctbr:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lpad 0
; RV64-NEXT:    sext.w a0, a0
; RV64-NEXT:    slli a0, a0, 3
; RV64-NEXT:    lui a2, %hi(.L__const.indirctbr.addr)
; RV64-NEXT:    addi a2, a2, %lo(.L__const.indirctbr.addr)
; RV64-NEXT:    add a0, a2, a0
; RV64-NEXT:    ld a0, 0(a0)
; RV64-NEXT:    jr a0
; RV64-NEXT:    .p2align 2
; RV64-NEXT:  .Ltmp3: # Block address taken
; RV64-NEXT:  .LBB0_1: # %labelA
; RV64-NEXT:    lpad 0
; RV64-NEXT:    li a0, 1
; RV64-NEXT:    sw a0, 0(a1)
; RV64-NEXT:    .p2align 2
; RV64-NEXT:  .Ltmp4: # Block address taken
; RV64-NEXT:  .LBB0_2: # %labelB
; RV64-NEXT:    lpad 0
; RV64-NEXT:    li a0, 2
; RV64-NEXT:    sw a0, 0(a1)
; RV64-NEXT:    ret
;
; FIXED-ONE-RV32-LABEL: indirctbr:
; FIXED-ONE-RV32:       # %bb.0: # %entry
; FIXED-ONE-RV32-NEXT:    lpad 1
; FIXED-ONE-RV32-NEXT:    slli a0, a0, 2
; FIXED-ONE-RV32-NEXT:    lui a2, %hi(.L__const.indirctbr.addr)
; FIXED-ONE-RV32-NEXT:    addi a2, a2, %lo(.L__const.indirctbr.addr)
; FIXED-ONE-RV32-NEXT:    add a0, a2, a0
; FIXED-ONE-RV32-NEXT:    lw a0, 0(a0)
; FIXED-ONE-RV32-NEXT:    lui t2, 1
; FIXED-ONE-RV32-NEXT:    jr a0
; FIXED-ONE-RV32-NEXT:    .p2align 2
; FIXED-ONE-RV32-NEXT:  .Ltmp3: # Block address taken
; FIXED-ONE-RV32-NEXT:  .LBB0_1: # %labelA
; FIXED-ONE-RV32-NEXT:    lpad 1
; FIXED-ONE-RV32-NEXT:    li a0, 1
; FIXED-ONE-RV32-NEXT:    sw a0, 0(a1)
; FIXED-ONE-RV32-NEXT:    .p2align 2
; FIXED-ONE-RV32-NEXT:  .Ltmp4: # Block address taken
; FIXED-ONE-RV32-NEXT:  .LBB0_2: # %labelB
; FIXED-ONE-RV32-NEXT:    lpad 1
; FIXED-ONE-RV32-NEXT:    li a0, 2
; FIXED-ONE-RV32-NEXT:    sw a0, 0(a1)
; FIXED-ONE-RV32-NEXT:    ret
;
; FIXED-ONE-RV64-LABEL: indirctbr:
; FIXED-ONE-RV64:       # %bb.0: # %entry
; FIXED-ONE-RV64-NEXT:    lpad 1
; FIXED-ONE-RV64-NEXT:    sext.w a0, a0
; FIXED-ONE-RV64-NEXT:    slli a0, a0, 3
; FIXED-ONE-RV64-NEXT:    lui a2, %hi(.L__const.indirctbr.addr)
; FIXED-ONE-RV64-NEXT:    addi a2, a2, %lo(.L__const.indirctbr.addr)
; FIXED-ONE-RV64-NEXT:    add a0, a2, a0
; FIXED-ONE-RV64-NEXT:    ld a0, 0(a0)
; FIXED-ONE-RV64-NEXT:    lui t2, 1
; FIXED-ONE-RV64-NEXT:    jr a0
; FIXED-ONE-RV64-NEXT:    .p2align 2
; FIXED-ONE-RV64-NEXT:  .Ltmp3: # Block address taken
; FIXED-ONE-RV64-NEXT:  .LBB0_1: # %labelA
; FIXED-ONE-RV64-NEXT:    lpad 1
; FIXED-ONE-RV64-NEXT:    li a0, 1
; FIXED-ONE-RV64-NEXT:    sw a0, 0(a1)
; FIXED-ONE-RV64-NEXT:    .p2align 2
; FIXED-ONE-RV64-NEXT:  .Ltmp4: # Block address taken
; FIXED-ONE-RV64-NEXT:  .LBB0_2: # %labelB
; FIXED-ONE-RV64-NEXT:    lpad 1
; FIXED-ONE-RV64-NEXT:    li a0, 2
; FIXED-ONE-RV64-NEXT:    sw a0, 0(a1)
; FIXED-ONE-RV64-NEXT:    ret
entry:
  %arrayidx = getelementptr inbounds [2 x ptr], ptr @__const.indirctbr.addr, i64 0, i32 %i
  %0 = load ptr, ptr %arrayidx
  indirectbr ptr %0, [label %labelA, label %labelB]

labelA:                                           ; preds = %entry
  store volatile i32 1, ptr %p
  br label %labelB

labelB:                                           ; preds = %labelA, %entry
  store volatile i32 2, ptr %p
  ret void
}

; Check indirect call.
define void @call(ptr %0) {
; CHECK-LABEL: call:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lpad 0
; CHECK-NEXT:    jr a0
;
; FIXED-ONE-LABEL: call:
; FIXED-ONE:       # %bb.0:
; FIXED-ONE-NEXT:    lpad 1
; FIXED-ONE-NEXT:    lui t2, 1
; FIXED-ONE-NEXT:    jr a0
  tail call void %0()
  ret void
}

; Check invoke.
declare dso_local i32 @__gxx_personality_v0(...)
define void @invoke(ptr %f) personality ptr @__gxx_personality_v0 {
; RV32-LABEL: invoke:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lpad 0
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_remember_state
; RV32-NEXT:  .Ltmp0:
; RV32-NEXT:    jalr a0
; RV32-NEXT:  .Ltmp1:
; RV32-NEXT:  .LBB2_1: # %try.cont
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    .cfi_restore ra
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    .cfi_def_cfa_offset 0
; RV32-NEXT:    ret
; RV32-NEXT:  .LBB2_2: # %lpad
; RV32-NEXT:    .cfi_restore_state
; RV32-NEXT:  .Ltmp2:
; RV32-NEXT:    j .LBB2_1
;
; RV64-LABEL: invoke:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lpad 0
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    .cfi_def_cfa_offset 16
; RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_remember_state
; RV64-NEXT:  .Ltmp0:
; RV64-NEXT:    jalr a0
; RV64-NEXT:  .Ltmp1:
; RV64-NEXT:  .LBB2_1: # %try.cont
; RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    .cfi_restore ra
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    .cfi_def_cfa_offset 0
; RV64-NEXT:    ret
; RV64-NEXT:  .LBB2_2: # %lpad
; RV64-NEXT:    .cfi_restore_state
; RV64-NEXT:  .Ltmp2:
; RV64-NEXT:    j .LBB2_1
;
; FIXED-ONE-RV32-LABEL: invoke:
; FIXED-ONE-RV32:       # %bb.0: # %entry
; FIXED-ONE-RV32-NEXT:    lpad 1
; FIXED-ONE-RV32-NEXT:    addi sp, sp, -16
; FIXED-ONE-RV32-NEXT:    .cfi_def_cfa_offset 16
; FIXED-ONE-RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; FIXED-ONE-RV32-NEXT:    .cfi_offset ra, -4
; FIXED-ONE-RV32-NEXT:    .cfi_remember_state
; FIXED-ONE-RV32-NEXT:  .Ltmp0:
; FIXED-ONE-RV32-NEXT:    lui t2, 1
; FIXED-ONE-RV32-NEXT:    jalr a0
; FIXED-ONE-RV32-NEXT:  .Ltmp1:
; FIXED-ONE-RV32-NEXT:  .LBB2_1: # %try.cont
; FIXED-ONE-RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; FIXED-ONE-RV32-NEXT:    .cfi_restore ra
; FIXED-ONE-RV32-NEXT:    addi sp, sp, 16
; FIXED-ONE-RV32-NEXT:    .cfi_def_cfa_offset 0
; FIXED-ONE-RV32-NEXT:    ret
; FIXED-ONE-RV32-NEXT:  .LBB2_2: # %lpad
; FIXED-ONE-RV32-NEXT:    .cfi_restore_state
; FIXED-ONE-RV32-NEXT:  .Ltmp2:
; FIXED-ONE-RV32-NEXT:    j .LBB2_1
;
; FIXED-ONE-RV64-LABEL: invoke:
; FIXED-ONE-RV64:       # %bb.0: # %entry
; FIXED-ONE-RV64-NEXT:    lpad 1
; FIXED-ONE-RV64-NEXT:    addi sp, sp, -16
; FIXED-ONE-RV64-NEXT:    .cfi_def_cfa_offset 16
; FIXED-ONE-RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; FIXED-ONE-RV64-NEXT:    .cfi_offset ra, -8
; FIXED-ONE-RV64-NEXT:    .cfi_remember_state
; FIXED-ONE-RV64-NEXT:  .Ltmp0:
; FIXED-ONE-RV64-NEXT:    lui t2, 1
; FIXED-ONE-RV64-NEXT:    jalr a0
; FIXED-ONE-RV64-NEXT:  .Ltmp1:
; FIXED-ONE-RV64-NEXT:  .LBB2_1: # %try.cont
; FIXED-ONE-RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; FIXED-ONE-RV64-NEXT:    .cfi_restore ra
; FIXED-ONE-RV64-NEXT:    addi sp, sp, 16
; FIXED-ONE-RV64-NEXT:    .cfi_def_cfa_offset 0
; FIXED-ONE-RV64-NEXT:    ret
; FIXED-ONE-RV64-NEXT:  .LBB2_2: # %lpad
; FIXED-ONE-RV64-NEXT:    .cfi_restore_state
; FIXED-ONE-RV64-NEXT:  .Ltmp2:
; FIXED-ONE-RV64-NEXT:    j .LBB2_1
entry:
  invoke void %f() to label %try.cont unwind label %lpad

lpad:
  %0 = landingpad { ptr, i32 } cleanup
  br label %try.cont

try.cont:
  ret void
}

; Check external linkage function.
define void @external() {
; CHECK-LABEL: external:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lpad 0
; CHECK-NEXT:    ret
;
; FIXED-ONE-LABEL: external:
; FIXED-ONE:       # %bb.0:
; FIXED-ONE-NEXT:    lpad 1
; FIXED-ONE-NEXT:    ret
  ret void
}

; Check internal linkage function.
define internal void @internal() {
; CHECK-LABEL: internal:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
;
; FIXED-ONE-LABEL: internal:
; FIXED-ONE:       # %bb.0:
; FIXED-ONE-NEXT:    ret
  ret void
}

; Check internal linkage function with taken address.
@foo = constant ptr @internal2
define internal void @internal2() {
; CHECK-LABEL: internal2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lpad 0
; CHECK-NEXT:    ret
;
; FIXED-ONE-LABEL: internal2:
; FIXED-ONE:       # %bb.0:
; FIXED-ONE-NEXT:    lpad 1
; FIXED-ONE-NEXT:    ret
  ret void
}

; Check interrupt function does not need landing pad.
define void @interrupt() "interrupt"="user" {
; CHECK-LABEL: interrupt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mret
;
; FIXED-ONE-LABEL: interrupt:
; FIXED-ONE:       # %bb.0:
; FIXED-ONE-NEXT:    mret
  ret void
}