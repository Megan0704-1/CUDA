; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -global-isel -mattr=+d -verify-machineinstrs < %s \
; RUN:   -target-abi=ilp32d | FileCheck -check-prefixes=CHECKIFD,RV32IFD %s
; RUN: llc -mtriple=riscv64 -global-isel -mattr=+d -verify-machineinstrs < %s \
; RUN:   -target-abi=lp64d | FileCheck -check-prefixes=CHECKIFD,RV64IFD %s
; RUN: llc -mtriple=riscv32 -global-isel -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -global-isel -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

define float @fcvt_s_d(double %a) nounwind {
; CHECKIFD-LABEL: fcvt_s_d:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.s.d fa0, fa0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_s_d:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __truncdfsf2
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_s_d:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __truncdfsf2
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptrunc double %a to float
  ret float %1
}

define double @fcvt_d_s(float %a) nounwind {
; CHECKIFD-LABEL: fcvt_d_s:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.d.s fa0, fa0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_s:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __extendsfdf2
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __extendsfdf2
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fpext float %a to double
  ret double %1
}

define i32 @fcvt_w_d(double %a) nounwind {
; CHECKIFD-LABEL: fcvt_w_d:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.w.d a0, fa0, rtz
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_w_d:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixdfsi
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_w_d:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixdfsi
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptosi double %a to i32
  ret i32 %1
}

define i32 @fcvt_wu_d(double %a) nounwind {
; CHECKIFD-LABEL: fcvt_wu_d:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.wu.d a0, fa0, rtz
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_wu_d:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixunsdfsi
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_wu_d:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunsdfsi
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptoui double %a to i32
  ret i32 %1
}

define i32 @fcvt_wu_d_multiple_use(double %x, ptr %y) nounwind {
; CHECKIFD-LABEL: fcvt_wu_d_multiple_use:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.wu.d a0, fa0, rtz
; CHECKIFD-NEXT:    bnez a0, .LBB4_2
; CHECKIFD-NEXT:  # %bb.1:
; CHECKIFD-NEXT:    li a0, 1
; CHECKIFD-NEXT:  .LBB4_2:
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_wu_d_multiple_use:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixunsdfsi
; RV32I-NEXT:    bnez a0, .LBB4_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    li a0, 1
; RV32I-NEXT:  .LBB4_2:
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_wu_d_multiple_use:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunsdfsi
; RV64I-NEXT:    sext.w a1, a0
; RV64I-NEXT:    bnez a1, .LBB4_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    li a0, 1
; RV64I-NEXT:  .LBB4_2:
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %a = fptoui double %x to i32
  %b = icmp eq i32 %a, 0
  %c = select i1 %b, i32 1, i32 %a
  ret i32 %c
}

define double @fcvt_d_w(i32 %a) nounwind {
; CHECKIFD-LABEL: fcvt_d_w:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.d.w fa0, a0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_w:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatsidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_w:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    call __floatsidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = sitofp i32 %a to double
  ret double %1
}

define double @fcvt_d_w_load(ptr %p) nounwind {
; CHECKIFD-LABEL: fcvt_d_w_load:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    lw a0, 0(a0)
; CHECKIFD-NEXT:    fcvt.d.w fa0, a0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_w_load:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lw a0, 0(a0)
; RV32I-NEXT:    call __floatsidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_w_load:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lw a0, 0(a0)
; RV64I-NEXT:    call __floatsidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %a = load i32, ptr %p
  %1 = sitofp i32 %a to double
  ret double %1
}

define double @fcvt_d_wu(i32 %a) nounwind {
; CHECKIFD-LABEL: fcvt_d_wu:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.d.wu fa0, a0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_wu:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatunsidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_wu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    call __floatunsidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = uitofp i32 %a to double
  ret double %1
}

define double @fcvt_d_wu_load(ptr %p) nounwind {
; RV32IFD-LABEL: fcvt_d_wu_load:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    lw a0, 0(a0)
; RV32IFD-NEXT:    fcvt.d.wu fa0, a0
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_d_wu_load:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    lwu a0, 0(a0)
; RV64IFD-NEXT:    fcvt.d.wu fa0, a0
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_wu_load:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lw a0, 0(a0)
; RV32I-NEXT:    call __floatunsidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_wu_load:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lw a0, 0(a0)
; RV64I-NEXT:    call __floatunsidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %a = load i32, ptr %p
  %1 = uitofp i32 %a to double
  ret double %1
}

define i64 @fcvt_l_d(double %a) nounwind {
; RV32IFD-LABEL: fcvt_l_d:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    call __fixdfdi
; RV32IFD-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_l_d:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.l.d a0, fa0, rtz
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_l_d:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixdfdi
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_l_d:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixdfdi
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptosi double %a to i64
  ret i64 %1
}

define i64 @fcvt_lu_d(double %a) nounwind {
; RV32IFD-LABEL: fcvt_lu_d:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    call __fixunsdfdi
; RV32IFD-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_lu_d:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.lu.d a0, fa0, rtz
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_lu_d:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixunsdfdi
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_lu_d:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunsdfdi
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptoui double %a to i64
  ret i64 %1
}

define i64 @fmv_x_d(double %a, double %b) nounwind {
; RV32IFD-LABEL: fmv_x_d:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    fadd.d fa5, fa0, fa1
; RV32IFD-NEXT:    fsd fa5, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fmv_x_d:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fadd.d fa5, fa0, fa1
; RV64IFD-NEXT:    fmv.x.d a0, fa5
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fmv_x_d:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __adddf3
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fmv_x_d:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __adddf3
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fadd double %a, %b
  %2 = bitcast double %1 to i64
  ret i64 %2
}

define double @fcvt_d_l(i64 %a) nounwind {
; RV32IFD-LABEL: fcvt_d_l:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    call __floatdidf
; RV32IFD-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_d_l:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.d.l fa0, a0
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_l:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatdidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_l:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatdidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = sitofp i64 %a to double
  ret double %1
}

define double @fcvt_d_lu(i64 %a) nounwind {
; RV32IFD-LABEL: fcvt_d_lu:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    call __floatundidf
; RV32IFD-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_d_lu:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.d.lu fa0, a0
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_lu:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatundidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_lu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatundidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = uitofp i64 %a to double
  ret double %1
}

define double @fmv_d_x(i64 %a, i64 %b) nounwind {
; RV32IFD-LABEL: fmv_d_x:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw a0, 8(sp)
; RV32IFD-NEXT:    sw a1, 12(sp)
; RV32IFD-NEXT:    fld fa5, 8(sp)
; RV32IFD-NEXT:    sw a2, 8(sp)
; RV32IFD-NEXT:    sw a3, 12(sp)
; RV32IFD-NEXT:    fld fa4, 8(sp)
; RV32IFD-NEXT:    fadd.d fa0, fa5, fa4
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fmv_d_x:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fmv.d.x fa5, a0
; RV64IFD-NEXT:    fmv.d.x fa4, a1
; RV64IFD-NEXT:    fadd.d fa0, fa5, fa4
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fmv_d_x:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __adddf3
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fmv_d_x:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __adddf3
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = bitcast i64 %a to double
  %2 = bitcast i64 %b to double
  %3 = fadd double %1, %2
  ret double %3
}

define double @fcvt_d_w_i8(i8 signext %a) nounwind {
; CHECKIFD-LABEL: fcvt_d_w_i8:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.d.w fa0, a0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_w_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatsidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_w_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatsidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = sitofp i8 %a to double
  ret double %1
}

define double @fcvt_d_wu_i8(i8 zeroext %a) nounwind {
; CHECKIFD-LABEL: fcvt_d_wu_i8:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.d.wu fa0, a0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_wu_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatunsidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_wu_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatunsidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = uitofp i8 %a to double
  ret double %1
}

define double @fcvt_d_w_i16(i16 signext %a) nounwind {
; CHECKIFD-LABEL: fcvt_d_w_i16:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.d.w fa0, a0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_w_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatsidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_w_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatsidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = sitofp i16 %a to double
  ret double %1
}

define double @fcvt_d_wu_i16(i16 zeroext %a) nounwind {
; CHECKIFD-LABEL: fcvt_d_wu_i16:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.d.wu fa0, a0
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_wu_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __floatunsidf
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_wu_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatunsidf
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = uitofp i16 %a to double
  ret double %1
}

define signext i32 @fcvt_d_w_demanded_bits(i32 signext %0, ptr %1) nounwind {
; RV32IFD-LABEL: fcvt_d_w_demanded_bits:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi a0, a0, 1
; RV32IFD-NEXT:    fcvt.d.w fa5, a0
; RV32IFD-NEXT:    fsd fa5, 0(a1)
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_d_w_demanded_bits:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    addiw a0, a0, 1
; RV64IFD-NEXT:    fcvt.d.w fa5, a0
; RV64IFD-NEXT:    fsd fa5, 0(a1)
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_w_demanded_bits:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a1
; RV32I-NEXT:    addi s1, a0, 1
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __floatsidf
; RV32I-NEXT:    sw a0, 0(s0)
; RV32I-NEXT:    sw a1, 4(s0)
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_w_demanded_bits:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a1
; RV64I-NEXT:    addiw s1, a0, 1
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __floatsidf
; RV64I-NEXT:    sd a0, 0(s0)
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %3 = add i32 %0, 1
  %4 = sitofp i32 %3 to double
  store double %4, ptr %1, align 8
  ret i32 %3
}

define signext i32 @fcvt_d_wu_demanded_bits(i32 signext %0, ptr %1) nounwind {
; RV32IFD-LABEL: fcvt_d_wu_demanded_bits:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi a0, a0, 1
; RV32IFD-NEXT:    fcvt.d.wu fa5, a0
; RV32IFD-NEXT:    fsd fa5, 0(a1)
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_d_wu_demanded_bits:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    addiw a0, a0, 1
; RV64IFD-NEXT:    fcvt.d.wu fa5, a0
; RV64IFD-NEXT:    fsd fa5, 0(a1)
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_d_wu_demanded_bits:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a1
; RV32I-NEXT:    addi s1, a0, 1
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    call __floatunsidf
; RV32I-NEXT:    sw a0, 0(s0)
; RV32I-NEXT:    sw a1, 4(s0)
; RV32I-NEXT:    mv a0, s1
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_d_wu_demanded_bits:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a1
; RV64I-NEXT:    addiw s1, a0, 1
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    call __floatunsidf
; RV64I-NEXT:    sd a0, 0(s0)
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %3 = add i32 %0, 1
  %4 = uitofp i32 %3 to double
  store double %4, ptr %1, align 8
  ret i32 %3
}

define signext i16 @fcvt_w_s_i16(double %a) nounwind {
; RV32IFD-LABEL: fcvt_w_s_i16:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    fcvt.w.d a0, fa0, rtz
; RV32IFD-NEXT:    slli a0, a0, 16
; RV32IFD-NEXT:    srai a0, a0, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_w_s_i16:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.w.d a0, fa0, rtz
; RV64IFD-NEXT:    slli a0, a0, 48
; RV64IFD-NEXT:    srai a0, a0, 48
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_w_s_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixdfsi
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_w_s_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixdfsi
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptosi double %a to i16
  ret i16 %1
}

define zeroext i16 @fcvt_wu_s_i16(double %a) nounwind {
; RV32IFD-LABEL: fcvt_wu_s_i16:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    fcvt.wu.d a0, fa0, rtz
; RV32IFD-NEXT:    slli a0, a0, 16
; RV32IFD-NEXT:    srli a0, a0, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_wu_s_i16:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.wu.d a0, fa0, rtz
; RV64IFD-NEXT:    slli a0, a0, 48
; RV64IFD-NEXT:    srli a0, a0, 48
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_wu_s_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixunsdfsi
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srli a0, a0, 16
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_wu_s_i16:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunsdfsi
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srli a0, a0, 48
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptoui double %a to i16
  ret i16 %1
}

define signext i8 @fcvt_w_s_i8(double %a) nounwind {
; RV32IFD-LABEL: fcvt_w_s_i8:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    fcvt.w.d a0, fa0, rtz
; RV32IFD-NEXT:    slli a0, a0, 24
; RV32IFD-NEXT:    srai a0, a0, 24
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fcvt_w_s_i8:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fcvt.w.d a0, fa0, rtz
; RV64IFD-NEXT:    slli a0, a0, 56
; RV64IFD-NEXT:    srai a0, a0, 56
; RV64IFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_w_s_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixdfsi
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 24
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_w_s_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixdfsi
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptosi double %a to i8
  ret i8 %1
}

define zeroext i8 @fcvt_wu_s_i8(double %a) nounwind {
; CHECKIFD-LABEL: fcvt_wu_s_i8:
; CHECKIFD:       # %bb.0:
; CHECKIFD-NEXT:    fcvt.wu.d a0, fa0, rtz
; CHECKIFD-NEXT:    andi a0, a0, 255
; CHECKIFD-NEXT:    ret
;
; RV32I-LABEL: fcvt_wu_s_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __fixunsdfsi
; RV32I-NEXT:    andi a0, a0, 255
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fcvt_wu_s_i8:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunsdfsi
; RV64I-NEXT:    andi a0, a0, 255
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptoui double %a to i8
  ret i8 %1
}