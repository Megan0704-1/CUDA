; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm-eabi %s -o - | FileCheck %s
; RUN: llc -mtriple=armv6m-eabi %s -o - | FileCheck %s --check-prefix=EXPAND

define i64 @test_shl(i64 %val, i64 %amt) {
; CHECK-LABEL: test_shl:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    rsb r3, r2, #32
; CHECK-NEXT:    lsr r3, r0, r3
; CHECK-NEXT:    orr r1, r3, r1, lsl r2
; CHECK-NEXT:    subs r3, r2, #32
; CHECK-NEXT:    lslpl r1, r0, r3
; CHECK-NEXT:    lsl r0, r0, r2
; CHECK-NEXT:    movpl r0, #0
; CHECK-NEXT:    mov pc, lr
;
; EXPAND-LABEL: test_shl:
; EXPAND:       @ %bb.0:
; EXPAND-NEXT:    .save {r7, lr}
; EXPAND-NEXT:    push {r7, lr}
; EXPAND-NEXT:    bl __aeabi_llsl
; EXPAND-NEXT:    pop {r7, pc}
  %res = shl i64 %val, %amt
  ret i64 %res
}

; Explanation for lshr is pretty much the reverse of shl.
define i64 @test_lshr(i64 %val, i64 %amt) {
; CHECK-LABEL: test_lshr:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    rsb r3, r2, #32
; CHECK-NEXT:    lsr r0, r0, r2
; CHECK-NEXT:    orr r0, r0, r1, lsl r3
; CHECK-NEXT:    subs r3, r2, #32
; CHECK-NEXT:    lsrpl r0, r1, r3
; CHECK-NEXT:    lsr r1, r1, r2
; CHECK-NEXT:    movpl r1, #0
; CHECK-NEXT:    mov pc, lr
;
; EXPAND-LABEL: test_lshr:
; EXPAND:       @ %bb.0:
; EXPAND-NEXT:    .save {r7, lr}
; EXPAND-NEXT:    push {r7, lr}
; EXPAND-NEXT:    bl __aeabi_llsr
; EXPAND-NEXT:    pop {r7, pc}
  %res = lshr i64 %val, %amt
  ret i64 %res
}

; One minor difference for ashr: the high bits must be "hi >> 31" if the shift
; amount is large to get the right sign bit.
define i64 @test_ashr(i64 %val, i64 %amt) {
; CHECK-LABEL: test_ashr:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    rsb r3, r2, #32
; CHECK-NEXT:    lsr r0, r0, r2
; CHECK-NEXT:    orr r0, r0, r1, lsl r3
; CHECK-NEXT:    subs r3, r2, #32
; CHECK-NEXT:    asr r2, r1, r2
; CHECK-NEXT:    asrpl r2, r1, #31
; CHECK-NEXT:    asrpl r0, r1, r3
; CHECK-NEXT:    mov r1, r2
; CHECK-NEXT:    mov pc, lr
;
; EXPAND-LABEL: test_ashr:
; EXPAND:       @ %bb.0:
; EXPAND-NEXT:    .save {r7, lr}
; EXPAND-NEXT:    push {r7, lr}
; EXPAND-NEXT:    bl __aeabi_lasr
; EXPAND-NEXT:    pop {r7, pc}
  %res = ashr i64 %val, %amt
  ret i64 %res
}