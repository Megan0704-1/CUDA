; RUN: opt -S %s -passes=sample-profile -sample-profile-file=%S/Inputs/indirect-call.prof | FileCheck %s
; RUN: opt -S %s -passes=sample-profile -sample-profile-file=%S/Inputs/indirect-call.extbinary.afdo | FileCheck %s

; CHECK-LABEL: @test
define void @test(ptr) #0 !dbg !3 {
  %2 = alloca ptr
  store ptr %0, ptr %2
  %3 = load ptr, ptr %2
  ; CHECK: call {{.*}}, !prof ![[PROF:[0-9]+]]
  call void %3(), !dbg !4
  ret void
}

; CHECK-LABEL: @test_inline
; If the indirect call is promoted and inlined in profile, we should promote and inline it.
define void @test_inline(ptr, ptr %x) #0 !dbg !6 {
  %2 = alloca ptr
  store ptr %0, ptr %2
  %3 = load ptr, ptr %2
; CHECK: icmp {{.*}} @foo_inline2
; CHECK: br {{.*}} !prof ![[BR1:[0-9]+]]
; CHECK: if.true.direct_targ:
; CHECK-NOT: call
; CHECK: if.false.orig_indirect:
; CHECK: icmp {{.*}} @foo_inline1
; CHECK: br {{.*}} !prof ![[BR2:[0-9]+]]
; CHECK: if.true.direct_targ1:
; CHECK-NOT: call
; CHECK: if.false.orig_indirect2:
; CHECK: call {{.*}} !prof ![[VP:[0-9]+]]
  call ptr %3(ptr %x), !dbg !7
  ret void
}

; CHECK-LABEL: @test_inline_strip
; If the indirect call is promoted and inlined in profile, and the callee name
; is stripped we should promote and inline it.
define void @test_inline_strip(ptr, ptr %x) #0 !dbg !8 {
  %2 = alloca ptr
  store ptr %0, ptr %2
  %3 = load ptr, ptr %2
; CHECK: icmp {{.*}} @foo_inline_strip.suffix
; CHECK: if.true.direct_targ:
; CHECK-NOT: call
; CHECK: if.false.orig_indirect:
; CHECK: call
  call ptr %3(ptr %x), !dbg !9
  ret void
}

; CHECK-LABEL: @test_inline_strip_conflict
; If the indirect call is promoted and inlined in profile, and the callee name
; is stripped, but have more than 1 potential match, we should not promote.
define void @test_inline_strip_conflict(ptr, ptr %x) #0 !dbg !10 {
  %2 = alloca ptr
  store ptr %0, ptr %2
  %3 = load ptr, ptr %2
; CHECK-NOT: if.true.direct_targ:
  call ptr %3(ptr %x), !dbg !11
  ret void
}

; CHECK-LABEL: @test_noinline
; If the indirect call target is not available, we should not promote it.
define void @test_noinline(ptr) #0 !dbg !12 {
  %2 = alloca ptr
  store ptr %0, ptr %2
  %3 = load ptr, ptr %2
; CHECK-NOT: icmp
; CHECK: call
  call void %3(), !dbg !13
  ret void
}

; CHECK-LABEL: @test_noinline_bitcast
; If the indirect call has been promoted to a direct call with bitcast,
; do not inline it.
define float @test_noinline_bitcast(ptr) #0 !dbg !26 {
  %2 = alloca ptr
  store ptr %0, ptr %2
; CHECK: icmp
; CHECK: call
  %3 = load ptr, ptr %2
  %4 = call float %3(), !dbg !27
  ret float %4
}

; CHECK-LABEL: @test_norecursive_inline
; If the indirect call target is the caller, we should not promote it.
define void @test_norecursive_inline() #0 !dbg !24 {
; CHECK-NOT: icmp
; CHECK: call
  %1 = load ptr, ptr @y, align 8
  call void %1(), !dbg !25
  ret void
}

define ptr @return_arg(ptr readnone returned) #0 !dbg !29{
  ret ptr %0
}

; CHECK-LABEL: @return_arg_caller
; When the promoted indirect call returns a parameter that was defined by the
; return value of a previous direct call. Checks both direct call and promoted
; indirect call are inlined.
define ptr @return_arg_caller(ptr nocapture) #0 !dbg !30{
; CHECK-NOT: call ptr @foo_inline1
; CHECK: if.true.direct_targ:
; CHECK-NOT: call
; CHECK: if.false.orig_indirect:
; CHECK: call
  %2 = call ptr @foo_inline1(ptr null), !dbg !31
  %cmp = icmp ne ptr %2, null
  br i1 %cmp, label %then, label %else

then:
  %3 = tail call ptr %0(ptr %2), !dbg !32
  ret ptr %3

else:
  ret ptr null
}

; CHECK-LABEL: @branch_prof_valid
; Check the conditional branch generated by indirect call promotion won't
; have invalid profile like !{!"branch_weights", i32 0, i32 0}.
define void @branch_prof_valid(ptr %t0) #0 !dbg !33 {
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = load ptr, ptr %t1
  ; CHECK-NOT: call {{.*}}
  ; CHECK: br i1 {{.*}}, label %if.true.direct_targ, label %if.false.orig_indirect, {{.*}}, !prof ![[BR3:[0-9]+]]
  call void %t2(), !dbg !34
  ret void
}

@x = global i32 0, align 4
@y = global ptr null, align 8

define ptr @foo_inline1(ptr %x) #0 !dbg !14 {
  ret ptr %x
}

define ptr @foo_inline_strip.suffix(ptr %x) #0 !dbg !15 {
  ret ptr %x
}

define ptr @foo_inline_strip_conflict.suffix1(ptr %x) #0 !dbg !16 {
  ret ptr %x
}

define ptr @foo_inline_strip_conflict.suffix2(ptr %x) #0 !dbg !17 {
  ret ptr %x
}

define ptr @foo_inline_strip_conflict.suffix3(ptr %x) #0 !dbg !18 {
  ret ptr %x
}

define ptr @foo_inline2(ptr %x) #0 !dbg !19 {
  ret ptr %x
}

define void @foo_inline3() #0 !dbg !35 {
  ret void
}

define i32 @foo_noinline(i32 %x) #0 !dbg !20 {
  ret i32 %x
}

define void @foo_direct() #0 !dbg !21 {
  ret void
}

define i32 @foo_direct_i32() #0 !dbg !28 {
  ret i32 0;
}

; CHECK-LABEL: @test_direct
; We should not promote a direct call.
define void @test_direct() #0 !dbg !22 {
; CHECK-NOT: icmp
; CHECK: call
  call void @foo_alias(), !dbg !23
  ret void
}

@foo_alias = alias void (), ptr @foo_direct

attributes #0 = {"use-sample-profile"}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1)
!1 = !DIFile(filename: "test.cc", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 3, unit: !0)
!4 = !DILocation(line: 4, scope: !3)
!5 = !DILocation(line: 6, scope: !3)
; CHECK: ![[PROF]] = !{!"VP", i32 0, i64 3457, i64 9191153033785521275, i64 2059, i64 -1069303473483922844, i64 1398}
; CHECK: ![[BR1]] = !{!"branch_weights", i32 4000, i32 4000}
; CHECK: ![[BR2]] = !{!"branch_weights", i32 3000, i32 1000}
; CHECK: ![[VP]] = !{!"VP", i32 0, i64 8000, i64 7476224446746900038, i64 -1, i64 925324185419832389, i64 -1, i64 -6391416044382067764, i64 1000}
; CHECK: ![[BR3]] = !{!"branch_weights", i32 1, i32 0}
!6 = distinct !DISubprogram(name: "test_inline", scope: !1, file: !1, line: 6, unit: !0)
!7 = !DILocation(line: 7, scope: !6)
!8 = distinct !DISubprogram(name: "test_inline_strip", scope: !1, file: !1, line: 8, unit: !0)
!9 = !DILocation(line: 9, scope: !8)
!10 = distinct !DISubprogram(name: "test_inline_strip_conflict", scope: !1, file: !1, line: 10, unit: !0)
!11 = !DILocation(line: 11, scope: !10)
!12 = distinct !DISubprogram(name: "test_noinline", scope: !1, file: !1, line: 12, unit: !0)
!13 = !DILocation(line: 13, scope: !12)
!14 = distinct !DISubprogram(name: "foo_inline1", scope: !1, file: !1, line: 11, unit: !0)
!15 = distinct !DISubprogram(name: "foo_inline_strip.suffix", scope: !1, file: !1, line: 1, unit: !0)
!16 = distinct !DISubprogram(name: "foo_inline_strip_conflict.suffix1", scope: !1, file: !1, line: 1, unit: !0)
!17 = distinct !DISubprogram(name: "foo_inline_strip_conflict.suffix2", scope: !1, file: !1, line: 1, unit: !0)
!18 = distinct !DISubprogram(name: "foo_inline_strip_conflict.suffix3", scope: !1, file: !1, line: 1, unit: !0)
!19 = distinct !DISubprogram(name: "foo_inline2", scope: !1, file: !1, line: 19, unit: !0)
!20 = distinct !DISubprogram(name: "foo_noinline", scope: !1, file: !1, line: 20, unit: !0)
!21 = distinct !DISubprogram(name: "foo_direct", scope: !1, file: !1, line: 21, unit: !0)
!22 = distinct !DISubprogram(name: "test_direct", scope: !1, file: !1, line: 22, unit: !0)
!23 = !DILocation(line: 23, scope: !22)
!24 = distinct !DISubprogram(name: "test_norecursive_inline", scope: !1, file: !1, line: 12, unit: !0)
!25 = !DILocation(line: 13, scope: !24)
!26 = distinct !DISubprogram(name: "test_noinline_bitcast", scope: !1, file: !1, line: 12, unit: !0)
!27 = !DILocation(line: 13, scope: !26)
!28 = distinct !DISubprogram(name: "foo_direct_i32", scope: !1, file: !1, line: 11, unit: !0)
!29 = distinct !DISubprogram(name: "return_arg", scope: !1, file: !1, line: 11, unit: !0)
!30 = distinct !DISubprogram(name: "return_arg_caller", scope: !1, file: !1, line: 11, unit: !0)
!31 = !DILocation(line: 12, scope: !30)
!32 = !DILocation(line: 13, scope: !30)
!33 = distinct !DISubprogram(name: "branch_prof_valid", scope: !1, file: !1, line: 25, unit: !0)
!34 = !DILocation(line: 27, scope: !33)
!35 = distinct !DISubprogram(name: "foo_inline3", scope: !1, file: !1, line: 29, unit: !0)