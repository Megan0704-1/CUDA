; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=xtensa < %s \
; RUN:   | FileCheck %s

declare ptr @llvm.frameaddress(i32)
declare ptr @llvm.returnaddress(i32)

define ptr @test_frameaddress_0() nounwind {
; CHECK-LABEL: test_frameaddress_0:
; CHECK:         or a2, a1, a1
; CHECK-NEXT:    ret
  %frameaddr = call ptr @llvm.frameaddress(i32 0)
  ret ptr %frameaddr
}

define ptr @test_returnaddress_0() nounwind {
; CHECK-LABEL: test_returnaddress_0:
; CHECK:         or a2, a0, a0
; CHECK-NEXT:    ret
  %retaddr = call ptr @llvm.returnaddress(i32 0)
  ret ptr %retaddr
}

define ptr @test_frameaddress_1() nounwind {
; CHECK-LABEL: test_frameaddress_1:
; CHECK:         movi a2, 0
; CHECK-NEXT:    ret
  %frameaddr = call ptr @llvm.frameaddress(i32 1)
  ret ptr %frameaddr
}

define ptr @test_returnaddress_1() nounwind {
; CHECK-LABEL: test_returnaddress_1:
; CHECK:         movi a2, 0
; CHECK-NEXT:    ret
  %retaddr = call ptr @llvm.returnaddress(i32 1)
  ret ptr %retaddr
}