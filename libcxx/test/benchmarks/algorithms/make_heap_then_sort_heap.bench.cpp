//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14

#include <algorithm>

#include "common.h"

namespace {
template <class ValueType, class Order>
struct MakeThenSortHeap {
  size_t Quantity;

  void run(benchmark::State& state) const {
    runOpOnCopies<ValueType>(state, Quantity, Order(), BatchSize::CountElements, [](auto& Copy) {
      std::make_heap(Copy.begin(), Copy.end());
      std::sort_heap(Copy.begin(), Copy.end());
    });
  }

  std::string name() const {
    return "BM_MakeThenSortHeap" + ValueType::name() + Order::name() + "_" + std::to_string(Quantity);
  };
};
} // namespace

int main(int argc, char** argv) {
  benchmark::Initialize(&argc, argv);
  if (benchmark::ReportUnrecognizedArguments(argc, argv))
    return 1;
  makeCartesianProductBenchmark<MakeThenSortHeap, AllValueTypes, AllOrders>(Quantities);
  benchmark::RunSpecifiedBenchmarks();
}