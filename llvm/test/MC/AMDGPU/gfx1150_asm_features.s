// RUN: llvm-mc -triple=amdgcn -show-encoding -mcpu=gfx1150 %s | FileCheck --check-prefix=GFX1150 %s
// RUN: llvm-mc -triple=amdgcn -show-encoding -mcpu=gfx1151 %s | FileCheck --check-prefix=GFX1150 %s
// RUN: llvm-mc -triple=amdgcn -show-encoding -mcpu=gfx1152 %s | FileCheck --check-prefix=GFX1150 %s
// RUN: llvm-mc -triple=amdgcn -show-encoding -mcpu=gfx1153 %s | FileCheck --check-prefix=GFX1150 %s

//
// Subtargets allow src1 of VOP3 DPP instructions to be SGPR or inlinable
// constant.
//

v_add3_u32_e64_dpp v5, v1, s2, v3 quad_perm:[3,2,1,0] row_mask:0xf bank_mask:0xf
// GFX1150: encoding: [0x05,0x00,0x55,0xd6,0xfa,0x04,0x0c,0x04,0x01,0x1b,0x00,0xff]

v_add3_u32_e64_dpp v5, v1, 42, v3 quad_perm:[3,2,1,0] row_mask:0xf bank_mask:0xf
// GFX1150: encoding: [0x05,0x00,0x55,0xd6,0xfa,0x54,0x0d,0x04,0x01,0x1b,0x00,0xff]

v_add3_u32_e64_dpp v5, v1, s2, v0 dpp8:[7,6,5,4,3,2,1,0]
// GFX1150: encoding: [0x05,0x00,0x55,0xd6,0xe9,0x04,0x00,0x04,0x01,0x77,0x39,0x05]

v_add3_u32_e64_dpp v5, v1, 42, v0 dpp8:[7,6,5,4,3,2,1,0]
// GFX1150: encoding: [0x05,0x00,0x55,0xd6,0xe9,0x54,0x01,0x04,0x01,0x77,0x39,0x05]

v_add3_u32_e64_dpp v5, v1, s2, s3 dpp8:[7,6,5,4,3,2,1,0]
// GFX1150: encoding: [0x05,0x00,0x55,0xd6,0xe9,0x04,0x0c,0x00,0x01,0x77,0x39,0x05]

v_cmp_ne_i32_e64_dpp vcc_lo, v1, s2 dpp8:[7,6,5,4,3,2,1,0]
// GFX1150: encoding: [0x6a,0x00,0x45,0xd4,0xe9,0x04,0x00,0x00,0x01,0x77,0x39,0x05]

v_add_f32_e64_dpp v5, v1, s2 row_mirror
// GFX1150: encoding: [0x05,0x00,0x03,0xd5,0xfa,0x04,0x00,0x00,0x01,0x40,0x01,0xff]

v_min3_f16 v5, v1, s2, 2.0 op_sel:[1,1,0,1] quad_perm:[1,1,1,1] row_mask:0xf bank_mask:0xf
// GFX1150: encoding: [0x05,0x58,0x49,0xd6,0xfa,0x04,0xd0,0x03,0x01,0x55,0x00,0xff]

v_cmp_le_f32 vcc_lo, v1, v2 row_mirror
// GFX1150: encoding: [0xfa,0x04,0x26,0x7c,0x01,0x40,0x01,0xff]

v_cmp_le_f32 vcc_lo, v1, s2 row_mirror
// GFX1150: encoding: [0x6a,0x00,0x13,0xd4,0xfa,0x04,0x00,0x00,0x01,0x40,0x01,0xff]

v_cmp_le_f32 vcc_lo, v1, s2 quad_perm:[1,1,1,1]
// GFX1150: encoding: [0x6a,0x00,0x13,0xd4,0xfa,0x04,0x00,0x00,0x01,0x55,0x00,0xff]

v_cmpx_neq_f16 v1, 2.0 dpp8:[7,6,5,4,3,2,1,0]
// GFX1150: encoding: [0x7e,0x00,0x8d,0xd4,0xe9,0xe8,0x01,0x00,0x01,0x77,0x39,0x05]

v_cmpx_class_f16 v1, 2.0 quad_perm:[1,1,1,1]
// GFX1150: encoding: [0x7e,0x00,0xfd,0xd4,0xfa,0xe8,0x01,0x00,0x01,0x55,0x00,0xff]