; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instsimplify -S | FileCheck %s
; RUN: opt < %s -passes=instsimplify -use-constant-fp-for-fixed-length-splat -use-constant-int-for-fixed-length-splat -S | FileCheck %s

; Weird Types

define i129 @vec_extract_negidx(<3 x i129> %a) {
; CHECK-LABEL: @vec_extract_negidx(
; CHECK-NEXT:    ret i129 poison
;
  %E1 = extractelement <3 x i129> %a, i129 -1
  ret i129 %E1
}

define i129 @vec_extract_out_of_bounds(<3 x i129> %a) {
; CHECK-LABEL: @vec_extract_out_of_bounds(
; CHECK-NEXT:    ret i129 poison
;
  %E1 = extractelement <3 x i129> %a, i129 3
  ret i129 %E1
}

define i129 @vec_extract_out_of_bounds2(<3 x i129> %a) {
; CHECK-LABEL: @vec_extract_out_of_bounds2(
; CHECK-NEXT:    ret i129 poison
;
  %E1 = extractelement <3 x i129> %a, i129 999999999999999
  ret i129 %E1
}

define i129 @vec_extract_undef_index(<3 x i129> %a) {
; CHECK-LABEL: @vec_extract_undef_index(
; CHECK-NEXT:    ret i129 poison
;
  %E1 = extractelement <3 x i129> %a, i129 undef
  ret i129 %E1
}

define i129 @vec_extract_poison_index(<3 x i129> %a) {
; CHECK-LABEL: @vec_extract_poison_index(
; CHECK-NEXT:    ret i129 poison
;
  %E1 = extractelement <3 x i129> %a, i129 poison
  ret i129 %E1
}

define i129 @vec_extract_in_bounds(<3 x i129> %a) {
; CHECK-LABEL: @vec_extract_in_bounds(
; CHECK-NEXT:    [[E1:%.*]] = extractelement <3 x i129> [[A:%.*]], i129 2
; CHECK-NEXT:    ret i129 [[E1]]
;
  %E1 = extractelement <3 x i129> %a, i129 2
  ret i129 %E1
}

define float @extract_element_splat_constant_vector_variable_index(i32 %y) {
; CHECK-LABEL: @extract_element_splat_constant_vector_variable_index(
; CHECK-NEXT:    ret float 2.000000e+00
;
  %r = extractelement <4 x float> <float 2.0, float 2.0, float 2.0, float 2.0>, i32 %y
  ret float %r
}

define i32 @extractelement_splat_variable_index(i32 %v, i32 %index) {
; CHECK-LABEL: @extractelement_splat_variable_index(
; CHECK-NEXT:    ret i32 [[V:%.*]]
;
  %in = insertelement <3 x i32> poison, i32 %v, i32 0
  %splat = shufflevector <3 x i32> %in, <3 x i32> poison, <3 x i32> zeroinitializer
  %r = extractelement <3 x i32> %splat, i32 %index
  ret i32 %r
}