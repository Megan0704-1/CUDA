// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64 -target-feature +sme -O1 -Werror -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64 -target-feature +sme -O1 -Werror -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64 -target-feature +sme -S -disable-O0-optnone -Werror -Wall -o /dev/null %s

#include <arm_sme.h>

// CHECK-LABEL: @test_in_streaming_mode_streaming_compatible(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.aarch64.sme.in.streaming.mode()
// CHECK-NEXT:    ret i1 [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z43test_in_streaming_mode_streaming_compatiblev(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call i1 @llvm.aarch64.sme.in.streaming.mode()
// CPP-CHECK-NEXT:    ret i1 [[TMP0]]
//
bool test_in_streaming_mode_streaming_compatible(void) __arm_streaming_compatible {
  return __arm_in_streaming_mode();
}

// CHECK-LABEL: @test_in_streaming_mode_streaming(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret i1 true
//
// CPP-CHECK-LABEL: @_Z32test_in_streaming_mode_streamingv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret i1 true
//
bool test_in_streaming_mode_streaming(void) __arm_streaming {
//
  return __arm_in_streaming_mode();
}

// CHECK-LABEL: @test_in_streaming_mode_non_streaming(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret i1 false
//
// CPP-CHECK-LABEL: @_Z36test_in_streaming_mode_non_streamingv(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret i1 false
//
bool test_in_streaming_mode_non_streaming(void) {
  return __arm_in_streaming_mode();
}

// CHECK-LABEL: @test_za_disable(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    tail call void @__arm_za_disable() #[[ATTR7:[0-9]+]]
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z15test_za_disablev(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    tail call void @__arm_za_disable() #[[ATTR7:[0-9]+]]
// CPP-CHECK-NEXT:    ret void
//
void test_za_disable(void) __arm_streaming_compatible {
  __arm_za_disable();
}

// CHECK-LABEL: @test_has_sme(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call aarch64_sme_preservemost_from_x2 { i64, i64 } @__arm_sme_state() #[[ATTR7]]
// CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { i64, i64 } [[TMP0]], 0
// CHECK-NEXT:    [[TOBOOL_I:%.*]] = icmp slt i64 [[TMP1]], 0
// CHECK-NEXT:    ret i1 [[TOBOOL_I]]
//
// CPP-CHECK-LABEL: @_Z12test_has_smev(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call aarch64_sme_preservemost_from_x2 { i64, i64 } @__arm_sme_state() #[[ATTR7]]
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { i64, i64 } [[TMP0]], 0
// CPP-CHECK-NEXT:    [[TOBOOL_I:%.*]] = icmp slt i64 [[TMP1]], 0
// CPP-CHECK-NEXT:    ret i1 [[TOBOOL_I]]
//
bool test_has_sme(void) __arm_streaming_compatible {
  return __arm_has_sme();
}

// CHECK-LABEL: @test_svundef_za(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z15test_svundef_zav(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret void
//
void test_svundef_za(void) __arm_streaming_compatible __arm_out("za") {
  svundef_za();
}

// CHECK-LABEL: @test_sc_memcpy(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @__arm_sc_memcpy(ptr noundef [[DEST:%.*]], ptr noundef [[SRC:%.*]], i64 noundef [[N:%.*]]) #[[ATTR7]]
// CHECK-NEXT:    ret ptr [[CALL]]
//
// CPP-CHECK-LABEL: @_Z14test_sc_memcpyPvPKvm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @__arm_sc_memcpy(ptr noundef [[DEST:%.*]], ptr noundef [[SRC:%.*]], i64 noundef [[N:%.*]]) #[[ATTR7]]
// CPP-CHECK-NEXT:    ret ptr [[CALL]]
//
void *test_sc_memcpy(void *dest, const void *src, size_t n) __arm_streaming_compatible {
  return __arm_sc_memcpy(dest, src, n);
}

// CHECK-LABEL: @test_sc_memmove(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @__arm_sc_memmove(ptr noundef [[DEST:%.*]], ptr noundef [[SRC:%.*]], i64 noundef [[N:%.*]]) #[[ATTR7]]
// CHECK-NEXT:    ret ptr [[CALL]]
//
// CPP-CHECK-LABEL: @_Z15test_sc_memmovePvPKvm(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @__arm_sc_memmove(ptr noundef [[DEST:%.*]], ptr noundef [[SRC:%.*]], i64 noundef [[N:%.*]]) #[[ATTR7]]
// CPP-CHECK-NEXT:    ret ptr [[CALL]]
//
void *test_sc_memmove(void *dest, const void *src, size_t n) __arm_streaming_compatible {
  return __arm_sc_memmove(dest, src, n);
}

// CHECK-LABEL: @test_sc_memset(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @__arm_sc_memset(ptr noundef [[S:%.*]], i32 noundef [[C:%.*]], i64 noundef [[N:%.*]]) #[[ATTR7]]
// CHECK-NEXT:    ret ptr [[CALL]]
//
// CPP-CHECK-LABEL: @_Z14test_sc_memsetPvim(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @__arm_sc_memset(ptr noundef [[S:%.*]], i32 noundef [[C:%.*]], i64 noundef [[N:%.*]]) #[[ATTR7]]
// CPP-CHECK-NEXT:    ret ptr [[CALL]]
//
void *test_sc_memset(void *s, int c, size_t n) __arm_streaming_compatible {
  return __arm_sc_memset(s, c, n);
}

// CHECK-LABEL: @test_sc_memchr(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @__arm_sc_memchr(ptr noundef [[S:%.*]], i32 noundef [[C:%.*]], i64 noundef [[N:%.*]]) #[[ATTR7]]
// CHECK-NEXT:    ret ptr [[CALL]]
//
// CPP-CHECK-LABEL: @_Z14test_sc_memchrPvim(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[CALL:%.*]] = tail call ptr @__arm_sc_memchr(ptr noundef [[S:%.*]], i32 noundef [[C:%.*]], i64 noundef [[N:%.*]]) #[[ATTR7]]
// CPP-CHECK-NEXT:    ret ptr [[CALL]]
//
void *test_sc_memchr(void *s, int c, size_t n) __arm_streaming_compatible {
  return __arm_sc_memchr(s, c, n);
}