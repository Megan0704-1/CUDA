// RUN: llvm-mc -triple x86_64 -x86-asm-syntax=intel -output-asm-variant=1 --show-encoding %s | FileCheck %s

// CHECK: rdmsr r9, 123
// CHECK: encoding: [0xc4,0xc7,0x7b,0xf6,0xc1,0x7b,0x00,0x00,0x00]
          rdmsr r9, 123

// CHECK: wrmsrns 123, r9
// CHECK: encoding: [0xc4,0xc7,0x7a,0xf6,0xc1,0x7b,0x00,0x00,0x00]
          wrmsrns 123, r9
