; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs < %s | FileCheck %s

define void @gather_const_v8f16(ptr %x) {
; CHECK-LABEL: gather_const_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flh fa5, 10(a0)
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa5
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <8 x half>, ptr %x
  %b = extractelement <8 x half> %a, i32 5
  %c = insertelement <8 x half> poison, half %b, i32 0
  %d = shufflevector <8 x half> %c, <8 x half> poison, <8 x i32> zeroinitializer
  store <8 x half> %d, ptr %x
  ret void
}

define void @gather_const_v4f32(ptr %x) {
; CHECK-LABEL: gather_const_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flw fa5, 8(a0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa5
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <4 x float>, ptr %x
  %b = extractelement <4 x float> %a, i32 2
  %c = insertelement <4 x float> poison, float %b, i32 0
  %d = shufflevector <4 x float> %c, <4 x float> poison, <4 x i32> zeroinitializer
  store <4 x float> %d, ptr %x
  ret void
}

define void @gather_const_v2f64(ptr %x) {
; CHECK-LABEL: gather_const_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fld fa5, 0(a0)
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa5
; CHECK-NEXT:    vse64.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %b = extractelement <2 x double> %a, i32 0
  %c = insertelement <2 x double> poison, double %b, i32 0
  %d = shufflevector <2 x double> %c, <2 x double> poison, <2 x i32> zeroinitializer
  store <2 x double> %d, ptr %x
  ret void
}

define void @gather_const_v64f16(ptr %x) {
; CHECK-LABEL: gather_const_v64f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flh fa5, 94(a0)
; CHECK-NEXT:    li a1, 64
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa5
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <64 x half>, ptr %x
  %b = extractelement <64 x half> %a, i32 47
  %c = insertelement <64 x half> poison, half %b, i32 0
  %d = shufflevector <64 x half> %c, <64 x half> poison, <64 x i32> zeroinitializer
  store <64 x half> %d, ptr %x
  ret void
}

define void @gather_const_v32f32(ptr %x) {
; CHECK-LABEL: gather_const_v32f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    flw fa5, 68(a0)
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa5
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <32 x float>, ptr %x
  %b = extractelement <32 x float> %a, i32 17
  %c = insertelement <32 x float> poison, float %b, i32 0
  %d = shufflevector <32 x float> %c, <32 x float> poison, <32 x i32> zeroinitializer
  store <32 x float> %d, ptr %x
  ret void
}

define void @gather_const_v16f64(ptr %x) {
; CHECK-LABEL: gather_const_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fld fa5, 80(a0)
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa5
; CHECK-NEXT:    vse64.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <16 x double>, ptr %x
  %b = extractelement <16 x double> %a, i32 10
  %c = insertelement <16 x double> poison, double %b, i32 0
  %d = shufflevector <16 x double> %c, <16 x double> poison, <16 x i32> zeroinitializer
  store <16 x double> %d, ptr %x
  ret void
}