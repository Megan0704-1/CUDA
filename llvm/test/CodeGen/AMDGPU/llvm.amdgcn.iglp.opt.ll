; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx90a -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

define amdgpu_kernel void @test_iglp_opt() #0 {
; GCN-LABEL: test_iglp_opt:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    ; iglp_opt mask(0x00000000)
; GCN-NEXT:    s_endpgm
entry:
  call void @llvm.amdgcn.iglp.opt(i32 0) #1
  ret void
}

define amdgpu_kernel void @test_iglp_opt_mfma_gemm(ptr addrspace(3) noalias %in, ptr addrspace(3) noalias %out) #0 {
; GCN-LABEL: test_iglp_opt_mfma_gemm:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 7, v0
; GCN-NEXT:    v_and_b32_e32 v0, 0x1ff80, v0
; GCN-NEXT:    v_mov_b32_e32 v3, 2.0
; GCN-NEXT:    ; iglp_opt mask(0x00000000)
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_add_u32_e32 v1, s0, v0
; GCN-NEXT:    v_add_u32_e32 v2, 0x6000, v1
; GCN-NEXT:    ds_read_b128 a[28:31], v2 offset:57456
; GCN-NEXT:    ds_read_b128 a[24:27], v2 offset:57440
; GCN-NEXT:    ds_read_b128 a[20:23], v2 offset:57424
; GCN-NEXT:    ds_read_b128 a[16:19], v2 offset:57408
; GCN-NEXT:    ds_read_b128 a[0:3], v2 offset:57344
; GCN-NEXT:    ds_read_b128 a[4:7], v2 offset:57360
; GCN-NEXT:    ds_read_b128 a[8:11], v2 offset:57376
; GCN-NEXT:    ds_read_b128 a[12:15], v2 offset:57392
; GCN-NEXT:    v_mov_b32_e32 v2, 1.0
; GCN-NEXT:    ds_read_b128 a[60:63], v1 offset:49264
; GCN-NEXT:    ds_read_b128 a[56:59], v1 offset:49248
; GCN-NEXT:    ds_read_b128 a[52:55], v1 offset:49232
; GCN-NEXT:    ds_read_b128 a[48:51], v1 offset:49216
; GCN-NEXT:    ds_read_b128 a[44:47], v1 offset:49200
; GCN-NEXT:    ds_read_b128 a[40:43], v1 offset:49184
; GCN-NEXT:    ds_read_b128 a[36:39], v1 offset:49168
; GCN-NEXT:    ds_read_b128 a[32:35], v1 offset:49152
; GCN-NEXT:    s_waitcnt lgkmcnt(8)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[0:31], v2, v3, a[0:31]
; GCN-NEXT:    ds_read_b128 a[156:159], v1 offset:112
; GCN-NEXT:    ds_read_b128 a[152:155], v1 offset:96
; GCN-NEXT:    ds_read_b128 a[68:71], v1 offset:24592
; GCN-NEXT:    ds_read_b128 a[64:67], v1 offset:24576
; GCN-NEXT:    v_add_u32_e32 v0, s1, v0
; GCN-NEXT:    s_waitcnt lgkmcnt(4)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[32:63], v2, v3, a[32:63]
; GCN-NEXT:    ds_read_b128 a[148:151], v1 offset:80
; GCN-NEXT:    ds_read_b128 a[144:147], v1 offset:64
; GCN-NEXT:    ds_read_b128 a[128:131], v1
; GCN-NEXT:    ds_read_b128 a[132:135], v1 offset:16
; GCN-NEXT:    ds_read_b128 a[136:139], v1 offset:32
; GCN-NEXT:    ds_read_b128 a[140:143], v1 offset:48
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[128:159], v2, v3, a[128:159]
; GCN-NEXT:    ds_read_b128 a[124:127], v1 offset:8304
; GCN-NEXT:    ds_read_b128 a[120:123], v1 offset:8288
; GCN-NEXT:    ds_read_b128 a[116:119], v1 offset:8272
; GCN-NEXT:    ds_read_b128 a[112:115], v1 offset:8256
; GCN-NEXT:    ds_read_b128 a[108:111], v1 offset:8240
; GCN-NEXT:    ds_read_b128 a[104:107], v1 offset:8224
; GCN-NEXT:    ds_read_b128 a[100:103], v1 offset:8208
; GCN-NEXT:    ds_read_b128 a[96:99], v1 offset:8192
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[96:127], v2, v3, a[96:127]
; GCN-NEXT:    ds_read_b128 a[92:95], v1 offset:24688
; GCN-NEXT:    ds_read_b128 a[88:91], v1 offset:24672
; GCN-NEXT:    ds_read_b128 a[84:87], v1 offset:24656
; GCN-NEXT:    ds_read_b128 a[80:83], v1 offset:24640
; GCN-NEXT:    ds_read_b128 a[76:79], v1 offset:24624
; GCN-NEXT:    ds_read_b128 a[72:75], v1 offset:24608
; GCN-NEXT:    s_nop 2
; GCN-NEXT:    ds_write_b128 v0, a[156:159] offset:112
; GCN-NEXT:    ds_write_b128 v0, a[152:155] offset:96
; GCN-NEXT:    ds_write_b128 v0, a[148:151] offset:80
; GCN-NEXT:    ds_write_b128 v0, a[144:147] offset:64
; GCN-NEXT:    ds_write_b128 v0, a[140:143] offset:48
; GCN-NEXT:    ds_write_b128 v0, a[136:139] offset:32
; GCN-NEXT:    ds_write_b128 v0, a[132:135] offset:16
; GCN-NEXT:    ds_write_b128 v0, a[128:131]
; GCN-NEXT:    v_mov_b32_e32 v0, s1
; GCN-NEXT:    s_waitcnt lgkmcnt(8)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[64:95], v2, v3, a[64:95]
; GCN-NEXT:    ds_write_b128 v0, a[56:59] offset:24672
; GCN-NEXT:    ds_write_b128 v0, a[60:63] offset:24688
; GCN-NEXT:    ds_write_b128 v0, a[48:51] offset:24640
; GCN-NEXT:    ds_write_b128 v0, a[120:123] offset:8288
; GCN-NEXT:    ds_write_b128 v0, a[124:127] offset:8304
; GCN-NEXT:    ds_write_b128 v0, a[112:115] offset:8256
; GCN-NEXT:    ds_write_b128 v0, a[116:119] offset:8272
; GCN-NEXT:    ds_write_b128 v0, a[104:107] offset:8224
; GCN-NEXT:    ds_write_b128 v0, a[108:111] offset:8240
; GCN-NEXT:    ds_write_b128 v0, a[96:99] offset:8192
; GCN-NEXT:    ds_write_b128 v0, a[100:103] offset:8208
; GCN-NEXT:    ds_write_b128 v0, a[52:55] offset:24656
; GCN-NEXT:    ds_write_b128 v0, a[40:43] offset:24608
; GCN-NEXT:    ds_write_b128 v0, a[44:47] offset:24624
; GCN-NEXT:    ds_write_b128 v0, a[32:35] offset:24576
; GCN-NEXT:    ds_write_b128 v0, a[36:39] offset:24592
; GCN-NEXT:    ds_write_b128 v0, a[24:27] offset:32864
; GCN-NEXT:    ds_write_b128 v0, a[28:31] offset:32880
; GCN-NEXT:    ds_write_b128 v0, a[16:19] offset:32832
; GCN-NEXT:    ds_write_b128 v0, a[88:91] offset:16480
; GCN-NEXT:    ds_write_b128 v0, a[92:95] offset:16496
; GCN-NEXT:    ds_write_b128 v0, a[80:83] offset:16448
; GCN-NEXT:    ds_write_b128 v0, a[84:87] offset:16464
; GCN-NEXT:    ds_write_b128 v0, a[72:75] offset:16416
; GCN-NEXT:    ds_write_b128 v0, a[76:79] offset:16432
; GCN-NEXT:    ds_write_b128 v0, a[64:67] offset:16384
; GCN-NEXT:    ds_write_b128 v0, a[68:71] offset:16400
; GCN-NEXT:    ds_write_b128 v0, a[20:23] offset:32848
; GCN-NEXT:    ds_write_b128 v0, a[8:11] offset:32800
; GCN-NEXT:    ds_write_b128 v0, a[12:15] offset:32816
; GCN-NEXT:    ds_write_b128 v0, a[0:3] offset:32768
; GCN-NEXT:    ds_write_b128 v0, a[4:7] offset:32784
; GCN-NEXT:    s_endpgm
entry:
  call void @llvm.amdgcn.iglp.opt(i32 0)
  %idx = call i32 @llvm.amdgcn.workitem.id.x()
  %load.0.addr = getelementptr <32 x float>, ptr addrspace(3) %in, i32 %idx
  %load.0 = load <32 x float>, ptr addrspace(3) %load.0.addr
  %load.1.addr = getelementptr <32 x float>, ptr addrspace(3) %load.0.addr, i32 64
  %load.1 = load <32 x float>, ptr addrspace(3) %load.1.addr
  %load.2.addr = getelementptr <32 x float>, ptr addrspace(3) %load.1.addr, i32 128
  %load.2 = load <32 x float>, ptr addrspace(3) %load.2.addr
  %load.3.addr = getelementptr <32 x float>, ptr addrspace(3) %load.2.addr, i32 192
  %load.3 = load <32 x float>, ptr addrspace(3) %load.3.addr
  %load.4.addr = getelementptr <32 x float>, ptr addrspace(3) %load.3.addr, i32 256
  %load.4 = load <32 x float>, ptr addrspace(3) %load.4.addr
  %mai.0 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.0, i32 0, i32 0, i32 0)
  %mai.1 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.1, i32 0, i32 0, i32 0)
  %mai.2 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.2, i32 0, i32 0, i32 0)
  %mai.3 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.3, i32 0, i32 0, i32 0)
  %mai.4 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.4, i32 0, i32 0, i32 0)
  %store.0.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 %idx
  store <32 x float> %mai.0, ptr addrspace(3) %store.0.addr
  %store.1.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 64
  store <32 x float> %mai.1, ptr addrspace(3) %store.1.addr
  %store.2.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 128
  store <32 x float> %mai.2, ptr addrspace(3) %store.2.addr
  %store.3.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 192
  store <32 x float> %mai.3, ptr addrspace(3) %store.3.addr
  %store.4.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 256
  store <32 x float> %mai.4, ptr addrspace(3) %store.4.addr
  ret void
}


define amdgpu_kernel void @test_iglp_opt_rev_mfma_gemm(ptr addrspace(3) noalias %in, ptr addrspace(3) noalias %out) #0 {
; GCN-LABEL: test_iglp_opt_rev_mfma_gemm:
; GCN:       ; %bb.0: ; %entry
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x24
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 7, v0
; GCN-NEXT:    v_and_b32_e32 v0, 0x1ff80, v0
; GCN-NEXT:    v_mov_b32_e32 v2, 1.0
; GCN-NEXT:    v_mov_b32_e32 v3, 2.0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_add_u32_e32 v1, s0, v0
; GCN-NEXT:    ds_read_b128 a[28:31], v1 offset:112
; GCN-NEXT:    ds_read_b128 a[24:27], v1 offset:96
; GCN-NEXT:    ds_read_b128 a[20:23], v1 offset:80
; GCN-NEXT:    ds_read_b128 a[16:19], v1 offset:64
; GCN-NEXT:    ds_read_b128 a[0:3], v1
; GCN-NEXT:    ds_read_b128 a[4:7], v1 offset:16
; GCN-NEXT:    ds_read_b128 a[8:11], v1 offset:32
; GCN-NEXT:    ds_read_b128 a[12:15], v1 offset:48
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[0:31], v2, v3, a[0:31]
; GCN-NEXT:    ds_read_b128 a[156:159], v1 offset:8304
; GCN-NEXT:    ds_read_b128 a[152:155], v1 offset:8288
; GCN-NEXT:    ds_read_b128 a[148:151], v1 offset:8272
; GCN-NEXT:    ds_read_b128 a[144:147], v1 offset:8256
; GCN-NEXT:    ds_read_b128 a[140:143], v1 offset:8240
; GCN-NEXT:    ds_read_b128 a[136:139], v1 offset:8224
; GCN-NEXT:    ds_read_b128 a[132:135], v1 offset:8208
; GCN-NEXT:    ds_read_b128 a[128:131], v1 offset:8192
; GCN-NEXT:    v_add_u32_e32 v0, s1, v0
; GCN-NEXT:    ; iglp_opt mask(0x00000001)
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[128:159], v2, v3, a[128:159]
; GCN-NEXT:    ds_read_b128 a[124:127], v1 offset:24688
; GCN-NEXT:    ds_read_b128 a[120:123], v1 offset:24672
; GCN-NEXT:    ds_read_b128 a[116:119], v1 offset:24656
; GCN-NEXT:    ds_read_b128 a[112:115], v1 offset:24640
; GCN-NEXT:    ds_read_b128 a[108:111], v1 offset:24624
; GCN-NEXT:    ds_read_b128 a[104:107], v1 offset:24608
; GCN-NEXT:    ds_read_b128 a[100:103], v1 offset:24592
; GCN-NEXT:    ds_read_b128 a[96:99], v1 offset:24576
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[96:127], v2, v3, a[96:127]
; GCN-NEXT:    ds_read_b128 a[92:95], v1 offset:49264
; GCN-NEXT:    ds_read_b128 a[88:91], v1 offset:49248
; GCN-NEXT:    ds_read_b128 a[84:87], v1 offset:49232
; GCN-NEXT:    ds_read_b128 a[80:83], v1 offset:49216
; GCN-NEXT:    ds_read_b128 a[76:79], v1 offset:49200
; GCN-NEXT:    ds_read_b128 a[72:75], v1 offset:49184
; GCN-NEXT:    ds_read_b128 a[68:71], v1 offset:49168
; GCN-NEXT:    ds_read_b128 a[64:67], v1 offset:49152
; GCN-NEXT:    v_add_u32_e32 v1, 0x6000, v1
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[64:95], v2, v3, a[64:95]
; GCN-NEXT:    ds_read_b128 a[60:63], v1 offset:57456
; GCN-NEXT:    ds_read_b128 a[56:59], v1 offset:57440
; GCN-NEXT:    ds_read_b128 a[52:55], v1 offset:57424
; GCN-NEXT:    ds_read_b128 a[48:51], v1 offset:57408
; GCN-NEXT:    ds_read_b128 a[32:35], v1 offset:57344
; GCN-NEXT:    ds_read_b128 a[36:39], v1 offset:57360
; GCN-NEXT:    ds_read_b128 a[40:43], v1 offset:57376
; GCN-NEXT:    ds_read_b128 a[44:47], v1 offset:57392
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mfma_f32_32x32x1f32 a[32:63], v2, v3, a[32:63]
; GCN-NEXT:    ds_write_b128 v0, a[28:31] offset:112
; GCN-NEXT:    ds_write_b128 v0, a[24:27] offset:96
; GCN-NEXT:    ds_write_b128 v0, a[20:23] offset:80
; GCN-NEXT:    ds_write_b128 v0, a[16:19] offset:64
; GCN-NEXT:    ds_write_b128 v0, a[12:15] offset:48
; GCN-NEXT:    ds_write_b128 v0, a[8:11] offset:32
; GCN-NEXT:    ds_write_b128 v0, a[4:7] offset:16
; GCN-NEXT:    ds_write_b128 v0, a[0:3]
; GCN-NEXT:    v_mov_b32_e32 v0, s1
; GCN-NEXT:    ds_write_b128 v0, a[152:155] offset:8288
; GCN-NEXT:    ds_write_b128 v0, a[156:159] offset:8304
; GCN-NEXT:    ds_write_b128 v0, a[144:147] offset:8256
; GCN-NEXT:    ds_write_b128 v0, a[148:151] offset:8272
; GCN-NEXT:    ds_write_b128 v0, a[136:139] offset:8224
; GCN-NEXT:    ds_write_b128 v0, a[140:143] offset:8240
; GCN-NEXT:    ds_write_b128 v0, a[128:131] offset:8192
; GCN-NEXT:    ds_write_b128 v0, a[132:135] offset:8208
; GCN-NEXT:    ds_write_b128 v0, a[120:123] offset:16480
; GCN-NEXT:    ds_write_b128 v0, a[124:127] offset:16496
; GCN-NEXT:    ds_write_b128 v0, a[112:115] offset:16448
; GCN-NEXT:    ds_write_b128 v0, a[116:119] offset:16464
; GCN-NEXT:    ds_write_b128 v0, a[104:107] offset:16416
; GCN-NEXT:    ds_write_b128 v0, a[108:111] offset:16432
; GCN-NEXT:    ds_write_b128 v0, a[96:99] offset:16384
; GCN-NEXT:    ds_write_b128 v0, a[100:103] offset:16400
; GCN-NEXT:    ds_write_b128 v0, a[88:91] offset:24672
; GCN-NEXT:    ds_write_b128 v0, a[92:95] offset:24688
; GCN-NEXT:    ds_write_b128 v0, a[80:83] offset:24640
; GCN-NEXT:    ds_write_b128 v0, a[84:87] offset:24656
; GCN-NEXT:    ds_write_b128 v0, a[72:75] offset:24608
; GCN-NEXT:    ds_write_b128 v0, a[76:79] offset:24624
; GCN-NEXT:    ds_write_b128 v0, a[64:67] offset:24576
; GCN-NEXT:    ds_write_b128 v0, a[68:71] offset:24592
; GCN-NEXT:    ds_write_b128 v0, a[56:59] offset:32864
; GCN-NEXT:    ds_write_b128 v0, a[60:63] offset:32880
; GCN-NEXT:    ds_write_b128 v0, a[48:51] offset:32832
; GCN-NEXT:    ds_write_b128 v0, a[52:55] offset:32848
; GCN-NEXT:    ds_write_b128 v0, a[40:43] offset:32800
; GCN-NEXT:    ds_write_b128 v0, a[44:47] offset:32816
; GCN-NEXT:    ds_write_b128 v0, a[32:35] offset:32768
; GCN-NEXT:    ds_write_b128 v0, a[36:39] offset:32784
; GCN-NEXT:    s_endpgm
entry:
  call void @llvm.amdgcn.iglp.opt(i32 1)
  %idx = call i32 @llvm.amdgcn.workitem.id.x()
  %load.0.addr = getelementptr <32 x float>, ptr addrspace(3) %in, i32 %idx
  %load.0 = load <32 x float>, ptr addrspace(3) %load.0.addr
  %load.1.addr = getelementptr <32 x float>, ptr addrspace(3) %load.0.addr, i32 64
  %load.1 = load <32 x float>, ptr addrspace(3) %load.1.addr
  %load.2.addr = getelementptr <32 x float>, ptr addrspace(3) %load.1.addr, i32 128
  %load.2 = load <32 x float>, ptr addrspace(3) %load.2.addr
  %load.3.addr = getelementptr <32 x float>, ptr addrspace(3) %load.2.addr, i32 192
  %load.3 = load <32 x float>, ptr addrspace(3) %load.3.addr
  %load.4.addr = getelementptr <32 x float>, ptr addrspace(3) %load.3.addr, i32 256
  %load.4 = load <32 x float>, ptr addrspace(3) %load.4.addr
  %mai.0 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.0, i32 0, i32 0, i32 0)
  %mai.1 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.1, i32 0, i32 0, i32 0)
  %mai.2 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.2, i32 0, i32 0, i32 0)
  %mai.3 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.3, i32 0, i32 0, i32 0)
  %mai.4 = tail call <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float 1.0, float 2.0, <32 x float> %load.4, i32 0, i32 0, i32 0)
  %store.0.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 %idx
  store <32 x float> %mai.0, ptr addrspace(3) %store.0.addr
  %store.1.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 64
  store <32 x float> %mai.1, ptr addrspace(3) %store.1.addr
  %store.2.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 128
  store <32 x float> %mai.2, ptr addrspace(3) %store.2.addr
  %store.3.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 192
  store <32 x float> %mai.3, ptr addrspace(3) %store.3.addr
  %store.4.addr = getelementptr <32 x float>, ptr addrspace(3) %out, i32 256
  store <32 x float> %mai.4, ptr addrspace(3) %store.4.addr
  ret void
}


declare void @llvm.amdgcn.iglp.opt(i32) #1
declare i32 @llvm.amdgcn.workitem.id.x() #1
declare <32 x float> @llvm.amdgcn.mfma.f32.32x32x1f32(float, float, <32 x float>, i32, i32, i32) #1

attributes #0 = { nounwind "amdgpu-flat-work-group-size"="1,256" }
attributes #1 = { convergent nounwind }