; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5

; RUN: llc -verify-machineinstrs -O3 -mcpu=pwr8 \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck  \
; RUN:   -check-prefix=CHECK-P8 %s

; RUN: llc -verify-machineinstrs -O3 -mcpu=pwr8 -disable-ppc-vsx-swap-removal \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck  \
; RUN:   -check-prefix=NOOPTSWAP-P8 %s

; RUN: llc -O3 -mcpu=pwr9 -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:  -verify-machineinstrs -ppc-vsr-nums-as-vr < %s | FileCheck  \
; RUN:  -check-prefix=CHECK-P9 --implicit-check-not xxswapd %s

; RUN: llc -O3 -mcpu=pwr9 -disable-ppc-vsx-swap-removal -mattr=-power9-vector \
; RUN:  -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu < %s \
; RUN:  | FileCheck  -check-prefix=NOOPTSWAP-P9 %s

; LH: 2016-11-17
;   Updated align attritue from 16 to 8 to keep swap instructions tests.
;   Changes have been made on little-endian to use lvx and stvx
;   instructions instead of lxvd2x/xxswapd and xxswapd/stxvd2x for
;   aligned vectors with elements up to 4 bytes

; This test was generated from the following source:
;
; #define N 4096
; int ca[N] __attribute__((aligned(16)));
; int cb[N] __attribute__((aligned(16)));
; int cc[N] __attribute__((aligned(16)));
; int cd[N] __attribute__((aligned(16)));
;
; void foo ()
; {
;   int i;
;   for (i = 0; i < N; i++) {
;     ca[i] = (cb[i] + cc[i]) * cd[i];
;   }
; }

@cb = common global [4096 x i32] zeroinitializer, align 8
@cc = common global [4096 x i32] zeroinitializer, align 8
@cd = common global [4096 x i32] zeroinitializer, align 8
@ca = common global [4096 x i32] zeroinitializer, align 8

define void @foo() {
; CHECK-P8-LABEL: foo:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    li 3, 256
; CHECK-P8-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; CHECK-P8-NEXT:    addis 4, 2, .LC0@toc@ha
; CHECK-P8-NEXT:    addis 5, 2, .LC1@toc@ha
; CHECK-P8-NEXT:    addis 6, 2, .LC2@toc@ha
; CHECK-P8-NEXT:    addis 7, 2, .LC3@toc@ha
; CHECK-P8-NEXT:    li 8, 16
; CHECK-P8-NEXT:    li 9, 32
; CHECK-P8-NEXT:    mtctr 3
; CHECK-P8-NEXT:    ld 4, .LC0@toc@l(4)
; CHECK-P8-NEXT:    ld 5, .LC1@toc@l(5)
; CHECK-P8-NEXT:    ld 6, .LC2@toc@l(6)
; CHECK-P8-NEXT:    ld 7, .LC3@toc@l(7)
; CHECK-P8-NEXT:    li 3, 0
; CHECK-P8-NEXT:    li 10, 48
; CHECK-P8-NEXT:    .p2align 4
; CHECK-P8-NEXT:  .LBB0_1: # %vector.body
; CHECK-P8-NEXT:    #
; CHECK-P8-NEXT:    lxvd2x 34, 4, 3
; CHECK-P8-NEXT:    lxvd2x 35, 5, 3
; CHECK-P8-NEXT:    add 11, 4, 3
; CHECK-P8-NEXT:    add 12, 5, 3
; CHECK-P8-NEXT:    lxvd2x 36, 6, 3
; CHECK-P8-NEXT:    add 30, 6, 3
; CHECK-P8-NEXT:    lxvd2x 37, 11, 8
; CHECK-P8-NEXT:    lxvd2x 32, 12, 10
; CHECK-P8-NEXT:    vadduwm 2, 3, 2
; CHECK-P8-NEXT:    lxvd2x 35, 12, 8
; CHECK-P8-NEXT:    vmuluwm 2, 2, 4
; CHECK-P8-NEXT:    lxvd2x 36, 11, 9
; CHECK-P8-NEXT:    vadduwm 3, 3, 5
; CHECK-P8-NEXT:    lxvd2x 37, 12, 9
; CHECK-P8-NEXT:    stxvd2x 34, 7, 3
; CHECK-P8-NEXT:    lxvd2x 34, 30, 10
; CHECK-P8-NEXT:    vadduwm 4, 5, 4
; CHECK-P8-NEXT:    lxvd2x 37, 11, 10
; CHECK-P8-NEXT:    add 11, 7, 3
; CHECK-P8-NEXT:    addi 3, 3, 64
; CHECK-P8-NEXT:    vadduwm 5, 0, 5
; CHECK-P8-NEXT:    lxvd2x 32, 30, 8
; CHECK-P8-NEXT:    vmuluwm 2, 5, 2
; CHECK-P8-NEXT:    vmuluwm 3, 3, 0
; CHECK-P8-NEXT:    lxvd2x 32, 30, 9
; CHECK-P8-NEXT:    stxvd2x 34, 11, 10
; CHECK-P8-NEXT:    vmuluwm 4, 4, 0
; CHECK-P8-NEXT:    stxvd2x 35, 11, 8
; CHECK-P8-NEXT:    stxvd2x 36, 11, 9
; CHECK-P8-NEXT:    bdnz .LBB0_1
; CHECK-P8-NEXT:  # %bb.2: # %for.end
; CHECK-P8-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; CHECK-P8-NEXT:    blr
;
; NOOPTSWAP-P8-LABEL: foo:
; NOOPTSWAP-P8:       # %bb.0: # %entry
; NOOPTSWAP-P8-NEXT:    li 3, 256
; NOOPTSWAP-P8-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; NOOPTSWAP-P8-NEXT:    addis 4, 2, .LC0@toc@ha
; NOOPTSWAP-P8-NEXT:    addis 5, 2, .LC1@toc@ha
; NOOPTSWAP-P8-NEXT:    addis 6, 2, .LC2@toc@ha
; NOOPTSWAP-P8-NEXT:    addis 7, 2, .LC3@toc@ha
; NOOPTSWAP-P8-NEXT:    li 8, 16
; NOOPTSWAP-P8-NEXT:    li 9, 32
; NOOPTSWAP-P8-NEXT:    mtctr 3
; NOOPTSWAP-P8-NEXT:    ld 4, .LC0@toc@l(4)
; NOOPTSWAP-P8-NEXT:    ld 5, .LC1@toc@l(5)
; NOOPTSWAP-P8-NEXT:    ld 6, .LC2@toc@l(6)
; NOOPTSWAP-P8-NEXT:    ld 7, .LC3@toc@l(7)
; NOOPTSWAP-P8-NEXT:    li 3, 0
; NOOPTSWAP-P8-NEXT:    li 10, 48
; NOOPTSWAP-P8-NEXT:    .p2align 4
; NOOPTSWAP-P8-NEXT:  .LBB0_1: # %vector.body
; NOOPTSWAP-P8-NEXT:    #
; NOOPTSWAP-P8-NEXT:    lxvd2x 0, 4, 3
; NOOPTSWAP-P8-NEXT:    lxvd2x 1, 5, 3
; NOOPTSWAP-P8-NEXT:    add 30, 6, 3
; NOOPTSWAP-P8-NEXT:    add 11, 4, 3
; NOOPTSWAP-P8-NEXT:    add 12, 5, 3
; NOOPTSWAP-P8-NEXT:    lxvd2x 2, 11, 8
; NOOPTSWAP-P8-NEXT:    lxvd2x 3, 12, 8
; NOOPTSWAP-P8-NEXT:    lxvd2x 4, 11, 9
; NOOPTSWAP-P8-NEXT:    lxvd2x 5, 12, 9
; NOOPTSWAP-P8-NEXT:    lxvd2x 6, 11, 10
; NOOPTSWAP-P8-NEXT:    add 11, 7, 3
; NOOPTSWAP-P8-NEXT:    lxvd2x 7, 12, 10
; NOOPTSWAP-P8-NEXT:    xxswapd 34, 0
; NOOPTSWAP-P8-NEXT:    lxvd2x 0, 6, 3
; NOOPTSWAP-P8-NEXT:    xxswapd 35, 1
; NOOPTSWAP-P8-NEXT:    lxvd2x 1, 30, 8
; NOOPTSWAP-P8-NEXT:    vadduwm 2, 3, 2
; NOOPTSWAP-P8-NEXT:    xxswapd 36, 2
; NOOPTSWAP-P8-NEXT:    xxswapd 32, 4
; NOOPTSWAP-P8-NEXT:    xxswapd 38, 6
; NOOPTSWAP-P8-NEXT:    xxswapd 37, 3
; NOOPTSWAP-P8-NEXT:    xxswapd 33, 5
; NOOPTSWAP-P8-NEXT:    xxswapd 39, 7
; NOOPTSWAP-P8-NEXT:    vadduwm 3, 5, 4
; NOOPTSWAP-P8-NEXT:    vadduwm 4, 1, 0
; NOOPTSWAP-P8-NEXT:    xxswapd 40, 0
; NOOPTSWAP-P8-NEXT:    xxswapd 41, 1
; NOOPTSWAP-P8-NEXT:    lxvd2x 0, 30, 9
; NOOPTSWAP-P8-NEXT:    lxvd2x 1, 30, 10
; NOOPTSWAP-P8-NEXT:    vmuluwm 2, 2, 8
; NOOPTSWAP-P8-NEXT:    vmuluwm 3, 3, 9
; NOOPTSWAP-P8-NEXT:    xxswapd 42, 0
; NOOPTSWAP-P8-NEXT:    xxswapd 43, 1
; NOOPTSWAP-P8-NEXT:    vmuluwm 4, 4, 10
; NOOPTSWAP-P8-NEXT:    xxswapd 0, 34
; NOOPTSWAP-P8-NEXT:    vadduwm 2, 7, 6
; NOOPTSWAP-P8-NEXT:    xxswapd 1, 35
; NOOPTSWAP-P8-NEXT:    vmuluwm 2, 2, 11
; NOOPTSWAP-P8-NEXT:    stxvd2x 0, 7, 3
; NOOPTSWAP-P8-NEXT:    addi 3, 3, 64
; NOOPTSWAP-P8-NEXT:    stxvd2x 1, 11, 8
; NOOPTSWAP-P8-NEXT:    xxswapd 2, 36
; NOOPTSWAP-P8-NEXT:    stxvd2x 2, 11, 9
; NOOPTSWAP-P8-NEXT:    xxswapd 3, 34
; NOOPTSWAP-P8-NEXT:    stxvd2x 3, 11, 10
; NOOPTSWAP-P8-NEXT:    bdnz .LBB0_1
; NOOPTSWAP-P8-NEXT:  # %bb.2: # %for.end
; NOOPTSWAP-P8-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; NOOPTSWAP-P8-NEXT:    blr
;
; CHECK-P9-LABEL: foo:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    li 6, 256
; CHECK-P9-NEXT:    addis 3, 2, .LC0@toc@ha
; CHECK-P9-NEXT:    addis 4, 2, .LC1@toc@ha
; CHECK-P9-NEXT:    addis 5, 2, .LC2@toc@ha
; CHECK-P9-NEXT:    mtctr 6
; CHECK-P9-NEXT:    addis 6, 2, .LC3@toc@ha
; CHECK-P9-NEXT:    ld 3, .LC0@toc@l(3)
; CHECK-P9-NEXT:    ld 4, .LC1@toc@l(4)
; CHECK-P9-NEXT:    ld 5, .LC2@toc@l(5)
; CHECK-P9-NEXT:    ld 6, .LC3@toc@l(6)
; CHECK-P9-NEXT:    addi 3, 3, 32
; CHECK-P9-NEXT:    addi 4, 4, 32
; CHECK-P9-NEXT:    addi 5, 5, 32
; CHECK-P9-NEXT:    addi 6, 6, 32
; CHECK-P9-NEXT:    .p2align 4
; CHECK-P9-NEXT:  .LBB0_1: # %vector.body
; CHECK-P9-NEXT:    #
; CHECK-P9-NEXT:    lxv 2, -32(6)
; CHECK-P9-NEXT:    lxv 3, -32(5)
; CHECK-P9-NEXT:    lxv 4, -16(5)
; CHECK-P9-NEXT:    vadduwm 2, 3, 2
; CHECK-P9-NEXT:    lxv 3, -32(4)
; CHECK-P9-NEXT:    vmuluwm 2, 2, 3
; CHECK-P9-NEXT:    lxv 3, -16(6)
; CHECK-P9-NEXT:    vadduwm 3, 4, 3
; CHECK-P9-NEXT:    lxv 4, 0(5)
; CHECK-P9-NEXT:    stxv 2, -32(3)
; CHECK-P9-NEXT:    lxv 2, -16(4)
; CHECK-P9-NEXT:    vmuluwm 2, 3, 2
; CHECK-P9-NEXT:    lxv 3, 0(6)
; CHECK-P9-NEXT:    vadduwm 3, 4, 3
; CHECK-P9-NEXT:    lxv 4, 16(5)
; CHECK-P9-NEXT:    addi 5, 5, 64
; CHECK-P9-NEXT:    stxv 2, -16(3)
; CHECK-P9-NEXT:    lxv 2, 0(4)
; CHECK-P9-NEXT:    vmuluwm 2, 3, 2
; CHECK-P9-NEXT:    lxv 3, 16(6)
; CHECK-P9-NEXT:    addi 6, 6, 64
; CHECK-P9-NEXT:    vadduwm 3, 4, 3
; CHECK-P9-NEXT:    stxv 2, 0(3)
; CHECK-P9-NEXT:    lxv 2, 16(4)
; CHECK-P9-NEXT:    addi 4, 4, 64
; CHECK-P9-NEXT:    vmuluwm 2, 3, 2
; CHECK-P9-NEXT:    stxv 2, 16(3)
; CHECK-P9-NEXT:    addi 3, 3, 64
; CHECK-P9-NEXT:    bdnz .LBB0_1
; CHECK-P9-NEXT:  # %bb.2: # %for.end
; CHECK-P9-NEXT:    blr
;
; NOOPTSWAP-P9-LABEL: foo:
; NOOPTSWAP-P9:       # %bb.0: # %entry
; NOOPTSWAP-P9-NEXT:    addis 4, 2, .LC0@toc@ha
; NOOPTSWAP-P9-NEXT:    addis 5, 2, .LC1@toc@ha
; NOOPTSWAP-P9-NEXT:    addis 6, 2, .LC2@toc@ha
; NOOPTSWAP-P9-NEXT:    addis 7, 2, .LC3@toc@ha
; NOOPTSWAP-P9-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; NOOPTSWAP-P9-NEXT:    ld 4, .LC0@toc@l(4)
; NOOPTSWAP-P9-NEXT:    li 3, 256
; NOOPTSWAP-P9-NEXT:    ld 5, .LC1@toc@l(5)
; NOOPTSWAP-P9-NEXT:    ld 6, .LC2@toc@l(6)
; NOOPTSWAP-P9-NEXT:    ld 7, .LC3@toc@l(7)
; NOOPTSWAP-P9-NEXT:    mtctr 3
; NOOPTSWAP-P9-NEXT:    li 3, 0
; NOOPTSWAP-P9-NEXT:    li 8, 16
; NOOPTSWAP-P9-NEXT:    li 9, 32
; NOOPTSWAP-P9-NEXT:    li 10, 48
; NOOPTSWAP-P9-NEXT:    .p2align 4
; NOOPTSWAP-P9-NEXT:  .LBB0_1: # %vector.body
; NOOPTSWAP-P9-NEXT:    #
; NOOPTSWAP-P9-NEXT:    lxvd2x 0, 4, 3
; NOOPTSWAP-P9-NEXT:    lxvd2x 1, 5, 3
; NOOPTSWAP-P9-NEXT:    lxvd2x 2, 6, 3
; NOOPTSWAP-P9-NEXT:    add 12, 5, 3
; NOOPTSWAP-P9-NEXT:    add 11, 4, 3
; NOOPTSWAP-P9-NEXT:    add 30, 6, 3
; NOOPTSWAP-P9-NEXT:    lxvd2x 3, 11, 8
; NOOPTSWAP-P9-NEXT:    xxswapd 34, 0
; NOOPTSWAP-P9-NEXT:    xxswapd 35, 1
; NOOPTSWAP-P9-NEXT:    lxvd2x 0, 12, 8
; NOOPTSWAP-P9-NEXT:    xxswapd 36, 2
; NOOPTSWAP-P9-NEXT:    lxvd2x 1, 11, 9
; NOOPTSWAP-P9-NEXT:    vadduwm 2, 3, 2
; NOOPTSWAP-P9-NEXT:    xxswapd 35, 3
; NOOPTSWAP-P9-NEXT:    vmuluwm 2, 2, 4
; NOOPTSWAP-P9-NEXT:    xxswapd 36, 0
; NOOPTSWAP-P9-NEXT:    lxvd2x 0, 12, 9
; NOOPTSWAP-P9-NEXT:    vadduwm 3, 4, 3
; NOOPTSWAP-P9-NEXT:    xxswapd 36, 1
; NOOPTSWAP-P9-NEXT:    lxvd2x 1, 12, 10
; NOOPTSWAP-P9-NEXT:    xxswapd 37, 0
; NOOPTSWAP-P9-NEXT:    lxvd2x 0, 11, 10
; NOOPTSWAP-P9-NEXT:    add 11, 7, 3
; NOOPTSWAP-P9-NEXT:    vadduwm 4, 5, 4
; NOOPTSWAP-P9-NEXT:    xxswapd 32, 1
; NOOPTSWAP-P9-NEXT:    xxswapd 37, 0
; NOOPTSWAP-P9-NEXT:    lxvd2x 0, 30, 8
; NOOPTSWAP-P9-NEXT:    vadduwm 5, 0, 5
; NOOPTSWAP-P9-NEXT:    xxswapd 32, 0
; NOOPTSWAP-P9-NEXT:    lxvd2x 0, 30, 9
; NOOPTSWAP-P9-NEXT:    vmuluwm 3, 3, 0
; NOOPTSWAP-P9-NEXT:    xxswapd 32, 0
; NOOPTSWAP-P9-NEXT:    xxswapd 0, 34
; NOOPTSWAP-P9-NEXT:    vmuluwm 4, 4, 0
; NOOPTSWAP-P9-NEXT:    stxvd2x 0, 7, 3
; NOOPTSWAP-P9-NEXT:    addi 3, 3, 64
; NOOPTSWAP-P9-NEXT:    xxswapd 1, 35
; NOOPTSWAP-P9-NEXT:    stxvd2x 1, 11, 8
; NOOPTSWAP-P9-NEXT:    xxswapd 0, 36
; NOOPTSWAP-P9-NEXT:    stxvd2x 0, 11, 9
; NOOPTSWAP-P9-NEXT:    lxvd2x 0, 30, 10
; NOOPTSWAP-P9-NEXT:    xxswapd 34, 0
; NOOPTSWAP-P9-NEXT:    vmuluwm 2, 5, 2
; NOOPTSWAP-P9-NEXT:    xxswapd 0, 34
; NOOPTSWAP-P9-NEXT:    stxvd2x 0, 11, 10
; NOOPTSWAP-P9-NEXT:    bdnz .LBB0_1
; NOOPTSWAP-P9-NEXT:  # %bb.2: # %for.end
; NOOPTSWAP-P9-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; NOOPTSWAP-P9-NEXT:    blr
entry:
  br label %vector.body

vector.body:
  %index = phi i64 [ 0, %entry ], [ %index.next.3, %vector.body ]
  %0 = getelementptr inbounds [4096 x i32], ptr @cb, i64 0, i64 %index
  %wide.load = load <4 x i32>, ptr %0, align 8
  %1 = getelementptr inbounds [4096 x i32], ptr @cc, i64 0, i64 %index
  %wide.load13 = load <4 x i32>, ptr %1, align 8
  %2 = add nsw <4 x i32> %wide.load13, %wide.load
  %3 = getelementptr inbounds [4096 x i32], ptr @cd, i64 0, i64 %index
  %wide.load14 = load <4 x i32>, ptr %3, align 8
  %4 = mul nsw <4 x i32> %2, %wide.load14
  %5 = getelementptr inbounds [4096 x i32], ptr @ca, i64 0, i64 %index
  store <4 x i32> %4, ptr %5, align 8
  %index.next = add nuw nsw i64 %index, 4
  %6 = getelementptr inbounds [4096 x i32], ptr @cb, i64 0, i64 %index.next
  %wide.load.1 = load <4 x i32>, ptr %6, align 8
  %7 = getelementptr inbounds [4096 x i32], ptr @cc, i64 0, i64 %index.next
  %wide.load13.1 = load <4 x i32>, ptr %7, align 8
  %8 = add nsw <4 x i32> %wide.load13.1, %wide.load.1
  %9 = getelementptr inbounds [4096 x i32], ptr @cd, i64 0, i64 %index.next
  %wide.load14.1 = load <4 x i32>, ptr %9, align 8
  %10 = mul nsw <4 x i32> %8, %wide.load14.1
  %11 = getelementptr inbounds [4096 x i32], ptr @ca, i64 0, i64 %index.next
  store <4 x i32> %10, ptr %11, align 8
  %index.next.1 = add nuw nsw i64 %index.next, 4
  %12 = getelementptr inbounds [4096 x i32], ptr @cb, i64 0, i64 %index.next.1
  %wide.load.2 = load <4 x i32>, ptr %12, align 8
  %13 = getelementptr inbounds [4096 x i32], ptr @cc, i64 0, i64 %index.next.1
  %wide.load13.2 = load <4 x i32>, ptr %13, align 8
  %14 = add nsw <4 x i32> %wide.load13.2, %wide.load.2
  %15 = getelementptr inbounds [4096 x i32], ptr @cd, i64 0, i64 %index.next.1
  %wide.load14.2 = load <4 x i32>, ptr %15, align 8
  %16 = mul nsw <4 x i32> %14, %wide.load14.2
  %17 = getelementptr inbounds [4096 x i32], ptr @ca, i64 0, i64 %index.next.1
  store <4 x i32> %16, ptr %17, align 8
  %index.next.2 = add nuw nsw i64 %index.next.1, 4
  %18 = getelementptr inbounds [4096 x i32], ptr @cb, i64 0, i64 %index.next.2
  %wide.load.3 = load <4 x i32>, ptr %18, align 8
  %19 = getelementptr inbounds [4096 x i32], ptr @cc, i64 0, i64 %index.next.2
  %wide.load13.3 = load <4 x i32>, ptr %19, align 8
  %20 = add nsw <4 x i32> %wide.load13.3, %wide.load.3
  %21 = getelementptr inbounds [4096 x i32], ptr @cd, i64 0, i64 %index.next.2
  %wide.load14.3 = load <4 x i32>, ptr %21, align 8
  %22 = mul nsw <4 x i32> %20, %wide.load14.3
  %23 = getelementptr inbounds [4096 x i32], ptr @ca, i64 0, i64 %index.next.2
  store <4 x i32> %22, ptr %23, align 8
  %index.next.3 = add nuw nsw i64 %index.next.2, 4
  %24 = icmp eq i64 %index.next.3, 4096
  br i1 %24, label %for.end, label %vector.body

for.end:
  ret void
}