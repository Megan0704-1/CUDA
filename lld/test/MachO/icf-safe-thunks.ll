; NOTE: Code has been autogenerated by utils/update_test_body.py
; REQUIRES: aarch64

; RUN: rm -rf %t && split-file %s %t

; RUN: llc -filetype=obj %t/a.ll -O3 -o %t/a.o -enable-machine-outliner=never -mtriple arm64-apple-macos -addrsig
; RUN: %lld -arch arm64 -lSystem --icf=safe_thunks -dylib -o %t/a.dylib -map %t/a.map %t/a.o
; RUN: llvm-objdump %t/a.dylib -d --macho | FileCheck %s --check-prefixes=CHECK-ARM64
; RUN: cat %t/a.map | FileCheck %s --check-prefixes=CHECK-ARM64-MAP

; CHECK-ARM64:        (__TEXT,__text) section
; CHECK-ARM64-NEXT:   _func_unique_1:
; CHECK-ARM64-NEXT:        mov {{.*}}, #0x1
;
; CHECK-ARM64:        _func_unique_2_canmerge:
; CHECK-ARM64-NEXT:   _func_2identical_v1:
; CHECK-ARM64-NEXT:        mov {{.*}}, #0x2
;
; CHECK-ARM64:        _func_3identical_v1:
; CHECK-ARM64-NEXT:        mov {{.*}}, #0x3
;
; CHECK-ARM64:        _func_3identical_v1_canmerge:
; CHECK-ARM64-NEXT:   _func_3identical_v2_canmerge:
; CHECK-ARM64-NEXT:   _func_3identical_v3_canmerge:
; CHECK-ARM64-NEXT:        mov {{.*}}, #0x21
;
; CHECK-ARM64:        _func_call_thunked_1_nomerge:
; CHECK-ARM64-NEXT:        stp	x29
;
; CHECK-ARM64:        _func_call_thunked_2_nomerge:
; CHECK-ARM64-NEXT:   _func_call_thunked_2_merge:
; CHECK-ARM64-NEXT:        stp	x29
;
; CHECK-ARM64:        _call_all_funcs:
; CHECK-ARM64-NEXT:        stp  x29
;
; CHECK-ARM64:        _take_func_addr:
; CHECK-ARM64-NEXT:        adr
;
; CHECK-ARM64:        _func_2identical_v2:
; CHECK-ARM64-NEXT:        b  _func_2identical_v1
; CHECK-ARM64-NEXT:   _func_3identical_v2:
; CHECK-ARM64-NEXT:        b  _func_3identical_v1
; CHECK-ARM64-NEXT:   _func_3identical_v3:
; CHECK-ARM64-NEXT:        b  _func_3identical_v1


; CHECK-ARM64-MAP:      0x00000010 [  2] _func_unique_1
; CHECK-ARM64-MAP-NEXT: 0x00000010 [  2] _func_2identical_v1
; CHECK-ARM64-MAP-NEXT: 0x00000000 [  2] _func_unique_2_canmerge
; CHECK-ARM64-MAP-NEXT: 0x00000010 [  2] _func_3identical_v1
; CHECK-ARM64-MAP-NEXT: 0x00000010 [  2] _func_3identical_v1_canmerge
; CHECK-ARM64-MAP-NEXT: 0x00000000 [  2] _func_3identical_v2_canmerge
; CHECK-ARM64-MAP-NEXT: 0x00000000 [  2] _func_3identical_v3_canmerge
; CHECK-ARM64-MAP-NEXT: 0x00000020 [  2] _func_call_thunked_1_nomerge
; CHECK-ARM64-MAP-NEXT: 0x00000020 [  2] _func_call_thunked_2_nomerge
; CHECK-ARM64-MAP-NEXT: 0x00000000 [  2] _func_call_thunked_2_merge
; CHECK-ARM64-MAP-NEXT: 0x00000034 [  2] _call_all_funcs
; CHECK-ARM64-MAP-NEXT: 0x00000050 [  2] _take_func_addr
; CHECK-ARM64-MAP-NEXT: 0x00000004 [  2] _func_2identical_v2
; CHECK-ARM64-MAP-NEXT: 0x00000004 [  2] _func_3identical_v2
; CHECK-ARM64-MAP-NEXT: 0x00000004 [  2] _func_3identical_v3

;--- a.cpp
#define ATTR __attribute__((noinline)) extern "C"
typedef unsigned long long ULL;

volatile char g_val = 0;
void *volatile g_ptr = 0;

ATTR void func_unique_1() { g_val = 1; }

ATTR void func_unique_2_canmerge() { g_val = 2; }

ATTR void func_2identical_v1() { g_val = 2; }

ATTR void func_2identical_v2() { g_val = 2; }

ATTR void func_3identical_v1() { g_val = 3; }

ATTR void func_3identical_v2() { g_val = 3; }

ATTR void func_3identical_v3() { g_val = 3; }

ATTR void func_3identical_v1_canmerge() { g_val = 33; }

ATTR void func_3identical_v2_canmerge() { g_val = 33; }

ATTR void func_3identical_v3_canmerge() { g_val = 33; }

ATTR void func_call_thunked_1_nomerge() {
    func_2identical_v1();
    g_val = 77;
}

ATTR void func_call_thunked_2_nomerge() {
    func_2identical_v2();
    g_val = 77;
}

ATTR void func_call_thunked_2_merge() {
    func_2identical_v2();
    g_val = 77;
}

ATTR void call_all_funcs() {
    func_unique_1();
    func_unique_2_canmerge();
    func_2identical_v1();
    func_2identical_v2();
    func_3identical_v1();
    func_3identical_v2();
    func_3identical_v3();
    func_3identical_v1_canmerge();
    func_3identical_v2_canmerge();
    func_3identical_v3_canmerge();
}

ATTR void take_func_addr() {
    g_ptr = (void*)func_unique_1;
    g_ptr = (void*)func_2identical_v1;
    g_ptr = (void*)func_2identical_v2;
    g_ptr = (void*)func_3identical_v1;
    g_ptr = (void*)func_3identical_v2;
    g_ptr = (void*)func_3identical_v3;
}

;--- gen
clang -target arm64-apple-macos11.0 -S -emit-llvm a.cpp -O3 -o -

;--- a.ll
; ModuleID = 'a.cpp'
source_filename = "a.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx11.0.0"

@g_val = global i8 0, align 1
@g_ptr = global ptr null, align 8

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_unique_1() #0 {
  store volatile i8 1, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_unique_2_canmerge() local_unnamed_addr #0 {
  store volatile i8 2, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_2identical_v1() #0 {
  store volatile i8 2, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_2identical_v2() #0 {
  store volatile i8 2, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_3identical_v1() #0 {
  store volatile i8 3, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_3identical_v2() #0 {
  store volatile i8 3, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_3identical_v3() #0 {
  store volatile i8 3, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_3identical_v1_canmerge() local_unnamed_addr #0 {
  store volatile i8 33, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_3identical_v2_canmerge() local_unnamed_addr #0 {
  store volatile i8 33, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @func_3identical_v3_canmerge() local_unnamed_addr #0 {
  store volatile i8 33, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp uwtable(sync)
define void @func_call_thunked_1_nomerge() local_unnamed_addr #1 {
  tail call void @func_2identical_v1()
  store volatile i8 77, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp uwtable(sync)
define void @func_call_thunked_2_nomerge() local_unnamed_addr #1 {
  tail call void @func_2identical_v2()
  store volatile i8 77, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp uwtable(sync)
define void @func_call_thunked_2_merge() local_unnamed_addr #1 {
  tail call void @func_2identical_v2()
  store volatile i8 77, ptr @g_val, align 1, !tbaa !4
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp uwtable(sync)
define void @call_all_funcs() local_unnamed_addr #1 {
  tail call void @func_unique_1()
  tail call void @func_unique_2_canmerge()
  tail call void @func_2identical_v1()
  tail call void @func_2identical_v2()
  tail call void @func_3identical_v1()
  tail call void @func_3identical_v2()
  tail call void @func_3identical_v3()
  tail call void @func_3identical_v1_canmerge()
  tail call void @func_3identical_v2_canmerge()
  tail call void @func_3identical_v3_canmerge()
  ret void
}

; Function Attrs: mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync)
define void @take_func_addr() local_unnamed_addr #0 {
  store volatile ptr @func_unique_1, ptr @g_ptr, align 8, !tbaa !7
  store volatile ptr @func_2identical_v1, ptr @g_ptr, align 8, !tbaa !7
  store volatile ptr @func_2identical_v2, ptr @g_ptr, align 8, !tbaa !7
  store volatile ptr @func_3identical_v1, ptr @g_ptr, align 8, !tbaa !7
  store volatile ptr @func_3identical_v2, ptr @g_ptr, align 8, !tbaa !7
  store volatile ptr @func_3identical_v3, ptr @g_ptr, align 8, !tbaa !7
  ret void
}

attributes #0 = { mustprogress nofree noinline norecurse nounwind ssp memory(readwrite, argmem: none) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress nofree noinline norecurse nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!5, !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!8, !8, i64 0}
!8 = !{!"any pointer", !5, i64 0}