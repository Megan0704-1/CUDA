# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=sapphirerapids -instruction-tables < %s | FileCheck %s

aesdec          %xmm0, %xmm2
aesdec          (%rax), %xmm2

aesdeclast      %xmm0, %xmm2
aesdeclast      (%rax), %xmm2

aesenc          %xmm0, %xmm2
aesenc          (%rax), %xmm2

aesenclast      %xmm0, %xmm2
aesenclast      (%rax), %xmm2

aesimc          %xmm0, %xmm2
aesimc          (%rax), %xmm2

aeskeygenassist $22, %xmm0, %xmm2
aeskeygenassist $22, (%rax), %xmm2

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      5     0.50                        aesdec	%xmm0, %xmm2
# CHECK-NEXT:  2      12    0.50    *                   aesdec	(%rax), %xmm2
# CHECK-NEXT:  1      5     0.50                        aesdeclast	%xmm0, %xmm2
# CHECK-NEXT:  2      12    0.50    *                   aesdeclast	(%rax), %xmm2
# CHECK-NEXT:  1      5     0.50                        aesenc	%xmm0, %xmm2
# CHECK-NEXT:  2      12    0.50    *                   aesenc	(%rax), %xmm2
# CHECK-NEXT:  1      5     0.50                        aesenclast	%xmm0, %xmm2
# CHECK-NEXT:  2      12    0.50    *                   aesenclast	(%rax), %xmm2
# CHECK-NEXT:  2      8     1.00                        aesimc	%xmm0, %xmm2
# CHECK-NEXT:  3      15    1.00    *                   aesimc	(%rax), %xmm2
# CHECK-NEXT:  14     7     4.00                        aeskeygenassist	$22, %xmm0, %xmm2
# CHECK-NEXT:  14     12    4.00    *                   aeskeygenassist	$22, (%rax), %xmm2

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SPRPort00
# CHECK-NEXT: [1]   - SPRPort01
# CHECK-NEXT: [2]   - SPRPort02
# CHECK-NEXT: [3]   - SPRPort03
# CHECK-NEXT: [4]   - SPRPort04
# CHECK-NEXT: [5]   - SPRPort05
# CHECK-NEXT: [6]   - SPRPort06
# CHECK-NEXT: [7]   - SPRPort07
# CHECK-NEXT: [8]   - SPRPort08
# CHECK-NEXT: [9]   - SPRPort09
# CHECK-NEXT: [10]  - SPRPort10
# CHECK-NEXT: [11]  - SPRPort11
# CHECK-NEXT: [12]  - SPRPortInvalid

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]
# CHECK-NEXT: 17.33  10.33  2.00   2.00    -     9.33   2.00    -      -      -     2.00    -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   Instructions:
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     aesdec	%xmm0, %xmm2
# CHECK-NEXT: 0.50   0.50   0.33   0.33    -      -      -      -      -      -     0.33    -      -     aesdec	(%rax), %xmm2
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     aesdeclast	%xmm0, %xmm2
# CHECK-NEXT: 0.50   0.50   0.33   0.33    -      -      -      -      -      -     0.33    -      -     aesdeclast	(%rax), %xmm2
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     aesenc	%xmm0, %xmm2
# CHECK-NEXT: 0.50   0.50   0.33   0.33    -      -      -      -      -      -     0.33    -      -     aesenc	(%rax), %xmm2
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     aesenclast	%xmm0, %xmm2
# CHECK-NEXT: 0.50   0.50   0.33   0.33    -      -      -      -      -      -     0.33    -      -     aesenclast	(%rax), %xmm2
# CHECK-NEXT: 1.00   1.00    -      -      -      -      -      -      -      -      -      -      -     aesimc	%xmm0, %xmm2
# CHECK-NEXT: 1.00   1.00   0.33   0.33    -      -      -      -      -      -     0.33    -      -     aesimc	(%rax), %xmm2
# CHECK-NEXT: 5.83   2.33    -      -      -     4.83   1.00    -      -      -      -      -      -     aeskeygenassist	$22, %xmm0, %xmm2
# CHECK-NEXT: 5.50   2.00   0.33   0.33    -     4.50   1.00    -      -      -     0.33    -      -     aeskeygenassist	$22, (%rax), %xmm2