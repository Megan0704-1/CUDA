; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes=instcombine -S %s | FileCheck %s

define <2 x i8> @select_icmp_insertelement_eq(<2 x i8> %x, <2 x i8> %y, i8 %i) {
; CHECK-LABEL: define <2 x i8> @select_icmp_insertelement_eq(
; CHECK-SAME: <2 x i8> [[X:%.*]], <2 x i8> [[Y:%.*]], i8 [[I:%.*]]) {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i8> [[Y]], splat (i8 2)
; CHECK-NEXT:    [[INSERT:%.*]] = insertelement <2 x i8> splat (i8 2), i8 0, i8 [[I]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[CMP]], <2 x i8> [[INSERT]], <2 x i8> [[X]]
; CHECK-NEXT:    ret <2 x i8> [[RETVAL]]
;
  %cmp = icmp eq <2 x i8> %y, <i8 2, i8 2>
  %insert = insertelement <2 x i8> %y, i8 0, i8 %i
  %retval = select <2 x i1> %cmp, <2 x i8> %insert, <2 x i8> %x
  ret <2 x i8> %retval
}

define <2 x i8> @select_icmp_insertelement_ne(<2 x i8> %x, <2 x i8> %y, i8 %i) {
; CHECK-LABEL: define <2 x i8> @select_icmp_insertelement_ne(
; CHECK-SAME: <2 x i8> [[X:%.*]], <2 x i8> [[Y:%.*]], i8 [[I:%.*]]) {
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq <2 x i8> [[Y]], splat (i8 2)
; CHECK-NEXT:    [[INSERT:%.*]] = insertelement <2 x i8> splat (i8 2), i8 0, i8 [[I]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[CMP_NOT]], <2 x i8> [[INSERT]], <2 x i8> [[X]]
; CHECK-NEXT:    ret <2 x i8> [[RETVAL]]
;
  %cmp = icmp ne <2 x i8> %y, <i8 2, i8 2>
  %insert = insertelement <2 x i8> %y, i8 0, i8 %i
  %retval = select <2 x i1> %cmp, <2 x i8> %x, <2 x i8> %insert
  ret <2 x i8> %retval
}

define <2 x i8> @select_icmp_shufflevector_identity(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: define <2 x i8> @select_icmp_shufflevector_identity(
; CHECK-SAME: <2 x i8> [[X:%.*]], <2 x i8> [[Y:%.*]]) {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i8> [[Y]], splat (i8 2)
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[CMP]], <2 x i8> splat (i8 2), <2 x i8> [[X]]
; CHECK-NEXT:    ret <2 x i8> [[RETVAL]]
;
  %cmp = icmp eq <2 x i8> %y, <i8 2, i8 2>
  %shuffle = shufflevector <2 x i8> %y, <2 x i8> poison, <2 x i32> <i32 0, i32 1>
  %retval = select <2 x i1> %cmp, <2 x i8> %shuffle, <2 x i8> %x
  ret <2 x i8> %retval
}

define <4 x i8> @select_icmp_shufflevector_select(<4 x i8> %x, <4 x i8> %y, <4 x i8> %z) {
; CHECK-LABEL: define <4 x i8> @select_icmp_shufflevector_select(
; CHECK-SAME: <4 x i8> [[X:%.*]], <4 x i8> [[Y:%.*]], <4 x i8> [[Z:%.*]]) {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <4 x i8> [[Y]], splat (i8 2)
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i8> [[Z]], <4 x i8> <i8 poison, i8 2, i8 poison, i8 2>, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
; CHECK-NEXT:    [[RETVAL:%.*]] = select <4 x i1> [[CMP]], <4 x i8> [[SHUFFLE]], <4 x i8> [[X]]
; CHECK-NEXT:    ret <4 x i8> [[RETVAL]]
;
  %cmp = icmp eq <4 x i8> %y, <i8 2, i8 2, i8 2, i8 2>
  %shuffle = shufflevector <4 x i8> %y, <4 x i8> %z, <4 x i32> <i32 4, i32 1, i32 6, i32 3>
  %retval = select <4 x i1> %cmp, <4 x i8> %shuffle, <4 x i8> %x
  ret <4 x i8> %retval
}

define <2 x i8> @select_icmp_shufflevector_lanecrossing(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: define <2 x i8> @select_icmp_shufflevector_lanecrossing(
; CHECK-SAME: <2 x i8> [[X:%.*]], <2 x i8> [[Y:%.*]]) {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i8> [[Y]], splat (i8 2)
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x i8> [[Y]], <2 x i8> poison, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[CMP]], <2 x i8> [[SHUFFLE]], <2 x i8> [[X]]
; CHECK-NEXT:    ret <2 x i8> [[RETVAL]]
;
  %cmp = icmp eq <2 x i8> %y, <i8 2, i8 2>
  %shuffle = shufflevector <2 x i8> %y, <2 x i8> poison, <2 x i32> <i32 1, i32 0>
  %retval = select <2 x i1> %cmp, <2 x i8> %shuffle, <2 x i8> %x
  ret <2 x i8> %retval
}

declare <2 x i8> @fn(<2 x i8>) speculatable

define <2 x i8> @select_icmp_call_possibly_lanecrossing(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: define <2 x i8> @select_icmp_call_possibly_lanecrossing(
; CHECK-SAME: <2 x i8> [[X:%.*]], <2 x i8> [[Y:%.*]]) {
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq <2 x i8> [[Y]], splat (i8 2)
; CHECK-NEXT:    [[CALL:%.*]] = call <2 x i8> @fn(<2 x i8> [[Y]])
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[CMP]], <2 x i8> [[CALL]], <2 x i8> [[X]]
; CHECK-NEXT:    ret <2 x i8> [[RETVAL]]
;
  %cmp = icmp eq <2 x i8> %y, <i8 2, i8 2>
  %call = call <2 x i8> @fn(<2 x i8> %y)
  %retval = select <2 x i1> %cmp, <2 x i8> %call, <2 x i8> %x
  ret <2 x i8> %retval
}

define float @select_fcmp_fadd_oeq_not_zero(float %x, float %y) {
; CHECK-LABEL: define float @select_fcmp_fadd_oeq_not_zero(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp oeq float [[Y]], 2.000000e+00
; CHECK-NEXT:    [[FADD:%.*]] = fadd float [[X]], 2.000000e+00
; CHECK-NEXT:    [[RETVAL:%.*]] = select i1 [[FCMP]], float [[FADD]], float [[X]]
; CHECK-NEXT:    ret float [[RETVAL]]
;
  %fcmp = fcmp oeq float %y, 2.0
  %fadd = fadd float %x, %y
  %retval = select i1 %fcmp, float %fadd, float %x
  ret float %retval
}

define float @select_fcmp_fadd_une_not_zero(float %x, float %y) {
; CHECK-LABEL: define float @select_fcmp_fadd_une_not_zero(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp une float [[Y]], 2.000000e+00
; CHECK-NEXT:    [[FADD:%.*]] = fadd float [[X]], 2.000000e+00
; CHECK-NEXT:    [[RETVAL:%.*]] = select i1 [[FCMP]], float [[X]], float [[FADD]]
; CHECK-NEXT:    ret float [[RETVAL]]
;
  %fcmp = fcmp une float %y, 2.0
  %fadd = fadd float %x, %y
  %retval = select i1 %fcmp, float %x, float %fadd
  ret float %retval
}

define float @select_fcmp_fadd_ueq_nnan_not_zero(float %x, float %y) {
; CHECK-LABEL: define float @select_fcmp_fadd_ueq_nnan_not_zero(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp nnan ueq float [[Y]], 2.000000e+00
; CHECK-NEXT:    [[FADD:%.*]] = fadd float [[X]], 2.000000e+00
; CHECK-NEXT:    [[RETVAL:%.*]] = select i1 [[FCMP]], float [[FADD]], float [[X]]
; CHECK-NEXT:    ret float [[RETVAL]]
;
  %fcmp = fcmp nnan ueq float %y, 2.0
  %fadd = fadd float %x, %y
  %retval = select i1 %fcmp, float %fadd, float %x
  ret float %retval
}

define float @select_fcmp_fadd_one_nnan_not_zero(float %x, float %y) {
; CHECK-LABEL: define float @select_fcmp_fadd_one_nnan_not_zero(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp nnan one float [[Y]], 2.000000e+00
; CHECK-NEXT:    [[FADD:%.*]] = fadd float [[X]], 2.000000e+00
; CHECK-NEXT:    [[RETVAL:%.*]] = select i1 [[FCMP]], float [[X]], float [[FADD]]
; CHECK-NEXT:    ret float [[RETVAL]]
;
  %fcmp = fcmp nnan one float %y, 2.0
  %fadd = fadd float %x, %y
  %retval = select i1 %fcmp, float %x, float %fadd
  ret float %retval
}

define float @select_fcmp_fadd_ueq(float %x, float %y) {
; CHECK-LABEL: define float @select_fcmp_fadd_ueq(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp ueq float [[Y]], 2.000000e+00
; CHECK-NEXT:    [[FADD:%.*]] = fadd float [[X]], [[Y]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select i1 [[FCMP]], float [[FADD]], float [[X]]
; CHECK-NEXT:    ret float [[RETVAL]]
;
  %fcmp = fcmp ueq float %y, 2.0
  %fadd = fadd float %x, %y
  %retval = select i1 %fcmp, float %fadd, float %x
  ret float %retval
}

define float @select_fcmp_fadd_one(float %x, float %y) {
; CHECK-LABEL: define float @select_fcmp_fadd_one(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp one float [[Y]], 2.000000e+00
; CHECK-NEXT:    [[FADD:%.*]] = fadd float [[X]], [[Y]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select i1 [[FCMP]], float [[X]], float [[FADD]]
; CHECK-NEXT:    ret float [[RETVAL]]
;
  %fcmp = fcmp one float %y, 2.0
  %fadd = fadd float %x, %y
  %retval = select i1 %fcmp, float %x, float %fadd
  ret float %retval
}

define float @select_fcmp_fadd_oeq_zero(float %x, float %y) {
; CHECK-LABEL: define float @select_fcmp_fadd_oeq_zero(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp oeq float [[Y]], 0.000000e+00
; CHECK-NEXT:    [[FADD:%.*]] = fadd float [[X]], [[Y]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select i1 [[FCMP]], float [[FADD]], float [[X]]
; CHECK-NEXT:    ret float [[RETVAL]]
;
  %fcmp = fcmp oeq float %y, 0.0
  %fadd = fadd float %x, %y
  %retval = select i1 %fcmp, float %fadd, float %x
  ret float %retval
}

define float @select_fcmp_fadd_une_zero(float %x, float %y) {
; CHECK-LABEL: define float @select_fcmp_fadd_une_zero(
; CHECK-SAME: float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp une float [[Y]], 0.000000e+00
; CHECK-NEXT:    [[FADD:%.*]] = fadd float [[X]], [[Y]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select i1 [[FCMP]], float [[X]], float [[FADD]]
; CHECK-NEXT:    ret float [[RETVAL]]
;
  %fcmp = fcmp une float %y, 0.0
  %fadd = fadd float %x, %y
  %retval = select i1 %fcmp, float %x, float %fadd
  ret float %retval
}

define <2 x float> @select_fcmp_fadd_oeq_not_zero_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @select_fcmp_fadd_oeq_not_zero_vec(
; CHECK-SAME: <2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp oeq <2 x float> [[Y]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[FADD:%.*]] = fadd <2 x float> [[X]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[FCMP]], <2 x float> [[FADD]], <2 x float> [[X]]
; CHECK-NEXT:    ret <2 x float> [[RETVAL]]
;
  %fcmp = fcmp oeq <2 x float> %y, <float 2.0, float 2.0>
  %fadd = fadd <2 x float> %x, %y
  %retval = select <2 x i1> %fcmp, <2 x float> %fadd, <2 x float> %x
  ret <2 x float> %retval
}

define <2 x float> @select_fcmp_fadd_une_not_zero_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @select_fcmp_fadd_une_not_zero_vec(
; CHECK-SAME: <2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp une <2 x float> [[Y]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[FADD:%.*]] = fadd <2 x float> [[X]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[FCMP]], <2 x float> [[X]], <2 x float> [[FADD]]
; CHECK-NEXT:    ret <2 x float> [[RETVAL]]
;
  %fcmp = fcmp une <2 x float> %y, <float 2.0, float 2.0>
  %fadd = fadd <2 x float> %x, %y
  %retval = select <2 x i1> %fcmp, <2 x float> %x, <2 x float> %fadd
  ret <2 x float> %retval
}

define <2 x float> @select_fcmp_fadd_ueq_nnan_not_zero_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @select_fcmp_fadd_ueq_nnan_not_zero_vec(
; CHECK-SAME: <2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp nnan ueq <2 x float> [[Y]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[FADD:%.*]] = fadd <2 x float> [[X]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[FCMP]], <2 x float> [[FADD]], <2 x float> [[X]]
; CHECK-NEXT:    ret <2 x float> [[RETVAL]]
;
  %fcmp = fcmp nnan ueq <2 x float> %y, <float 2.0, float 2.0>
  %fadd = fadd <2 x float> %x, %y
  %retval = select <2 x i1> %fcmp, <2 x float> %fadd, <2 x float> %x
  ret <2 x float> %retval
}

define <2 x float> @select_fcmp_fadd_one_nnan_not_zero_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @select_fcmp_fadd_one_nnan_not_zero_vec(
; CHECK-SAME: <2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp nnan one <2 x float> [[Y]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[FADD:%.*]] = fadd <2 x float> [[X]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[FCMP]], <2 x float> [[X]], <2 x float> [[FADD]]
; CHECK-NEXT:    ret <2 x float> [[RETVAL]]
;
  %fcmp = fcmp nnan one <2 x float> %y, <float 2.0, float 2.0>
  %fadd = fadd <2 x float> %x, %y
  %retval = select <2 x i1> %fcmp, <2 x float> %x, <2 x float> %fadd
  ret <2 x float> %retval
}

define <2 x float> @select_fcmp_fadd_ueq_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @select_fcmp_fadd_ueq_vec(
; CHECK-SAME: <2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp ueq <2 x float> [[Y]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[FADD:%.*]] = fadd <2 x float> [[X]], [[Y]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[FCMP]], <2 x float> [[FADD]], <2 x float> [[X]]
; CHECK-NEXT:    ret <2 x float> [[RETVAL]]
;
  %fcmp = fcmp ueq <2 x float> %y, <float 2.0, float 2.0>
  %fadd = fadd <2 x float> %x, %y
  %retval = select <2 x i1> %fcmp, <2 x float> %fadd, <2 x float> %x
  ret <2 x float> %retval
}

define <2 x float> @select_fcmp_fadd_one_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @select_fcmp_fadd_one_vec(
; CHECK-SAME: <2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp one <2 x float> [[Y]], splat (float 2.000000e+00)
; CHECK-NEXT:    [[FADD:%.*]] = fadd <2 x float> [[X]], [[Y]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[FCMP]], <2 x float> [[X]], <2 x float> [[FADD]]
; CHECK-NEXT:    ret <2 x float> [[RETVAL]]
;
  %fcmp = fcmp one <2 x float> %y, <float 2.0, float 2.0>
  %fadd = fadd <2 x float> %x, %y
  %retval = select <2 x i1> %fcmp, <2 x float> %x, <2 x float> %fadd
  ret <2 x float> %retval
}

define <2 x float> @select_fcmp_fadd_oeq_zero_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @select_fcmp_fadd_oeq_zero_vec(
; CHECK-SAME: <2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp oeq <2 x float> [[Y]], zeroinitializer
; CHECK-NEXT:    [[FADD:%.*]] = fadd <2 x float> [[X]], [[Y]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[FCMP]], <2 x float> [[FADD]], <2 x float> [[X]]
; CHECK-NEXT:    ret <2 x float> [[RETVAL]]
;
  %fcmp = fcmp oeq <2 x float> %y, zeroinitializer
  %fadd = fadd <2 x float> %x, %y
  %retval = select <2 x i1> %fcmp, <2 x float> %fadd, <2 x float> %x
  ret <2 x float> %retval
}

define <2 x float> @select_fcmp_fadd_une_zero_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @select_fcmp_fadd_une_zero_vec(
; CHECK-SAME: <2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FCMP:%.*]] = fcmp une <2 x float> [[Y]], zeroinitializer
; CHECK-NEXT:    [[FADD:%.*]] = fadd <2 x float> [[X]], [[Y]]
; CHECK-NEXT:    [[RETVAL:%.*]] = select <2 x i1> [[FCMP]], <2 x float> [[X]], <2 x float> [[FADD]]
; CHECK-NEXT:    ret <2 x float> [[RETVAL]]
;
  %fcmp = fcmp une <2 x float> %y, zeroinitializer
  %fadd = fadd <2 x float> %x, %y
  %retval = select <2 x i1> %fcmp, <2 x float> %x, <2 x float> %fadd
  ret <2 x float> %retval
}

define <2 x i8> @select_vec_op_const_no_undef(<2 x i8> %x) {
; CHECK-LABEL: define <2 x i8> @select_vec_op_const_no_undef(
; CHECK-SAME: <2 x i8> [[X:%.*]]) {
; CHECK-NEXT:    [[XZ:%.*]] = icmp eq <2 x i8> [[X]], <i8 1, i8 2>
; CHECK-NEXT:    [[XR:%.*]] = select <2 x i1> [[XZ]], <2 x i8> <i8 1, i8 2>, <2 x i8> <i8 4, i8 3>
; CHECK-NEXT:    ret <2 x i8> [[XR]]
;
  %xz = icmp eq <2 x i8> %x, <i8 1, i8 2>
  %xr = select <2 x i1> %xz, <2 x i8> %x, <2 x i8> <i8 4, i8 3>
  ret <2 x i8> %xr
}

define <2 x i8> @select_vec_op_const_undef(<2 x i8> %x) {
; CHECK-LABEL: define <2 x i8> @select_vec_op_const_undef(
; CHECK-SAME: <2 x i8> [[X:%.*]]) {
; CHECK-NEXT:    [[XZ:%.*]] = icmp eq <2 x i8> [[X]], <i8 1, i8 undef>
; CHECK-NEXT:    [[XR:%.*]] = select <2 x i1> [[XZ]], <2 x i8> [[X]], <2 x i8> <i8 4, i8 3>
; CHECK-NEXT:    ret <2 x i8> [[XR]]
;
  %xz = icmp eq <2 x i8> %x, <i8 1, i8 undef>
  %xr = select <2 x i1> %xz, <2 x i8> %x, <2 x i8> <i8 4, i8 3>
  ret <2 x i8> %xr
}