; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=armv5-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=ARM5
; RUN: llc -mtriple=armv6-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=ARM6
; RUN: llc -mtriple=armv7-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=ARM7
; RUN: llc -mtriple=armv8-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=ARM8
; RUN: llc -mtriple=armv7-unknown-linux-gnu -mattr=+neon < %s | FileCheck %s --check-prefixes=NEON7
; RUN: llc -mtriple=armv8-unknown-linux-gnu -mattr=+neon < %s | FileCheck %s --check-prefixes=NEON8

define i1 @test_urem_odd(i13 %X) nounwind {
; ARM5-LABEL: test_urem_odd:
; ARM5:       @ %bb.0:
; ARM5-NEXT:    mov r1, #205
; ARM5-NEXT:    orr r1, r1, #3072
; ARM5-NEXT:    mul r2, r0, r1
; ARM5-NEXT:    mov r0, #255
; ARM5-NEXT:    orr r0, r0, #7936
; ARM5-NEXT:    and r1, r2, r0
; ARM5-NEXT:    mov r2, #103
; ARM5-NEXT:    orr r2, r2, #1536
; ARM5-NEXT:    mov r0, #0
; ARM5-NEXT:    cmp r1, r2
; ARM5-NEXT:    movlo r0, #1
; ARM5-NEXT:    bx lr
;
; ARM6-LABEL: test_urem_odd:
; ARM6:       @ %bb.0:
; ARM6-NEXT:    mov r1, #205
; ARM6-NEXT:    mov r2, #103
; ARM6-NEXT:    orr r1, r1, #3072
; ARM6-NEXT:    orr r2, r2, #1536
; ARM6-NEXT:    mul r0, r0, r1
; ARM6-NEXT:    mov r1, #255
; ARM6-NEXT:    orr r1, r1, #7936
; ARM6-NEXT:    and r1, r0, r1
; ARM6-NEXT:    mov r0, #0
; ARM6-NEXT:    cmp r1, r2
; ARM6-NEXT:    movlo r0, #1
; ARM6-NEXT:    bx lr
;
; ARM7-LABEL: test_urem_odd:
; ARM7:       @ %bb.0:
; ARM7-NEXT:    movw r1, #3277
; ARM7-NEXT:    movw r2, #1639
; ARM7-NEXT:    mul r1, r0, r1
; ARM7-NEXT:    mov r0, #0
; ARM7-NEXT:    bfc r1, #13, #19
; ARM7-NEXT:    cmp r1, r2
; ARM7-NEXT:    movwlo r0, #1
; ARM7-NEXT:    bx lr
;
; ARM8-LABEL: test_urem_odd:
; ARM8:       @ %bb.0:
; ARM8-NEXT:    movw r1, #3277
; ARM8-NEXT:    movw r2, #1639
; ARM8-NEXT:    mul r1, r0, r1
; ARM8-NEXT:    mov r0, #0
; ARM8-NEXT:    bfc r1, #13, #19
; ARM8-NEXT:    cmp r1, r2
; ARM8-NEXT:    movwlo r0, #1
; ARM8-NEXT:    bx lr
;
; NEON7-LABEL: test_urem_odd:
; NEON7:       @ %bb.0:
; NEON7-NEXT:    movw r1, #3277
; NEON7-NEXT:    movw r2, #1639
; NEON7-NEXT:    mul r1, r0, r1
; NEON7-NEXT:    mov r0, #0
; NEON7-NEXT:    bfc r1, #13, #19
; NEON7-NEXT:    cmp r1, r2
; NEON7-NEXT:    movwlo r0, #1
; NEON7-NEXT:    bx lr
;
; NEON8-LABEL: test_urem_odd:
; NEON8:       @ %bb.0:
; NEON8-NEXT:    movw r1, #3277
; NEON8-NEXT:    movw r2, #1639
; NEON8-NEXT:    mul r1, r0, r1
; NEON8-NEXT:    mov r0, #0
; NEON8-NEXT:    bfc r1, #13, #19
; NEON8-NEXT:    cmp r1, r2
; NEON8-NEXT:    movwlo r0, #1
; NEON8-NEXT:    bx lr
  %urem = urem i13 %X, 5
  %cmp = icmp eq i13 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_even(i27 %X) nounwind {
; ARM5-LABEL: test_urem_even:
; ARM5:       @ %bb.0:
; ARM5-NEXT:    ldr r1, .LCPI1_0
; ARM5-NEXT:    mul r2, r0, r1
; ARM5-NEXT:    bic r0, r2, #-134217727
; ARM5-NEXT:    lsr r0, r0, #1
; ARM5-NEXT:    orr r0, r0, r2, lsl #26
; ARM5-NEXT:    ldr r2, .LCPI1_1
; ARM5-NEXT:    bic r1, r0, #-134217728
; ARM5-NEXT:    mov r0, #0
; ARM5-NEXT:    cmp r1, r2
; ARM5-NEXT:    movlo r0, #1
; ARM5-NEXT:    bx lr
; ARM5-NEXT:    .p2align 2
; ARM5-NEXT:  @ %bb.1:
; ARM5-NEXT:  .LCPI1_0:
; ARM5-NEXT:    .long 115043767 @ 0x6db6db7
; ARM5-NEXT:  .LCPI1_1:
; ARM5-NEXT:    .long 9586981 @ 0x924925
;
; ARM6-LABEL: test_urem_even:
; ARM6:       @ %bb.0:
; ARM6-NEXT:    ldr r1, .LCPI1_0
; ARM6-NEXT:    ldr r2, .LCPI1_1
; ARM6-NEXT:    mul r0, r0, r1
; ARM6-NEXT:    bic r1, r0, #-134217727
; ARM6-NEXT:    lsr r1, r1, #1
; ARM6-NEXT:    orr r0, r1, r0, lsl #26
; ARM6-NEXT:    bic r1, r0, #-134217728
; ARM6-NEXT:    mov r0, #0
; ARM6-NEXT:    cmp r1, r2
; ARM6-NEXT:    movlo r0, #1
; ARM6-NEXT:    bx lr
; ARM6-NEXT:    .p2align 2
; ARM6-NEXT:  @ %bb.1:
; ARM6-NEXT:  .LCPI1_0:
; ARM6-NEXT:    .long 115043767 @ 0x6db6db7
; ARM6-NEXT:  .LCPI1_1:
; ARM6-NEXT:    .long 9586981 @ 0x924925
;
; ARM7-LABEL: test_urem_even:
; ARM7:       @ %bb.0:
; ARM7-NEXT:    movw r1, #28087
; ARM7-NEXT:    movw r2, #18725
; ARM7-NEXT:    movt r1, #1755
; ARM7-NEXT:    movt r2, #146
; ARM7-NEXT:    mul r0, r0, r1
; ARM7-NEXT:    ubfx r1, r0, #1, #26
; ARM7-NEXT:    orr r0, r1, r0, lsl #26
; ARM7-NEXT:    bic r1, r0, #-134217728
; ARM7-NEXT:    mov r0, #0
; ARM7-NEXT:    cmp r1, r2
; ARM7-NEXT:    movwlo r0, #1
; ARM7-NEXT:    bx lr
;
; ARM8-LABEL: test_urem_even:
; ARM8:       @ %bb.0:
; ARM8-NEXT:    movw r1, #28087
; ARM8-NEXT:    movw r2, #18725
; ARM8-NEXT:    movt r1, #1755
; ARM8-NEXT:    movt r2, #146
; ARM8-NEXT:    mul r0, r0, r1
; ARM8-NEXT:    ubfx r1, r0, #1, #26
; ARM8-NEXT:    orr r0, r1, r0, lsl #26
; ARM8-NEXT:    bic r1, r0, #-134217728
; ARM8-NEXT:    mov r0, #0
; ARM8-NEXT:    cmp r1, r2
; ARM8-NEXT:    movwlo r0, #1
; ARM8-NEXT:    bx lr
;
; NEON7-LABEL: test_urem_even:
; NEON7:       @ %bb.0:
; NEON7-NEXT:    movw r1, #28087
; NEON7-NEXT:    movw r2, #18725
; NEON7-NEXT:    movt r1, #1755
; NEON7-NEXT:    movt r2, #146
; NEON7-NEXT:    mul r0, r0, r1
; NEON7-NEXT:    ubfx r1, r0, #1, #26
; NEON7-NEXT:    orr r0, r1, r0, lsl #26
; NEON7-NEXT:    bic r1, r0, #-134217728
; NEON7-NEXT:    mov r0, #0
; NEON7-NEXT:    cmp r1, r2
; NEON7-NEXT:    movwlo r0, #1
; NEON7-NEXT:    bx lr
;
; NEON8-LABEL: test_urem_even:
; NEON8:       @ %bb.0:
; NEON8-NEXT:    movw r1, #28087
; NEON8-NEXT:    movw r2, #18725
; NEON8-NEXT:    movt r1, #1755
; NEON8-NEXT:    movt r2, #146
; NEON8-NEXT:    mul r0, r0, r1
; NEON8-NEXT:    ubfx r1, r0, #1, #26
; NEON8-NEXT:    orr r0, r1, r0, lsl #26
; NEON8-NEXT:    bic r1, r0, #-134217728
; NEON8-NEXT:    mov r0, #0
; NEON8-NEXT:    cmp r1, r2
; NEON8-NEXT:    movwlo r0, #1
; NEON8-NEXT:    bx lr
  %urem = urem i27 %X, 14
  %cmp = icmp eq i27 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_odd_setne(i4 %X) nounwind {
; ARM5-LABEL: test_urem_odd_setne:
; ARM5:       @ %bb.0:
; ARM5-NEXT:    mov r1, #13
; ARM5-NEXT:    mul r2, r0, r1
; ARM5-NEXT:    mov r0, #0
; ARM5-NEXT:    and r1, r2, #15
; ARM5-NEXT:    cmp r1, #3
; ARM5-NEXT:    movhi r0, #1
; ARM5-NEXT:    bx lr
;
; ARM6-LABEL: test_urem_odd_setne:
; ARM6:       @ %bb.0:
; ARM6-NEXT:    mov r1, #13
; ARM6-NEXT:    mul r0, r0, r1
; ARM6-NEXT:    and r1, r0, #15
; ARM6-NEXT:    mov r0, #0
; ARM6-NEXT:    cmp r1, #3
; ARM6-NEXT:    movhi r0, #1
; ARM6-NEXT:    bx lr
;
; ARM7-LABEL: test_urem_odd_setne:
; ARM7:       @ %bb.0:
; ARM7-NEXT:    mov r1, #13
; ARM7-NEXT:    mul r0, r0, r1
; ARM7-NEXT:    and r1, r0, #15
; ARM7-NEXT:    mov r0, #0
; ARM7-NEXT:    cmp r1, #3
; ARM7-NEXT:    movwhi r0, #1
; ARM7-NEXT:    bx lr
;
; ARM8-LABEL: test_urem_odd_setne:
; ARM8:       @ %bb.0:
; ARM8-NEXT:    mov r1, #13
; ARM8-NEXT:    mul r0, r0, r1
; ARM8-NEXT:    and r1, r0, #15
; ARM8-NEXT:    mov r0, #0
; ARM8-NEXT:    cmp r1, #3
; ARM8-NEXT:    movwhi r0, #1
; ARM8-NEXT:    bx lr
;
; NEON7-LABEL: test_urem_odd_setne:
; NEON7:       @ %bb.0:
; NEON7-NEXT:    mov r1, #13
; NEON7-NEXT:    mul r0, r0, r1
; NEON7-NEXT:    and r1, r0, #15
; NEON7-NEXT:    mov r0, #0
; NEON7-NEXT:    cmp r1, #3
; NEON7-NEXT:    movwhi r0, #1
; NEON7-NEXT:    bx lr
;
; NEON8-LABEL: test_urem_odd_setne:
; NEON8:       @ %bb.0:
; NEON8-NEXT:    mov r1, #13
; NEON8-NEXT:    mul r0, r0, r1
; NEON8-NEXT:    and r1, r0, #15
; NEON8-NEXT:    mov r0, #0
; NEON8-NEXT:    cmp r1, #3
; NEON8-NEXT:    movwhi r0, #1
; NEON8-NEXT:    bx lr
  %urem = urem i4 %X, 5
  %cmp = icmp ne i4 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_negative_odd(i9 %X) nounwind {
; ARM5-LABEL: test_urem_negative_odd:
; ARM5:       @ %bb.0:
; ARM5-NEXT:    mov r1, #51
; ARM5-NEXT:    orr r1, r1, #256
; ARM5-NEXT:    mul r2, r0, r1
; ARM5-NEXT:    mov r0, #255
; ARM5-NEXT:    orr r0, r0, #256
; ARM5-NEXT:    and r1, r2, r0
; ARM5-NEXT:    mov r0, #0
; ARM5-NEXT:    cmp r1, #1
; ARM5-NEXT:    movhi r0, #1
; ARM5-NEXT:    bx lr
;
; ARM6-LABEL: test_urem_negative_odd:
; ARM6:       @ %bb.0:
; ARM6-NEXT:    mov r1, #51
; ARM6-NEXT:    orr r1, r1, #256
; ARM6-NEXT:    mul r0, r0, r1
; ARM6-NEXT:    mov r1, #255
; ARM6-NEXT:    orr r1, r1, #256
; ARM6-NEXT:    and r1, r0, r1
; ARM6-NEXT:    mov r0, #0
; ARM6-NEXT:    cmp r1, #1
; ARM6-NEXT:    movhi r0, #1
; ARM6-NEXT:    bx lr
;
; ARM7-LABEL: test_urem_negative_odd:
; ARM7:       @ %bb.0:
; ARM7-NEXT:    movw r1, #307
; ARM7-NEXT:    mul r1, r0, r1
; ARM7-NEXT:    mov r0, #0
; ARM7-NEXT:    bfc r1, #9, #23
; ARM7-NEXT:    cmp r1, #1
; ARM7-NEXT:    movwhi r0, #1
; ARM7-NEXT:    bx lr
;
; ARM8-LABEL: test_urem_negative_odd:
; ARM8:       @ %bb.0:
; ARM8-NEXT:    movw r1, #307
; ARM8-NEXT:    mul r1, r0, r1
; ARM8-NEXT:    mov r0, #0
; ARM8-NEXT:    bfc r1, #9, #23
; ARM8-NEXT:    cmp r1, #1
; ARM8-NEXT:    movwhi r0, #1
; ARM8-NEXT:    bx lr
;
; NEON7-LABEL: test_urem_negative_odd:
; NEON7:       @ %bb.0:
; NEON7-NEXT:    movw r1, #307
; NEON7-NEXT:    mul r1, r0, r1
; NEON7-NEXT:    mov r0, #0
; NEON7-NEXT:    bfc r1, #9, #23
; NEON7-NEXT:    cmp r1, #1
; NEON7-NEXT:    movwhi r0, #1
; NEON7-NEXT:    bx lr
;
; NEON8-LABEL: test_urem_negative_odd:
; NEON8:       @ %bb.0:
; NEON8-NEXT:    movw r1, #307
; NEON8-NEXT:    mul r1, r0, r1
; NEON8-NEXT:    mov r0, #0
; NEON8-NEXT:    bfc r1, #9, #23
; NEON8-NEXT:    cmp r1, #1
; NEON8-NEXT:    movwhi r0, #1
; NEON8-NEXT:    bx lr
  %urem = urem i9 %X, -5
  %cmp = icmp ne i9 %urem, 0
  ret i1 %cmp
}

define <3 x i1> @test_urem_vec(<3 x i11> %X) nounwind {
; ARM5-LABEL: test_urem_vec:
; ARM5:       @ %bb.0:
; ARM5-NEXT:    push {r4, lr}
; ARM5-NEXT:    mov r3, #171
; ARM5-NEXT:    orr r3, r3, #512
; ARM5-NEXT:    mul r12, r0, r3
; ARM5-NEXT:    mov r0, #1020
; ARM5-NEXT:    orr r0, r0, #1024
; ARM5-NEXT:    mov r3, #254
; ARM5-NEXT:    orr r3, r3, #1792
; ARM5-NEXT:    and r0, r12, r0
; ARM5-NEXT:    lsr r0, r0, #1
; ARM5-NEXT:    orr r0, r0, r12, lsl #10
; ARM5-NEXT:    sub r12, r1, #1
; ARM5-NEXT:    mov r1, #183
; ARM5-NEXT:    and r0, r0, r3
; ARM5-NEXT:    orr r1, r1, #1280
; ARM5-NEXT:    mov r3, #0
; ARM5-NEXT:    lsr r0, r0, #1
; ARM5-NEXT:    cmp r0, #170
; ARM5-NEXT:    mul lr, r12, r1
; ARM5-NEXT:    mov r12, #255
; ARM5-NEXT:    orr r12, r12, #1792
; ARM5-NEXT:    mov r0, #0
; ARM5-NEXT:    movhi r0, #1
; ARM5-NEXT:    and r1, lr, r12
; ARM5-NEXT:    sub lr, r2, #2
; ARM5-NEXT:    mov r2, #51
; ARM5-NEXT:    cmp r1, #292
; ARM5-NEXT:    orr r2, r2, #768
; ARM5-NEXT:    mov r1, #0
; ARM5-NEXT:    movhi r1, #1
; ARM5-NEXT:    mul r4, lr, r2
; ARM5-NEXT:    and r2, r4, r12
; ARM5-NEXT:    cmp r2, #1
; ARM5-NEXT:    movhi r3, #1
; ARM5-NEXT:    mov r2, r3
; ARM5-NEXT:    pop {r4, pc}
;
; ARM6-LABEL: test_urem_vec:
; ARM6:       @ %bb.0:
; ARM6-NEXT:    push {r11, lr}
; ARM6-NEXT:    mov r3, #171
; ARM6-NEXT:    sub r12, r1, #1
; ARM6-NEXT:    orr r3, r3, #512
; ARM6-NEXT:    mov r1, #183
; ARM6-NEXT:    orr r1, r1, #1280
; ARM6-NEXT:    sub lr, r2, #2
; ARM6-NEXT:    mul r0, r0, r3
; ARM6-NEXT:    mov r3, #1020
; ARM6-NEXT:    orr r3, r3, #1024
; ARM6-NEXT:    mov r2, #51
; ARM6-NEXT:    mul r1, r12, r1
; ARM6-NEXT:    orr r2, r2, #768
; ARM6-NEXT:    mov r12, #255
; ARM6-NEXT:    and r3, r0, r3
; ARM6-NEXT:    mul r2, lr, r2
; ARM6-NEXT:    orr r12, r12, #1792
; ARM6-NEXT:    lsr r3, r3, #1
; ARM6-NEXT:    orr r0, r3, r0, lsl #10
; ARM6-NEXT:    mov r3, #254
; ARM6-NEXT:    and r1, r1, r12
; ARM6-NEXT:    orr r3, r3, #1792
; ARM6-NEXT:    and r0, r0, r3
; ARM6-NEXT:    and r2, r2, r12
; ARM6-NEXT:    mov r3, #0
; ARM6-NEXT:    lsr r0, r0, #1
; ARM6-NEXT:    cmp r0, #170
; ARM6-NEXT:    mov r0, #0
; ARM6-NEXT:    movhi r0, #1
; ARM6-NEXT:    cmp r1, #292
; ARM6-NEXT:    mov r1, #0
; ARM6-NEXT:    movhi r1, #1
; ARM6-NEXT:    cmp r2, #1
; ARM6-NEXT:    movhi r3, #1
; ARM6-NEXT:    mov r2, r3
; ARM6-NEXT:    pop {r11, pc}
;
; ARM7-LABEL: test_urem_vec:
; ARM7:       @ %bb.0:
; ARM7-NEXT:    vmov.16 d16[0], r0
; ARM7-NEXT:    vldr d17, .LCPI4_0
; ARM7-NEXT:    vmov.16 d16[1], r1
; ARM7-NEXT:    vldr d19, .LCPI4_3
; ARM7-NEXT:    vmov.16 d16[2], r2
; ARM7-NEXT:    vsub.i16 d16, d16, d17
; ARM7-NEXT:    vldr d17, .LCPI4_1
; ARM7-NEXT:    vmul.i16 d16, d16, d17
; ARM7-NEXT:    vldr d17, .LCPI4_2
; ARM7-NEXT:    vneg.s16 d17, d17
; ARM7-NEXT:    vshl.i16 d18, d16, #1
; ARM7-NEXT:    vbic.i16 d16, #0xf800
; ARM7-NEXT:    vshl.u16 d16, d16, d17
; ARM7-NEXT:    vshl.u16 d17, d18, d19
; ARM7-NEXT:    vorr d16, d16, d17
; ARM7-NEXT:    vldr d17, .LCPI4_4
; ARM7-NEXT:    vbic.i16 d16, #0xf800
; ARM7-NEXT:    vcgt.u16 d16, d16, d17
; ARM7-NEXT:    vmov.u16 r0, d16[0]
; ARM7-NEXT:    vmov.u16 r1, d16[1]
; ARM7-NEXT:    vmov.u16 r2, d16[2]
; ARM7-NEXT:    bx lr
; ARM7-NEXT:    .p2align 3
; ARM7-NEXT:  @ %bb.1:
; ARM7-NEXT:  .LCPI4_0:
; ARM7-NEXT:    .short 0 @ 0x0
; ARM7-NEXT:    .short 1 @ 0x1
; ARM7-NEXT:    .short 2 @ 0x2
; ARM7-NEXT:    .zero 2
; ARM7-NEXT:  .LCPI4_1:
; ARM7-NEXT:    .short 683 @ 0x2ab
; ARM7-NEXT:    .short 1463 @ 0x5b7
; ARM7-NEXT:    .short 819 @ 0x333
; ARM7-NEXT:    .zero 2
; ARM7-NEXT:  .LCPI4_2:
; ARM7-NEXT:    .short 1 @ 0x1
; ARM7-NEXT:    .short 0 @ 0x0
; ARM7-NEXT:    .short 0 @ 0x0
; ARM7-NEXT:    .short 0 @ 0x0
; ARM7-NEXT:  .LCPI4_3:
; ARM7-NEXT:    .short 9 @ 0x9
; ARM7-NEXT:    .short 10 @ 0xa
; ARM7-NEXT:    .short 10 @ 0xa
; ARM7-NEXT:    .short 10 @ 0xa
; ARM7-NEXT:  .LCPI4_4:
; ARM7-NEXT:    .short 341 @ 0x155
; ARM7-NEXT:    .short 292 @ 0x124
; ARM7-NEXT:    .short 1 @ 0x1
; ARM7-NEXT:    .short 0 @ 0x0
;
; ARM8-LABEL: test_urem_vec:
; ARM8:       @ %bb.0:
; ARM8-NEXT:    vmov.16 d16[0], r0
; ARM8-NEXT:    vldr d17, .LCPI4_0
; ARM8-NEXT:    vmov.16 d16[1], r1
; ARM8-NEXT:    vldr d19, .LCPI4_3
; ARM8-NEXT:    vmov.16 d16[2], r2
; ARM8-NEXT:    vsub.i16 d16, d16, d17
; ARM8-NEXT:    vldr d17, .LCPI4_1
; ARM8-NEXT:    vmul.i16 d16, d16, d17
; ARM8-NEXT:    vldr d17, .LCPI4_2
; ARM8-NEXT:    vneg.s16 d17, d17
; ARM8-NEXT:    vshl.i16 d18, d16, #1
; ARM8-NEXT:    vbic.i16 d16, #0xf800
; ARM8-NEXT:    vshl.u16 d16, d16, d17
; ARM8-NEXT:    vshl.u16 d17, d18, d19
; ARM8-NEXT:    vorr d16, d16, d17
; ARM8-NEXT:    vldr d17, .LCPI4_4
; ARM8-NEXT:    vbic.i16 d16, #0xf800
; ARM8-NEXT:    vcgt.u16 d16, d16, d17
; ARM8-NEXT:    vmov.u16 r0, d16[0]
; ARM8-NEXT:    vmov.u16 r1, d16[1]
; ARM8-NEXT:    vmov.u16 r2, d16[2]
; ARM8-NEXT:    bx lr
; ARM8-NEXT:    .p2align 3
; ARM8-NEXT:  @ %bb.1:
; ARM8-NEXT:  .LCPI4_0:
; ARM8-NEXT:    .short 0 @ 0x0
; ARM8-NEXT:    .short 1 @ 0x1
; ARM8-NEXT:    .short 2 @ 0x2
; ARM8-NEXT:    .zero 2
; ARM8-NEXT:  .LCPI4_1:
; ARM8-NEXT:    .short 683 @ 0x2ab
; ARM8-NEXT:    .short 1463 @ 0x5b7
; ARM8-NEXT:    .short 819 @ 0x333
; ARM8-NEXT:    .zero 2
; ARM8-NEXT:  .LCPI4_2:
; ARM8-NEXT:    .short 1 @ 0x1
; ARM8-NEXT:    .short 0 @ 0x0
; ARM8-NEXT:    .short 0 @ 0x0
; ARM8-NEXT:    .short 0 @ 0x0
; ARM8-NEXT:  .LCPI4_3:
; ARM8-NEXT:    .short 9 @ 0x9
; ARM8-NEXT:    .short 10 @ 0xa
; ARM8-NEXT:    .short 10 @ 0xa
; ARM8-NEXT:    .short 10 @ 0xa
; ARM8-NEXT:  .LCPI4_4:
; ARM8-NEXT:    .short 341 @ 0x155
; ARM8-NEXT:    .short 292 @ 0x124
; ARM8-NEXT:    .short 1 @ 0x1
; ARM8-NEXT:    .short 0 @ 0x0
;
; NEON7-LABEL: test_urem_vec:
; NEON7:       @ %bb.0:
; NEON7-NEXT:    vmov.16 d16[0], r0
; NEON7-NEXT:    vldr d17, .LCPI4_0
; NEON7-NEXT:    vmov.16 d16[1], r1
; NEON7-NEXT:    vldr d19, .LCPI4_3
; NEON7-NEXT:    vmov.16 d16[2], r2
; NEON7-NEXT:    vsub.i16 d16, d16, d17
; NEON7-NEXT:    vldr d17, .LCPI4_1
; NEON7-NEXT:    vmul.i16 d16, d16, d17
; NEON7-NEXT:    vldr d17, .LCPI4_2
; NEON7-NEXT:    vneg.s16 d17, d17
; NEON7-NEXT:    vshl.i16 d18, d16, #1
; NEON7-NEXT:    vbic.i16 d16, #0xf800
; NEON7-NEXT:    vshl.u16 d16, d16, d17
; NEON7-NEXT:    vshl.u16 d17, d18, d19
; NEON7-NEXT:    vorr d16, d16, d17
; NEON7-NEXT:    vldr d17, .LCPI4_4
; NEON7-NEXT:    vbic.i16 d16, #0xf800
; NEON7-NEXT:    vcgt.u16 d16, d16, d17
; NEON7-NEXT:    vmov.u16 r0, d16[0]
; NEON7-NEXT:    vmov.u16 r1, d16[1]
; NEON7-NEXT:    vmov.u16 r2, d16[2]
; NEON7-NEXT:    bx lr
; NEON7-NEXT:    .p2align 3
; NEON7-NEXT:  @ %bb.1:
; NEON7-NEXT:  .LCPI4_0:
; NEON7-NEXT:    .short 0 @ 0x0
; NEON7-NEXT:    .short 1 @ 0x1
; NEON7-NEXT:    .short 2 @ 0x2
; NEON7-NEXT:    .zero 2
; NEON7-NEXT:  .LCPI4_1:
; NEON7-NEXT:    .short 683 @ 0x2ab
; NEON7-NEXT:    .short 1463 @ 0x5b7
; NEON7-NEXT:    .short 819 @ 0x333
; NEON7-NEXT:    .zero 2
; NEON7-NEXT:  .LCPI4_2:
; NEON7-NEXT:    .short 1 @ 0x1
; NEON7-NEXT:    .short 0 @ 0x0
; NEON7-NEXT:    .short 0 @ 0x0
; NEON7-NEXT:    .short 0 @ 0x0
; NEON7-NEXT:  .LCPI4_3:
; NEON7-NEXT:    .short 9 @ 0x9
; NEON7-NEXT:    .short 10 @ 0xa
; NEON7-NEXT:    .short 10 @ 0xa
; NEON7-NEXT:    .short 10 @ 0xa
; NEON7-NEXT:  .LCPI4_4:
; NEON7-NEXT:    .short 341 @ 0x155
; NEON7-NEXT:    .short 292 @ 0x124
; NEON7-NEXT:    .short 1 @ 0x1
; NEON7-NEXT:    .short 0 @ 0x0
;
; NEON8-LABEL: test_urem_vec:
; NEON8:       @ %bb.0:
; NEON8-NEXT:    vmov.16 d16[0], r0
; NEON8-NEXT:    vldr d17, .LCPI4_0
; NEON8-NEXT:    vmov.16 d16[1], r1
; NEON8-NEXT:    vldr d19, .LCPI4_3
; NEON8-NEXT:    vmov.16 d16[2], r2
; NEON8-NEXT:    vsub.i16 d16, d16, d17
; NEON8-NEXT:    vldr d17, .LCPI4_1
; NEON8-NEXT:    vmul.i16 d16, d16, d17
; NEON8-NEXT:    vldr d17, .LCPI4_2
; NEON8-NEXT:    vneg.s16 d17, d17
; NEON8-NEXT:    vshl.i16 d18, d16, #1
; NEON8-NEXT:    vbic.i16 d16, #0xf800
; NEON8-NEXT:    vshl.u16 d16, d16, d17
; NEON8-NEXT:    vshl.u16 d17, d18, d19
; NEON8-NEXT:    vorr d16, d16, d17
; NEON8-NEXT:    vldr d17, .LCPI4_4
; NEON8-NEXT:    vbic.i16 d16, #0xf800
; NEON8-NEXT:    vcgt.u16 d16, d16, d17
; NEON8-NEXT:    vmov.u16 r0, d16[0]
; NEON8-NEXT:    vmov.u16 r1, d16[1]
; NEON8-NEXT:    vmov.u16 r2, d16[2]
; NEON8-NEXT:    bx lr
; NEON8-NEXT:    .p2align 3
; NEON8-NEXT:  @ %bb.1:
; NEON8-NEXT:  .LCPI4_0:
; NEON8-NEXT:    .short 0 @ 0x0
; NEON8-NEXT:    .short 1 @ 0x1
; NEON8-NEXT:    .short 2 @ 0x2
; NEON8-NEXT:    .zero 2
; NEON8-NEXT:  .LCPI4_1:
; NEON8-NEXT:    .short 683 @ 0x2ab
; NEON8-NEXT:    .short 1463 @ 0x5b7
; NEON8-NEXT:    .short 819 @ 0x333
; NEON8-NEXT:    .zero 2
; NEON8-NEXT:  .LCPI4_2:
; NEON8-NEXT:    .short 1 @ 0x1
; NEON8-NEXT:    .short 0 @ 0x0
; NEON8-NEXT:    .short 0 @ 0x0
; NEON8-NEXT:    .short 0 @ 0x0
; NEON8-NEXT:  .LCPI4_3:
; NEON8-NEXT:    .short 9 @ 0x9
; NEON8-NEXT:    .short 10 @ 0xa
; NEON8-NEXT:    .short 10 @ 0xa
; NEON8-NEXT:    .short 10 @ 0xa
; NEON8-NEXT:  .LCPI4_4:
; NEON8-NEXT:    .short 341 @ 0x155
; NEON8-NEXT:    .short 292 @ 0x124
; NEON8-NEXT:    .short 1 @ 0x1
; NEON8-NEXT:    .short 0 @ 0x0
  %urem = urem <3 x i11> %X, <i11 6, i11 7, i11 -5>
  %cmp = icmp ne <3 x i11> %urem, <i11 0, i11 1, i11 2>
  ret <3 x i1> %cmp
}

define i1 @test_urem_larger(i63 %X) nounwind {
; ARM5-LABEL: test_urem_larger:
; ARM5:       @ %bb.0:
; ARM5-NEXT:    push {r4, lr}
; ARM5-NEXT:    ldr r12, .LCPI5_0
; ARM5-NEXT:    ldr r2, .LCPI5_1
; ARM5-NEXT:    umull r3, lr, r0, r12
; ARM5-NEXT:    mla r4, r0, r2, lr
; ARM5-NEXT:    mla r0, r1, r12, r4
; ARM5-NEXT:    bic r0, r0, #-2147483648
; ARM5-NEXT:    lsrs r0, r0, #1
; ARM5-NEXT:    rrx r2, r3
; ARM5-NEXT:    orr r0, r0, r3, lsl #30
; ARM5-NEXT:    ldr r3, .LCPI5_2
; ARM5-NEXT:    bic r1, r0, #-2147483648
; ARM5-NEXT:    mov r0, #0
; ARM5-NEXT:    subs r2, r2, r3
; ARM5-NEXT:    sbcs r1, r1, #1
; ARM5-NEXT:    movlo r0, #1
; ARM5-NEXT:    pop {r4, pc}
; ARM5-NEXT:    .p2align 2
; ARM5-NEXT:  @ %bb.1:
; ARM5-NEXT:  .LCPI5_0:
; ARM5-NEXT:    .long 3456474841 @ 0xce059ed9
; ARM5-NEXT:  .LCPI5_1:
; ARM5-NEXT:    .long 790204738 @ 0x2f199142
; ARM5-NEXT:  .LCPI5_2:
; ARM5-NEXT:    .long 3175964122 @ 0xbd4d5dda
;
; ARM6-LABEL: test_urem_larger:
; ARM6:       @ %bb.0:
; ARM6-NEXT:    push {r11, lr}
; ARM6-NEXT:    ldr r12, .LCPI5_0
; ARM6-NEXT:    ldr r2, .LCPI5_1
; ARM6-NEXT:    umull r3, lr, r0, r12
; ARM6-NEXT:    mla r0, r0, r2, lr
; ARM6-NEXT:    mla r0, r1, r12, r0
; ARM6-NEXT:    bic r0, r0, #-2147483648
; ARM6-NEXT:    lsrs r0, r0, #1
; ARM6-NEXT:    rrx r2, r3
; ARM6-NEXT:    orr r0, r0, r3, lsl #30
; ARM6-NEXT:    ldr r3, .LCPI5_2
; ARM6-NEXT:    bic r1, r0, #-2147483648
; ARM6-NEXT:    mov r0, #0
; ARM6-NEXT:    subs r2, r2, r3
; ARM6-NEXT:    sbcs r1, r1, #1
; ARM6-NEXT:    movlo r0, #1
; ARM6-NEXT:    pop {r11, pc}
; ARM6-NEXT:    .p2align 2
; ARM6-NEXT:  @ %bb.1:
; ARM6-NEXT:  .LCPI5_0:
; ARM6-NEXT:    .long 3456474841 @ 0xce059ed9
; ARM6-NEXT:  .LCPI5_1:
; ARM6-NEXT:    .long 790204738 @ 0x2f199142
; ARM6-NEXT:  .LCPI5_2:
; ARM6-NEXT:    .long 3175964122 @ 0xbd4d5dda
;
; ARM7-LABEL: test_urem_larger:
; ARM7:       @ %bb.0:
; ARM7-NEXT:    push {r11, lr}
; ARM7-NEXT:    movw r12, #40665
; ARM7-NEXT:    movw r2, #37186
; ARM7-NEXT:    movt r12, #52741
; ARM7-NEXT:    movt r2, #12057
; ARM7-NEXT:    umull r3, lr, r0, r12
; ARM7-NEXT:    mla r0, r0, r2, lr
; ARM7-NEXT:    mla r0, r1, r12, r0
; ARM7-NEXT:    bic r0, r0, #-2147483648
; ARM7-NEXT:    lsrs r0, r0, #1
; ARM7-NEXT:    rrx r2, r3
; ARM7-NEXT:    orr r0, r0, r3, lsl #30
; ARM7-NEXT:    movw r3, #24026
; ARM7-NEXT:    bic r1, r0, #-2147483648
; ARM7-NEXT:    movt r3, #48461
; ARM7-NEXT:    subs r2, r2, r3
; ARM7-NEXT:    mov r0, #0
; ARM7-NEXT:    sbcs r1, r1, #1
; ARM7-NEXT:    movwlo r0, #1
; ARM7-NEXT:    pop {r11, pc}
;
; ARM8-LABEL: test_urem_larger:
; ARM8:       @ %bb.0:
; ARM8-NEXT:    push {r11, lr}
; ARM8-NEXT:    movw r12, #40665
; ARM8-NEXT:    movw r2, #37186
; ARM8-NEXT:    movt r12, #52741
; ARM8-NEXT:    movt r2, #12057
; ARM8-NEXT:    umull r3, lr, r0, r12
; ARM8-NEXT:    mla r0, r0, r2, lr
; ARM8-NEXT:    mla r0, r1, r12, r0
; ARM8-NEXT:    bic r0, r0, #-2147483648
; ARM8-NEXT:    lsrs r0, r0, #1
; ARM8-NEXT:    rrx r2, r3
; ARM8-NEXT:    orr r0, r0, r3, lsl #30
; ARM8-NEXT:    movw r3, #24026
; ARM8-NEXT:    bic r1, r0, #-2147483648
; ARM8-NEXT:    movt r3, #48461
; ARM8-NEXT:    subs r2, r2, r3
; ARM8-NEXT:    mov r0, #0
; ARM8-NEXT:    sbcs r1, r1, #1
; ARM8-NEXT:    movwlo r0, #1
; ARM8-NEXT:    pop {r11, pc}
;
; NEON7-LABEL: test_urem_larger:
; NEON7:       @ %bb.0:
; NEON7-NEXT:    push {r11, lr}
; NEON7-NEXT:    movw r12, #40665
; NEON7-NEXT:    movw r2, #37186
; NEON7-NEXT:    movt r12, #52741
; NEON7-NEXT:    movt r2, #12057
; NEON7-NEXT:    umull r3, lr, r0, r12
; NEON7-NEXT:    mla r0, r0, r2, lr
; NEON7-NEXT:    mla r0, r1, r12, r0
; NEON7-NEXT:    bic r0, r0, #-2147483648
; NEON7-NEXT:    lsrs r0, r0, #1
; NEON7-NEXT:    rrx r2, r3
; NEON7-NEXT:    orr r0, r0, r3, lsl #30
; NEON7-NEXT:    movw r3, #24026
; NEON7-NEXT:    bic r1, r0, #-2147483648
; NEON7-NEXT:    movt r3, #48461
; NEON7-NEXT:    subs r2, r2, r3
; NEON7-NEXT:    mov r0, #0
; NEON7-NEXT:    sbcs r1, r1, #1
; NEON7-NEXT:    movwlo r0, #1
; NEON7-NEXT:    pop {r11, pc}
;
; NEON8-LABEL: test_urem_larger:
; NEON8:       @ %bb.0:
; NEON8-NEXT:    push {r11, lr}
; NEON8-NEXT:    movw r12, #40665
; NEON8-NEXT:    movw r2, #37186
; NEON8-NEXT:    movt r12, #52741
; NEON8-NEXT:    movt r2, #12057
; NEON8-NEXT:    umull r3, lr, r0, r12
; NEON8-NEXT:    mla r0, r0, r2, lr
; NEON8-NEXT:    mla r0, r1, r12, r0
; NEON8-NEXT:    bic r0, r0, #-2147483648
; NEON8-NEXT:    lsrs r0, r0, #1
; NEON8-NEXT:    rrx r2, r3
; NEON8-NEXT:    orr r0, r0, r3, lsl #30
; NEON8-NEXT:    movw r3, #24026
; NEON8-NEXT:    bic r1, r0, #-2147483648
; NEON8-NEXT:    movt r3, #48461
; NEON8-NEXT:    subs r2, r2, r3
; NEON8-NEXT:    mov r0, #0
; NEON8-NEXT:    sbcs r1, r1, #1
; NEON8-NEXT:    movwlo r0, #1
; NEON8-NEXT:    pop {r11, pc}
  %urem = urem i63 %X, 1234567890
  %cmp = icmp eq i63 %urem, 0
  ret i1 %cmp
}