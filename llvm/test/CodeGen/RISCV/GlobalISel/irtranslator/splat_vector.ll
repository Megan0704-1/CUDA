; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=riscv32 -mattr=+v,+zvfh -global-isel -stop-after=irtranslator \
; RUN:   -verify-machineinstrs < %s | FileCheck -check-prefixes=RV32 %s
; RUN: llc -mtriple=riscv64 -mattr=+v,+zvfh -global-isel -stop-after=irtranslator \
; RUN:   -verify-machineinstrs < %s | FileCheck -check-prefixes=RV64 %s

define <vscale x 1 x i1> @splat_zero_nxv1i1() {
  ; RV32-LABEL: name: splat_zero_nxv1i1
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV32-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s1>)
  ; RV32-NEXT:   PseudoRET implicit $v0
  ;
  ; RV64-LABEL: name: splat_zero_nxv1i1
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV64-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s1>)
  ; RV64-NEXT:   PseudoRET implicit $v0
  ret <vscale x 1 x i1> zeroinitializer
}

define <vscale x 2 x i1> @splat_zero_nxv2i1() {
  ; RV32-LABEL: name: splat_zero_nxv2i1
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV32-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s1>)
  ; RV32-NEXT:   PseudoRET implicit $v0
  ;
  ; RV64-LABEL: name: splat_zero_nxv2i1
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV64-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s1>)
  ; RV64-NEXT:   PseudoRET implicit $v0
  ret <vscale x 2 x i1> zeroinitializer
}

define <vscale x 4 x i1> @splat_zero_nxv4i1() {
  ; RV32-LABEL: name: splat_zero_nxv4i1
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV32-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s1>)
  ; RV32-NEXT:   PseudoRET implicit $v0
  ;
  ; RV64-LABEL: name: splat_zero_nxv4i1
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV64-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s1>)
  ; RV64-NEXT:   PseudoRET implicit $v0
  ret <vscale x 4 x i1> zeroinitializer
}

define <vscale x 8 x i1> @splat_zero_nxv8i1() {
  ; RV32-LABEL: name: splat_zero_nxv8i1
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV32-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s1>)
  ; RV32-NEXT:   PseudoRET implicit $v0
  ;
  ; RV64-LABEL: name: splat_zero_nxv8i1
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV64-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s1>)
  ; RV64-NEXT:   PseudoRET implicit $v0
  ret <vscale x 8 x i1> zeroinitializer
}

define <vscale x 16 x i1> @splat_zero_nxv16i1() {
  ; RV32-LABEL: name: splat_zero_nxv16i1
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV32-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s1>)
  ; RV32-NEXT:   PseudoRET implicit $v0
  ;
  ; RV64-LABEL: name: splat_zero_nxv16i1
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV64-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s1>)
  ; RV64-NEXT:   PseudoRET implicit $v0
  ret <vscale x 16 x i1> zeroinitializer
}

define <vscale x 32 x i1> @splat_zero_nxv32i1() {
  ; RV32-LABEL: name: splat_zero_nxv32i1
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 32 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV32-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 32 x s1>)
  ; RV32-NEXT:   PseudoRET implicit $v0
  ;
  ; RV64-LABEL: name: splat_zero_nxv32i1
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 32 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV64-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 32 x s1>)
  ; RV64-NEXT:   PseudoRET implicit $v0
  ret <vscale x 32 x i1> zeroinitializer
}

define <vscale x 64 x i1> @splat_zero_nxv64i1() {
  ; RV32-LABEL: name: splat_zero_nxv64i1
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 64 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV32-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 64 x s1>)
  ; RV32-NEXT:   PseudoRET implicit $v0
  ;
  ; RV64-LABEL: name: splat_zero_nxv64i1
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 64 x s1>) = G_SPLAT_VECTOR [[C]](s1)
  ; RV64-NEXT:   $v0 = COPY [[SPLAT_VECTOR]](<vscale x 64 x s1>)
  ; RV64-NEXT:   PseudoRET implicit $v0
  ret <vscale x 64 x i1> zeroinitializer
}

define <vscale x 1 x i8> @splat_zero_nxv1i8() {
  ; RV32-LABEL: name: splat_zero_nxv1i8
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s8>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv1i8
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s8>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 1 x i8> zeroinitializer
}

define <vscale x 2 x i8> @splat_zero_nxv2i8() {
  ; RV32-LABEL: name: splat_zero_nxv2i8
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s8>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv2i8
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s8>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 2 x i8> zeroinitializer
}

define <vscale x 4 x i8> @splat_zero_nxv4i8() {
  ; RV32-LABEL: name: splat_zero_nxv4i8
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s8>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv4i8
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s8>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 4 x i8> zeroinitializer
}

define <vscale x 8 x i8> @splat_zero_nxv8i8() {
  ; RV32-LABEL: name: splat_zero_nxv8i8
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s8>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv8i8
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s8>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 8 x i8> zeroinitializer
}

define <vscale x 16 x i8> @splat_zero_nxv16i8() {
  ; RV32-LABEL: name: splat_zero_nxv16i8
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV32-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s8>)
  ; RV32-NEXT:   PseudoRET implicit $v8m2
  ;
  ; RV64-LABEL: name: splat_zero_nxv16i8
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV64-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s8>)
  ; RV64-NEXT:   PseudoRET implicit $v8m2
  ret <vscale x 16 x i8> zeroinitializer
}

define <vscale x 32 x i8> @splat_zero_nxv32i8() {
  ; RV32-LABEL: name: splat_zero_nxv32i8
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 32 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV32-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 32 x s8>)
  ; RV32-NEXT:   PseudoRET implicit $v8m4
  ;
  ; RV64-LABEL: name: splat_zero_nxv32i8
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 32 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV64-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 32 x s8>)
  ; RV64-NEXT:   PseudoRET implicit $v8m4
  ret <vscale x 32 x i8> zeroinitializer
}

define <vscale x 64 x i8> @splat_zero_nxv64i8() {
  ; RV32-LABEL: name: splat_zero_nxv64i8
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 64 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV32-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 64 x s8>)
  ; RV32-NEXT:   PseudoRET implicit $v8m8
  ;
  ; RV64-LABEL: name: splat_zero_nxv64i8
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s8) = G_CONSTANT i8 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 64 x s8>) = G_SPLAT_VECTOR [[C]](s8)
  ; RV64-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 64 x s8>)
  ; RV64-NEXT:   PseudoRET implicit $v8m8
  ret <vscale x 64 x i8> zeroinitializer
}

define <vscale x 1 x i16> @splat_zero_nxv1i16() {
  ; RV32-LABEL: name: splat_zero_nxv1i16
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv1i16
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 1 x i16> zeroinitializer
}

define <vscale x 2 x i16> @splat_zero_nxv2i16() {
  ; RV32-LABEL: name: splat_zero_nxv2i16
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv2i16
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 2 x i16> zeroinitializer
}

define <vscale x 4 x i16> @splat_zero_nxv4i16() {
  ; RV32-LABEL: name: splat_zero_nxv4i16
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv4i16
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 4 x i16> zeroinitializer
}

define <vscale x 8 x i16> @splat_zero_nxv8i16() {
  ; RV32-LABEL: name: splat_zero_nxv8i16
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8m2
  ;
  ; RV64-LABEL: name: splat_zero_nxv8i16
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8m2
  ret <vscale x 8 x i16> zeroinitializer
}

define <vscale x 16 x i16> @splat_zero_nxv16i16() {
  ; RV32-LABEL: name: splat_zero_nxv16i16
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8m4
  ;
  ; RV64-LABEL: name: splat_zero_nxv16i16
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8m4
  ret <vscale x 16 x i16> zeroinitializer
}

define <vscale x 32 x i16> @splat_zero_nxv32i16() {
  ; RV32-LABEL: name: splat_zero_nxv32i16
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 32 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 32 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8m8
  ;
  ; RV64-LABEL: name: splat_zero_nxv32i16
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_CONSTANT i16 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 32 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 32 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8m8
  ret <vscale x 32 x i16> zeroinitializer
}

define <vscale x 1 x i32> @splat_zero_nxv1i32() {
  ; RV32-LABEL: name: splat_zero_nxv1i32
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv1i32
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 1 x i32> zeroinitializer
}

define <vscale x 2 x i32> @splat_zero_nxv2i32() {
  ; RV32-LABEL: name: splat_zero_nxv2i32
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv2i32
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 2 x i32> zeroinitializer
}

define <vscale x 4 x i32> @splat_zero_nxv4i32() {
  ; RV32-LABEL: name: splat_zero_nxv4i32
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8m2
  ;
  ; RV64-LABEL: name: splat_zero_nxv4i32
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8m2
  ret <vscale x 4 x i32> zeroinitializer
}

define <vscale x 8 x i32> @splat_zero_nxv8i32() {
  ; RV32-LABEL: name: splat_zero_nxv8i32
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8m4
  ;
  ; RV64-LABEL: name: splat_zero_nxv8i32
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8m4
  ret <vscale x 8 x i32> zeroinitializer
}

define <vscale x 16 x i32> @splat_zero_nxv16i32() {
  ; RV32-LABEL: name: splat_zero_nxv16i32
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8m8
  ;
  ; RV64-LABEL: name: splat_zero_nxv16i32
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8m8
  ret <vscale x 16 x i32> zeroinitializer
}

define <vscale x 1 x i64> @splat_zero_nxv1i64() {
  ; RV32-LABEL: name: splat_zero_nxv1i64
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s64>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv1i64
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s64>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 1 x i64> zeroinitializer
}

define <vscale x 2 x i64> @splat_zero_nxv2i64() {
  ; RV32-LABEL: name: splat_zero_nxv2i64
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV32-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s64>)
  ; RV32-NEXT:   PseudoRET implicit $v8m2
  ;
  ; RV64-LABEL: name: splat_zero_nxv2i64
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV64-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s64>)
  ; RV64-NEXT:   PseudoRET implicit $v8m2
  ret <vscale x 2 x i64> zeroinitializer
}

define <vscale x 4 x i64> @splat_zero_nxv4i64() {
  ; RV32-LABEL: name: splat_zero_nxv4i64
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV32-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s64>)
  ; RV32-NEXT:   PseudoRET implicit $v8m4
  ;
  ; RV64-LABEL: name: splat_zero_nxv4i64
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV64-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s64>)
  ; RV64-NEXT:   PseudoRET implicit $v8m4
  ret <vscale x 4 x i64> zeroinitializer
}

define <vscale x 8 x i64> @splat_zero_nxv8i64() {
  ; RV32-LABEL: name: splat_zero_nxv8i64
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV32-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s64>)
  ; RV32-NEXT:   PseudoRET implicit $v8m8
  ;
  ; RV64-LABEL: name: splat_zero_nxv8i64
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV64-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s64>)
  ; RV64-NEXT:   PseudoRET implicit $v8m8
  ret <vscale x 8 x i64> zeroinitializer
}

define <vscale x 1 x half> @splat_zero_nxv1half() {
  ; RV32-LABEL: name: splat_zero_nxv1half
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv1half
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 1 x half> zeroinitializer
}

define <vscale x 2 x half> @splat_zero_nxv2half() {
  ; RV32-LABEL: name: splat_zero_nxv2half
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv2half
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 2 x half> zeroinitializer
}

define <vscale x 4 x half> @splat_zero_nxv4half() {
  ; RV32-LABEL: name: splat_zero_nxv4half
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv4half
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 4 x half> zeroinitializer
}

define <vscale x 8 x half> @splat_zero_nxv8half() {
  ; RV32-LABEL: name: splat_zero_nxv8half
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8m2
  ;
  ; RV64-LABEL: name: splat_zero_nxv8half
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8m2
  ret <vscale x 8 x half> zeroinitializer
}

define <vscale x 16 x half> @splat_zero_nxv16half() {
  ; RV32-LABEL: name: splat_zero_nxv16half
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8m4
  ;
  ; RV64-LABEL: name: splat_zero_nxv16half
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8m4
  ret <vscale x 16 x half> zeroinitializer
}

define <vscale x 32 x half> @splat_zero_nxv32half() {
  ; RV32-LABEL: name: splat_zero_nxv32half
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 32 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV32-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 32 x s16>)
  ; RV32-NEXT:   PseudoRET implicit $v8m8
  ;
  ; RV64-LABEL: name: splat_zero_nxv32half
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s16) = G_FCONSTANT half 0xH0000
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 32 x s16>) = G_SPLAT_VECTOR [[C]](s16)
  ; RV64-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 32 x s16>)
  ; RV64-NEXT:   PseudoRET implicit $v8m8
  ret <vscale x 32 x half> zeroinitializer
}

define <vscale x 1 x float> @splat_zero_nxv1float() {
  ; RV32-LABEL: name: splat_zero_nxv1float
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv1float
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 1 x float> zeroinitializer
}

define <vscale x 2 x float> @splat_zero_nxv2float() {
  ; RV32-LABEL: name: splat_zero_nxv2float
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv2float
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 2 x float> zeroinitializer
}

define <vscale x 4 x float> @splat_zero_nxv4float() {
  ; RV32-LABEL: name: splat_zero_nxv4float
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8m2
  ;
  ; RV64-LABEL: name: splat_zero_nxv4float
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8m2
  ret <vscale x 4 x float> zeroinitializer
}

define <vscale x 8 x float> @splat_zero_nxv8float() {
  ; RV32-LABEL: name: splat_zero_nxv8float
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8m4
  ;
  ; RV64-LABEL: name: splat_zero_nxv8float
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8m4
  ret <vscale x 8 x float> zeroinitializer
}

define <vscale x 16 x float> @splat_zero_nxv16float() {
  ; RV32-LABEL: name: splat_zero_nxv16float
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV32-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s32>)
  ; RV32-NEXT:   PseudoRET implicit $v8m8
  ;
  ; RV64-LABEL: name: splat_zero_nxv16float
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 16 x s32>) = G_SPLAT_VECTOR [[C]](s32)
  ; RV64-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 16 x s32>)
  ; RV64-NEXT:   PseudoRET implicit $v8m8
  ret <vscale x 16 x float> zeroinitializer
}

define <vscale x 1 x double> @splat_zero_nxv1double() {
  ; RV32-LABEL: name: splat_zero_nxv1double
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s64>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv1double
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x s64>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 1 x double> zeroinitializer
}

define <vscale x 2 x double> @splat_zero_nxv2double() {
  ; RV32-LABEL: name: splat_zero_nxv2double
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV32-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s64>)
  ; RV32-NEXT:   PseudoRET implicit $v8m2
  ;
  ; RV64-LABEL: name: splat_zero_nxv2double
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV64-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 2 x s64>)
  ; RV64-NEXT:   PseudoRET implicit $v8m2
  ret <vscale x 2 x double> zeroinitializer
}

define <vscale x 4 x double> @splat_zero_nxv4double() {
  ; RV32-LABEL: name: splat_zero_nxv4double
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV32-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s64>)
  ; RV32-NEXT:   PseudoRET implicit $v8m4
  ;
  ; RV64-LABEL: name: splat_zero_nxv4double
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV64-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 4 x s64>)
  ; RV64-NEXT:   PseudoRET implicit $v8m4
  ret <vscale x 4 x double> zeroinitializer
}

define <vscale x 8 x double> @splat_zero_nxv8double() {
  ; RV32-LABEL: name: splat_zero_nxv8double
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 0.000000e+00
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV32-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s64>)
  ; RV32-NEXT:   PseudoRET implicit $v8m8
  ;
  ; RV64-LABEL: name: splat_zero_nxv8double
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(s64) = G_FCONSTANT double 0.000000e+00
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x s64>) = G_SPLAT_VECTOR [[C]](s64)
  ; RV64-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 8 x s64>)
  ; RV64-NEXT:   PseudoRET implicit $v8m8
  ret <vscale x 8 x double> zeroinitializer
}

define <vscale x 1 x ptr> @splat_zero_nxv1ptr() {
  ; RV32-LABEL: name: splat_zero_nxv1ptr
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x p0>) = G_SPLAT_VECTOR [[C]](p0)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x p0>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv1ptr
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i64 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 1 x p0>) = G_SPLAT_VECTOR [[C]](p0)
  ; RV64-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 1 x p0>)
  ; RV64-NEXT:   PseudoRET implicit $v8
  ret <vscale x 1 x ptr> zeroinitializer
}

define <vscale x 2 x ptr> @splat_zero_nxv2ptr() {
  ; RV32-LABEL: name: splat_zero_nxv2ptr
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x p0>) = G_SPLAT_VECTOR [[C]](p0)
  ; RV32-NEXT:   $v8 = COPY [[SPLAT_VECTOR]](<vscale x 2 x p0>)
  ; RV32-NEXT:   PseudoRET implicit $v8
  ;
  ; RV64-LABEL: name: splat_zero_nxv2ptr
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i64 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 2 x p0>) = G_SPLAT_VECTOR [[C]](p0)
  ; RV64-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 2 x p0>)
  ; RV64-NEXT:   PseudoRET implicit $v8m2
  ret <vscale x 2 x ptr> zeroinitializer
}

define <vscale x 4 x ptr> @splat_zero_nxv4ptr() {
  ; RV32-LABEL: name: splat_zero_nxv4ptr
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x p0>) = G_SPLAT_VECTOR [[C]](p0)
  ; RV32-NEXT:   $v8m2 = COPY [[SPLAT_VECTOR]](<vscale x 4 x p0>)
  ; RV32-NEXT:   PseudoRET implicit $v8m2
  ;
  ; RV64-LABEL: name: splat_zero_nxv4ptr
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i64 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 4 x p0>) = G_SPLAT_VECTOR [[C]](p0)
  ; RV64-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 4 x p0>)
  ; RV64-NEXT:   PseudoRET implicit $v8m4
  ret <vscale x 4 x ptr> zeroinitializer
}

define <vscale x 8 x ptr> @splat_zero_nxv8ptr() {
  ; RV32-LABEL: name: splat_zero_nxv8ptr
  ; RV32: bb.1 (%ir-block.0):
  ; RV32-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i32 0
  ; RV32-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x p0>) = G_SPLAT_VECTOR [[C]](p0)
  ; RV32-NEXT:   $v8m4 = COPY [[SPLAT_VECTOR]](<vscale x 8 x p0>)
  ; RV32-NEXT:   PseudoRET implicit $v8m4
  ;
  ; RV64-LABEL: name: splat_zero_nxv8ptr
  ; RV64: bb.1 (%ir-block.0):
  ; RV64-NEXT:   [[C:%[0-9]+]]:_(p0) = G_CONSTANT i64 0
  ; RV64-NEXT:   [[SPLAT_VECTOR:%[0-9]+]]:_(<vscale x 8 x p0>) = G_SPLAT_VECTOR [[C]](p0)
  ; RV64-NEXT:   $v8m8 = COPY [[SPLAT_VECTOR]](<vscale x 8 x p0>)
  ; RV64-NEXT:   PseudoRET implicit $v8m8
  ret <vscale x 8 x ptr> zeroinitializer
}