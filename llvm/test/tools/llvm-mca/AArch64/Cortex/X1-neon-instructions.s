# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=aarch64 -mcpu=cortex-x1 -instruction-tables < %s | FileCheck %s

# Check the Neoverse V1 model is used.

add	v0.16b, v1.16b, v31.16b

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      2     0.25                        add	v0.16b, v1.16b, v31.16b

# CHECK:      Resources:
# CHECK-NEXT: [0.0] - V1UnitB
# CHECK-NEXT: [0.1] - V1UnitB
# CHECK-NEXT: [1.0] - V1UnitD
# CHECK-NEXT: [1.1] - V1UnitD
# CHECK-NEXT: [2.0] - V1UnitFlg
# CHECK-NEXT: [2.1] - V1UnitFlg
# CHECK-NEXT: [2.2] - V1UnitFlg
# CHECK-NEXT: [3]   - V1UnitL2
# CHECK-NEXT: [4.0] - V1UnitL01
# CHECK-NEXT: [4.1] - V1UnitL01
# CHECK-NEXT: [5]   - V1UnitM0
# CHECK-NEXT: [6]   - V1UnitM1
# CHECK-NEXT: [7.0] - V1UnitS
# CHECK-NEXT: [7.1] - V1UnitS
# CHECK-NEXT: [8]   - V1UnitV0
# CHECK-NEXT: [9]   - V1UnitV1
# CHECK-NEXT: [10]  - V1UnitV2
# CHECK-NEXT: [11]  - V1UnitV3

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0.0]  [0.1]  [1.0]  [1.1]  [2.0]  [2.1]  [2.2]  [3]    [4.0]  [4.1]  [5]    [6]    [7.0]  [7.1]  [8]    [9]    [10]   [11]
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -      -      -      -     0.25   0.25   0.25   0.25

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0.0]  [0.1]  [1.0]  [1.1]  [2.0]  [2.1]  [2.2]  [3]    [4.0]  [4.1]  [5]    [6]    [7.0]  [7.1]  [8]    [9]    [10]   [11]   Instructions:
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -      -      -      -     0.25   0.25   0.25   0.25   add	v0.16b, v1.16b, v31.16b