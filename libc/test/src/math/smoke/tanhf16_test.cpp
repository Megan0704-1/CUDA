//===-- Unittests for tanhf16 ---------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "hdr/fenv_macros.h"
#include "src/__support/FPUtil/cast.h"
#include "src/errno/libc_errno.h"
#include "src/math/tanhf16.h"
#include "test/UnitTest/FPMatcher.h"
#include "test/UnitTest/Test.h"

using LlvmLibcTanhf16Test = LIBC_NAMESPACE::testing::FPTest<float16>;

TEST_F(LlvmLibcTanhf16Test, SpecialNumbers) {
  LIBC_NAMESPACE::libc_errno = 0;

  EXPECT_FP_EQ_ALL_ROUNDING(aNaN, LIBC_NAMESPACE::tanhf16(aNaN));
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION(aNaN, LIBC_NAMESPACE::tanhf16(sNaN), FE_INVALID);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_ALL_ROUNDING(LIBC_NAMESPACE::fputil::cast<float16>(1.0),
                            LIBC_NAMESPACE::tanhf16(inf));
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_ALL_ROUNDING(LIBC_NAMESPACE::fputil::cast<float16>(-1.0),
                            LIBC_NAMESPACE::tanhf16(neg_inf));
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_ALL_ROUNDING(zero, LIBC_NAMESPACE::tanhf16(zero));
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_ALL_ROUNDING(neg_zero, LIBC_NAMESPACE::tanhf16(neg_zero));
  EXPECT_MATH_ERRNO(0);
}

TEST_F(LlvmLibcTanhf16Test, ResultNearBounds) {
  LIBC_NAMESPACE::libc_errno = 0;

  EXPECT_FP_EQ_WITH_EXCEPTION(LIBC_NAMESPACE::fputil::cast<float16>(1.0),
                              LIBC_NAMESPACE::tanhf16(max_normal), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION(LIBC_NAMESPACE::fputil::cast<float16>(-1.0),
                              LIBC_NAMESPACE::tanhf16(neg_max_normal),
                              FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  // round(atanh(1 - 2^-11), HP, RU);
  float16 x = LIBC_NAMESPACE::fputil::cast<float16>(0x1.0a4p+2);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_NEAREST(
      LIBC_NAMESPACE::fputil::cast<float16>(0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_UPWARD(
      LIBC_NAMESPACE::fputil::cast<float16>(1.0), LIBC_NAMESPACE::tanhf16(x),
      FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_DOWNWARD(
      LIBC_NAMESPACE::fputil::cast<float16>(0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_TOWARD_ZERO(
      LIBC_NAMESPACE::fputil::cast<float16>(0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  x = LIBC_NAMESPACE::fputil::cast<float16>(0x1.208p+2);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_NEAREST(
      LIBC_NAMESPACE::fputil::cast<float16>(1.0), LIBC_NAMESPACE::tanhf16(x),
      FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_UPWARD(
      LIBC_NAMESPACE::fputil::cast<float16>(1.0), LIBC_NAMESPACE::tanhf16(x),
      FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_DOWNWARD(
      LIBC_NAMESPACE::fputil::cast<float16>(0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_TOWARD_ZERO(
      LIBC_NAMESPACE::fputil::cast<float16>(0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  // round(atanh(-1 + 2^-11), HP, RD);
  x = LIBC_NAMESPACE::fputil::cast<float16>(-0x1.0a4p+2);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_NEAREST(
      LIBC_NAMESPACE::fputil::cast<float16>(-0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_UPWARD(
      LIBC_NAMESPACE::fputil::cast<float16>(-0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_DOWNWARD(
      LIBC_NAMESPACE::fputil::cast<float16>(-1.0), LIBC_NAMESPACE::tanhf16(x),
      FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_TOWARD_ZERO(
      LIBC_NAMESPACE::fputil::cast<float16>(-0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  x = LIBC_NAMESPACE::fputil::cast<float16>(-0x1.208p+2);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_NEAREST(
      LIBC_NAMESPACE::fputil::cast<float16>(-1.0), LIBC_NAMESPACE::tanhf16(x),
      FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_UPWARD(
      LIBC_NAMESPACE::fputil::cast<float16>(-0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_DOWNWARD(
      LIBC_NAMESPACE::fputil::cast<float16>(-1.0), LIBC_NAMESPACE::tanhf16(x),
      FE_INEXACT);
  EXPECT_MATH_ERRNO(0);

  EXPECT_FP_EQ_WITH_EXCEPTION_ROUNDING_TOWARD_ZERO(
      LIBC_NAMESPACE::fputil::cast<float16>(-0x1.ffcp-1),
      LIBC_NAMESPACE::tanhf16(x), FE_INEXACT);
  EXPECT_MATH_ERRNO(0);
}