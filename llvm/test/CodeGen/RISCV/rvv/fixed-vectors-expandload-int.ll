; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -verify-machineinstrs -mtriple=riscv32 -mattr=+m,+v %s -o - \
; RUN:   | FileCheck %s --check-prefixes=CHECK,CHECK-RV32
; RUN: llc -verify-machineinstrs -mtriple=riscv64 -mattr=+m,+v %s -o - \
; RUN:   | FileCheck %s --check-prefixes=CHECK,CHECK-RV64

declare <1 x i8> @llvm.masked.expandload.v1i8(ptr, <1 x i1>, <1 x i8>)
define <1 x i8> @expandload_v1i8(ptr %base, <1 x i8> %src0, <1 x i1> %mask) {
; CHECK-LABEL: expandload_v1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <1 x i8> @llvm.masked.expandload.v1i8(ptr %base, <1 x i1> %mask, <1 x i8> %src0)
  ret <1 x i8>%res
}

declare <2 x i8> @llvm.masked.expandload.v2i8(ptr, <2 x i1>, <2 x i8>)
define <2 x i8> @expandload_v2i8(ptr %base, <2 x i8> %src0, <2 x i1> %mask) {
; CHECK-LABEL: expandload_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <2 x i8> @llvm.masked.expandload.v2i8(ptr %base, <2 x i1> %mask, <2 x i8> %src0)
  ret <2 x i8>%res
}

declare <4 x i8> @llvm.masked.expandload.v4i8(ptr, <4 x i1>, <4 x i8>)
define <4 x i8> @expandload_v4i8(ptr %base, <4 x i8> %src0, <4 x i1> %mask) {
; CHECK-LABEL: expandload_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <4 x i8> @llvm.masked.expandload.v4i8(ptr %base, <4 x i1> %mask, <4 x i8> %src0)
  ret <4 x i8>%res
}

declare <8 x i8> @llvm.masked.expandload.v8i8(ptr, <8 x i1>, <8 x i8>)
define <8 x i8> @expandload_v8i8(ptr %base, <8 x i8> %src0, <8 x i1> %mask) {
; CHECK-LABEL: expandload_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <8 x i8> @llvm.masked.expandload.v8i8(ptr %base, <8 x i1> %mask, <8 x i8> %src0)
  ret <8 x i8>%res
}

declare <1 x i16> @llvm.masked.expandload.v1i16(ptr, <1 x i1>, <1 x i16>)
define <1 x i16> @expandload_v1i16(ptr %base, <1 x i16> %src0, <1 x i1> %mask) {
; CHECK-LABEL: expandload_v1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <1 x i16> @llvm.masked.expandload.v1i16(ptr align 2 %base, <1 x i1> %mask, <1 x i16> %src0)
  ret <1 x i16>%res
}

declare <2 x i16> @llvm.masked.expandload.v2i16(ptr, <2 x i1>, <2 x i16>)
define <2 x i16> @expandload_v2i16(ptr %base, <2 x i16> %src0, <2 x i1> %mask) {
; CHECK-LABEL: expandload_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <2 x i16> @llvm.masked.expandload.v2i16(ptr align 2 %base, <2 x i1> %mask, <2 x i16> %src0)
  ret <2 x i16>%res
}

declare <4 x i16> @llvm.masked.expandload.v4i16(ptr, <4 x i1>, <4 x i16>)
define <4 x i16> @expandload_v4i16(ptr %base, <4 x i16> %src0, <4 x i1> %mask) {
; CHECK-LABEL: expandload_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <4 x i16> @llvm.masked.expandload.v4i16(ptr align 2 %base, <4 x i1> %mask, <4 x i16> %src0)
  ret <4 x i16>%res
}

declare <8 x i16> @llvm.masked.expandload.v8i16(ptr, <8 x i1>, <8 x i16>)
define <8 x i16> @expandload_v8i16(ptr %base, <8 x i16> %src0, <8 x i1> %mask) {
; CHECK-LABEL: expandload_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <8 x i16> @llvm.masked.expandload.v8i16(ptr align 2 %base, <8 x i1> %mask, <8 x i16> %src0)
  ret <8 x i16>%res
}

declare <1 x i32> @llvm.masked.expandload.v1i32(ptr, <1 x i1>, <1 x i32>)
define <1 x i32> @expandload_v1i32(ptr %base, <1 x i32> %src0, <1 x i1> %mask) {
; CHECK-LABEL: expandload_v1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <1 x i32> @llvm.masked.expandload.v1i32(ptr align 4 %base, <1 x i1> %mask, <1 x i32> %src0)
  ret <1 x i32>%res
}

declare <2 x i32> @llvm.masked.expandload.v2i32(ptr, <2 x i1>, <2 x i32>)
define <2 x i32> @expandload_v2i32(ptr %base, <2 x i32> %src0, <2 x i1> %mask) {
; CHECK-LABEL: expandload_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <2 x i32> @llvm.masked.expandload.v2i32(ptr align 4 %base, <2 x i1> %mask, <2 x i32> %src0)
  ret <2 x i32>%res
}

declare <4 x i32> @llvm.masked.expandload.v4i32(ptr, <4 x i1>, <4 x i32>)
define <4 x i32> @expandload_v4i32(ptr %base, <4 x i32> %src0, <4 x i1> %mask) {
; CHECK-LABEL: expandload_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <4 x i32> @llvm.masked.expandload.v4i32(ptr align 4 %base, <4 x i1> %mask, <4 x i32> %src0)
  ret <4 x i32>%res
}

declare <8 x i32> @llvm.masked.expandload.v8i32(ptr, <8 x i1>, <8 x i32>)
define <8 x i32> @expandload_v8i32(ptr %base, <8 x i32> %src0, <8 x i1> %mask) {
; CHECK-LABEL: expandload_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; CHECK-NEXT:    viota.m v12, v0
; CHECK-NEXT:    vrgather.vv v8, v10, v12, v0.t
; CHECK-NEXT:    ret
  %res = call <8 x i32> @llvm.masked.expandload.v8i32(ptr align 4 %base, <8 x i1> %mask, <8 x i32> %src0)
  ret <8 x i32>%res
}

declare <1 x i64> @llvm.masked.expandload.v1i64(ptr, <1 x i1>, <1 x i64>)
define <1 x i64> @expandload_v1i64(ptr %base, <1 x i64> %src0, <1 x i1> %mask) {
; CHECK-LABEL: expandload_v1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; CHECK-NEXT:    vle64.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <1 x i64> @llvm.masked.expandload.v1i64(ptr align 8 %base, <1 x i1> %mask, <1 x i64> %src0)
  ret <1 x i64>%res
}

declare <2 x i64> @llvm.masked.expandload.v2i64(ptr, <2 x i1>, <2 x i64>)
define <2 x i64> @expandload_v2i64(ptr %base, <2 x i64> %src0, <2 x i1> %mask) {
; CHECK-LABEL: expandload_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; CHECK-NEXT:    vle64.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; CHECK-NEXT:    viota.m v10, v0
; CHECK-NEXT:    vrgather.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
  %res = call <2 x i64> @llvm.masked.expandload.v2i64(ptr align 8 %base, <2 x i1> %mask, <2 x i64> %src0)
  ret <2 x i64>%res
}

declare <4 x i64> @llvm.masked.expandload.v4i64(ptr, <4 x i1>, <4 x i64>)
define <4 x i64> @expandload_v4i64(ptr %base, <4 x i64> %src0, <4 x i1> %mask) {
; CHECK-LABEL: expandload_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, ta, ma
; CHECK-NEXT:    vle64.v v10, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, mu
; CHECK-NEXT:    viota.m v12, v0
; CHECK-NEXT:    vrgather.vv v8, v10, v12, v0.t
; CHECK-NEXT:    ret
  %res = call <4 x i64> @llvm.masked.expandload.v4i64(ptr align 8 %base, <4 x i1> %mask, <4 x i64> %src0)
  ret <4 x i64>%res
}

declare <8 x i64> @llvm.masked.expandload.v8i64(ptr, <8 x i1>, <8 x i64>)
define <8 x i64> @expandload_v8i64(ptr %base, <8 x i64> %src0, <8 x i1> %mask) {
; CHECK-LABEL: expandload_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vcpop.m a1, v0
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, ta, ma
; CHECK-NEXT:    vle64.v v12, (a0)
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; CHECK-NEXT:    viota.m v16, v0
; CHECK-NEXT:    vrgather.vv v8, v12, v16, v0.t
; CHECK-NEXT:    ret
  %res = call <8 x i64> @llvm.masked.expandload.v8i64(ptr align 8 %base, <8 x i1> %mask, <8 x i64> %src0)
  ret <8 x i64>%res
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-RV32: {{.*}}
; CHECK-RV64: {{.*}}