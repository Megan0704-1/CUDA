; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=hexagon < %s | FileCheck %s

define i64 @f0(ptr %a0, <8 x i8> %a1) #0 {
; CHECK-LABEL: f0:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r5:4 = combine(#0,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r1:0 = vmux(p0,r3:2,r5:4)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0, align 1
  %v1 = select <8 x i1> %v0, <8 x i8> %a1, <8 x i8> zeroinitializer
  %v2 = bitcast <8 x i8> %v1 to i64
  ret i64 %v2
}

define i32 @f1(ptr %a0, <4 x i8> %a1) #0 {
; CHECK-LABEL: f1:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3:2 = combine(#0,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r5:4 = vzxtbh(r1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r1:0 = vmux(p0,r5:4,r3:2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = vtrunehb(r1:0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = load <4 x i1>, ptr %a0, align 1
  %v1 = select <4 x i1> %v0, <4 x i8> %a1, <4 x i8> zeroinitializer
  %v2 = bitcast <4 x i8> %v1 to i32
  ret i32 %v2
}

define i16 @f2(ptr %a0, <2 x i8> %a1) #0 {
; CHECK-LABEL: f2:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p1 = tstbit(r0,#4)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = mux(p1,r3,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = mux(p0,r2,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = insert(r1,#24,#8)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = load <2 x i1>, ptr %a0, align 1
  %v1 = select <2 x i1> %v0, <2 x i8> %a1, <2 x i8> zeroinitializer
  %v2 = bitcast <2 x i8> %v1 to i16
  ret i16 %v2
}

define i8 @f3(ptr %a0, <1 x i8> %a1) #0 {
; CHECK-LABEL: f3:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = mux(p0,r1,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = load <1 x i1>, ptr %a0, align 1
  %v1 = select <1 x i1> %v0, <1 x i8> %a1, <1 x i8> zeroinitializer
  %v2 = bitcast <1 x i8> %v1 to i8
  ret i8 %v2
}

define void @f4(ptr %a0, i64 %a1) #0 {
; CHECK-LABEL: f4:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r5:4 = combine(#0,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = vcmpb.eq(r3:2,r5:4)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = not(p0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = p0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     memb(r0+#0) = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = bitcast i64 %a1 to <8 x i8>
  %v1 = icmp ne <8 x i8> %v0, zeroinitializer
  store <8 x i1> %v1, ptr %a0, align 1
  ret void
}

define void @f5(ptr %a0, i32 %a1) #0 {
; CHECK-LABEL: f5:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r3:2 = vsxtbh(r1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r5:4 = combine(#0,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = vcmph.eq(r3:2,r5:4)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = not(p0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r2 = p0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     memb(r0+#0) = r2
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = bitcast i32 %a1 to <4 x i8>
  %v1 = icmp ne <4 x i8> %v0, zeroinitializer
  store <4 x i1> %v1, ptr %a0, align 1
  ret void
}

define void @f6(ptr %a0, i16 %a1) #0 {
; CHECK-LABEL: f6:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r2 = extractu(r1,#8,#8)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = #255
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p1 = !bitsclr(r1,r3)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = cmp.eq(r2,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     if (p0) r2 = #0
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = mux(p1,#8,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = mux(p1,#2,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r5 = setbit(r1,#2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r6 = setbit(r3,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     if (!p0) r2 = #128
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r4 = mux(p0,#0,#32)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     if (!p1) r5 = add(r1,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     if (!p1) r6 = add(r3,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = setbit(r2,#6)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = setbit(r4,#4)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r5 = or(r6,r5)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     if (!p0) r2 = add(r1,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     if (!p0) r4 = add(r3,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r5 |= or(r4,r2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     memb(r0+#0) = r5
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = bitcast i16 %a1 to <2 x i8>
  %v1 = icmp ne <2 x i8> %v0, zeroinitializer
  store <2 x i1> %v1, ptr %a0, align 1
  ret void
}

define void @f7(ptr %a0, i8 %a1) #0 {
; CHECK-LABEL: f7:
; CHECK:       // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r2 = #255
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = !bitsclr(r1,r2)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = mux(p0,#1,#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     memb(r0+#0) = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:    }
b0:
  %v0 = bitcast i8 %a1 to <1 x i8>
  %v1 = icmp ne <1 x i8> %v0, zeroinitializer
  store <1 x i1> %v1, ptr %a0, align 1
  ret void
}

attributes #0 = { nounwind "target-features"="-packets" }