; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=thumbv7-gnu-linux < %s | FileCheck -check-prefixes=CHECK %s

define { half, half } @test_sincos_f16(half %a) {
; CHECK-LABEL: test_sincos_f16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    bl __gnu_h2f_ieee
; CHECK-NEXT:    add r1, sp, #4
; CHECK-NEXT:    mov r2, sp
; CHECK-NEXT:    bl sincosf
; CHECK-NEXT:    ldr r0, [sp, #4]
; CHECK-NEXT:    bl __gnu_f2h_ieee
; CHECK-NEXT:    mov r4, r0
; CHECK-NEXT:    ldr r0, [sp]
; CHECK-NEXT:    bl __gnu_f2h_ieee
; CHECK-NEXT:    mov r1, r0
; CHECK-NEXT:    mov r0, r4
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    pop {r4, pc}
  %result = call { half, half } @llvm.sincos.f16(half %a)
  ret { half, half } %result
}

define half @test_sincos_f16_only_use_sin(half %a) {
; CHECK-LABEL: test_sincos_f16_only_use_sin:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    bl __gnu_h2f_ieee
; CHECK-NEXT:    add r1, sp, #4
; CHECK-NEXT:    mov r2, sp
; CHECK-NEXT:    bl sincosf
; CHECK-NEXT:    ldr r0, [sp, #4]
; CHECK-NEXT:    bl __gnu_f2h_ieee
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    pop {r7, pc}
  %result = call { half, half } @llvm.sincos.f16(half %a)
  %result.0 = extractvalue { half, half } %result, 0
  ret half %result.0
}

define half @test_sincos_f16_only_use_cos(half %a) {
; CHECK-LABEL: test_sincos_f16_only_use_cos:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    bl __gnu_h2f_ieee
; CHECK-NEXT:    add r1, sp, #4
; CHECK-NEXT:    mov r2, sp
; CHECK-NEXT:    bl sincosf
; CHECK-NEXT:    ldr r0, [sp]
; CHECK-NEXT:    bl __gnu_f2h_ieee
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    pop {r7, pc}
  %result = call { half, half } @llvm.sincos.f16(half %a)
  %result.1 = extractvalue { half, half } %result, 1
  ret half %result.1
}

define { <2 x half>, <2 x half> } @test_sincos_v2f16(<2 x half> %a) {
; CHECK-LABEL: test_sincos_v2f16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    vpush {d8}
; CHECK-NEXT:    sub sp, #24
; CHECK-NEXT:    mov r4, r0
; CHECK-NEXT:    mov r0, r1
; CHECK-NEXT:    bl __gnu_h2f_ieee
; CHECK-NEXT:    add r1, sp, #12
; CHECK-NEXT:    add r2, sp, #8
; CHECK-NEXT:    bl sincosf
; CHECK-NEXT:    mov r0, r4
; CHECK-NEXT:    bl __gnu_h2f_ieee
; CHECK-NEXT:    add r1, sp, #4
; CHECK-NEXT:    mov r2, sp
; CHECK-NEXT:    bl sincosf
; CHECK-NEXT:    ldr r0, [sp, #12]
; CHECK-NEXT:    bl __gnu_f2h_ieee
; CHECK-NEXT:    ldr r1, [sp, #4]
; CHECK-NEXT:    strh.w r0, [sp, #22]
; CHECK-NEXT:    mov r0, r1
; CHECK-NEXT:    bl __gnu_f2h_ieee
; CHECK-NEXT:    strh.w r0, [sp, #20]
; CHECK-NEXT:    add r0, sp, #20
; CHECK-NEXT:    vld1.32 {d8[0]}, [r0:32]
; CHECK-NEXT:    ldr r0, [sp, #8]
; CHECK-NEXT:    bl __gnu_f2h_ieee
; CHECK-NEXT:    ldr r1, [sp]
; CHECK-NEXT:    strh.w r0, [sp, #18]
; CHECK-NEXT:    mov r0, r1
; CHECK-NEXT:    bl __gnu_f2h_ieee
; CHECK-NEXT:    strh.w r0, [sp, #16]
; CHECK-NEXT:    add r0, sp, #16
; CHECK-NEXT:    vmovl.u16 q9, d8
; CHECK-NEXT:    vld1.32 {d16[0]}, [r0:32]
; CHECK-NEXT:    vmovl.u16 q8, d16
; CHECK-NEXT:    vmov.32 r0, d18[0]
; CHECK-NEXT:    vmov.32 r1, d18[1]
; CHECK-NEXT:    vmov.32 r2, d16[0]
; CHECK-NEXT:    vmov.32 r3, d16[1]
; CHECK-NEXT:    add sp, #24
; CHECK-NEXT:    vpop {d8}
; CHECK-NEXT:    pop {r4, pc}
  %result = call { <2 x half>, <2 x half> } @llvm.sincos.v2f16(<2 x half> %a)
  ret { <2 x half>, <2 x half> } %result
}

define { float, float } @test_sincos_f32(float %a) {
; CHECK-LABEL: test_sincos_f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    add r1, sp, #4
; CHECK-NEXT:    mov r2, sp
; CHECK-NEXT:    bl sincosf
; CHECK-NEXT:    ldrd r1, r0, [sp], #8
; CHECK-NEXT:    pop {r7, pc}
  %result = call { float, float } @llvm.sincos.f32(float %a)
  ret { float, float } %result
}

define { <2 x float>, <2 x float> } @test_sincos_v2f32(<2 x float> %a) {
; CHECK-LABEL: test_sincos_v2f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vpush {d8}
; CHECK-NEXT:    sub sp, #16
; CHECK-NEXT:    vmov d8, r0, r1
; CHECK-NEXT:    add r1, sp, #4
; CHECK-NEXT:    mov r2, sp
; CHECK-NEXT:    vmov r0, s17
; CHECK-NEXT:    bl sincosf
; CHECK-NEXT:    vmov r0, s16
; CHECK-NEXT:    add r1, sp, #12
; CHECK-NEXT:    add r2, sp, #8
; CHECK-NEXT:    bl sincosf
; CHECK-NEXT:    vldr s1, [sp, #4]
; CHECK-NEXT:    vldr s3, [sp]
; CHECK-NEXT:    vldr s0, [sp, #12]
; CHECK-NEXT:    vldr s2, [sp, #8]
; CHECK-NEXT:    vmov r0, r1, d0
; CHECK-NEXT:    vmov r2, r3, d1
; CHECK-NEXT:    add sp, #16
; CHECK-NEXT:    vpop {d8}
; CHECK-NEXT:    pop {r7, pc}
  %result = call { <2 x float>, <2 x float> } @llvm.sincos.v2f32(<2 x float> %a)
  ret { <2 x float>, <2 x float> } %result
}

define { double, double } @test_sincos_f64(double %a) {
; CHECK-LABEL: test_sincos_f64:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    sub sp, #16
; CHECK-NEXT:    add r2, sp, #8
; CHECK-NEXT:    mov r3, sp
; CHECK-NEXT:    bl sincos
; CHECK-NEXT:    ldrd r0, r1, [sp, #8]
; CHECK-NEXT:    ldrd r2, r3, [sp], #16
; CHECK-NEXT:    pop {r7, pc}
  %result = call { double, double } @llvm.sincos.f64(double %a)
  ret { double, double } %result
}

define { <2 x double>, <2 x double> } @test_sincos_v2f64(<2 x double> %a) {
; CHECK-LABEL: test_sincos_v2f64:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    sub sp, #32
; CHECK-NEXT:    mov r1, r3
; CHECK-NEXT:    mov r12, r2
; CHECK-NEXT:    add r2, sp, #24
; CHECK-NEXT:    add r3, sp, #16
; CHECK-NEXT:    mov r4, r0
; CHECK-NEXT:    mov r0, r12
; CHECK-NEXT:    bl sincos
; CHECK-NEXT:    ldrd r0, r1, [sp, #40]
; CHECK-NEXT:    add r2, sp, #8
; CHECK-NEXT:    mov r3, sp
; CHECK-NEXT:    bl sincos
; CHECK-NEXT:    vldr d19, [sp, #8]
; CHECK-NEXT:    vldr d18, [sp, #24]
; CHECK-NEXT:    vldr d17, [sp]
; CHECK-NEXT:    vldr d16, [sp, #16]
; CHECK-NEXT:    vst1.64 {d18, d19}, [r4]!
; CHECK-NEXT:    vst1.64 {d16, d17}, [r4]
; CHECK-NEXT:    add sp, #32
; CHECK-NEXT:    pop {r4, pc}
  %result = call { <2 x double>, <2 x double> } @llvm.sincos.v2f64(<2 x double> %a)
  ret { <2 x double>, <2 x double> } %result
}

define { fp128, fp128 } @test_sincos_f128(fp128 %a) {
; CHECK-LABEL: test_sincos_f128:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    sub sp, #40
; CHECK-NEXT:    mov r12, r3
; CHECK-NEXT:    ldr r3, [sp, #56]
; CHECK-NEXT:    add.w lr, sp, #8
; CHECK-NEXT:    mov r4, r0
; CHECK-NEXT:    add r0, sp, #24
; CHECK-NEXT:    strd r0, lr, [sp]
; CHECK-NEXT:    mov r0, r1
; CHECK-NEXT:    mov r1, r2
; CHECK-NEXT:    mov r2, r12
; CHECK-NEXT:    bl sincosl
; CHECK-NEXT:    ldrd r2, r3, [sp, #16]
; CHECK-NEXT:    ldrd r12, r1, [sp, #8]
; CHECK-NEXT:    str r3, [r4, #28]
; CHECK-NEXT:    ldrd r3, r5, [sp, #32]
; CHECK-NEXT:    ldrd lr, r0, [sp, #24]
; CHECK-NEXT:    strd r1, r2, [r4, #20]
; CHECK-NEXT:    add.w r1, r4, #8
; CHECK-NEXT:    stm.w r1, {r3, r5, r12}
; CHECK-NEXT:    strd lr, r0, [r4]
; CHECK-NEXT:    add sp, #40
; CHECK-NEXT:    pop {r4, r5, r7, pc}
  %result = call { fp128, fp128 } @llvm.sincos.f16(fp128 %a)
  ret { fp128, fp128 } %result
}