; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --no_x86_scrub_sp --version 5
; RUN: llc < %s -mtriple=i386-unknown-linux-gnu  | FileCheck %s

define void @test_sincos_v4f32(<4 x float> %x, ptr noalias %out_sin, ptr noalias %out_cos) {
; CHECK-LABEL: test_sincos_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    subl $52, %esp
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset %esi, -12
; CHECK-NEXT:    .cfi_offset %edi, -8
; CHECK-NEXT:    movl 84(%esp), %esi
; CHECK-NEXT:    flds 76(%esp)
; CHECK-NEXT:    fstps {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Spill
; CHECK-NEXT:    flds 64(%esp)
; CHECK-NEXT:    fstps {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Spill
; CHECK-NEXT:    flds 72(%esp)
; CHECK-NEXT:    fstps {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Spill
; CHECK-NEXT:    flds 68(%esp)
; CHECK-NEXT:    movl 80(%esp), %edi
; CHECK-NEXT:    leal 40(%esp), %eax
; CHECK-NEXT:    movl %eax, 8(%esp)
; CHECK-NEXT:    leal 4(%edi), %eax
; CHECK-NEXT:    movl %eax, 4(%esp)
; CHECK-NEXT:    fstps (%esp)
; CHECK-NEXT:    calll sincosf
; CHECK-NEXT:    leal 44(%esp), %eax
; CHECK-NEXT:    movl %eax, 8(%esp)
; CHECK-NEXT:    leal 8(%edi), %eax
; CHECK-NEXT:    movl %eax, 4(%esp)
; CHECK-NEXT:    flds {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; CHECK-NEXT:    fstps (%esp)
; CHECK-NEXT:    calll sincosf
; CHECK-NEXT:    leal 36(%esp), %eax
; CHECK-NEXT:    movl %eax, 8(%esp)
; CHECK-NEXT:    movl %edi, 4(%esp)
; CHECK-NEXT:    flds {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; CHECK-NEXT:    fstps (%esp)
; CHECK-NEXT:    calll sincosf
; CHECK-NEXT:    leal 48(%esp), %eax
; CHECK-NEXT:    movl %eax, 8(%esp)
; CHECK-NEXT:    addl $12, %edi
; CHECK-NEXT:    movl %edi, 4(%esp)
; CHECK-NEXT:    flds {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; CHECK-NEXT:    fstps (%esp)
; CHECK-NEXT:    calll sincosf
; CHECK-NEXT:    flds 36(%esp)
; CHECK-NEXT:    flds 40(%esp)
; CHECK-NEXT:    flds 44(%esp)
; CHECK-NEXT:    flds 48(%esp)
; CHECK-NEXT:    fstps 12(%esi)
; CHECK-NEXT:    fstps 8(%esi)
; CHECK-NEXT:    fstps 4(%esi)
; CHECK-NEXT:    fstps (%esi)
; CHECK-NEXT:    addl $52, %esp
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    retl
  %result = call { <4 x float>, <4 x float> } @llvm.sincos.v4f32(<4 x float> %x)
  %result.0 = extractvalue { <4 x float>, <4 x float> } %result, 0
  %result.1 = extractvalue { <4 x float>, <4 x float> } %result, 1
  store <4 x float> %result.0, ptr %out_sin, align 4
  store <4 x float> %result.1, ptr %out_cos, align 4
  ret void
}

define void @test_sincos_v2f64(<2 x double> %x, ptr noalias %out_sin, ptr noalias %out_cos) {
; CHECK-LABEL: test_sincos_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    subl $52, %esp
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset %esi, -12
; CHECK-NEXT:    .cfi_offset %edi, -8
; CHECK-NEXT:    movl 84(%esp), %esi
; CHECK-NEXT:    fldl 72(%esp)
; CHECK-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; CHECK-NEXT:    fldl 64(%esp)
; CHECK-NEXT:    movl 80(%esp), %edi
; CHECK-NEXT:    leal 24(%esp), %eax
; CHECK-NEXT:    movl %eax, 12(%esp)
; CHECK-NEXT:    movl %edi, 8(%esp)
; CHECK-NEXT:    fstpl (%esp)
; CHECK-NEXT:    calll sincos
; CHECK-NEXT:    leal 32(%esp), %eax
; CHECK-NEXT:    movl %eax, 12(%esp)
; CHECK-NEXT:    addl $8, %edi
; CHECK-NEXT:    movl %edi, 8(%esp)
; CHECK-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; CHECK-NEXT:    fstpl (%esp)
; CHECK-NEXT:    calll sincos
; CHECK-NEXT:    fldl 24(%esp)
; CHECK-NEXT:    fldl 32(%esp)
; CHECK-NEXT:    fstpl 8(%esi)
; CHECK-NEXT:    fstpl (%esi)
; CHECK-NEXT:    addl $52, %esp
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    retl
  %result = call { <2 x double>, <2 x double> } @llvm.sincos.v2f64(<2 x double> %x)
  %result.0 = extractvalue { <2 x double>, <2 x double> } %result, 0
  %result.1 = extractvalue { <2 x double>, <2 x double> } %result, 1
  store <2 x double> %result.0, ptr %out_sin, align 8
  store <2 x double> %result.1, ptr %out_cos, align 8
  ret void
}

declare void @foo(ptr, ptr)

define void @can_fold_with_call_in_chain(float %x, ptr noalias %a, ptr noalias %b) {
; CHECK-LABEL: can_fold_with_call_in_chain:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    subl $20, %esp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset %esi, -12
; CHECK-NEXT:    .cfi_offset %edi, -8
; CHECK-NEXT:    flds 32(%esp)
; CHECK-NEXT:    fstps {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Spill
; CHECK-NEXT:    movl 36(%esp), %edi
; CHECK-NEXT:    movl 40(%esp), %esi
; CHECK-NEXT:    movl %esi, 4(%esp)
; CHECK-NEXT:    movl %edi, (%esp)
; CHECK-NEXT:    calll foo@PLT
; CHECK-NEXT:    leal 16(%esp), %eax
; CHECK-NEXT:    movl %eax, 8(%esp)
; CHECK-NEXT:    movl %edi, 4(%esp)
; CHECK-NEXT:    flds {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; CHECK-NEXT:    fstps (%esp)
; CHECK-NEXT:    calll sincosf
; CHECK-NEXT:    flds 16(%esp)
; CHECK-NEXT:    fstps (%esi)
; CHECK-NEXT:    addl $20, %esp
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 4
; CHECK-NEXT:    retl
entry:
  %sin = tail call float @llvm.sin.f32(float %x)
  %cos = tail call float @llvm.cos.f32(float %x)
  call void @foo(ptr %a, ptr %b)
  store float %sin, ptr %a, align 4
  store float %cos, ptr %b, align 4
  ret void
}