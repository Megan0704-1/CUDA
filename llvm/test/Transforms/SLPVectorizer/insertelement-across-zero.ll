; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer < %s | FileCheck %s

define void @test(i8 %0, i8 %1) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: i8 [[TMP0:%.*]], i8 [[TMP1:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP2:%.*]] = load <8 x i8>, ptr getelementptr (i8, ptr null, i32 8), align 1
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i8> [[TMP2]], <8 x i8> poison, <16 x i32> <i32 7, i32 6, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 poison, i32 poison>
; CHECK-NEXT:    [[LUPTO132421:%.*]] = shufflevector <16 x i8> zeroinitializer, <16 x i8> [[TMP3]], <16 x i32> <i32 16, i32 17, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 14, i32 15>
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <16 x i8> [[LUPTO132421]], <16 x i8> <i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 0, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison>, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 23, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <16 x i8> [[TMP6]], i8 [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <16 x i8> [[TMP4]], i8 [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <8 x i8> [[TMP2]], <8 x i8> poison, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <16 x i8> [[TMP5]], <16 x i8> [[TMP7]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 17, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <16 x i8> [[TMP8]], <16 x i8> poison, <16 x i32> <i32 0, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 7, i32 0, i32 9, i32 0, i32 0, i32 0, i32 0, i32 0, i32 15>
; CHECK-NEXT:    [[TMP10:%.*]] = icmp ne <16 x i8> zeroinitializer, [[TMP9]]
; CHECK-NEXT:    ret void
;
entry:
  %li8 = load i8, ptr getelementptr (i8, ptr null, i32 8), align 1
  %li9163 = load i8, ptr getelementptr (i8, ptr null, i32 9), align 1
  %li10 = load i8, ptr getelementptr (i8, ptr null, i32 10), align 1
  %li11164 = load i8, ptr getelementptr (i8, ptr null, i32 11), align 1
  %li12 = load i8, ptr getelementptr (i8, ptr null, i32 12), align 1
  %li13 = load i8, ptr getelementptr (i8, ptr null, i32 13), align 1
  %li14 = load i8, ptr getelementptr (i8, ptr null, i32 14), align 1
  %li15165 = load i8, ptr getelementptr (i8, ptr null, i32 15), align 1
  %lupto8237 = insertelement <16 x i8> zeroinitializer, i8 %li8, i64 8
  %lupto9238 = insertelement <16 x i8> %lupto8237, i8 %li9163, i64 9
  %lupto10239 = insertelement <16 x i8> %lupto9238, i8 %li10, i64 10
  %lupto11240 = insertelement <16 x i8> %lupto10239, i8 %li11164, i64 11
  %lupto12241 = insertelement <16 x i8> %lupto11240, i8 %li12, i64 12
  %lupto13242 = insertelement <16 x i8> %lupto12241, i8 %li13, i64 13
  %lupto14243 = insertelement <16 x i8> %lupto13242, i8 %li14, i64 1
  %l = insertelement <16 x i8> %lupto14243, i8 %li15165, i64 0
  %li15 = extractelement <16 x i8> %l, i64 15
  %2 = icmp ne i8 %0, 0
  %3 = icmp ne i8 %1, 0
  %4 = icmp ne i8 %0, 0
  %.i3 = icmp ne i8 %0, 0
  %.i4 = icmp ne i8 %0, 0
  %5 = icmp ne i8 %0, 0
  %6 = icmp ne i8 %0, 0
  %7 = icmp ne i8 0, 0
  %8 = icmp ne i8 %0, 0
  %.i9 = icmp ne i8 %li9163, 0
  %9 = icmp ne i8 %0, 0
  %10 = icmp ne i8 %0, 0
  %11 = icmp ne i8 %0, 0
  %12 = icmp ne i8 %0, 0
  %13 = icmp ne i8 %0, 0
  %.i15 = icmp ne i8 %li15, 0
  %i0244 = insertelement <16 x i1> zeroinitializer, i1 %2, i64 0
  %i1245 = insertelement <16 x i1> %i0244, i1 %3, i64 1
  %i2246 = insertelement <16 x i1> %i1245, i1 %4, i64 2
  %i3247 = insertelement <16 x i1> %i2246, i1 %.i3, i64 3
  %i4248 = insertelement <16 x i1> %i3247, i1 %.i4, i64 4
  %i5249 = insertelement <16 x i1> %i4248, i1 %5, i64 5
  %i6250 = insertelement <16 x i1> %i5249, i1 %6, i64 6
  %i7251 = insertelement <16 x i1> %i6250, i1 %7, i64 7
  %i8252 = insertelement <16 x i1> %i7251, i1 %8, i64 8
  %i9253 = insertelement <16 x i1> %i8252, i1 %.i9, i64 9
  %i10254 = insertelement <16 x i1> %i9253, i1 %9, i64 10
  %i11255 = insertelement <16 x i1> %i10254, i1 %10, i64 11
  %i12256 = insertelement <16 x i1> %i11255, i1 %11, i64 12
  %i13257 = insertelement <16 x i1> %i12256, i1 %12, i64 13
  %i14 = insertelement <16 x i1> %i13257, i1 %13, i64 14
  %14 = insertelement <16 x i1> %i14, i1 %.i15, i64 15
  ret void
}