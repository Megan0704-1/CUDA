; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=hexagon -hexagon-expand-condsets=0 < %s | FileCheck %s

define <4 x i8> @f0(<4 x i8> %a0, <4 x i8> %a1, i32 %a2) #0 {
; CHECK-LABEL: f0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = cmp.eq(r2,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = mux(p0,r0,r1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %v0 = icmp eq i32 %a2, 0
  %v1 = select i1 %v0, <4 x i8> %a0, <4 x i8> %a1
  ret <4 x i8> %v1
}

define <8 x i8> @f1(<8 x i8> %a0, <8 x i8> %a1, i32 %a2) #0 {
; CHECK-LABEL: f1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = cmp.eq(r4,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = mux(p0,r0,r2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     r1 = mux(p0,r1,r3)
; CHECK-NEXT:    }
  %v0 = icmp eq i32 %a2, 0
  %v1 = select i1 %v0, <8 x i8> %a0, <8 x i8> %a1
  ret <8 x i8> %v1
}

define <2 x i16> @f2(<2 x i16> %a0, <2 x i16> %a1, i32 %a2) #0 {
; CHECK-LABEL: f2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = cmp.eq(r2,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = mux(p0,r0,r1)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
  %v0 = icmp eq i32 %a2, 0
  %v1 = select i1 %v0, <2 x i16> %a0, <2 x i16> %a1
  ret <2 x i16> %v1
}

define <4 x i16> @f3(<4 x i16> %a0, <4 x i16> %a1, i32 %a2) #0 {
; CHECK-LABEL: f3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = cmp.eq(r4,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = mux(p0,r0,r2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     r1 = mux(p0,r1,r3)
; CHECK-NEXT:    }
  %v0 = icmp eq i32 %a2, 0
  %v1 = select i1 %v0, <4 x i16> %a0, <4 x i16> %a1
  ret <4 x i16> %v1
}

define <2 x i32> @f4(<2 x i32> %a0, <2 x i32> %a1, i32 %a2) #0 {
; CHECK-LABEL: f4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = cmp.eq(r4,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = mux(p0,r0,r2)
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     r1 = mux(p0,r1,r3)
; CHECK-NEXT:    }
  %v0 = icmp eq i32 %a2, 0
  %v1 = select i1 %v0, <2 x i32> %a0, <2 x i32> %a1
  ret <2 x i32> %v1
}

attributes #0 = { nounwind }