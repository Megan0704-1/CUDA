//===-- Collection of utils for sinf16/cosf16 -------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC_MATH_GENERIC_SINCOSF16_UTILS_H
#define LLVM_LIBC_SRC_MATH_GENERIC_SINCOSF16_UTILS_H

#include "src/__support/FPUtil/PolyEval.h"
#include "src/__support/FPUtil/nearest_integer.h"
#include "src/__support/common.h"
#include "src/__support/macros/config.h"

namespace LIBC_NAMESPACE_DECL {

// Lookup table for sin(k * pi / 32) with k = 0, ..., 63.
// Table is generated with Sollya as follows:
// > display = hexadecimmal;
// > for k from 0 to 63 do { round(sin(k * pi/32), SG, RN); };
constexpr float SIN_K_PI_OVER_32[64] = {
    0x0.0p0,        0x1.917a6cp-4,  0x1.8f8b84p-3,  0x1.294062p-2,
    0x1.87de2ap-2,  0x1.e2b5d4p-2,  0x1.1c73b4p-1,  0x1.44cf32p-1,
    0x1.6a09e6p-1,  0x1.8bc806p-1,  0x1.a9b662p-1,  0x1.c38b3p-1,
    0x1.d906bcp-1,  0x1.e9f416p-1,  0x1.f6297cp-1,  0x1.fd88dap-1,
    0x1p0,          0x1.fd88dap-1,  0x1.f6297cp-1,  0x1.e9f416p-1,
    0x1.d906bcp-1,  0x1.c38b3p-1,   0x1.a9b662p-1,  0x1.8bc806p-1,
    0x1.6a09e6p-1,  0x1.44cf32p-1,  0x1.1c73b4p-1,  0x1.e2b5d4p-2,
    0x1.87de2ap-2,  0x1.294062p-2,  0x1.8f8b84p-3,  0x1.917a6cp-4,
    0x0.0p0,        -0x1.917a6cp-4, -0x1.8f8b84p-3, -0x1.294062p-2,
    -0x1.87de2ap-2, -0x1.e2b5d4p-2, -0x1.1c73b4p-1, -0x1.44cf32p-1,
    -0x1.6a09e6p-1, -0x1.8bc806p-1, -0x1.a9b662p-1, -0x1.c38b3p-1,
    -0x1.d906bcp-1, -0x1.e9f416p-1, -0x1.f6297ep-1, -0x1.fd88dap-1,
    -0x1p0,         -0x1.fd88dap-1, -0x1.f6297cp-1, -0x1.e9f416p-1,
    -0x1.d906bcp-1, -0x1.c38b3p-1,  -0x1.a9b662p-1, -0x1.8bc806p-1,
    -0x1.6a09e6p-1, -0x1.44cf32p-1, -0x1.1c73b4p-1, -0x1.e2b5d4p-2,
    -0x1.87de2ap-2, -0x1.294062p-2, -0x1.8f8b84p-3, -0x1.917a6cp-4};

LIBC_INLINE int32_t range_reduction_sincospif16(float x, float &y) {
  float kf = fputil::nearest_integer(x * 32);
  y = fputil::multiply_add<float>(x, 32.0, -kf);

  return static_cast<int32_t>(kf);
}

// Recall, range reduction:
//   k = round(x * 32/pi)
//   y = x * 32/pi - k
//
// The constant 0x1.45f306dc9c883p3 is 32/pi rounded to double-precision.
// 32/pi is generated by Sollya with the following commands:
// > display = hexadecimal;
// > round(32/pi, D, RN);
//
// The precision choice of 'double' is to minimize rounding errors
// in this initial scaling step, preserving enough bits so errors accumulated
// while computing the subtraction: y = x * 32/pi - round(x * 32/pi)
// are beyond the least-significant bit of single-precision used during
// further intermediate computation.
LIBC_INLINE int32_t range_reduction_sincosf16(float x, float &y) {
  double prod = x * 0x1.45f306dc9c883p3;
  double kf = fputil::nearest_integer(prod);
  y = static_cast<float>(prod - kf);

  return static_cast<int32_t>(kf);
}

static LIBC_INLINE void sincosf16_poly_eval(int32_t k, float y, float &sin_k,
                                            float &cos_k, float &sin_y,
                                            float &cosm1_y) {

  sin_k = SIN_K_PI_OVER_32[k & 63];
  cos_k = SIN_K_PI_OVER_32[(k + 16) & 63];

  // Recall, after range reduction, -0.5 <= y <= 0.5. For very small values of
  // y, calculating sin(y * p/32) can be inaccurate. Generating a polynomial for
  // sin(y * p/32)/y instead significantly reduces the relative errors.
  float ysq = y * y;

  // Degree-6 minimax even polynomial for sin(y*pi/32)/y generated by Sollya
  // with:
  // > Q = fpminimax(sin(y * pi/32)/y, [|0, 2, 4, 6|], [|SG...|], [0, 0.5]);
  sin_y = y * fputil::polyeval(ysq, 0x1.921fb6p-4f, -0x1.4aeabcp-13f,
                               0x1.a03354p-21f, -0x1.ad02d2p-20f);

  // Degree-6 minimax even polynomial for cos(y*pi/32) generated by Sollya
  // with:
  // > P = fpminimax(cos(y * pi/32), [|0, 2, 4, 6|],[|1, SG...|], [0, 0.5]);
  cosm1_y = ysq * fputil::polyeval(ysq, -0x1.3bd3ccp-8f, 0x1.03a61ap-18f,
                                   0x1.a6f7a2p-29f);
}

LIBC_INLINE void sincosf16_eval(float xf, float &sin_k, float &cos_k,
                                float &sin_y, float &cosm1_y) {
  float y;
  int32_t k = range_reduction_sincosf16(xf, y);

  sincosf16_poly_eval(k, y, sin_k, cos_k, sin_y, cosm1_y);
}

LIBC_INLINE void sincospif16_eval(float xf, float &sin_k, float &cos_k,
                                  float &sin_y, float &cosm1_y) {
  float y;
  int32_t k = range_reduction_sincospif16(xf, y);

  sincosf16_poly_eval(k, y, sin_k, cos_k, sin_y, cosm1_y);
}

} // namespace LIBC_NAMESPACE_DECL

#endif // LLVM_LIBC_SRC_MATH_GENERIC_SINCOSF16_UTILS_H