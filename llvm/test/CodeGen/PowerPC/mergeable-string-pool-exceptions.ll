; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=ppc64le-unknown-linux-gnu < %s | FileCheck %s

@id = private unnamed_addr constant [4 x i8] c"@id\00", align 1
@id2 = private unnamed_addr constant [5 x i8] c"@id2\00", align 1

; Higher-aligned dummy to make sure it is first in the global merge pool.
@dummy = private unnamed_addr constant [1 x i32] [i32 42], align 4

define ptr @test1() personality ptr @__gnu_objc_personality_v0 {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    stdu 1, -32(1)
; CHECK-NEXT:    std 0, 48(1)
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    addis 3, 2, .Ldummy@toc@ha
; CHECK-NEXT:    addi 3, 3, .Ldummy@toc@l
; CHECK-NEXT:    bl foo
; CHECK-NEXT:    nop
  invoke void @foo(ptr @dummy)
          to label %cont unwind label %unwind

cont:
  unreachable

unwind:
  %lp = landingpad { ptr, i32 }
          catch ptr @id
  resume { ptr, i32 } %lp
}

define i32 @test2() personality ptr @__gnu_objc_personality_v0 {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 3, 1
; CHECK-NEXT:    blr
  %id = tail call i32 @llvm.eh.typeid.for(ptr @id2)
  ret i32 %id
}

declare i32 @__gnu_objc_personality_v0(...)

declare i32 @llvm.eh.typeid.for(ptr)

declare void @foo()