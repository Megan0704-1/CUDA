// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2-aes < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2,+sve-aes < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+ssve-aes,+sve-aes < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: not llvm-mc -triple=aarch64 -show-encoding -mattr=+sme < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2,+sve-aes < %s \
// RUN:        | llvm-objdump -d --mattr=+sve2,+sve-aes - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2,+sve-aes < %s \
// RUN:   | llvm-objdump -d --mattr=-sve-aes - | FileCheck %s --check-prefix=CHECK-UNKNOWN


aesmc z0.b, z0.b
// CHECK-INST: aesmc z0.b, z0.b
// CHECK-ENCODING: [0x00,0xe0,0x20,0x45]
// CHECK-ERROR: instruction requires: sve2 or ssve-aes sve-aes
// CHECK-UNKNOWN: 4520e000 <unknown>

aesmc z31.b, z31.b
// CHECK-INST: aesmc z31.b, z31.b
// CHECK-ENCODING: [0x1f,0xe0,0x20,0x45]
// CHECK-ERROR: instruction requires: sve2 or ssve-aes sve-aes
// CHECK-UNKNOWN: 4520e01f <unknown>