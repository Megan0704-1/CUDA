; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -mtriple=riscv64 -passes="ee-instrument<post-inline>" -S < %s | FileCheck %s --check-prefixes=CHECK,RISCV64
; RUN: opt -mtriple=riscv32 -passes="ee-instrument<post-inline>" -S < %s | FileCheck %s --check-prefixes=CHECK,RISCV32
; RUN: opt -mtriple=loongarch64 -passes="ee-instrument<post-inline>" -S < %s | FileCheck %s --check-prefixes=CHECK,LOONGARCH64
; RUN: opt -mtriple=loongarch32 -passes="ee-instrument<post-inline>" -S < %s | FileCheck %s --check-prefixes=CHECK,LOONGARCH32
; RUN: opt -mtriple=aarch64 -passes="ee-instrument<post-inline>" -S < %s | FileCheck %s --check-prefixes=CHECK,AARCH64
; RUN: opt -mtriple=aarch64_be -passes="ee-instrument<post-inline>" -S < %s | FileCheck %s --check-prefixes=CHECK,AARCH64_BE
; RUN: opt -mtriple=aarch64_32 -passes="ee-instrument<post-inline>" -S < %s | FileCheck %s --check-prefixes=CHECK,AARCH64_32

define void @f1() "instrument-function-entry-inlined"="_mcount" {
; CHECK-LABEL: define void @f1() {
; CHECK-NEXT:    [[TMP1:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    call void @_mcount(ptr [[TMP1]])
; CHECK-NEXT:    ret void
;
  ret void
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; AARCH64: {{.*}}
; AARCH64_32: {{.*}}
; AARCH64_BE: {{.*}}
; LOONGARCH32: {{.*}}
; LOONGARCH64: {{.*}}
; RISCV32: {{.*}}
; RISCV64: {{.*}}