; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse2 | FileCheck %s --check-prefixes=SSE
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx | FileCheck %s --check-prefixes=AVX1
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck %s --check-prefixes=AVX2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512f,+avx512bw,+avx512vl | FileCheck %s --check-prefixes=AVX512

define i64 @PR62286(i32 %a) {
; SSE-LABEL: PR62286:
; SSE:       # %bb.0:
; SSE-NEXT:    movd %edi, %xmm0
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[0,1,1,0]
; SSE-NEXT:    paddd %xmm1, %xmm1
; SSE-NEXT:    pxor %xmm2, %xmm2
; SSE-NEXT:    pxor %xmm3, %xmm3
; SSE-NEXT:    pcmpgtd %xmm1, %xmm3
; SSE-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1]
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,0,1,0]
; SSE-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    pcmpgtd %xmm0, %xmm2
; SSE-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,2,3]
; SSE-NEXT:    paddq %xmm1, %xmm0
; SSE-NEXT:    movq %xmm0, %rax
; SSE-NEXT:    retq
;
; AVX1-LABEL: PR62286:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovd %edi, %xmm0
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,1,1,0]
; AVX1-NEXT:    vpaddd %xmm0, %xmm0, %xmm1
; AVX1-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; AVX1-NEXT:    vblendps {{.*#+}} ymm0 = ymm1[0],ymm0[1,2,3],ymm1[4],ymm0[5,6,7]
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vorps %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpmovsxdq %xmm0, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,2,3]
; AVX1-NEXT:    vpmovsxdq %xmm0, %xmm0
; AVX1-NEXT:    vpaddq %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; AVX1-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: PR62286:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovd %edi, %xmm0
; AVX2-NEXT:    vpaddd %xmm0, %xmm0, %xmm1
; AVX2-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3]
; AVX2-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm1[0],xmm0[1,2,3]
; AVX2-NEXT:    vpmovsxdq %xmm0, %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; AVX2-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vmovq %xmm0, %rax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: PR62286:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovd %edi, %xmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,1,1,0]
; AVX512-NEXT:    vpandd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %zmm0, %zmm1
; AVX512-NEXT:    movw $4369, %ax # imm = 0x1111
; AVX512-NEXT:    kmovd %eax, %k1
; AVX512-NEXT:    vpaddd %zmm0, %zmm0, %zmm1 {%k1}
; AVX512-NEXT:    vpmovsxdq %ymm1, %zmm0
; AVX512-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512-NEXT:    vpaddq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; AVX512-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vmovq %xmm0, %rax
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %v2 = insertelement <16 x i32> <i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %a, i64 0
  %v3 = insertelement <16 x i32> %v2, i32 0, i64 1
  %v4 = insertelement <16 x i32> %v3, i32 0, i64 2
  %v5 = insertelement <16 x i32> %v4, i32 %a, i64 3
  %v6 = insertelement <16 x i32> %v5, i32 0, i64 4
  %v7 = shl <16 x i32> %v6, <i32 1, i32 2, i32 3, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %v8 = and <16 x i32> %v6, <i32 1, i32 -384969324, i32 -1073118976, i32 -2147418112, i32 poison, i32 -384969324, i32 -1073118976, i32 -2147418112, i32 456, i32 -384969324, i32 -1073118976, i32 -2147418112, i32 99, i32 -384969324, i32 -1073118976, i32 -2147418112>
  %v9 = shufflevector <16 x i32> %v7, <16 x i32> %v8, <16 x i32> <i32 0, i32 17, i32 18, i32 19, i32 4, i32 21, i32 22, i32 23, i32 8, i32 25, i32 26, i32 27, i32 12, i32 29, i32 30, i32 31>
  %v10 = sext <16 x i32> %v9 to <16 x i64>
  %v12 = call i64 @llvm.vector.reduce.add.v16i64(<16 x i64> %v10)
  ret i64 %v12
}
declare i64 @llvm.vector.reduce.add.v16i64(<16 x i64>)