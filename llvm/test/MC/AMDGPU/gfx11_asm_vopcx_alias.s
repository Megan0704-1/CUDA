// NOTE: Assertions have been autogenerated by utils/update_mc_test_checks.py UTC_ARGS: --version 5
// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize64 -show-encoding %s | FileCheck -check-prefix=GFX11 %s

v_cmpx_tru_i32 v1, v2
// GFX11: v_cmpx_t_i32_e32 v1, v2                 ; encoding: [0x01,0x05,0x8e,0x7d]

v_cmpx_tru_u32 v1, v2
// GFX11: v_cmpx_t_u32_e32 v1, v2                 ; encoding: [0x01,0x05,0x9e,0x7d]

v_cmpx_tru_i64 v[1:2], v[2:3]
// GFX11: v_cmpx_t_i64_e32 v[1:2], v[2:3]         ; encoding: [0x01,0x05,0xae,0x7d]

v_cmpx_tru_u64 v[1:2], v[2:3]
// GFX11: v_cmpx_t_u64_e32 v[1:2], v[2:3]         ; encoding: [0x01,0x05,0xbe,0x7d]