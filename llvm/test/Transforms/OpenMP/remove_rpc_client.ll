; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -passes=openmp-opt-postlink < %s | FileCheck %s --check-prefix=POSTLINK
; RUN: opt -S -passes=openmp-opt < %s | FileCheck %s --check-prefix=PRELINK

@__llvm_rpc_client = internal addrspace(1) global i32 zeroinitializer, align 8

;.
; PRELINK: @__llvm_rpc_client = internal addrspace(1) global i32 0, align 8
;.
define void @a() {
; POSTLINK-LABEL: define {{[^@]+}}@a() {
; POSTLINK-NEXT:    ret void
;
; PRELINK-LABEL: define {{[^@]+}}@a() {
; PRELINK-NEXT:    ret void
;
  ret void
}

!llvm.module.flags = !{!0, !1, !2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"openmp", i32 50}
!2 = !{i32 7, !"openmp-device", i32 50}
;.
; POSTLINK: [[META0:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
; POSTLINK: [[META1:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; POSTLINK: [[META2:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
;.
; PRELINK: [[META0:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
; PRELINK: [[META1:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; PRELINK: [[META2:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
;.