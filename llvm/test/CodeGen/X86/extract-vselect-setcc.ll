; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=x86_64 | FileCheck %s

define void @PR117684(i1 %cond, <8 x float> %vec, ptr %ptr1, ptr %ptr2) #0 {
; CHECK-LABEL: PR117684:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; CHECK-NEXT:    vcmpnltps %ymm1, %ymm0, %k1
; CHECK-NEXT:    vbroadcastss {{.*#+}} xmm0 = [NaN,NaN,NaN,NaN]
; CHECK-NEXT:    vinsertf32x4 $0, %xmm0, %ymm0, %ymm0 {%k1} {z}
; CHECK-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; CHECK-NEXT:    vmulss %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vmulss {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm2
; CHECK-NEXT:    vbroadcastss %xmm2, %ymm2
; CHECK-NEXT:    testb $1, %dil
; CHECK-NEXT:    cmoveq %rdx, %rsi
; CHECK-NEXT:    vmovups %ymm2, (%rsi)
; CHECK-NEXT:    vmulss %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vbroadcastss %xmm0, %ymm0
; CHECK-NEXT:    vmovups %ymm0, (%rdx)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %cmp = fcmp olt <8 x float> %vec, zeroinitializer
  %sel1 = select <8 x i1> %cmp, <8 x float> zeroinitializer, <8 x float>
  <float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000,
  float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000>
  %fmul1 = fmul <8 x float> zeroinitializer, %sel1
  %shuffle = shufflevector <8 x float> %fmul1, <8 x float> zeroinitializer, <8 x i32> zeroinitializer
  %fmul2 = fmul <8 x float> %shuffle,
  <float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000,
  float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000, float 0x7FF8000000000000>
  %sel2 = select i1 %cond, ptr %ptr1, ptr %ptr2
  store <8 x float> %fmul2, ptr %sel2, align 4
  %fmul3 = fmul <8 x float> %shuffle, zeroinitializer
  store <8 x float> %fmul3, ptr %ptr2, align 4
  ret void
}

attributes #0 = { "target-cpu"="skylake-avx512" }