// RUN: llvm-mc -triple=amdgcn -mcpu=gfx950 -show-encoding %s | FileCheck --check-prefixes=GFX950 %s

v_prng_b32 v5, v1 quad_perm:[3,2,1,0]
// GFX950: v_prng_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0xf bank_mask:0xf ;   encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x1b,0x00,0xff]

v_prng_b32 v5, v1 quad_perm:[0,1,2,3]
// GFX950: v_prng_b32_dpp v5, v1 quad_perm:[0,1,2,3] row_mask:0xf bank_mask:0xf ;   encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0xe4,0x00,0xff]

v_prng_b32 v5, v1 row_mirror
// GFX950: v_prng_b32_dpp v5, v1 row_mirror row_mask:0xf bank_mask:0xf ;            encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x40,0x01,0xff]

v_prng_b32 v5, v1 row_half_mirror
// GFX950: v_prng_b32_dpp v5, v1 row_half_mirror row_mask:0xf bank_mask:0xf ;       encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x41,0x01,0xff]

v_prng_b32 v5, v1 row_shl:1
// GFX950: v_prng_b32_dpp v5, v1 row_shl:1 row_mask:0xf bank_mask:0xf ;             encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x01,0x01,0xff]

v_prng_b32 v5, v1 row_shl:15
// GFX950: v_prng_b32_dpp v5, v1 row_shl:15 row_mask:0xf bank_mask:0xf ;            encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x0f,0x01,0xff]

v_prng_b32 v5, v1 row_shr:1
// GFX950: v_prng_b32_dpp v5, v1 row_shr:1 row_mask:0xf bank_mask:0xf ;             encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x11,0x01,0xff]

v_prng_b32 v5, v1 row_shr:15
// GFX950: v_prng_b32_dpp v5, v1 row_shr:15 row_mask:0xf bank_mask:0xf ;            encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x1f,0x01,0xff]

v_prng_b32 v5, v1 row_ror:1
// GFX950: v_prng_b32_dpp v5, v1 row_ror:1 row_mask:0xf bank_mask:0xf ;             encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x21,0x01,0xff]

v_prng_b32 v5, v1 row_ror:15
// GFX950: v_prng_b32_dpp v5, v1 row_ror:15 row_mask:0xf bank_mask:0xf ;            encoding: [0xfa,0xb0,0x0a,0x7e,0x01,0x2f,0x01,0xff]