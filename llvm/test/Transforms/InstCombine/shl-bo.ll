; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @use(i8)

define i8 @lshr_add(i8 %a, i8 %y) {
; CHECK-LABEL: @lshr_add(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 5
; CHECK-NEXT:    [[R2:%.*]] = add i8 [[Y:%.*]], [[B1]]
; CHECK-NEXT:    [[L:%.*]] = and i8 [[R2]], -32
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 5
  %b = add i8 %r, %x
  %l = shl i8 %b, 5
  ret i8 %l
}

define <2 x i8> @lshr_add_commute_splat(<2 x i8> %a, <2 x i8> %y) {
; CHECK-LABEL: @lshr_add_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 5)
; CHECK-NEXT:    [[R2:%.*]] = add <2 x i8> [[Y:%.*]], [[B1]]
; CHECK-NEXT:    [[L:%.*]] = and <2 x i8> [[R2]], splat (i8 -32)
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 5, i8 5>
  %b = add <2 x i8> %x, %r
  %l = shl <2 x i8> %b, <i8 5, i8 5>
  ret <2 x i8> %l
}

define i8 @lshr_sub(i8 %a, i8 %y) {
; CHECK-LABEL: @lshr_sub(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 3
; CHECK-NEXT:    [[B:%.*]] = sub nsw i8 [[X]], [[R]]
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 3
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 3
  %b = sub i8 %x, %r
  %l = shl i8 %b, 3
  ret i8 %l
}

define <2 x i8> @lshr_sub_commute_splat(<2 x i8> %a, <2 x i8> %y) {
; CHECK-LABEL: @lshr_sub_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 3)
; CHECK-NEXT:    [[R2:%.*]] = sub <2 x i8> [[Y:%.*]], [[B1]]
; CHECK-NEXT:    [[L:%.*]] = and <2 x i8> [[R2]], splat (i8 -8)
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 3, i8 3>
  %b = sub <2 x i8> %r, %x
  %l = shl <2 x i8> %b, <i8 3, i8 3>
  ret <2 x i8> %l
}

define i8 @lshr_and(i8 %a, i8 %y) {
; CHECK-LABEL: @lshr_and(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 6
; CHECK-NEXT:    [[R2:%.*]] = and i8 [[Y:%.*]], [[B1]]
; CHECK-NEXT:    ret i8 [[R2]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 6
  %b = and i8 %r, %x
  %l = shl i8 %b, 6
  ret i8 %l
}

define <2 x i8> @lshr_and_commute_splat(<2 x i8> %a, <2 x i8> %y) {
; CHECK-LABEL: @lshr_and_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 6)
; CHECK-NEXT:    [[R2:%.*]] = and <2 x i8> [[Y:%.*]], [[B1]]
; CHECK-NEXT:    ret <2 x i8> [[R2]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 6, i8 6>
  %b = and <2 x i8> %x, %r
  %l = shl <2 x i8> %b, <i8 6, i8 6>
  ret <2 x i8> %l
}

define i8 @lshr_or(i8 %a, i8 %y) {
; CHECK-LABEL: @lshr_or(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 4
; CHECK-NEXT:    [[Y_MASKED:%.*]] = and i8 [[Y:%.*]], -16
; CHECK-NEXT:    [[L:%.*]] = or i8 [[Y_MASKED]], [[B1]]
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 4
  %b = or i8 %x, %r
  %l = shl i8 %b, 4
  ret i8 %l
}

define <2 x i8> @lshr_or_commute_splat(<2 x i8> %a, <2 x i8> %y) {
; CHECK-LABEL: @lshr_or_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 4)
; CHECK-NEXT:    [[Y_MASKED:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 -16)
; CHECK-NEXT:    [[L:%.*]] = or <2 x i8> [[Y_MASKED]], [[B1]]
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 4, i8 4>
  %b = or <2 x i8> %r, %x
  %l = shl <2 x i8> %b, <i8 4, i8 4>
  ret <2 x i8> %l
}

define i8 @lshr_xor(i8 %a, i8 %y) {
; CHECK-LABEL: @lshr_xor(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 3
; CHECK-NEXT:    [[Y_MASKED:%.*]] = and i8 [[Y:%.*]], -8
; CHECK-NEXT:    [[L:%.*]] = xor i8 [[Y_MASKED]], [[B1]]
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 3
  %b = xor i8 %r, %x
  %l = shl i8 %b, 3
  ret i8 %l
}

define <2 x i8> @lshr_xor_commute_splat(<2 x i8> %a, <2 x i8> %y) {
; CHECK-LABEL: @lshr_xor_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 3)
; CHECK-NEXT:    [[Y_MASKED:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 -8)
; CHECK-NEXT:    [[L:%.*]] = xor <2 x i8> [[Y_MASKED]], [[B1]]
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 3, i8 3>
  %b = xor <2 x i8> %x, %r
  %l = shl <2 x i8> %b, <i8 3, i8 3>
  ret <2 x i8> %l
}

define i8 @lshr_add_use1(i8 %x, i8 %y) {
; CHECK-LABEL: @lshr_add_use1(
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 5
; CHECK-NEXT:    call void @use(i8 [[R]])
; CHECK-NEXT:    [[B:%.*]] = add i8 [[R]], [[X:%.*]]
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 5
; CHECK-NEXT:    ret i8 [[L]]
;
  %r = lshr i8 %y, 5
  call void @use(i8 %r)
  %b = add i8 %r, %x
  %l = shl i8 %b, 5
  ret i8 %l
}

define i8 @lshr_add_use2(i8 %x, i8 %y) {
; CHECK-LABEL: @lshr_add_use2(
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 5
; CHECK-NEXT:    [[B:%.*]] = add i8 [[R]], [[X:%.*]]
; CHECK-NEXT:    call void @use(i8 [[B]])
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 5
; CHECK-NEXT:    ret i8 [[L]]
;
  %r = lshr i8 %y, 5
  %b = add i8 %r, %x
  call void @use(i8 %b)
  %l = shl i8 %b, 5
  ret i8 %l
}

define i8 @lshr_and_add(i8 %a, i8 %y)  {
; CHECK-LABEL: @lshr_and_add(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 3
; CHECK-NEXT:    [[Y_MASK:%.*]] = and i8 [[Y:%.*]], 96
; CHECK-NEXT:    [[L:%.*]] = add i8 [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 3
  %m = and i8 %r, 12
  %b = add i8 %x, %m
  %l = shl i8 %b, 3
  ret i8 %l
}

define <2 x i8> @lshr_and_add_commute_splat(<2 x i8> %a, <2 x i8> %y)  {
; CHECK-LABEL: @lshr_and_add_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 3)
; CHECK-NEXT:    [[Y_MASK:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 96)
; CHECK-NEXT:    [[L:%.*]] = add <2 x i8> [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 3, i8 3>
  %m = and <2 x i8> %r, <i8 12, i8 12>
  %b = add <2 x i8> %m, %x
  %l = shl <2 x i8> %b, <i8 3, i8 3>
  ret <2 x i8> %l
}

define i8 @lshr_and_sub(i8 %a, i8 %y)  {
; CHECK-LABEL: @lshr_and_sub(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 2
; CHECK-NEXT:    [[M:%.*]] = and i8 [[R]], 13
; CHECK-NEXT:    [[B:%.*]] = sub nsw i8 [[X]], [[M]]
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 2
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 2
  %m = and i8 %r, 13
  %b = sub i8 %x, %m
  %l = shl i8 %b, 2
  ret i8 %l
}

define <2 x i8> @lshr_and_sub_commute_splat(<2 x i8> %a, <2 x i8> %y)  {
; CHECK-LABEL: @lshr_and_sub_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 2)
; CHECK-NEXT:    [[Y_MASK:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 52)
; CHECK-NEXT:    [[L:%.*]] = sub <2 x i8> [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 2, i8 2>
  %m = and <2 x i8> %r, <i8 13, i8 13>
  %b = sub <2 x i8> %m, %x
  %l = shl <2 x i8> %b, <i8 2, i8 2>
  ret <2 x i8> %l
}

define i8 @lshr_and_and(i8 %a, i8 %y)  {
; CHECK-LABEL: @lshr_and_and(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 2
; CHECK-NEXT:    [[Y_MASK:%.*]] = and i8 [[Y:%.*]], 52
; CHECK-NEXT:    [[L:%.*]] = and i8 [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 2
  %m = and i8 %r, 13
  %b = and i8 %m, %x
  %l = shl i8 %b, 2
  ret i8 %l
}

define <2 x i8> @lshr_and_and_commute_splat(<2 x i8> %a, <2 x i8> %y)  {
; CHECK-LABEL: @lshr_and_and_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 2)
; CHECK-NEXT:    [[Y_MASK:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 52)
; CHECK-NEXT:    [[L:%.*]] = and <2 x i8> [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 2, i8 2>
  %m = and <2 x i8> %r, <i8 13, i8 13>
  %b = and <2 x i8> %x, %m
  %l = shl <2 x i8> %b, <i8 2, i8 2>
  ret <2 x i8> %l
}

define i8 @lshr_and_or(i8 %a, i8 %y)  {
; CHECK-LABEL: @lshr_and_or(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 2
; CHECK-NEXT:    [[Y_MASK:%.*]] = and i8 [[Y:%.*]], 52
; CHECK-NEXT:    [[L:%.*]] = or i8 [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 2
  %m = and i8 %r, 13
  %b = or i8 %x, %m
  %l = shl i8 %b, 2
  ret i8 %l
}

define i8 @lshr_and_or_disjoint(i8 %a, i8 %y)  {
; CHECK-LABEL: @lshr_and_or_disjoint(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 2
; CHECK-NEXT:    [[Y_MASK:%.*]] = and i8 [[Y:%.*]], 52
; CHECK-NEXT:    [[L:%.*]] = or disjoint i8 [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 2
  %m = and i8 %r, 13
  %b = or disjoint i8 %x, %m
  %l = shl i8 %b, 2
  ret i8 %l
}

define i8 @ashr_and_or_disjoint(i8 %a, i8 %y)  {
; CHECK-LABEL: @ashr_and_or_disjoint(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 2
; CHECK-NEXT:    [[Y_MASK:%.*]] = and i8 [[Y:%.*]], 52
; CHECK-NEXT:    [[L:%.*]] = or disjoint i8 [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = ashr i8 %y, 2
  %m = and i8 %r, 13
  %b = or disjoint i8 %x, %m
  %l = shl i8 %b, 2
  ret i8 %l
}


define <2 x i8> @lshr_and_or_commute_splat(<2 x i8> %a, <2 x i8> %y)  {
; CHECK-LABEL: @lshr_and_or_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 2)
; CHECK-NEXT:    [[Y_MASK:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 52)
; CHECK-NEXT:    [[L:%.*]] = or <2 x i8> [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 2, i8 2>
  %m = and <2 x i8> %r, <i8 13, i8 13>
  %b = or <2 x i8> %m, %x
  %l = shl <2 x i8> %b, <i8 2, i8 2>
  ret <2 x i8> %l
}

define i8 @lshr_and_xor(i8 %a, i8 %y)  {
; CHECK-LABEL: @lshr_and_xor(
; CHECK-NEXT:    [[X:%.*]] = srem i8 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = shl i8 [[X]], 2
; CHECK-NEXT:    [[Y_MASK:%.*]] = and i8 [[Y:%.*]], 52
; CHECK-NEXT:    [[L:%.*]] = xor i8 [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret i8 [[L]]
;
  %x = srem i8 %a, 42 ; thwart complexity-based canonicalization
  %r = lshr i8 %y, 2
  %m = and i8 %r, 13
  %b = xor i8 %m, %x
  %l = shl i8 %b, 2
  ret i8 %l
}

define <2 x i8> @lshr_and_xor_commute_splat(<2 x i8> %a, <2 x i8> %y)  {
; CHECK-LABEL: @lshr_and_xor_commute_splat(
; CHECK-NEXT:    [[X:%.*]] = srem <2 x i8> [[A:%.*]], splat (i8 42)
; CHECK-NEXT:    [[B1:%.*]] = shl <2 x i8> [[X]], splat (i8 2)
; CHECK-NEXT:    [[Y_MASK:%.*]] = and <2 x i8> [[Y:%.*]], splat (i8 52)
; CHECK-NEXT:    [[L:%.*]] = xor <2 x i8> [[Y_MASK]], [[B1]]
; CHECK-NEXT:    ret <2 x i8> [[L]]
;
  %x = srem <2 x i8> %a, <i8 42, i8 42> ; thwart complexity-based canonicalization
  %r = lshr <2 x i8> %y, <i8 2, i8 2>
  %m = and <2 x i8> %r, <i8 13, i8 13>
  %b = xor <2 x i8> %x, %m
  %l = shl <2 x i8> %b, <i8 2, i8 2>
  ret <2 x i8> %l
}

define i8 @lshr_and_add_use1(i8 %x, i8 %y)  {
; CHECK-LABEL: @lshr_and_add_use1(
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @use(i8 [[R]])
; CHECK-NEXT:    [[M:%.*]] = and i8 [[R]], 12
; CHECK-NEXT:    [[B:%.*]] = add i8 [[X:%.*]], [[M]]
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 3
; CHECK-NEXT:    ret i8 [[L]]
;
  %r = lshr i8 %y, 3
  call void @use(i8 %r)
  %m = and i8 %r, 12
  %b = add i8 %x, %m
  %l = shl i8 %b, 3
  ret i8 %l
}

define i8 @lshr_and_add_use2(i8 %x, i8 %y)  {
; CHECK-LABEL: @lshr_and_add_use2(
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 3
; CHECK-NEXT:    [[M:%.*]] = and i8 [[R]], 12
; CHECK-NEXT:    call void @use(i8 [[M]])
; CHECK-NEXT:    [[B:%.*]] = add i8 [[X:%.*]], [[M]]
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 3
; CHECK-NEXT:    ret i8 [[L]]
;
  %r = lshr i8 %y, 3
  %m = and i8 %r, 12
  call void @use(i8 %m)
  %b = add i8 %x, %m
  %l = shl i8 %b, 3
  ret i8 %l
}

define i8 @lshr_and_add_use3(i8 %x, i8 %y)  {
; CHECK-LABEL: @lshr_and_add_use3(
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 3
; CHECK-NEXT:    [[M:%.*]] = and i8 [[R]], 12
; CHECK-NEXT:    [[B:%.*]] = add i8 [[X:%.*]], [[M]]
; CHECK-NEXT:    call void @use(i8 [[B]])
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 3
; CHECK-NEXT:    ret i8 [[L]]
;
  %r = lshr i8 %y, 3
  %m = and i8 %r, 12
  %b = add i8 %x, %m
  call void @use(i8 %b)
  %l = shl i8 %b, 3
  ret i8 %l
}

define i8 @lshr_and_add_use4(i8 %x, i8 %y)  {
; CHECK-LABEL: @lshr_and_add_use4(
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @use(i8 [[R]])
; CHECK-NEXT:    [[M:%.*]] = and i8 [[R]], 12
; CHECK-NEXT:    call void @use(i8 [[M]])
; CHECK-NEXT:    [[B:%.*]] = add i8 [[X:%.*]], [[M]]
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 3
; CHECK-NEXT:    ret i8 [[L]]
;
  %r = lshr i8 %y, 3
  call void @use(i8 %r)
  %m = and i8 %r, 12
  call void @use(i8 %m)
  %b = add i8 %x, %m
  %l = shl i8 %b, 3
  ret i8 %l
}

define i8 @lshr_and_add_use5(i8 %x, i8 %y)  {
; CHECK-LABEL: @lshr_and_add_use5(
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 3
; CHECK-NEXT:    [[M:%.*]] = and i8 [[R]], 12
; CHECK-NEXT:    call void @use(i8 [[M]])
; CHECK-NEXT:    [[B:%.*]] = add i8 [[X:%.*]], [[M]]
; CHECK-NEXT:    call void @use(i8 [[B]])
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 3
; CHECK-NEXT:    ret i8 [[L]]
;
  %r = lshr i8 %y, 3
  %m = and i8 %r, 12
  call void @use(i8 %m)
  %b = add i8 %x, %m
  call void @use(i8 %b)
  %l = shl i8 %b, 3
  ret i8 %l
}

define i8 @lshr_and_add_use6(i8 %x, i8 %y)  {
; CHECK-LABEL: @lshr_and_add_use6(
; CHECK-NEXT:    [[R:%.*]] = lshr i8 [[Y:%.*]], 3
; CHECK-NEXT:    call void @use(i8 [[R]])
; CHECK-NEXT:    [[M:%.*]] = and i8 [[R]], 12
; CHECK-NEXT:    call void @use(i8 [[M]])
; CHECK-NEXT:    [[B:%.*]] = add i8 [[X:%.*]], [[M]]
; CHECK-NEXT:    [[L:%.*]] = shl i8 [[B]], 3
; CHECK-NEXT:    ret i8 [[L]]
;
  %r = lshr i8 %y, 3
  call void @use(i8 %r)
  %m = and i8 %r, 12
  call void @use(i8 %m)
  %b = add i8 %x, %m
  %l = shl i8 %b, 3
  ret i8 %l
}

define <2 x i8> @lshr_add_shl_v2i8_undef(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @lshr_add_shl_v2i8_undef(
; CHECK-NEXT:    [[A:%.*]] = lshr <2 x i8> [[Y:%.*]], <i8 5, i8 undef>
; CHECK-NEXT:    [[B:%.*]] = add <2 x i8> [[A]], [[X:%.*]]
; CHECK-NEXT:    [[C:%.*]] = shl <2 x i8> [[B]], <i8 undef, i8 5>
; CHECK-NEXT:    ret <2 x i8> [[C]]
;
  %a = lshr <2 x i8> %y, <i8 5, i8 undef>
  %b = add <2 x i8> %a, %x
  %c = shl <2 x i8> %b, <i8 undef, i8 5>
  ret <2 x i8> %c
}

define <2 x i8> @lshr_add_shl_v2i8_nonuniform(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @lshr_add_shl_v2i8_nonuniform(
; CHECK-NEXT:    [[A:%.*]] = lshr <2 x i8> [[Y:%.*]], <i8 5, i8 6>
; CHECK-NEXT:    [[B:%.*]] = add <2 x i8> [[A]], [[X:%.*]]
; CHECK-NEXT:    [[C:%.*]] = shl <2 x i8> [[B]], <i8 5, i8 6>
; CHECK-NEXT:    ret <2 x i8> [[C]]
;
  %a = lshr <2 x i8> %y, <i8 5, i8 6>
  %b = add <2 x i8> %a, %x
  %c = shl <2 x i8> %b, <i8 5, i8 6>
  ret <2 x i8> %c
}

define i32 @lshr_add_and_shl(i32 %x, i32 %y)  {
; CHECK-LABEL: @lshr_add_and_shl(
; CHECK-NEXT:    [[TMP1:%.*]] = shl i32 [[Y:%.*]], 5
; CHECK-NEXT:    [[X_MASK:%.*]] = and i32 [[X:%.*]], 4064
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[X_MASK]], [[TMP1]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = lshr i32 %x, 5
  %2 = and i32 %1, 127
  %3 = add i32 %y, %2
  %4 = shl i32 %3, 5
  ret i32 %4
}

define <2 x i32> @lshr_add_and_shl_v2i32(<2 x i32> %x, <2 x i32> %y)  {
; CHECK-LABEL: @lshr_add_and_shl_v2i32(
; CHECK-NEXT:    [[TMP1:%.*]] = shl <2 x i32> [[Y:%.*]], splat (i32 5)
; CHECK-NEXT:    [[X_MASK:%.*]] = and <2 x i32> [[X:%.*]], splat (i32 4064)
; CHECK-NEXT:    [[TMP2:%.*]] = add <2 x i32> [[X_MASK]], [[TMP1]]
; CHECK-NEXT:    ret <2 x i32> [[TMP2]]
;
  %1 = lshr <2 x i32> %x, <i32 5, i32 5>
  %2 = and <2 x i32> %1, <i32 127, i32 127>
  %3 = add <2 x i32> %y, %2
  %4 = shl <2 x i32> %3, <i32 5, i32 5>
  ret <2 x i32> %4
}

define <2 x i32> @lshr_add_and_shl_v2i32_undef(<2 x i32> %x, <2 x i32> %y)  {
; CHECK-LABEL: @lshr_add_and_shl_v2i32_undef(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr <2 x i32> [[X:%.*]], <i32 undef, i32 5>
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i32> [[TMP1]], splat (i32 127)
; CHECK-NEXT:    [[TMP3:%.*]] = add <2 x i32> [[Y:%.*]], [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = shl <2 x i32> [[TMP3]], <i32 5, i32 undef>
; CHECK-NEXT:    ret <2 x i32> [[TMP4]]
;
  %1 = lshr <2 x i32> %x, <i32 undef, i32 5>
  %2 = and <2 x i32> %1, <i32 127, i32 127>
  %3 = add <2 x i32> %y, %2
  %4 = shl <2 x i32> %3, <i32 5, i32 undef>
  ret <2 x i32> %4
}

define <2 x i32> @lshr_add_and_shl_v2i32_nonuniform(<2 x i32> %x, <2 x i32> %y)  {
; CHECK-LABEL: @lshr_add_and_shl_v2i32_nonuniform(
; CHECK-NEXT:    [[TMP1:%.*]] = lshr <2 x i32> [[X:%.*]], <i32 5, i32 6>
; CHECK-NEXT:    [[TMP2:%.*]] = and <2 x i32> [[TMP1]], <i32 127, i32 255>
; CHECK-NEXT:    [[TMP3:%.*]] = add <2 x i32> [[Y:%.*]], [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = shl <2 x i32> [[TMP3]], <i32 5, i32 6>
; CHECK-NEXT:    ret <2 x i32> [[TMP4]]
;
  %1 = lshr <2 x i32> %x, <i32 5, i32 6>
  %2 = and <2 x i32> %1, <i32 127, i32 255>
  %3 = add <2 x i32> %y, %2
  %4 = shl <2 x i32> %3, <i32 5, i32 6>
  ret <2 x i32> %4
}

define i32 @shl_add_and_lshr(i32 %x, i32 %y) {
; CHECK-LABEL: @shl_add_and_lshr(
; CHECK-NEXT:    [[C1:%.*]] = shl i32 [[Y:%.*]], 4
; CHECK-NEXT:    [[X_MASK:%.*]] = and i32 [[X:%.*]], 128
; CHECK-NEXT:    [[D:%.*]] = add i32 [[X_MASK]], [[C1]]
; CHECK-NEXT:    ret i32 [[D]]
;
  %a = lshr i32 %x, 4
  %b = and i32 %a, 8
  %c = add i32 %b, %y
  %d = shl i32 %c, 4
  ret i32 %d
}

define <2 x i32> @shl_add_and_lshr_v2i32(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @shl_add_and_lshr_v2i32(
; CHECK-NEXT:    [[C1:%.*]] = shl <2 x i32> [[Y:%.*]], splat (i32 4)
; CHECK-NEXT:    [[X_MASK:%.*]] = and <2 x i32> [[X:%.*]], splat (i32 128)
; CHECK-NEXT:    [[D:%.*]] = add <2 x i32> [[X_MASK]], [[C1]]
; CHECK-NEXT:    ret <2 x i32> [[D]]
;
  %a = lshr <2 x i32> %x, <i32 4, i32 4>
  %b = and <2 x i32> %a, <i32 8, i32 8>
  %c = add <2 x i32> %b, %y
  %d = shl <2 x i32> %c, <i32 4, i32 4>
  ret <2 x i32> %d
}

define <2 x i32> @shl_add_and_lshr_v2i32_undef(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @shl_add_and_lshr_v2i32_undef(
; CHECK-NEXT:    [[A:%.*]] = lshr <2 x i32> [[X:%.*]], <i32 4, i32 undef>
; CHECK-NEXT:    [[B:%.*]] = and <2 x i32> [[A]], <i32 8, i32 undef>
; CHECK-NEXT:    [[C:%.*]] = add <2 x i32> [[B]], [[Y:%.*]]
; CHECK-NEXT:    [[D:%.*]] = shl <2 x i32> [[C]], <i32 4, i32 undef>
; CHECK-NEXT:    ret <2 x i32> [[D]]
;
  %a = lshr <2 x i32> %x, <i32 4, i32 undef>
  %b = and <2 x i32> %a, <i32 8, i32 undef>
  %c = add <2 x i32> %b, %y
  %d = shl <2 x i32> %c, <i32 4, i32 undef>
  ret <2 x i32> %d
}

define <2 x i32> @shl_add_and_lshr_v2i32_nonuniform(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @shl_add_and_lshr_v2i32_nonuniform(
; CHECK-NEXT:    [[A:%.*]] = lshr <2 x i32> [[X:%.*]], <i32 4, i32 5>
; CHECK-NEXT:    [[B:%.*]] = and <2 x i32> [[A]], <i32 8, i32 9>
; CHECK-NEXT:    [[C:%.*]] = add <2 x i32> [[B]], [[Y:%.*]]
; CHECK-NEXT:    [[D:%.*]] = shl <2 x i32> [[C]], <i32 4, i32 5>
; CHECK-NEXT:    ret <2 x i32> [[D]]
;
  %a = lshr <2 x i32> %x, <i32 4, i32 5>
  %b = and <2 x i32> %a, <i32 8, i32 9>
  %c = add <2 x i32> %b, %y
  %d = shl <2 x i32> %c, <i32 4, i32 5>
  ret <2 x i32> %d
}

define <4 x i32> @test_FoldShiftByConstant_CreateSHL(<4 x i32> %in) {
; CHECK-LABEL: @test_FoldShiftByConstant_CreateSHL(
; CHECK-NEXT:    [[VSHL_N:%.*]] = mul <4 x i32> [[IN:%.*]], <i32 0, i32 -32, i32 0, i32 -32>
; CHECK-NEXT:    ret <4 x i32> [[VSHL_N]]
;
  %mul.i = mul <4 x i32> %in, <i32 0, i32 -1, i32 0, i32 -1>
  %vshl_n = shl <4 x i32> %mul.i, <i32 5, i32 5, i32 5, i32 5>
  ret <4 x i32> %vshl_n
}

define <8 x i16> @test_FoldShiftByConstant_CreateSHL2(<8 x i16> %in) {
; CHECK-LABEL: @test_FoldShiftByConstant_CreateSHL2(
; CHECK-NEXT:    [[VSHL_N:%.*]] = mul <8 x i16> [[IN:%.*]], <i16 0, i16 -32, i16 0, i16 -32, i16 0, i16 -32, i16 0, i16 -32>
; CHECK-NEXT:    ret <8 x i16> [[VSHL_N]]
;
  %mul.i = mul <8 x i16> %in, <i16 0, i16 -1, i16 0, i16 -1, i16 0, i16 -1, i16 0, i16 -1>
  %vshl_n = shl <8 x i16> %mul.i, <i16 5, i16 5, i16 5, i16 5, i16 5, i16 5, i16 5, i16 5>
  ret <8 x i16> %vshl_n
}

define <16 x i8> @test_FoldShiftByConstant_CreateAnd(<16 x i8> %in0) {
; CHECK-LABEL: @test_FoldShiftByConstant_CreateAnd(
; CHECK-NEXT:    [[VSRA_N2:%.*]] = mul <16 x i8> [[IN0:%.*]], splat (i8 33)
; CHECK-NEXT:    [[VSHL_N:%.*]] = and <16 x i8> [[VSRA_N2]], splat (i8 -32)
; CHECK-NEXT:    ret <16 x i8> [[VSHL_N]]
;
  %vsra_n = ashr <16 x i8> %in0, <i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5>
  %tmp = add <16 x i8> %in0, %vsra_n
  %vshl_n = shl <16 x i8> %tmp, <i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5>
  ret <16 x i8> %vshl_n
}