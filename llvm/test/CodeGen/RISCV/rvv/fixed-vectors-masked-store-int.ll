; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s

define void @masked_store_v1i8(<1 x i8> %val, ptr %a, <1 x i1> %mask) {
; CHECK-LABEL: masked_store_v1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v1i8.p0(<1 x i8> %val, ptr %a, i32 8, <1 x i1> %mask)
  ret void
}

define void @masked_store_v1i16(<1 x i16> %val, ptr %a, <1 x i1> %mask) {
; CHECK-LABEL: masked_store_v1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v1i16.p0(<1 x i16> %val, ptr %a, i32 8, <1 x i1> %mask)
  ret void
}

define void @masked_store_v1i32(<1 x i32> %val, ptr %a, <1 x i1> %mask) {
; CHECK-LABEL: masked_store_v1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v1i32.p0(<1 x i32> %val, ptr %a, i32 8, <1 x i1> %mask)
  ret void
}

define void @masked_store_v1i64(<1 x i64> %val, ptr %a, <1 x i1> %mask) {
; CHECK-LABEL: masked_store_v1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v1i64.p0(<1 x i64> %val, ptr %a, i32 8, <1 x i1> %mask)
  ret void
}

define void @masked_store_v2i8(<2 x i8> %val, ptr %a, <2 x i1> %mask) {
; CHECK-LABEL: masked_store_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v2i8.p0(<2 x i8> %val, ptr %a, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_store_v2i16(<2 x i16> %val, ptr %a, <2 x i1> %mask) {
; CHECK-LABEL: masked_store_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v2i16.p0(<2 x i16> %val, ptr %a, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_store_v2i32(<2 x i32> %val, ptr %a, <2 x i1> %mask) {
; CHECK-LABEL: masked_store_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v2i32.p0(<2 x i32> %val, ptr %a, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_store_v2i64(<2 x i64> %val, ptr %a, <2 x i1> %mask) {
; CHECK-LABEL: masked_store_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v2i64.p0(<2 x i64> %val, ptr %a, i32 8, <2 x i1> %mask)
  ret void
}

define void @masked_store_v4i8(<4 x i8> %val, ptr %a, <4 x i1> %mask) {
; CHECK-LABEL: masked_store_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v4i8.p0(<4 x i8> %val, ptr %a, i32 8, <4 x i1> %mask)
  ret void
}

define void @masked_store_v4i16(<4 x i16> %val, ptr %a, <4 x i1> %mask) {
; CHECK-LABEL: masked_store_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v4i16.p0(<4 x i16> %val, ptr %a, i32 8, <4 x i1> %mask)
  ret void
}

define void @masked_store_v4i32(<4 x i32> %val, ptr %a, <4 x i1> %mask) {
; CHECK-LABEL: masked_store_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v4i32.p0(<4 x i32> %val, ptr %a, i32 8, <4 x i1> %mask)
  ret void
}

define void @masked_store_v4i64(<4 x i64> %val, ptr %a, <4 x i1> %mask) {
; CHECK-LABEL: masked_store_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v4i64.p0(<4 x i64> %val, ptr %a, i32 8, <4 x i1> %mask)
  ret void
}

define void @masked_store_v8i8(<8 x i8> %val, ptr %a, <8 x i1> %mask) {
; CHECK-LABEL: masked_store_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v8i8.p0(<8 x i8> %val, ptr %a, i32 8, <8 x i1> %mask)
  ret void
}

define void @masked_store_v8i16(<8 x i16> %val, ptr %a, <8 x i1> %mask) {
; CHECK-LABEL: masked_store_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v8i16.p0(<8 x i16> %val, ptr %a, i32 8, <8 x i1> %mask)
  ret void
}

define void @masked_store_v8i32(<8 x i32> %val, ptr %a, <8 x i1> %mask) {
; CHECK-LABEL: masked_store_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v8i32.p0(<8 x i32> %val, ptr %a, i32 8, <8 x i1> %mask)
  ret void
}

define void @masked_store_v8i64(<8 x i64> %val, ptr %a, <8 x i1> %mask) {
; CHECK-LABEL: masked_store_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v8i64.p0(<8 x i64> %val, ptr %a, i32 8, <8 x i1> %mask)
  ret void
}

define void @masked_store_v16i8(<16 x i8> %val, ptr %a, <16 x i1> %mask) {
; CHECK-LABEL: masked_store_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v16i8.p0(<16 x i8> %val, ptr %a, i32 8, <16 x i1> %mask)
  ret void
}

define void @masked_store_v16i16(<16 x i16> %val, ptr %a, <16 x i1> %mask) {
; CHECK-LABEL: masked_store_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v16i16.p0(<16 x i16> %val, ptr %a, i32 8, <16 x i1> %mask)
  ret void
}

define void @masked_store_v16i32(<16 x i32> %val, ptr %a, <16 x i1> %mask) {
; CHECK-LABEL: masked_store_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v16i32.p0(<16 x i32> %val, ptr %a, i32 8, <16 x i1> %mask)
  ret void
}

define void @masked_store_v16i64(<16 x i64> %val, ptr %a, <16 x i1> %mask) {
; CHECK-LABEL: masked_store_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v16i64.p0(<16 x i64> %val, ptr %a, i32 8, <16 x i1> %mask)
  ret void
}

define void @masked_store_v32i8(<32 x i8> %val, ptr %a, <32 x i1> %mask) {
; CHECK-LABEL: masked_store_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v32i8.p0(<32 x i8> %val, ptr %a, i32 8, <32 x i1> %mask)
  ret void
}

define void @masked_store_v32i16(<32 x i16> %val, ptr %a, <32 x i1> %mask) {
; CHECK-LABEL: masked_store_v32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v32i16.p0(<32 x i16> %val, ptr %a, i32 8, <32 x i1> %mask)
  ret void
}

define void @masked_store_v32i32(<32 x i32> %val, ptr %a, <32 x i1> %mask) {
; CHECK-LABEL: masked_store_v32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v32i32.p0(<32 x i32> %val, ptr %a, i32 8, <32 x i1> %mask)
  ret void
}

define void @masked_store_v32i64(<32 x i64> %val, ptr %a, <32 x i1> %mask) {
; CHECK-LABEL: masked_store_v32i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v0, 2
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vse64.v v16, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v32i64.p0(<32 x i64> %val, ptr %a, i32 8, <32 x i1> %mask)
  ret void
}

define void @masked_store_v64i8(<64 x i8> %val, ptr %a, <64 x i1> %mask) {
; CHECK-LABEL: masked_store_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 64
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v64i8.p0(<64 x i8> %val, ptr %a, i32 8, <64 x i1> %mask)
  ret void
}

define void @masked_store_v64i16(<64 x i16> %val, ptr %a, <64 x i1> %mask) {
; CHECK-LABEL: masked_store_v64i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 64
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v64i16.p0(<64 x i16> %val, ptr %a, i32 8, <64 x i1> %mask)
  ret void
}

define void @masked_store_v64i32(<64 x i32> %val, ptr %a, <64 x i1> %mask) {
; CHECK-LABEL: masked_store_v64i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v24, v0, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vse32.v v16, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v64i32.p0(<64 x i32> %val, ptr %a, i32 8, <64 x i1> %mask)
  ret void
}

define void @masked_store_v128i8(<128 x i8> %val, ptr %a, <128 x i1> %mask) {
; CHECK-LABEL: masked_store_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 128
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v128i8.p0(<128 x i8> %val, ptr %a, i32 8, <128 x i1> %mask)
  ret void
}

define void @masked_store_v128i16(<128 x i16> %val, ptr %a, <128 x i1> %mask) {
; CHECK-LABEL: masked_store_v128i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 64
; CHECK-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v24, v0, 8
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vse16.v v16, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v128i16.p0(<128 x i16> %val, ptr %a, i32 8, <128 x i1> %mask)
  ret void
}

define void @masked_store_v256i8(<256 x i8> %val, ptr %a, <256 x i1> %mask) {
; CHECK-LABEL: masked_store_v256i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 128
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; CHECK-NEXT:    vlm.v v24, (a1)
; CHECK-NEXT:    addi a1, a0, 128
; CHECK-NEXT:    vse8.v v8, (a0), v0.t
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vse8.v v16, (a1), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.v256i8.p0(<256 x i8> %val, ptr %a, i32 8, <256 x i1> %mask)
  ret void
}
