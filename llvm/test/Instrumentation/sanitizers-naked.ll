; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=asan -S | FileCheck %s --check-prefixes=CHECK,CHECK-ASAN
; RUN: opt < %s -passes=tsan -S | FileCheck %s --check-prefixes=CHECK,CHECK-TSAN
; RUN: opt < %s -passes=msan -S | FileCheck %s --check-prefixes=CHECK,CHECK-MSAN
; RUN: opt < %s -passes=hwasan -S | FileCheck %s --check-prefixes=CHECK,CHECK-HWASAN
; RUN: opt < %s -passes='module(sancov-module)' -sanitizer-coverage-level=3 -sanitizer-coverage-control-flow -S | FileCheck %s --check-prefixes=CHECK,CHECK-SANCOV
; RUN: opt < %s -passes='module(sanmd-module)' -sanitizer-metadata-atomics -S | FileCheck %s --check-prefixes=CHECK,CHECK-SANMD

; REQUIRES: x86-registered-target

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @naked_function(ptr byval(i32) %p) naked {
; CHECK-ASAN-LABEL: define void @naked_function(
; CHECK-ASAN-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-ASAN-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-ASAN-NEXT:    unreachable
;
; CHECK-TSAN-LABEL: define void @naked_function(
; CHECK-TSAN-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-TSAN-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-TSAN-NEXT:    unreachable
;
; CHECK-MSAN-LABEL: define void @naked_function(
; CHECK-MSAN-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-MSAN-NEXT:    call void @llvm.donothing()
; CHECK-MSAN-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-MSAN-NEXT:    unreachable
;
; CHECK-HWASAN-LABEL: define void @naked_function(
; CHECK-HWASAN-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-HWASAN-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-HWASAN-NEXT:    unreachable
;
; CHECK-SANCOV-LABEL: define void @naked_function(
; CHECK-SANCOV-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-SANCOV-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-SANCOV-NEXT:    unreachable
;
; CHECK-SANMD-LABEL: define void @naked_function(
; CHECK-SANMD-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-SANMD-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-SANMD-NEXT:    unreachable
;
  call void asm sideeffect "nop", ""()
  unreachable
}

define void @naked_function_with_asan(ptr byval(i32) %p) sanitize_address naked {
; CHECK-ASAN-LABEL: define void @naked_function_with_asan(
; CHECK-ASAN-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-ASAN-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-ASAN-NEXT:    unreachable
;
  call void asm sideeffect "nop", ""()
  unreachable
}

define void @naked_function_with_tsan(ptr byval(i32) %p) sanitize_thread naked {
; CHECK-TSAN-LABEL: define void @naked_function_with_tsan(
; CHECK-TSAN-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR2:[0-9]+]] {
; CHECK-TSAN-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-TSAN-NEXT:    unreachable
;
  call void asm sideeffect "nop", ""()
  unreachable
}

define void @naked_function_with_msan(ptr byval(i32) %p) sanitize_memory naked {
; CHECK-MSAN-LABEL: define void @naked_function_with_msan(
; CHECK-MSAN-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-MSAN-NEXT:    call void @llvm.donothing()
; CHECK-MSAN-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-MSAN-NEXT:    unreachable
;
  call void asm sideeffect "nop", ""()
  unreachable
}

define void @naked_function_with_hwasan(ptr byval(i32) %p) sanitize_hwaddress naked {
; CHECK-HWASAN-LABEL: define void @naked_function_with_hwasan(
; CHECK-HWASAN-SAME: ptr byval(i32) [[P:%.*]]) #[[ATTR4:[0-9]+]] personality ptr @__hwasan_personality_thunk {
; CHECK-HWASAN-NEXT:    call void asm sideeffect "nop", ""()
; CHECK-HWASAN-NEXT:    unreachable
;
  call void asm sideeffect "nop", ""()
  unreachable
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}