// RUN: llvm-mc -triple aarch64 -filetype asm -o - %s 2>&1 | FileCheck %s

.arch_extension lsfe
ldfadd h0, h1, [x2]
// CHECK: ldfadd h0, h1, [x2]