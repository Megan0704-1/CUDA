; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68000 | FileCheck %s --check-prefix=NO-ATOMIC
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68010 | FileCheck %s --check-prefix=NO-ATOMIC
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68020 | FileCheck %s --check-prefix=ATOMIC
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68030 | FileCheck %s --check-prefix=ATOMIC
; RUN: llc %s -o - -mtriple=m68k -mcpu=M68040 | FileCheck %s --check-prefix=ATOMIC

define void @atomic_store_i8_element_monotonic(i8 %val, ptr %base, i32 %offset) nounwind {
; NO-ATOMIC-LABEL: atomic_store_i8_element_monotonic:
; NO-ATOMIC:       ; %bb.0:
; NO-ATOMIC-NEXT:    move.b (7,%sp), %d0
; NO-ATOMIC-NEXT:    move.l (12,%sp), %d1
; NO-ATOMIC-NEXT:    move.l (8,%sp), %a0
; NO-ATOMIC-NEXT:    move.b %d0, (0,%a0,%d1)
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomic_store_i8_element_monotonic:
; ATOMIC:       ; %bb.0:
; ATOMIC-NEXT:    move.b (7,%sp), %d0
; ATOMIC-NEXT:    move.l (12,%sp), %d1
; ATOMIC-NEXT:    move.l (8,%sp), %a0
; ATOMIC-NEXT:    move.b %d0, (0,%a0,%d1)
; ATOMIC-NEXT:    rts
  %store_pointer = getelementptr i8, ptr %base, i32 %offset
  store atomic i8 %val, ptr %store_pointer monotonic, align 1
  ret void
}

define i8 @atomic_load_i8_element_monotonic(ptr %base, i32 %offset) nounwind {
; NO-ATOMIC-LABEL: atomic_load_i8_element_monotonic:
; NO-ATOMIC:       ; %bb.0:
; NO-ATOMIC-NEXT:    move.l (8,%sp), %d0
; NO-ATOMIC-NEXT:    move.l (4,%sp), %a0
; NO-ATOMIC-NEXT:    move.b (0,%a0,%d0), %d0
; NO-ATOMIC-NEXT:    rts
;
; ATOMIC-LABEL: atomic_load_i8_element_monotonic:
; ATOMIC:       ; %bb.0:
; ATOMIC-NEXT:    move.l (8,%sp), %d0
; ATOMIC-NEXT:    move.l (4,%sp), %a0
; ATOMIC-NEXT:    move.b (0,%a0,%d0), %d0
; ATOMIC-NEXT:    rts
  %load_pointer = getelementptr i8, ptr %base, i32 %offset
  %return_val = load atomic i8, ptr %load_pointer monotonic, align 1
  ret i8 %return_val
}