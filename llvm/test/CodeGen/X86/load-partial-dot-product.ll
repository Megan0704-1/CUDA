; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+ssse3 | FileCheck %s --check-prefixes=SSSE3
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=AVX

; Partial load dot product patterns based off PR51075

;
; dot3(ptr x, ptr y) - ((xptr y[0])+(xptr y[1])+(xptr y[2]))
;

define float @dot3_float4(ptr dereferenceable(16) %a0, ptr dereferenceable(16) %a1) {
; SSE2-LABEL: dot3_float4:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movups (%rdi), %xmm0
; SSE2-NEXT:    movups (%rsi), %xmm1
; SSE2-NEXT:    mulps %xmm0, %xmm1
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: dot3_float4:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    movups (%rdi), %xmm0
; SSSE3-NEXT:    movups (%rsi), %xmm1
; SSSE3-NEXT:    mulps %xmm0, %xmm1
; SSSE3-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: dot3_float4:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movups (%rdi), %xmm0
; SSE41-NEXT:    movups (%rsi), %xmm1
; SSE41-NEXT:    mulps %xmm0, %xmm1
; SSE41-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: dot3_float4:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovups (%rdi), %xmm0
; AVX-NEXT:    vmulps (%rsi), %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vshufpd {{.*#+}} xmm2 = xmm0[1,0]
; AVX-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vaddss %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x0123 = load <4 x float>, ptr %a0, align 4
  %y0123 = load <4 x float>, ptr %a1, align 4
  %mul0123 = fmul <4 x float> %x0123, %y0123
  %mul0 = extractelement <4 x float> %mul0123, i32 0
  %mul1 = extractelement <4 x float> %mul0123, i32 1
  %mul2 = extractelement <4 x float> %mul0123, i32 2
  %dot01 = fadd float %mul0, %mul1
  %dot012 = fadd float %dot01, %mul2
  ret float %dot012
}

define float @dot3_float4_as_float3(ptr dereferenceable(16) %a0, ptr dereferenceable(16) %a1) {
; SSE2-LABEL: dot3_float4_as_float3:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movups (%rdi), %xmm0
; SSE2-NEXT:    movups (%rsi), %xmm1
; SSE2-NEXT:    mulps %xmm0, %xmm1
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: dot3_float4_as_float3:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    movups (%rdi), %xmm0
; SSSE3-NEXT:    movups (%rsi), %xmm1
; SSSE3-NEXT:    mulps %xmm0, %xmm1
; SSSE3-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: dot3_float4_as_float3:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movups (%rdi), %xmm0
; SSE41-NEXT:    movups (%rsi), %xmm1
; SSE41-NEXT:    mulps %xmm0, %xmm1
; SSE41-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: dot3_float4_as_float3:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovups (%rdi), %xmm0
; AVX-NEXT:    vmulps (%rsi), %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vshufpd {{.*#+}} xmm2 = xmm0[1,0]
; AVX-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vaddss %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x0123 = load <4 x float>, ptr %a0, align 4
  %y0123 = load <4 x float>, ptr %a1, align 4
  %x012 = shufflevector <4 x float> %x0123, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %y012 = shufflevector <4 x float> %y0123, <4 x float> undef, <3 x i32> <i32 0, i32 1, i32 2>
  %mul012 = fmul <3 x float> %x012, %y012
  %mul0 = extractelement <3 x float> %mul012, i32 0
  %mul1 = extractelement <3 x float> %mul012, i32 1
  %mul2 = extractelement <3 x float> %mul012, i32 2
  %dot01 = fadd float %mul0, %mul1
  %dot012 = fadd float %dot01, %mul2
  ret float %dot012
}

define float @dot3_float3(ptr dereferenceable(16) %a0, ptr dereferenceable(16) %a1) {
; SSE2-LABEL: dot3_float3:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    movss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,0],xmm0[3,0]
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,1],xmm1[0,2]
; SSE2-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSE2-NEXT:    movss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSE2-NEXT:    shufps {{.*#+}} xmm2 = xmm2[0,0],xmm1[3,0]
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,1],xmm2[0,2]
; SSE2-NEXT:    mulps %xmm0, %xmm1
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: dot3_float3:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSSE3-NEXT:    movss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSSE3-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,0],xmm0[3,0]
; SSSE3-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,1],xmm1[0,2]
; SSSE3-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSSE3-NEXT:    movss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSSE3-NEXT:    shufps {{.*#+}} xmm2 = xmm2[0,0],xmm1[3,0]
; SSSE3-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,1],xmm2[0,2]
; SSSE3-NEXT:    mulps %xmm0, %xmm1
; SSSE3-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: dot3_float3:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE41-NEXT:    insertps {{.*#+}} xmm0 = xmm0[0,1],mem[0],xmm0[3]
; SSE41-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSE41-NEXT:    insertps {{.*#+}} xmm1 = xmm1[0,1],mem[0],xmm1[3]
; SSE41-NEXT:    mulps %xmm0, %xmm1
; SSE41-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: dot3_float3:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; AVX-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],mem[0],xmm0[3]
; AVX-NEXT:    vmovsd {{.*#+}} xmm1 = mem[0],zero
; AVX-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1],mem[0],xmm1[3]
; AVX-NEXT:    vmulps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vshufpd {{.*#+}} xmm2 = xmm0[1,0]
; AVX-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vaddss %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x012 = load <3 x float>, ptr %a0, align 4
  %y012 = load <3 x float>, ptr %a1, align 4
  %mul012 = fmul <3 x float> %x012, %y012
  %mul0 = extractelement <3 x float> %mul012, i32 0
  %mul1 = extractelement <3 x float> %mul012, i32 1
  %mul2 = extractelement <3 x float> %mul012, i32 2
  %dot01 = fadd float %mul0, %mul1
  %dot012 = fadd float %dot01, %mul2
  ret float %dot012
}

define float @dot3_float2_float(ptr dereferenceable(16) %a0, ptr dereferenceable(16) %a1) {
; SSE2-LABEL: dot3_float2_float:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSE2-NEXT:    mulps %xmm0, %xmm1
; SSE2-NEXT:    movss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSE2-NEXT:    mulss 8(%rsi), %xmm2
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    addss %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: dot3_float2_float:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSSE3-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSSE3-NEXT:    mulps %xmm0, %xmm1
; SSSE3-NEXT:    movss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSSE3-NEXT:    mulss 8(%rsi), %xmm2
; SSSE3-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    addss %xmm2, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: dot3_float2_float:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE41-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSE41-NEXT:    mulps %xmm0, %xmm1
; SSE41-NEXT:    movss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; SSE41-NEXT:    mulss 8(%rsi), %xmm2
; SSE41-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    addss %xmm2, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: dot3_float2_float:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; AVX-NEXT:    vmovsd {{.*#+}} xmm1 = mem[0],zero
; AVX-NEXT:    vmulps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; AVX-NEXT:    vmulss 8(%rsi), %xmm1, %xmm1
; AVX-NEXT:    vmovshdup {{.*#+}} xmm2 = xmm0[1,1,3,3]
; AVX-NEXT:    vaddss %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x01 = load <2 x float>, ptr %a0, align 4
  %y01 = load <2 x float>, ptr %a1, align 4
  %ptrx2 = getelementptr inbounds float, ptr %a0, i64 2
  %ptry2 = getelementptr inbounds float, ptr %a1, i64 2
  %x2 = load float, ptr %ptrx2, align 4
  %y2 = load float, ptr %ptry2, align 4
  %mul01 = fmul <2 x float> %x01, %y01
  %mul2 = fmul float %x2, %y2
  %mul0 = extractelement <2 x float> %mul01, i32 0
  %mul1 = extractelement <2 x float> %mul01, i32 1
  %dot01 = fadd float %mul0, %mul1
  %dot012 = fadd float %dot01, %mul2
  ret float %dot012
}

define float @dot3_float_float2(ptr dereferenceable(16) %a0, ptr dereferenceable(16) %a1) {
; SSE2-LABEL: dot3_float_float2:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; SSE2-NEXT:    movsd {{.*#+}} xmm2 = mem[0],zero
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    mulps %xmm2, %xmm0
; SSE2-NEXT:    mulss (%rsi), %xmm1
; SSE2-NEXT:    addss %xmm0, %xmm1
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: dot3_float_float2:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSSE3-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSSE3-NEXT:    movsd {{.*#+}} xmm2 = mem[0],zero
; SSSE3-NEXT:    mulps %xmm1, %xmm2
; SSSE3-NEXT:    mulss (%rsi), %xmm0
; SSSE3-NEXT:    movshdup {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSSE3-NEXT:    addss %xmm2, %xmm0
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: dot3_float_float2:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE41-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSE41-NEXT:    movsd {{.*#+}} xmm2 = mem[0],zero
; SSE41-NEXT:    mulps %xmm1, %xmm2
; SSE41-NEXT:    mulss (%rsi), %xmm0
; SSE41-NEXT:    movshdup {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE41-NEXT:    addss %xmm2, %xmm0
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: dot3_float_float2:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; AVX-NEXT:    vmovsd {{.*#+}} xmm1 = mem[0],zero
; AVX-NEXT:    vmovsd {{.*#+}} xmm2 = mem[0],zero
; AVX-NEXT:    vmulps %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vmulss (%rsi), %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm2 = xmm1[1,1,3,3]
; AVX-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vaddss %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x0 = load float, ptr %a0, align 4
  %y0 = load float, ptr %a1, align 4
  %ptrx12 = getelementptr inbounds float, ptr %a0, i64 1
  %ptry12 = getelementptr inbounds float, ptr %a1, i64 1
  %x12 = load <2 x float>, ptr %ptrx12, align 4
  %y12 = load <2 x float>, ptr %ptry12, align 4
  %mul0 = fmul float %x0, %y0
  %mul12 = fmul <2 x float> %x12, %y12
  %mul1 = extractelement <2 x float> %mul12, i32 0
  %mul2 = extractelement <2 x float> %mul12, i32 1
  %dot01 = fadd float %mul0, %mul1
  %dot012 = fadd float %dot01, %mul2
  ret float %dot012
}

;
; dot2(ptr x, ptr y) - ((xptr y[0])+(xptr y[1]))
;

define float @dot2_float4(ptr dereferenceable(16) %a0, ptr dereferenceable(16) %a1) {
; SSE2-LABEL: dot2_float4:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movups (%rdi), %xmm0
; SSE2-NEXT:    movups (%rsi), %xmm1
; SSE2-NEXT:    mulps %xmm0, %xmm1
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: dot2_float4:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    movups (%rdi), %xmm0
; SSSE3-NEXT:    movups (%rsi), %xmm1
; SSSE3-NEXT:    mulps %xmm0, %xmm1
; SSSE3-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: dot2_float4:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movups (%rdi), %xmm0
; SSE41-NEXT:    movups (%rsi), %xmm1
; SSE41-NEXT:    mulps %xmm0, %xmm1
; SSE41-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: dot2_float4:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovups (%rdi), %xmm0
; AVX-NEXT:    vmulps (%rsi), %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x0123 = load <4 x float>, ptr %a0, align 4
  %y0123 = load <4 x float>, ptr %a1, align 4
  %mul0123 = fmul <4 x float> %x0123, %y0123
  %mul0 = extractelement <4 x float> %mul0123, i32 0
  %mul1 = extractelement <4 x float> %mul0123, i32 1
  %dot01 = fadd float %mul0, %mul1
  ret float %dot01
}

define float @dot2_float2(ptr dereferenceable(16) %a0, ptr dereferenceable(16) %a1) {
; SSE2-LABEL: dot2_float2:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSE2-NEXT:    mulps %xmm0, %xmm1
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[1,1]
; SSE2-NEXT:    addss %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: dot2_float2:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSSE3-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSSE3-NEXT:    mulps %xmm0, %xmm1
; SSSE3-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSSE3-NEXT:    addss %xmm1, %xmm0
; SSSE3-NEXT:    retq
;
; SSE41-LABEL: dot2_float2:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE41-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; SSE41-NEXT:    mulps %xmm0, %xmm1
; SSE41-NEXT:    movshdup {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE41-NEXT:    addss %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: dot2_float2:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; AVX-NEXT:    vmovsd {{.*#+}} xmm1 = mem[0],zero
; AVX-NEXT:    vmulps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; AVX-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %x01 = load <2 x float>, ptr %a0, align 4
  %y01 = load <2 x float>, ptr %a1, align 4
  %mul01 = fmul <2 x float> %x01, %y01
  %mul0 = extractelement <2 x float> %mul01, i32 0
  %mul1 = extractelement <2 x float> %mul01, i32 1
  %dot01 = fadd float %mul0, %mul1
  ret float %dot01
}