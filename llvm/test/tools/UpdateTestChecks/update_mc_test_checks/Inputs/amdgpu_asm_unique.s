// RUN: llvm-mc -triple=amdgcn -show-encoding %s 2>&1 | FileCheck --check-prefixes=CHECK %s

//this is commentA
v_bfrev_b32 v5, v1

v_bfrev_b32 v5, v1

//this is commentB

//this is commentB