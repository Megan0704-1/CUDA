; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -verify-machineinstrs \
; RUN:   -target-abi lp64 < %s | FileCheck %s -check-prefixes=CHECK,RV64I
; RUN: llc -mtriple=riscv64 -mattr=+zfh -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s | FileCheck %s -check-prefixes=CHECK,RV64IZFH
; RUN: llc -mtriple=riscv64 -mattr=+zhinx -verify-machineinstrs \
; RUN:   -target-abi lp64 < %s | FileCheck %s -check-prefixes=CHECK,RV64IZHINX

define half @sitofp_i128_to_f16(i128 %a) nounwind {
; RV64I-LABEL: sitofp_i128_to_f16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floattisf
; RV64I-NEXT:    call __truncsfhf2
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: sitofp_i128_to_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    call __floattihf
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: sitofp_i128_to_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    call __floattihf
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
  %1 = sitofp i128 %a to half
  ret half %1
}

define half @uitofp_i128_to_f16(i128 %a) nounwind {
; RV64I-LABEL: uitofp_i128_to_f16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatuntisf
; RV64I-NEXT:    call __truncsfhf2
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: uitofp_i128_to_f16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    call __floatuntihf
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: uitofp_i128_to_f16:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    call __floatuntihf
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
  %1 = uitofp i128 %a to half
  ret half %1
}

define i128 @fptosi_f16_to_i128(half %a) nounwind {
; RV64I-LABEL: fptosi_f16_to_i128:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __extendhfsf2
; RV64I-NEXT:    call __fixsfti
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: fptosi_f16_to_i128:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    call __fixhfti
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: fptosi_f16_to_i128:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    call __fixhfti
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
  %1 = fptosi half %a to i128
  ret i128 %1
}

define i128 @fptoui_f16_to_i128(half %a) nounwind {
; RV64I-LABEL: fptoui_f16_to_i128:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __extendhfsf2
; RV64I-NEXT:    call __fixunssfti
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: fptoui_f16_to_i128:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    call __fixunshfti
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: fptoui_f16_to_i128:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -16
; RV64IZHINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    call __fixunshfti
; RV64IZHINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 16
; RV64IZHINX-NEXT:    ret
  %1 = fptoui half %a to i128
  ret i128 %1
}

define i128 @fptosi_sat_f16_to_i128(half %a) nounwind {
; RV64I-LABEL: fptosi_sat_f16_to_i128:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -64
; RV64I-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 40(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 32(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s3, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s4, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s5, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __extendhfsf2
; RV64I-NEXT:    mv s2, a0
; RV64I-NEXT:    lui a1, 1044480
; RV64I-NEXT:    call __gesf2
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    mv a0, s2
; RV64I-NEXT:    call __fixsfti
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    mv s3, a1
; RV64I-NEXT:    li s5, -1
; RV64I-NEXT:    bgez s0, .LBB4_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    slli s3, s5, 63
; RV64I-NEXT:  .LBB4_2:
; RV64I-NEXT:    lui a1, 520192
; RV64I-NEXT:    addiw a1, a1, -1
; RV64I-NEXT:    mv a0, s2
; RV64I-NEXT:    call __gtsf2
; RV64I-NEXT:    mv s4, a0
; RV64I-NEXT:    blez a0, .LBB4_4
; RV64I-NEXT:  # %bb.3:
; RV64I-NEXT:    srli s3, s5, 1
; RV64I-NEXT:  .LBB4_4:
; RV64I-NEXT:    mv a0, s2
; RV64I-NEXT:    mv a1, s2
; RV64I-NEXT:    call __unordsf2
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    sgtz a1, s4
; RV64I-NEXT:    slti a2, s0, 0
; RV64I-NEXT:    addi a0, a0, -1
; RV64I-NEXT:    neg a3, a1
; RV64I-NEXT:    addi a2, a2, -1
; RV64I-NEXT:    and a1, a0, s3
; RV64I-NEXT:    and a2, a2, s1
; RV64I-NEXT:    or a2, a3, a2
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 40(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 32(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s3, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s4, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s5, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 64
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: fptosi_sat_f16_to_i128:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -32
; RV64IZFH-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fsw fs0, 12(sp) # 4-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fs0, fa0
; RV64IZFH-NEXT:    lui a0, 1044480
; RV64IZFH-NEXT:    fmv.w.x fa5, a0
; RV64IZFH-NEXT:    fle.s s0, fa5, fs0
; RV64IZFH-NEXT:    fmv.s fa0, fs0
; RV64IZFH-NEXT:    call __fixsfti
; RV64IZFH-NEXT:    li a2, -1
; RV64IZFH-NEXT:    bnez s0, .LBB4_2
; RV64IZFH-NEXT:  # %bb.1:
; RV64IZFH-NEXT:    slli a1, a2, 63
; RV64IZFH-NEXT:  .LBB4_2:
; RV64IZFH-NEXT:    lui a3, %hi(.LCPI4_0)
; RV64IZFH-NEXT:    flw fa5, %lo(.LCPI4_0)(a3)
; RV64IZFH-NEXT:    flt.s a3, fa5, fs0
; RV64IZFH-NEXT:    beqz a3, .LBB4_4
; RV64IZFH-NEXT:  # %bb.3:
; RV64IZFH-NEXT:    srli a1, a2, 1
; RV64IZFH-NEXT:  .LBB4_4:
; RV64IZFH-NEXT:    feq.s a2, fs0, fs0
; RV64IZFH-NEXT:    neg a3, a3
; RV64IZFH-NEXT:    neg a4, s0
; RV64IZFH-NEXT:    neg a2, a2
; RV64IZFH-NEXT:    and a0, a4, a0
; RV64IZFH-NEXT:    and a1, a2, a1
; RV64IZFH-NEXT:    or a0, a3, a0
; RV64IZFH-NEXT:    and a0, a2, a0
; RV64IZFH-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    flw fs0, 12(sp) # 4-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 32
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: fptosi_sat_f16_to_i128:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -32
; RV64IZHINX-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h s0, a0
; RV64IZHINX-NEXT:    lui a0, 1044480
; RV64IZHINX-NEXT:    fle.s s1, a0, s0
; RV64IZHINX-NEXT:    mv a0, s0
; RV64IZHINX-NEXT:    call __fixsfti
; RV64IZHINX-NEXT:    li a2, -1
; RV64IZHINX-NEXT:    bnez s1, .LBB4_2
; RV64IZHINX-NEXT:  # %bb.1:
; RV64IZHINX-NEXT:    slli a1, a2, 63
; RV64IZHINX-NEXT:  .LBB4_2:
; RV64IZHINX-NEXT:    lui a3, 520192
; RV64IZHINX-NEXT:    addiw a3, a3, -1
; RV64IZHINX-NEXT:    flt.s a3, a3, s0
; RV64IZHINX-NEXT:    beqz a3, .LBB4_4
; RV64IZHINX-NEXT:  # %bb.3:
; RV64IZHINX-NEXT:    srli a1, a2, 1
; RV64IZHINX-NEXT:  .LBB4_4:
; RV64IZHINX-NEXT:    feq.s a2, s0, s0
; RV64IZHINX-NEXT:    neg a3, a3
; RV64IZHINX-NEXT:    neg a4, s1
; RV64IZHINX-NEXT:    neg a2, a2
; RV64IZHINX-NEXT:    and a0, a4, a0
; RV64IZHINX-NEXT:    and a1, a2, a1
; RV64IZHINX-NEXT:    or a0, a3, a0
; RV64IZHINX-NEXT:    and a0, a2, a0
; RV64IZHINX-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 32
; RV64IZHINX-NEXT:    ret
  %1 = tail call i128 @llvm.fptosi.sat.i128.f16(half %a)
  ret i128 %1
}
declare i128 @llvm.fptosi.sat.i128.f16(half)

define i128 @fptoui_sat_f16_to_i128(half %a) nounwind {
; RV64I-LABEL: fptoui_sat_f16_to_i128:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __extendhfsf2
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    lui a1, 522240
; RV64I-NEXT:    addiw a1, a1, -1
; RV64I-NEXT:    call __gtsf2
; RV64I-NEXT:    sgtz a0, a0
; RV64I-NEXT:    neg s1, a0
; RV64I-NEXT:    mv a0, s0
; RV64I-NEXT:    li a1, 0
; RV64I-NEXT:    call __gesf2
; RV64I-NEXT:    slti a0, a0, 0
; RV64I-NEXT:    addi s2, a0, -1
; RV64I-NEXT:    mv a0, s0
; RV64I-NEXT:    call __fixunssfti
; RV64I-NEXT:    and a0, s2, a0
; RV64I-NEXT:    and a1, s2, a1
; RV64I-NEXT:    or a0, s1, a0
; RV64I-NEXT:    or a1, s1, a1
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s2, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
;
; RV64IZFH-LABEL: fptoui_sat_f16_to_i128:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -32
; RV64IZFH-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    lui a0, %hi(.LCPI5_0)
; RV64IZFH-NEXT:    flw fa5, %lo(.LCPI5_0)(a0)
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    fmv.w.x fa4, zero
; RV64IZFH-NEXT:    fle.s a0, fa4, fa0
; RV64IZFH-NEXT:    flt.s a1, fa5, fa0
; RV64IZFH-NEXT:    neg s0, a1
; RV64IZFH-NEXT:    neg s1, a0
; RV64IZFH-NEXT:    call __fixunssfti
; RV64IZFH-NEXT:    and a0, s1, a0
; RV64IZFH-NEXT:    and a1, s1, a1
; RV64IZFH-NEXT:    or a0, s0, a0
; RV64IZFH-NEXT:    or a1, s0, a1
; RV64IZFH-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 32
; RV64IZFH-NEXT:    ret
;
; RV64IZHINX-LABEL: fptoui_sat_f16_to_i128:
; RV64IZHINX:       # %bb.0:
; RV64IZHINX-NEXT:    addi sp, sp, -32
; RV64IZHINX-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64IZHINX-NEXT:    fcvt.s.h a0, a0
; RV64IZHINX-NEXT:    lui a1, 522240
; RV64IZHINX-NEXT:    addiw a1, a1, -1
; RV64IZHINX-NEXT:    fle.s a2, zero, a0
; RV64IZHINX-NEXT:    flt.s a1, a1, a0
; RV64IZHINX-NEXT:    neg s0, a1
; RV64IZHINX-NEXT:    neg s1, a2
; RV64IZHINX-NEXT:    call __fixunssfti
; RV64IZHINX-NEXT:    and a0, s1, a0
; RV64IZHINX-NEXT:    and a1, s1, a1
; RV64IZHINX-NEXT:    or a0, s0, a0
; RV64IZHINX-NEXT:    or a1, s0, a1
; RV64IZHINX-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64IZHINX-NEXT:    addi sp, sp, 32
; RV64IZHINX-NEXT:    ret
  %1 = tail call i128 @llvm.fptoui.sat.i128.f16(half %a)
  ret i128 %1
}
declare i128 @llvm.fptoui.sat.i128.f16(half)
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}