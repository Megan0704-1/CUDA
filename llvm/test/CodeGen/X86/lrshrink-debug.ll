; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc %s -o - | FileCheck %s
target triple = "i686-unknown-linux-gnu"

define noundef i32 @test(i1 %tobool1.not, i32 %sh.012, i1 %cmp, i64 %sh_prom, i64 %shl) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    pushl %ebx
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 20
; CHECK-NEXT:    .cfi_offset %esi, -20
; CHECK-NEXT:    .cfi_offset %edi, -16
; CHECK-NEXT:    .cfi_offset %ebx, -12
; CHECK-NEXT:    .cfi_offset %ebp, -8
; CHECK-NEXT:    xorl %esi, %esi
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movzbl {{[0-9]+}}(%esp), %edx
; CHECK-NEXT:    movb {{[0-9]+}}(%esp), %dh
; CHECK-NEXT:    xorl %edi, %edi
; CHECK-NEXT:    jmp .LBB0_1
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB0_4: # %if.end
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    orl %ecx, %ebx
; CHECK-NEXT:    orl %eax, %ebp
; CHECK-NEXT:    movl %ebx, %esi
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:  .LBB0_1: # %for.body
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    testb $1, %dh
; CHECK-NEXT:    je .LBB0_1
; CHECK-NEXT:  # %bb.2: # %if.end
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    xorl %ebx, %ebx
; CHECK-NEXT:    testb $1, %dl
; CHECK-NEXT:    movl $0, %ebp
; CHECK-NEXT:    jne .LBB0_4
; CHECK-NEXT:  # %bb.3: # %if.end
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    movl %esi, %ebx
; CHECK-NEXT:    movl %edi, %ebp
; CHECK-NEXT:    jmp .LBB0_4
entry:
  br label %for.body

for.body:                                         ; preds = %for.inc, %entry
  %bitmap.013 = phi i64 [ 0, %entry ], [ %bitmap.2, %for.inc ]
  br i1 %tobool1.not, label %if.end, label %for.inc

if.end:                                           ; preds = %for.body
  %spec.select10 = select i1 %cmp, i64 0, i64 %bitmap.013
  %shl6 = shl nuw i64 1, %sh_prom
  %or = or i64 %shl, %spec.select10
  tail call void @llvm.dbg.value(metadata i64 %or, metadata !17, metadata !DIExpression()), !dbg !21
  br label %for.inc

for.inc:                                          ; preds = %if.end, %for.body
  %bitmap.2 = phi i64 [ %bitmap.013, %for.body ], [ %or, %if.end ]
  %tobool.not = icmp eq i32 0, 0
  br label %for.body
}

declare void @llvm.dbg.value(metadata, metadata, metadata)

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!16}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, enums: !2)
!1 = !DIFile(filename: "test.c", directory: "test")
!2 = !{}
!16 = !{i32 2, !"Debug Info Version", i32 3}
!17 = !DILocalVariable(name: "bitmap", scope: !18, file: !1, line: 8, type: !20)
!18 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 6, type: !19, scopeLine: 6, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!19 = !DISubroutineType(types: !2)
!20 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!21 = !DILocation(line: 0, scope: !18)