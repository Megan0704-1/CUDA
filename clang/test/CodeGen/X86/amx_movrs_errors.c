// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 4
// RUN: %clang_cc1 %s -ffreestanding -triple=x86_64-unknown-unknown \
// RUN: -target-feature +amx-movrs -verify

#include <immintrin.h>
#include <stddef.h>

char buf[1024];

void test_tile_load() {
  _tile_loaddrs(20, buf, 32); // expected-error {{argument value 20 is outside the valid range [0, 7]}}
  _tile_stream_loaddrs(-1, buf, 20); // expected-error {{argument value 255 is outside the valid range [0, 7]}}
}