; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32,NOZBS32
; RUN: llc -mtriple=riscv64 -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64,NOZBS64
; RUN: llc -mtriple=riscv32 -mattr=+zbb,+zbs -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV32,ZBS
; RUN: llc -mtriple=riscv64 -mattr=+zbb,+zbs -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,RV64,ZBS

define i32 @and0xabcdefff(i32 %x) {
; CHECK-LABEL: and0xabcdefff:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 344865
; CHECK-NEXT:    andn a0, a0, a1
; CHECK-NEXT:    ret
  %and = and i32 %x, -1412567041
  ret i32 %and
}

define i32 @orlow13(i32 %x) {
; CHECK-LABEL: orlow13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 1048574
; CHECK-NEXT:    orn a0, a0, a1
; CHECK-NEXT:    ret
  %or = or i32 %x, 8191
  ret i32 %or
}

define i64 @orlow24(i64 %x) {
; RV32-LABEL: orlow24:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a2, 1044480
; RV32-NEXT:    orn a0, a0, a2
; RV32-NEXT:    ret
;
; RV64-LABEL: orlow24:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a1, 1044480
; RV64-NEXT:    orn a0, a0, a1
; RV64-NEXT:    ret
  %or = or i64 %x, 16777215
  ret i64 %or
}

define i32 @xorlow16(i32 %x) {
; CHECK-LABEL: xorlow16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 1048560
; CHECK-NEXT:    xnor a0, a0, a1
; CHECK-NEXT:    ret
  %xor = xor i32 %x, 65535
  ret i32 %xor
}

define i32 @xorlow31(i32 %x) {
; CHECK-LABEL: xorlow31:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 524288
; CHECK-NEXT:    xnor a0, a0, a1
; CHECK-NEXT:    ret
  %xor = xor i32 %x, 2147483647
  ret i32 %xor
}

define i32 @oraddlow16(i32 %x) {
; RV32-LABEL: oraddlow16:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a1, 16
; RV32-NEXT:    addi a1, a1, -1
; RV32-NEXT:    or a0, a0, a1
; RV32-NEXT:    add a0, a0, a1
; RV32-NEXT:    ret
;
; RV64-LABEL: oraddlow16:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a1, 16
; RV64-NEXT:    addi a1, a1, -1
; RV64-NEXT:    or a0, a0, a1
; RV64-NEXT:    addw a0, a0, a1
; RV64-NEXT:    ret
  %or = or i32 %x, 65535
  %add = add nsw i32 %or, 65535
  ret i32 %add
}

define i32 @addorlow16(i32 %x) {
; RV32-LABEL: addorlow16:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a1, 16
; RV32-NEXT:    addi a1, a1, -1
; RV32-NEXT:    add a0, a0, a1
; RV32-NEXT:    or a0, a0, a1
; RV32-NEXT:    ret
;
; RV64-LABEL: addorlow16:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a1, 16
; RV64-NEXT:    addiw a1, a1, -1
; RV64-NEXT:    addw a0, a0, a1
; RV64-NEXT:    or a0, a0, a1
; RV64-NEXT:    ret
  %add = add nsw i32 %x, 65535
  %or = or i32 %add, 65535
  ret i32 %or
}

define i32 @andxorlow16(i32 %x) {
; RV32-LABEL: andxorlow16:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a1, 16
; RV32-NEXT:    addi a1, a1, -1
; RV32-NEXT:    andn a0, a1, a0
; RV32-NEXT:    ret
;
; RV64-LABEL: andxorlow16:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a1, 16
; RV64-NEXT:    addiw a1, a1, -1
; RV64-NEXT:    andn a0, a1, a0
; RV64-NEXT:    ret
  %and = and i32 %x, 65535
  %xor = xor i32 %and, 65535
  ret i32 %xor
}

define void @orarray100(ptr %a) {
; RV32-LABEL: orarray100:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    li a1, 0
; RV32-NEXT:    li a2, 0
; RV32-NEXT:    lui a3, 1048560
; RV32-NEXT:  .LBB8_1: # %for.body
; RV32-NEXT:    # =>This Inner Loop Header: Depth=1
; RV32-NEXT:    slli a4, a1, 2
; RV32-NEXT:    addi a1, a1, 1
; RV32-NEXT:    add a4, a0, a4
; RV32-NEXT:    lw a5, 0(a4)
; RV32-NEXT:    seqz a6, a1
; RV32-NEXT:    add a2, a2, a6
; RV32-NEXT:    xori a6, a1, 100
; RV32-NEXT:    orn a5, a5, a3
; RV32-NEXT:    or a6, a6, a2
; RV32-NEXT:    sw a5, 0(a4)
; RV32-NEXT:    bnez a6, .LBB8_1
; RV32-NEXT:  # %bb.2: # %for.cond.cleanup
; RV32-NEXT:    ret
;
; RV64-LABEL: orarray100:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    addi a1, a0, 400
; RV64-NEXT:    lui a2, 1048560
; RV64-NEXT:  .LBB8_1: # %for.body
; RV64-NEXT:    # =>This Inner Loop Header: Depth=1
; RV64-NEXT:    lw a3, 0(a0)
; RV64-NEXT:    orn a3, a3, a2
; RV64-NEXT:    sw a3, 0(a0)
; RV64-NEXT:    addi a0, a0, 4
; RV64-NEXT:    bne a0, a1, .LBB8_1
; RV64-NEXT:  # %bb.2: # %for.cond.cleanup
; RV64-NEXT:    ret
entry:
  br label %for.body

for.cond.cleanup:
  ret void

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds nuw i32, ptr %a, i64 %indvars.iv
  %1 = load i32, ptr %arrayidx, align 4
  %or = or i32 %1, 65535
  store i32 %or, ptr %arrayidx, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @orarray3(ptr %a) {
; CHECK-LABEL: orarray3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lw a1, 0(a0)
; CHECK-NEXT:    lw a2, 4(a0)
; CHECK-NEXT:    lw a3, 8(a0)
; CHECK-NEXT:    lui a4, 1048560
; CHECK-NEXT:    orn a1, a1, a4
; CHECK-NEXT:    orn a2, a2, a4
; CHECK-NEXT:    orn a3, a3, a4
; CHECK-NEXT:    sw a1, 0(a0)
; CHECK-NEXT:    sw a2, 4(a0)
; CHECK-NEXT:    sw a3, 8(a0)
; CHECK-NEXT:    ret
  %1 = load i32, ptr %a, align 4
  %or = or i32 %1, 65535
  store i32 %or, ptr %a, align 4
  %arrayidx.1 = getelementptr inbounds nuw i8, ptr %a, i64 4
  %2 = load i32, ptr %arrayidx.1, align 4
  %or.1 = or i32 %2, 65535
  store i32 %or.1, ptr %arrayidx.1, align 4
  %arrayidx.2 = getelementptr inbounds nuw i8, ptr %a, i64 8
  %3 = load i32, ptr %arrayidx.2, align 4
  %or.2 = or i32 %3, 65535
  store i32 %or.2, ptr %arrayidx.2, align 4
  ret void
}

define i32 @andlow16(i32 %x) {
; CHECK-LABEL: andlow16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    zext.h a0, a0
; CHECK-NEXT:    ret
  %and = and i32 %x, 65535
  ret i32 %and
}

define i32 @andlow24(i32 %x) {
; RV32-LABEL: andlow24:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a0, a0, 8
; RV32-NEXT:    srli a0, a0, 8
; RV32-NEXT:    ret
;
; RV64-LABEL: andlow24:
; RV64:       # %bb.0:
; RV64-NEXT:    slli a0, a0, 40
; RV64-NEXT:    srli a0, a0, 40
; RV64-NEXT:    ret
  %and = and i32 %x, 16777215
  ret i32 %and
}

define i32 @compl(i32 %x) {
; CHECK-LABEL: compl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    not a0, a0
; CHECK-NEXT:    ret
  %not = xor i32 %x, -1
  ret i32 %not
}

define i32 @orlow12(i32 %x) {
; NOZBS32-LABEL: orlow12:
; NOZBS32:       # %bb.0:
; NOZBS32-NEXT:    lui a1, 1048575
; NOZBS32-NEXT:    orn a0, a0, a1
; NOZBS32-NEXT:    ret
;
; NOZBS64-LABEL: orlow12:
; NOZBS64:       # %bb.0:
; NOZBS64-NEXT:    lui a1, 1048575
; NOZBS64-NEXT:    orn a0, a0, a1
; NOZBS64-NEXT:    ret
;
; ZBS-LABEL: orlow12:
; ZBS:       # %bb.0:
; ZBS-NEXT:    ori a0, a0, 2047
; ZBS-NEXT:    bseti a0, a0, 11
; ZBS-NEXT:    ret
  %or = or i32 %x, 4095
  ret i32 %or
}

define i32 @xorlow12(i32 %x) {
; NOZBS32-LABEL: xorlow12:
; NOZBS32:       # %bb.0:
; NOZBS32-NEXT:    lui a1, 1048575
; NOZBS32-NEXT:    xnor a0, a0, a1
; NOZBS32-NEXT:    ret
;
; NOZBS64-LABEL: xorlow12:
; NOZBS64:       # %bb.0:
; NOZBS64-NEXT:    lui a1, 1048575
; NOZBS64-NEXT:    xnor a0, a0, a1
; NOZBS64-NEXT:    ret
;
; ZBS-LABEL: xorlow12:
; ZBS:       # %bb.0:
; ZBS-NEXT:    xori a0, a0, 2047
; ZBS-NEXT:    binvi a0, a0, 11
; ZBS-NEXT:    ret
  %xor = xor i32 %x, 4095
  ret i32 %xor
}

define i64 @andimm64(i64 %x) {
; RV32-LABEL: andimm64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a1, 4080
; RV32-NEXT:    andn a0, a0, a1
; RV32-NEXT:    li a1, 0
; RV32-NEXT:    ret
;
; RV64-LABEL: andimm64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a1, 983295
; RV64-NEXT:    slli a1, a1, 4
; RV64-NEXT:    andn a0, a0, a1
; RV64-NEXT:    ret
  %and = and i64 %x, 4278255615
  ret i64 %and
}

define i64 @andimm64srli(i64 %x) {
; RV32-LABEL: andimm64srli:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a2, 1040384
; RV32-NEXT:    orn a0, a0, a2
; RV32-NEXT:    lui a2, 917504
; RV32-NEXT:    or a1, a1, a2
; RV32-NEXT:    ret
;
; RV64-LABEL: andimm64srli:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a1, 983040
; RV64-NEXT:    srli a1, a1, 3
; RV64-NEXT:    orn a0, a0, a1
; RV64-NEXT:    ret
  %or = or i64 %x, -2305843009180139521
  ret i64 %or
}