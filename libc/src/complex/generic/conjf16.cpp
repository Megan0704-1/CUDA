//===-- Implementation of conjf16 function --------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/complex/conjf16.h"
#include "src/__support/common.h"
#include "src/__support/complex_type.h"

namespace LIBC_NAMESPACE_DECL {

LLVM_LIBC_FUNCTION(cfloat16, conjf16, (cfloat16 x)) {
  return conjugate<cfloat16>(x);
}

} // namespace LIBC_NAMESPACE_DECL