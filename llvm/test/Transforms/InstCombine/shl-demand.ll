; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s


; If we only want bits that already match the signbit then we don't need to shift.
; https://alive2.llvm.org/ce/z/WJBPVt
define i32 @src_srem_shl_demand_max_signbit(i32 %a0) {
; CHECK-LABEL: @src_srem_shl_demand_max_signbit(
; CHECK-NEXT:    [[SREM:%.*]] = srem i32 [[A0:%.*]], 2
; CHECK-NEXT:    [[MASK:%.*]] = and i32 [[SREM]], -2147483648
; CHECK-NEXT:    ret i32 [[MASK]]
;
  %srem = srem i32 %a0, 2           ; srem  = SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSD
  %shl = shl i32 %srem, 30          ; shl   = SD000000000000000000000000000000
  %mask = and i32 %shl, -2147483648 ; mask  = 10000000000000000000000000000000
  ret i32 %mask
}

define i32 @src_srem_shl_demand_min_signbit(i32 %a0) {
; CHECK-LABEL: @src_srem_shl_demand_min_signbit(
; CHECK-NEXT:    [[SREM:%.*]] = srem i32 [[A0:%.*]], 1073741823
; CHECK-NEXT:    [[MASK:%.*]] = and i32 [[SREM]], -2147483648
; CHECK-NEXT:    ret i32 [[MASK]]
;
  %srem = srem i32 %a0, 1073741823  ; srem  = SSDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
  %shl = shl i32 %srem, 1           ; shl   = SDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD0
  %mask = and i32 %shl, -2147483648 ; mask  = 10000000000000000000000000000000
  ret i32 %mask
}

define i32 @src_srem_shl_demand_max_mask(i32 %a0) {
; CHECK-LABEL: @src_srem_shl_demand_max_mask(
; CHECK-NEXT:    [[SREM:%.*]] = srem i32 [[A0:%.*]], 2
; CHECK-NEXT:    [[MASK:%.*]] = and i32 [[SREM]], -4
; CHECK-NEXT:    ret i32 [[MASK]]
;
  %srem = srem i32 %a0, 2           ; srem = SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSD
  %shl = shl i32 %srem, 1           ; shl  = SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSD0
  %mask = and i32 %shl, -4          ; mask = 11111111111111111111111111111100
  ret i32 %mask
}

; Negative test - mask demands non-signbit from shift source
define i32 @src_srem_shl_demand_max_signbit_mask_hit_first_demand(i32 %a0) {
; CHECK-LABEL: @src_srem_shl_demand_max_signbit_mask_hit_first_demand(
; CHECK-NEXT:    [[SREM:%.*]] = srem i32 [[A0:%.*]], 4
; CHECK-NEXT:    [[SHL:%.*]] = shl nsw i32 [[SREM]], 29
; CHECK-NEXT:    [[MASK:%.*]] = and i32 [[SHL]], -1073741824
; CHECK-NEXT:    ret i32 [[MASK]]
;
  %srem = srem i32 %a0, 4           ; srem  = SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSDD
  %shl = shl i32 %srem, 29          ; shl   = SDD00000000000000000000000000000
  %mask = and i32 %shl, -1073741824 ; mask  = 11000000000000000000000000000000
  ret i32 %mask
}

define i32 @src_srem_shl_demand_min_signbit_mask_hit_last_demand(i32 %a0) {
; CHECK-LABEL: @src_srem_shl_demand_min_signbit_mask_hit_last_demand(
; CHECK-NEXT:    [[SREM:%.*]] = srem i32 [[A0:%.*]], 536870912
; CHECK-NEXT:    [[SHL:%.*]] = shl nsw i32 [[SREM]], 1
; CHECK-NEXT:    [[MASK:%.*]] = and i32 [[SHL]], -1073741822
; CHECK-NEXT:    ret i32 [[MASK]]
;
  %srem = srem i32 %a0, 536870912   ; srem  = SSSDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
  %shl = shl i32 %srem, 1           ; shl   = SSDDDDDDDDDDDDDDDDDDDDDDDDDDDDD0
  %mask = and i32 %shl, -1073741822 ; mask  = 11000000000000000000000000000010
  ret i32 %mask
}

define i32 @src_srem_shl_demand_eliminate_signbit(i32 %a0) {
; CHECK-LABEL: @src_srem_shl_demand_eliminate_signbit(
; CHECK-NEXT:    [[SREM:%.*]] = srem i32 [[A0:%.*]], 1073741824
; CHECK-NEXT:    [[SHL:%.*]] = shl nsw i32 [[SREM]], 1
; CHECK-NEXT:    [[MASK:%.*]] = and i32 [[SHL]], 2
; CHECK-NEXT:    ret i32 [[MASK]]
;
  %srem = srem i32 %a0, 1073741824  ; srem  = SSDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
  %shl = shl i32 %srem, 1           ; shl   = DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD0
  %mask = and i32 %shl, 2           ; mask  = 00000000000000000000000000000010
  ret i32 %mask
}

define i32 @src_srem_shl_demand_max_mask_hit_demand(i32 %a0) {
; CHECK-LABEL: @src_srem_shl_demand_max_mask_hit_demand(
; CHECK-NEXT:    [[SREM:%.*]] = srem i32 [[A0:%.*]], 4
; CHECK-NEXT:    [[SHL:%.*]] = shl nsw i32 [[SREM]], 1
; CHECK-NEXT:    [[MASK:%.*]] = and i32 [[SHL]], -4
; CHECK-NEXT:    ret i32 [[MASK]]
;
  %srem = srem i32 %a0, 4           ; srem = SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSDD
  %shl= shl i32 %srem, 1            ; shl  = SSSSSSSSSSSSSSSSSSSSSSSSSSSSSDD0
  %mask = and i32 %shl, -4          ; mask = 11111111111111111111111111111100
  ret i32 %mask
}

define <2 x i32> @src_srem_shl_mask_vector(<2 x i32> %a0) {
; CHECK-LABEL: @src_srem_shl_mask_vector(
; CHECK-NEXT:    [[SREM:%.*]] = srem <2 x i32> [[A0:%.*]], splat (i32 4)
; CHECK-NEXT:    [[SHL:%.*]] = shl nsw <2 x i32> [[SREM]], splat (i32 29)
; CHECK-NEXT:    [[MASK:%.*]] = and <2 x i32> [[SHL]], splat (i32 -1073741824)
; CHECK-NEXT:    ret <2 x i32> [[MASK]]
;
  %srem = srem <2 x i32> %a0, <i32 4, i32 4>
  %shl = shl <2 x i32> %srem, <i32 29, i32 29>
  %mask = and <2 x i32> %shl, <i32 -1073741824, i32 -1073741824>
  ret <2 x i32> %mask
}

define <2 x i32> @src_srem_shl_mask_vector_nonconstant(<2 x i32> %a0, <2 x i32> %a1) {
; CHECK-LABEL: @src_srem_shl_mask_vector_nonconstant(
; CHECK-NEXT:    [[SREM:%.*]] = srem <2 x i32> [[A0:%.*]], splat (i32 4)
; CHECK-NEXT:    [[SHL:%.*]] = shl <2 x i32> [[SREM]], [[A1:%.*]]
; CHECK-NEXT:    [[MASK:%.*]] = and <2 x i32> [[SHL]], splat (i32 -1073741824)
; CHECK-NEXT:    ret <2 x i32> [[MASK]]
;
  %srem = srem <2 x i32> %a0, <i32 4, i32 4>
  %shl = shl <2 x i32> %srem, %a1
  %mask = and <2 x i32> %shl, <i32 -1073741824, i32 -1073741824>
  ret <2 x i32> %mask
}

define i16 @sext_shl_trunc_same_size(i16 %x, i32 %y) {
; CHECK-LABEL: @sext_shl_trunc_same_size(
; CHECK-NEXT:    [[CONV1:%.*]] = zext i16 [[X:%.*]] to i32
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[CONV1]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = trunc i32 [[SHL]] to i16
; CHECK-NEXT:    ret i16 [[T]]
;
  %conv = sext i16 %x to i32
  %shl = shl i32 %conv, %y
  %t = trunc i32 %shl to i16
  ret i16 %t
}

define i5 @sext_shl_trunc_smaller(i16 %x, i32 %y) {
; CHECK-LABEL: @sext_shl_trunc_smaller(
; CHECK-NEXT:    [[CONV1:%.*]] = zext i16 [[X:%.*]] to i32
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[CONV1]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = trunc i32 [[SHL]] to i5
; CHECK-NEXT:    ret i5 [[T]]
;
  %conv = sext i16 %x to i32
  %shl = shl i32 %conv, %y
  %t = trunc i32 %shl to i5
  ret i5 %t
}

; negative test - demanding 1 high-bit too many to change the extend

define i17 @sext_shl_trunc_larger(i16 %x, i32 %y) {
; CHECK-LABEL: @sext_shl_trunc_larger(
; CHECK-NEXT:    [[CONV:%.*]] = sext i16 [[X:%.*]] to i32
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[CONV]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = trunc i32 [[SHL]] to i17
; CHECK-NEXT:    ret i17 [[T]]
;
  %conv = sext i16 %x to i32
  %shl = shl i32 %conv, %y
  %t = trunc i32 %shl to i17
  ret i17 %t
}

define i32 @sext_shl_mask(i16 %x, i32 %y) {
; CHECK-LABEL: @sext_shl_mask(
; CHECK-NEXT:    [[CONV1:%.*]] = zext i16 [[X:%.*]] to i32
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[CONV1]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = and i32 [[SHL]], 65535
; CHECK-NEXT:    ret i32 [[T]]
;
  %conv = sext i16 %x to i32
  %shl = shl i32 %conv, %y
  %t = and i32 %shl, 65535
  ret i32 %t
}

; negative test - demanding a bit that could change with sext

define i32 @sext_shl_mask_higher(i16 %x, i32 %y) {
; CHECK-LABEL: @sext_shl_mask_higher(
; CHECK-NEXT:    [[CONV:%.*]] = sext i16 [[X:%.*]] to i32
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[CONV]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = and i32 [[SHL]], 65536
; CHECK-NEXT:    ret i32 [[T]]
;
  %conv = sext i16 %x to i32
  %shl = shl i32 %conv, %y
  %t = and i32 %shl, 65536
  ret i32 %t
}

; May need some, but not all of the bits set by the 'or'.

define i32 @set_shl_mask(i32 %x, i32 %y) {
; CHECK-LABEL: @set_shl_mask(
; CHECK-NEXT:    [[Z:%.*]] = or i32 [[X:%.*]], 65537
; CHECK-NEXT:    [[S:%.*]] = shl i32 [[Z]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = and i32 [[S]], 65536
; CHECK-NEXT:    ret i32 [[R]]
;
  %z = or i32 %x, 196609
  %s = shl i32 %z, %y
  %r = and i32 %s, 65536
  ret i32 %r
}

; PR50341

define i8 @must_drop_poison(i32 %x, i32 %y)  {
; CHECK-LABEL: @must_drop_poison(
; CHECK-NEXT:    [[S:%.*]] = shl i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[T:%.*]] = trunc i32 [[S]] to i8
; CHECK-NEXT:    ret i8 [[T]]
;
  %a = and i32 %x, 255
  %s = shl nuw nsw i32 %a, %y
  %t = trunc i32 %s to i8
  ret i8 %t
}

; This would infinite loop with D110170 / bb9333c3504a

define i32 @f_t15_t01_t09(i40 %t2) {
; CHECK-LABEL: @f_t15_t01_t09(
; CHECK-NEXT:    [[SH_DIFF:%.*]] = ashr i40 [[T2:%.*]], 15
; CHECK-NEXT:    [[TR_SH_DIFF:%.*]] = trunc nsw i40 [[SH_DIFF]] to i32
; CHECK-NEXT:    [[SHL1:%.*]] = and i32 [[TR_SH_DIFF]], -65536
; CHECK-NEXT:    ret i32 [[SHL1]]
;
  %downscale = ashr i40 %t2, 31
  %resize = trunc i40 %downscale to i32
  %shl1 = shl i32 %resize, 16
  %resize1 = ashr i32 %shl1, 16
  %r = shl i32 %resize1, 31
  ret i32 %shl1
}