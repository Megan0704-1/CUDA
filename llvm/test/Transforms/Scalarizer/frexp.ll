; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt %s -passes='function(scalarizer)' -S | FileCheck %s

define void @test_vector_frexp_void(<2 x double> noundef %d) {
; CHECK-LABEL: define void @test_vector_frexp_void(
; CHECK-SAME: <2 x double> noundef [[D:%.*]]) {
; CHECK-NEXT:    [[D_I0:%.*]] = extractelement <2 x double> [[D]], i64 0
; CHECK-NEXT:    [[DOTI0:%.*]] = call { double, i32 } @llvm.frexp.f64.i32(double [[D_I0]])
; CHECK-NEXT:    [[D_I1:%.*]] = extractelement <2 x double> [[D]], i64 1
; CHECK-NEXT:    [[DOTI1:%.*]] = call { double, i32 } @llvm.frexp.f64.i32(double [[D_I1]])
; CHECK-NEXT:    ret void
;
  %1 =  call { <2 x double>, <2 x i32> } @llvm.frexp.v2f64.v2i32(<2 x double> %d)
  ret void
}

define noundef <2 x half> @test_vector_half_frexp_half(<2 x half> noundef %h) {
; CHECK-LABEL: define noundef <2 x half> @test_vector_half_frexp_half(
; CHECK-SAME: <2 x half> noundef [[H:%.*]]) {
; CHECK-NEXT:    [[H_I0:%.*]] = extractelement <2 x half> [[H]], i64 0
; CHECK-NEXT:    [[R_I0:%.*]] = call { half, i32 } @llvm.frexp.f16.i32(half [[H_I0]])
; CHECK-NEXT:    [[H_I1:%.*]] = extractelement <2 x half> [[H]], i64 1
; CHECK-NEXT:    [[R_I1:%.*]] = call { half, i32 } @llvm.frexp.f16.i32(half [[H_I1]])
; CHECK-NEXT:    [[E0_ELEM0:%.*]] = extractvalue { half, i32 } [[R_I0]], 0
; CHECK-NEXT:    [[E0_ELEM01:%.*]] = extractvalue { half, i32 } [[R_I1]], 0
; CHECK-NEXT:    [[E0_UPTO0:%.*]] = insertelement <2 x half> poison, half [[E0_ELEM0]], i64 0
; CHECK-NEXT:    [[E0:%.*]] = insertelement <2 x half> [[E0_UPTO0]], half [[E0_ELEM01]], i64 1
; CHECK-NEXT:    ret <2 x half> [[E0]]
;
  %r =  call { <2 x half>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x half> %h)
  %e0 = extractvalue { <2 x half>, <2 x i32> } %r, 0
  ret <2 x half> %e0
}

define noundef <2 x i32> @test_vector_half_frexp_int(<2 x half> noundef %h) {
; CHECK-LABEL: define noundef <2 x i32> @test_vector_half_frexp_int(
; CHECK-SAME: <2 x half> noundef [[H:%.*]]) {
; CHECK-NEXT:    [[H_I0:%.*]] = extractelement <2 x half> [[H]], i64 0
; CHECK-NEXT:    [[R_I0:%.*]] = call { half, i32 } @llvm.frexp.f16.i32(half [[H_I0]])
; CHECK-NEXT:    [[H_I1:%.*]] = extractelement <2 x half> [[H]], i64 1
; CHECK-NEXT:    [[R_I1:%.*]] = call { half, i32 } @llvm.frexp.f16.i32(half [[H_I1]])
; CHECK-NEXT:    [[E1_ELEM1:%.*]] = extractvalue { half, i32 } [[R_I0]], 1
; CHECK-NEXT:    [[E1_ELEM11:%.*]] = extractvalue { half, i32 } [[R_I1]], 1
; CHECK-NEXT:    [[E1_UPTO0:%.*]] = insertelement <2 x i32> poison, i32 [[E1_ELEM1]], i64 0
; CHECK-NEXT:    [[E1:%.*]] = insertelement <2 x i32> [[E1_UPTO0]], i32 [[E1_ELEM11]], i64 1
; CHECK-NEXT:    ret <2 x i32> [[E1]]
;
  %r =  call { <2 x half>, <2 x i32> } @llvm.frexp.v2f32.v2i32(<2 x half> %h)
  %e1 = extractvalue { <2 x half>, <2 x i32> } %r, 1
  ret <2 x i32> %e1
}

define noundef <2 x float> @test_vector_float_frexp_int(<2 x float> noundef %f) {
; CHECK-LABEL: define noundef <2 x float> @test_vector_float_frexp_int(
; CHECK-SAME: <2 x float> noundef [[F:%.*]]) {
; CHECK-NEXT:    [[F_I0:%.*]] = extractelement <2 x float> [[F]], i64 0
; CHECK-NEXT:    [[DOTI0:%.*]] = call { float, i32 } @llvm.frexp.f32.i32(float [[F_I0]])
; CHECK-NEXT:    [[F_I1:%.*]] = extractelement <2 x float> [[F]], i64 1
; CHECK-NEXT:    [[DOTI1:%.*]] = call { float, i32 } @llvm.frexp.f32.i32(float [[F_I1]])
; CHECK-NEXT:    [[DOTELEM0:%.*]] = extractvalue { float, i32 } [[DOTI0]], 0
; CHECK-NEXT:    [[DOTELEM01:%.*]] = extractvalue { float, i32 } [[DOTI1]], 0
; CHECK-NEXT:    [[DOTUPTO010:%.*]] = insertelement <2 x float> poison, float [[DOTELEM0]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x float> [[DOTUPTO010]], float [[DOTELEM01]], i64 1
; CHECK-NEXT:    [[DOTELEM1:%.*]] = extractvalue { float, i32 } [[DOTI0]], 1
; CHECK-NEXT:    [[DOTELEM12:%.*]] = extractvalue { float, i32 } [[DOTI1]], 1
; CHECK-NEXT:    ret <2 x float> [[TMP1]]
;
  %1 =  call { <2 x float>, <2 x i32> } @llvm.frexp.v2f16.v2i32(<2 x float> %f)
  %2 = extractvalue { <2 x float>, <2 x i32> } %1, 0
  %3 = extractvalue { <2 x float>, <2 x i32> } %1, 1
  ret <2 x float> %2
}

define noundef <2 x double> @test_vector_double_frexp_int(<2 x double> noundef %d) {
; CHECK-LABEL: define noundef <2 x double> @test_vector_double_frexp_int(
; CHECK-SAME: <2 x double> noundef [[D:%.*]]) {
; CHECK-NEXT:    [[D_I0:%.*]] = extractelement <2 x double> [[D]], i64 0
; CHECK-NEXT:    [[DOTI0:%.*]] = call { double, i32 } @llvm.frexp.f64.i32(double [[D_I0]])
; CHECK-NEXT:    [[D_I1:%.*]] = extractelement <2 x double> [[D]], i64 1
; CHECK-NEXT:    [[DOTI1:%.*]] = call { double, i32 } @llvm.frexp.f64.i32(double [[D_I1]])
; CHECK-NEXT:    [[DOTELEM0:%.*]] = extractvalue { double, i32 } [[DOTI0]], 0
; CHECK-NEXT:    [[DOTELEM01:%.*]] = extractvalue { double, i32 } [[DOTI1]], 0
; CHECK-NEXT:    [[DOTUPTO010:%.*]] = insertelement <2 x double> poison, double [[DOTELEM0]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x double> [[DOTUPTO010]], double [[DOTELEM01]], i64 1
; CHECK-NEXT:    [[DOTELEM1:%.*]] = extractvalue { double, i32 } [[DOTI0]], 1
; CHECK-NEXT:    [[DOTELEM12:%.*]] = extractvalue { double, i32 } [[DOTI1]], 1
; CHECK-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 =  call { <2 x double>, <2 x i32> } @llvm.frexp.v2f64.v2i32(<2 x double> %d)
  %2 = extractvalue { <2 x double>, <2 x i32> } %1, 0
  %3 = extractvalue { <2 x double>, <2 x i32> } %1, 1
  ret <2 x double> %2
}