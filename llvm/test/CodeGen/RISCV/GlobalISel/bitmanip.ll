; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -global-isel -global-isel-abort=1 < %s 2>&1 | FileCheck %s --check-prefixes=RV32
; RUN: llc -mtriple=riscv64 -global-isel -global-isel-abort=1 < %s 2>&1 | FileCheck %s --check-prefixes=RV64

define i2 @bitreverse_i2(i2 %x) {
; RV32-LABEL: bitreverse_i2:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a1, a0, 1
; RV32-NEXT:    andi a0, a0, 3
; RV32-NEXT:    andi a1, a1, 2
; RV32-NEXT:    srli a0, a0, 1
; RV32-NEXT:    or a0, a1, a0
; RV32-NEXT:    ret
;
; RV64-LABEL: bitreverse_i2:
; RV64:       # %bb.0:
; RV64-NEXT:    slli a1, a0, 1
; RV64-NEXT:    andi a0, a0, 3
; RV64-NEXT:    andi a1, a1, 2
; RV64-NEXT:    srli a0, a0, 1
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    ret
  %rev = call i2 @llvm.bitreverse.i2(i2 %x)
  ret i2 %rev
}

define i3 @bitreverse_i3(i3 %x) {
; RV32-LABEL: bitreverse_i3:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a1, a0, 2
; RV32-NEXT:    andi a0, a0, 7
; RV32-NEXT:    andi a1, a1, 4
; RV32-NEXT:    andi a2, a0, 2
; RV32-NEXT:    or a1, a1, a2
; RV32-NEXT:    srli a0, a0, 2
; RV32-NEXT:    or a0, a1, a0
; RV32-NEXT:    ret
;
; RV64-LABEL: bitreverse_i3:
; RV64:       # %bb.0:
; RV64-NEXT:    slli a1, a0, 2
; RV64-NEXT:    andi a0, a0, 7
; RV64-NEXT:    andi a1, a1, 4
; RV64-NEXT:    andi a2, a0, 2
; RV64-NEXT:    or a1, a1, a2
; RV64-NEXT:    srli a0, a0, 2
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    ret
  %rev = call i3 @llvm.bitreverse.i3(i3 %x)
  ret i3 %rev
}

define i4 @bitreverse_i4(i4 %x) {
; RV32-LABEL: bitreverse_i4:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a1, a0, 3
; RV32-NEXT:    slli a2, a0, 1
; RV32-NEXT:    andi a0, a0, 15
; RV32-NEXT:    andi a1, a1, 8
; RV32-NEXT:    andi a2, a2, 4
; RV32-NEXT:    or a1, a1, a2
; RV32-NEXT:    srli a2, a0, 1
; RV32-NEXT:    andi a2, a2, 2
; RV32-NEXT:    or a1, a1, a2
; RV32-NEXT:    srli a0, a0, 3
; RV32-NEXT:    or a0, a1, a0
; RV32-NEXT:    ret
;
; RV64-LABEL: bitreverse_i4:
; RV64:       # %bb.0:
; RV64-NEXT:    slli a1, a0, 3
; RV64-NEXT:    slli a2, a0, 1
; RV64-NEXT:    andi a0, a0, 15
; RV64-NEXT:    andi a1, a1, 8
; RV64-NEXT:    andi a2, a2, 4
; RV64-NEXT:    or a1, a1, a2
; RV64-NEXT:    srli a2, a0, 1
; RV64-NEXT:    andi a2, a2, 2
; RV64-NEXT:    or a1, a1, a2
; RV64-NEXT:    srli a0, a0, 3
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    ret
  %rev = call i4 @llvm.bitreverse.i4(i4 %x)
  ret i4 %rev
}

define i7 @bitreverse_i7(i7 %x) {
; RV32-LABEL: bitreverse_i7:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a1, a0, 6
; RV32-NEXT:    slli a2, a0, 4
; RV32-NEXT:    slli a3, a0, 2
; RV32-NEXT:    andi a0, a0, 127
; RV32-NEXT:    andi a1, a1, 64
; RV32-NEXT:    andi a2, a2, 32
; RV32-NEXT:    andi a3, a3, 16
; RV32-NEXT:    or a1, a1, a2
; RV32-NEXT:    andi a2, a0, 8
; RV32-NEXT:    or a2, a3, a2
; RV32-NEXT:    srli a3, a0, 2
; RV32-NEXT:    or a1, a1, a2
; RV32-NEXT:    srli a2, a0, 4
; RV32-NEXT:    andi a3, a3, 4
; RV32-NEXT:    andi a2, a2, 2
; RV32-NEXT:    or a2, a3, a2
; RV32-NEXT:    or a1, a1, a2
; RV32-NEXT:    srli a0, a0, 6
; RV32-NEXT:    or a0, a1, a0
; RV32-NEXT:    ret
;
; RV64-LABEL: bitreverse_i7:
; RV64:       # %bb.0:
; RV64-NEXT:    slli a1, a0, 6
; RV64-NEXT:    slli a2, a0, 4
; RV64-NEXT:    slli a3, a0, 2
; RV64-NEXT:    andi a0, a0, 127
; RV64-NEXT:    andi a1, a1, 64
; RV64-NEXT:    andi a2, a2, 32
; RV64-NEXT:    andi a3, a3, 16
; RV64-NEXT:    or a1, a1, a2
; RV64-NEXT:    andi a2, a0, 8
; RV64-NEXT:    or a2, a3, a2
; RV64-NEXT:    srli a3, a0, 2
; RV64-NEXT:    or a1, a1, a2
; RV64-NEXT:    srli a2, a0, 4
; RV64-NEXT:    andi a3, a3, 4
; RV64-NEXT:    andi a2, a2, 2
; RV64-NEXT:    or a2, a3, a2
; RV64-NEXT:    or a1, a1, a2
; RV64-NEXT:    srli a0, a0, 6
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    ret
  %rev = call i7 @llvm.bitreverse.i7(i7 %x)
  ret i7 %rev
}

define i24 @bitreverse_i24(i24 %x) {
; RV32-LABEL: bitreverse_i24:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a1, a0, 16
; RV32-NEXT:    lui a2, 4096
; RV32-NEXT:    lui a3, 1048335
; RV32-NEXT:    addi a2, a2, -1
; RV32-NEXT:    addi a3, a3, 240
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    srli a0, a0, 16
; RV32-NEXT:    or a0, a0, a1
; RV32-NEXT:    and a1, a3, a2
; RV32-NEXT:    and a1, a0, a1
; RV32-NEXT:    slli a0, a0, 4
; RV32-NEXT:    and a0, a0, a3
; RV32-NEXT:    lui a3, 1047757
; RV32-NEXT:    addi a3, a3, -820
; RV32-NEXT:    srli a1, a1, 4
; RV32-NEXT:    or a0, a1, a0
; RV32-NEXT:    and a1, a3, a2
; RV32-NEXT:    and a1, a0, a1
; RV32-NEXT:    slli a0, a0, 2
; RV32-NEXT:    and a0, a0, a3
; RV32-NEXT:    lui a3, 1047211
; RV32-NEXT:    addi a3, a3, -1366
; RV32-NEXT:    and a2, a3, a2
; RV32-NEXT:    srli a1, a1, 2
; RV32-NEXT:    or a0, a1, a0
; RV32-NEXT:    and a2, a0, a2
; RV32-NEXT:    slli a0, a0, 1
; RV32-NEXT:    srli a2, a2, 1
; RV32-NEXT:    and a0, a0, a3
; RV32-NEXT:    or a0, a2, a0
; RV32-NEXT:    ret
;
; RV64-LABEL: bitreverse_i24:
; RV64:       # %bb.0:
; RV64-NEXT:    slli a1, a0, 16
; RV64-NEXT:    lui a2, 4096
; RV64-NEXT:    lui a3, 1048335
; RV64-NEXT:    addiw a2, a2, -1
; RV64-NEXT:    addiw a3, a3, 240
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    srli a0, a0, 16
; RV64-NEXT:    or a0, a0, a1
; RV64-NEXT:    and a1, a3, a2
; RV64-NEXT:    and a1, a0, a1
; RV64-NEXT:    slli a0, a0, 4
; RV64-NEXT:    and a0, a0, a3
; RV64-NEXT:    lui a3, 1047757
; RV64-NEXT:    addiw a3, a3, -820
; RV64-NEXT:    srli a1, a1, 4
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    and a1, a3, a2
; RV64-NEXT:    and a1, a0, a1
; RV64-NEXT:    slli a0, a0, 2
; RV64-NEXT:    and a0, a0, a3
; RV64-NEXT:    lui a3, 1047211
; RV64-NEXT:    addiw a3, a3, -1366
; RV64-NEXT:    and a2, a3, a2
; RV64-NEXT:    srli a1, a1, 2
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    and a2, a0, a2
; RV64-NEXT:    slli a0, a0, 1
; RV64-NEXT:    srli a2, a2, 1
; RV64-NEXT:    and a0, a0, a3
; RV64-NEXT:    or a0, a2, a0
; RV64-NEXT:    ret
  %rev = call i24 @llvm.bitreverse.i24(i24 %x)
  ret i24 %rev
}