; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=mips     -mcpu=mips32r5 -mattr=+msa,+fp64 -O0 < %s | FileCheck %s --check-prefix=MIPS32R5-EB
; RUN: llc -mtriple=mipsel   -mcpu=mips32r5 -mattr=+msa,+fp64 -O0 < %s | FileCheck %s --check-prefix=MIPS32R5-EL
; RUN: llc -mtriple=mips     -mcpu=mips32r6 -mattr=+msa,+fp64 -O0 < %s | FileCheck %s --check-prefix=MIPS32R6-EB
; RUN: llc -mtriple=mipsel   -mcpu=mips32r6 -mattr=+msa,+fp64 -O0 < %s | FileCheck %s --check-prefix=MIPS32R6-EL
; RUN: llc -mtriple=mips64   -mcpu=mips64r6 -mattr=+msa,+fp64 -O0 < %s | FileCheck %s --check-prefix=MIPS64R6
; RUN: llc -mtriple=mips64el -mcpu=mips64r6 -mattr=+msa,+fp64 -O0 < %s | FileCheck %s --check-prefix=MIPS64R6

; Test intrinsics for 4-byte and 8-byte MSA load and stores.

define void @llvm_mips_ldr_d_test(ptr %val, ptr %ptr) nounwind {
; MIPS32R5-EB-LABEL: llvm_mips_ldr_d_test:
; MIPS32R5-EB:       # %bb.0: # %entry
; MIPS32R5-EB-NEXT:    # implicit-def: $v0
; MIPS32R5-EB-NEXT:    lwr $2, 23($5)
; MIPS32R5-EB-NEXT:    lwl $2, 20($5)
; MIPS32R5-EB-NEXT:    # implicit-def: $at
; MIPS32R5-EB-NEXT:    lwr $1, 19($5)
; MIPS32R5-EB-NEXT:    lwl $1, 16($5)
; MIPS32R5-EB-NEXT:    fill.w $w0, $2
; MIPS32R5-EB-NEXT:    insert.w $w0[1], $1
; MIPS32R5-EB-NEXT:    st.d $w0, 0($4)
; MIPS32R5-EB-NEXT:    jr $ra
; MIPS32R5-EB-NEXT:    nop
;
; MIPS32R5-EL-LABEL: llvm_mips_ldr_d_test:
; MIPS32R5-EL:       # %bb.0: # %entry
; MIPS32R5-EL-NEXT:    # implicit-def: $v0
; MIPS32R5-EL-NEXT:    lwr $2, 16($5)
; MIPS32R5-EL-NEXT:    lwl $2, 19($5)
; MIPS32R5-EL-NEXT:    # implicit-def: $at
; MIPS32R5-EL-NEXT:    lwr $1, 20($5)
; MIPS32R5-EL-NEXT:    lwl $1, 23($5)
; MIPS32R5-EL-NEXT:    fill.w $w0, $2
; MIPS32R5-EL-NEXT:    insert.w $w0[1], $1
; MIPS32R5-EL-NEXT:    st.d $w0, 0($4)
; MIPS32R5-EL-NEXT:    jr $ra
; MIPS32R5-EL-NEXT:    nop
;
; MIPS32R6-EB-LABEL: llvm_mips_ldr_d_test:
; MIPS32R6-EB:       # %bb.0: # %entry
; MIPS32R6-EB-NEXT:    lw $2, 20($5)
; MIPS32R6-EB-NEXT:    lw $1, 16($5)
; MIPS32R6-EB-NEXT:    fill.w $w0, $2
; MIPS32R6-EB-NEXT:    insert.w $w0[1], $1
; MIPS32R6-EB-NEXT:    st.d $w0, 0($4)
; MIPS32R6-EB-NEXT:    jrc $ra
;
; MIPS32R6-EL-LABEL: llvm_mips_ldr_d_test:
; MIPS32R6-EL:       # %bb.0: # %entry
; MIPS32R6-EL-NEXT:    lw $2, 16($5)
; MIPS32R6-EL-NEXT:    lw $1, 20($5)
; MIPS32R6-EL-NEXT:    fill.w $w0, $2
; MIPS32R6-EL-NEXT:    insert.w $w0[1], $1
; MIPS32R6-EL-NEXT:    st.d $w0, 0($4)
; MIPS32R6-EL-NEXT:    jrc $ra
;
; MIPS64R6-LABEL: llvm_mips_ldr_d_test:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    ld $1, 16($5)
; MIPS64R6-NEXT:    fill.d $w0, $1
; MIPS64R6-NEXT:    st.d $w0, 0($4)
; MIPS64R6-NEXT:    jrc $ra
entry:
  %0 = tail call <2 x i64> @llvm.mips.ldr.d(ptr %ptr, i32 16)
  store <2 x i64> %0, ptr %val
  ret void
}

declare <2 x i64> @llvm.mips.ldr.d(ptr, i32) nounwind

define void @llvm_mips_ldr_w_test(ptr %val, ptr %ptr) nounwind {
; MIPS32R5-EB-LABEL: llvm_mips_ldr_w_test:
; MIPS32R5-EB:       # %bb.0: # %entry
; MIPS32R5-EB-NEXT:    # implicit-def: $at
; MIPS32R5-EB-NEXT:    lwr $1, 19($5)
; MIPS32R5-EB-NEXT:    lwl $1, 16($5)
; MIPS32R5-EB-NEXT:    fill.w $w0, $1
; MIPS32R5-EB-NEXT:    st.w $w0, 0($4)
; MIPS32R5-EB-NEXT:    jr $ra
; MIPS32R5-EB-NEXT:    nop
;
; MIPS32R5-EL-LABEL: llvm_mips_ldr_w_test:
; MIPS32R5-EL:       # %bb.0: # %entry
; MIPS32R5-EL-NEXT:    # implicit-def: $at
; MIPS32R5-EL-NEXT:    lwr $1, 16($5)
; MIPS32R5-EL-NEXT:    lwl $1, 19($5)
; MIPS32R5-EL-NEXT:    fill.w $w0, $1
; MIPS32R5-EL-NEXT:    st.w $w0, 0($4)
; MIPS32R5-EL-NEXT:    jr $ra
; MIPS32R5-EL-NEXT:    nop
;
; MIPS32R6-EB-LABEL: llvm_mips_ldr_w_test:
; MIPS32R6-EB:       # %bb.0: # %entry
; MIPS32R6-EB-NEXT:    lw $1, 16($5)
; MIPS32R6-EB-NEXT:    fill.w $w0, $1
; MIPS32R6-EB-NEXT:    st.w $w0, 0($4)
; MIPS32R6-EB-NEXT:    jrc $ra
;
; MIPS32R6-EL-LABEL: llvm_mips_ldr_w_test:
; MIPS32R6-EL:       # %bb.0: # %entry
; MIPS32R6-EL-NEXT:    lw $1, 16($5)
; MIPS32R6-EL-NEXT:    fill.w $w0, $1
; MIPS32R6-EL-NEXT:    st.w $w0, 0($4)
; MIPS32R6-EL-NEXT:    jrc $ra
;
; MIPS64R6-LABEL: llvm_mips_ldr_w_test:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    lw $1, 16($5)
; MIPS64R6-NEXT:    fill.w $w0, $1
; MIPS64R6-NEXT:    st.w $w0, 0($4)
; MIPS64R6-NEXT:    jrc $ra
entry:
  %0 = tail call <4 x i32> @llvm.mips.ldr.w(ptr %ptr, i32 16)
  store <4 x i32> %0, ptr %val
  ret void
}

declare <4 x i32> @llvm.mips.ldr.w(ptr, i32) nounwind

define void @llvm_mips_str_d_test(ptr %val, ptr %ptr) nounwind {
; MIPS32R5-EB-LABEL: llvm_mips_str_d_test:
; MIPS32R5-EB:       # %bb.0: # %entry
; MIPS32R5-EB-NEXT:    ld.d $w0, 0($4)
; MIPS32R5-EB-NEXT:    copy_s.w $2, $w0[0]
; MIPS32R5-EB-NEXT:    copy_s.w $1, $w0[1]
; MIPS32R5-EB-NEXT:    swr $2, 19($5)
; MIPS32R5-EB-NEXT:    swl $2, 16($5)
; MIPS32R5-EB-NEXT:    swr $1, 23($5)
; MIPS32R5-EB-NEXT:    swl $1, 20($5)
; MIPS32R5-EB-NEXT:    jr $ra
; MIPS32R5-EB-NEXT:    nop
;
; MIPS32R5-EL-LABEL: llvm_mips_str_d_test:
; MIPS32R5-EL:       # %bb.0: # %entry
; MIPS32R5-EL-NEXT:    ld.d $w0, 0($4)
; MIPS32R5-EL-NEXT:    copy_s.w $2, $w0[0]
; MIPS32R5-EL-NEXT:    copy_s.w $1, $w0[1]
; MIPS32R5-EL-NEXT:    swr $2, 16($5)
; MIPS32R5-EL-NEXT:    swl $2, 19($5)
; MIPS32R5-EL-NEXT:    swr $1, 20($5)
; MIPS32R5-EL-NEXT:    swl $1, 23($5)
; MIPS32R5-EL-NEXT:    jr $ra
; MIPS32R5-EL-NEXT:    nop
;
; MIPS32R6-EB-LABEL: llvm_mips_str_d_test:
; MIPS32R6-EB:       # %bb.0: # %entry
; MIPS32R6-EB-NEXT:    ld.d $w0, 0($4)
; MIPS32R6-EB-NEXT:    copy_s.w $2, $w0[0]
; MIPS32R6-EB-NEXT:    copy_s.w $1, $w0[1]
; MIPS32R6-EB-NEXT:    sw $2, 20($5)
; MIPS32R6-EB-NEXT:    sw $1, 16($5)
; MIPS32R6-EB-NEXT:    jrc $ra
;
; MIPS32R6-EL-LABEL: llvm_mips_str_d_test:
; MIPS32R6-EL:       # %bb.0: # %entry
; MIPS32R6-EL-NEXT:    ld.d $w0, 0($4)
; MIPS32R6-EL-NEXT:    copy_s.w $2, $w0[0]
; MIPS32R6-EL-NEXT:    copy_s.w $1, $w0[1]
; MIPS32R6-EL-NEXT:    sw $2, 16($5)
; MIPS32R6-EL-NEXT:    sw $1, 20($5)
; MIPS32R6-EL-NEXT:    jrc $ra
;
; MIPS64R6-LABEL: llvm_mips_str_d_test:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    ld.d $w0, 0($4)
; MIPS64R6-NEXT:    copy_s.d $1, $w0[0]
; MIPS64R6-NEXT:    sd $1, 16($5)
; MIPS64R6-NEXT:    jrc $ra
entry:
  %0 = load <2 x i64>, ptr %val
  tail call void @llvm.mips.str.d(<2 x i64> %0, ptr %ptr, i32 16)
  ret void
}

declare void @llvm.mips.str.d(<2 x i64>, ptr, i32) nounwind

define void @llvm_mips_str_w_test(ptr %val, ptr %ptr) nounwind {
; MIPS32R5-EB-LABEL: llvm_mips_str_w_test:
; MIPS32R5-EB:       # %bb.0: # %entry
; MIPS32R5-EB-NEXT:    ld.w $w0, 0($4)
; MIPS32R5-EB-NEXT:    copy_s.w $1, $w0[0]
; MIPS32R5-EB-NEXT:    swr $1, 19($5)
; MIPS32R5-EB-NEXT:    swl $1, 16($5)
; MIPS32R5-EB-NEXT:    jr $ra
; MIPS32R5-EB-NEXT:    nop
;
; MIPS32R5-EL-LABEL: llvm_mips_str_w_test:
; MIPS32R5-EL:       # %bb.0: # %entry
; MIPS32R5-EL-NEXT:    ld.w $w0, 0($4)
; MIPS32R5-EL-NEXT:    copy_s.w $1, $w0[0]
; MIPS32R5-EL-NEXT:    swr $1, 16($5)
; MIPS32R5-EL-NEXT:    swl $1, 19($5)
; MIPS32R5-EL-NEXT:    jr $ra
; MIPS32R5-EL-NEXT:    nop
;
; MIPS32R6-EB-LABEL: llvm_mips_str_w_test:
; MIPS32R6-EB:       # %bb.0: # %entry
; MIPS32R6-EB-NEXT:    ld.w $w0, 0($4)
; MIPS32R6-EB-NEXT:    copy_s.w $1, $w0[0]
; MIPS32R6-EB-NEXT:    sw $1, 16($5)
; MIPS32R6-EB-NEXT:    jrc $ra
;
; MIPS32R6-EL-LABEL: llvm_mips_str_w_test:
; MIPS32R6-EL:       # %bb.0: # %entry
; MIPS32R6-EL-NEXT:    ld.w $w0, 0($4)
; MIPS32R6-EL-NEXT:    copy_s.w $1, $w0[0]
; MIPS32R6-EL-NEXT:    sw $1, 16($5)
; MIPS32R6-EL-NEXT:    jrc $ra
;
; MIPS64R6-LABEL: llvm_mips_str_w_test:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    ld.w $w0, 0($4)
; MIPS64R6-NEXT:    copy_s.w $1, $w0[0]
; MIPS64R6-NEXT:    sw $1, 16($5)
; MIPS64R6-NEXT:    jrc $ra
entry:
  %0 = load <4 x i32>, ptr %val
  tail call void @llvm.mips.str.w(<4 x i32> %0, ptr %ptr, i32 16)
  ret void
}

declare void @llvm.mips.str.w(<4 x i32>, ptr, i32) nounwind
