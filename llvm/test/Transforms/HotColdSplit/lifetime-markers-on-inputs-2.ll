; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=hotcoldsplit -hotcoldsplit-threshold=0 < %s 2>&1 | FileCheck %s

declare void @llvm.lifetime.start.p0(i64, ptr nocapture)

declare void @llvm.lifetime.end.p0(i64, ptr nocapture)

declare void @cold_use(ptr) cold

declare void @use(ptr)

; In this CFG, splitting will extract the blocks extract{1,2}. I.e., it will
; extract a lifetime.start marker, but not the corresponding lifetime.end
; marker. Make sure that a lifetime.start marker is emitted before the call to
; the split function, and *only* that marker.
;
;            entry
;          /       \
;      extract1  no-extract1
;     (lt.start)    |
;    /              |
; extract2          |
;    \_____         |
;          \      /
;            exit
;          (lt.end)
;
; After splitting, we should see:
;
;            entry
;          /       \
;      codeRepl  no-extract1
;     (lt.start)   |
;          \      /
;            exit
;          (lt.end)
define void @only_lifetime_start_is_cold(i1 %arg) {
; CHECK-LABEL: @only_lifetime_start_is_cold(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL1:%.*]] = alloca i256, align 8
; CHECK-NEXT:    br i1 [[ARG:%.*]], label [[CODEREPL:%.*]], label [[NO_EXTRACT1:%.*]]
; CHECK:       codeRepl:
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 -1, ptr [[LOCAL1]])
; CHECK-NEXT:    [[TARGETBLOCK:%.*]] = call i1 @only_lifetime_start_is_cold.cold.1(ptr [[LOCAL1]], i1 [[ARG]]) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    br i1 [[TARGETBLOCK]], label [[NO_EXTRACT1]], label [[EXIT:%.*]]
; CHECK:       no-extract1:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 1, ptr [[LOCAL1]])
; CHECK-NEXT:    ret void
;
entry:
  %local1 = alloca i256
  br i1 %arg, label %extract1, label %no-extract1

extract1:
  ; lt.start
  call void @llvm.lifetime.start.p0(i64 1, ptr %local1)
  call void @cold_use(ptr %local1)
  br i1 %arg, label %extract2, label %no-extract1

extract2:
  br label %exit

no-extract1:
  br label %exit

exit:
  ; lt.end
  call void @llvm.lifetime.end.p0(i64 1, ptr %local1)
  ret void
}

; In this CFG, splitting will extract the block extract1. I.e., it will extract
; a lifetime.end marker, but not the corresponding lifetime.start marker. Do
; not emit a lifetime.end marker after the call to the split function.
;
;            entry
;         (lt.start)
;        /          \
;   no-extract1  extract1
;    (lt.end)    (lt.end)
;        \         /
;            exit
;
; After splitting, we should see:
;
;            entry
;         (lt.start)
;        /          \
;   no-extract1  codeRepl
;    (lt.end)
;        \         /
;            exit
define void @only_lifetime_end_is_cold(i1 %arg) {
; CHECK-LABEL: @only_lifetime_end_is_cold(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL1:%.*]] = alloca i256, align 8
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 1, ptr [[LOCAL1]])
; CHECK-NEXT:    br i1 [[ARG:%.*]], label [[NO_EXTRACT1:%.*]], label [[CODEREPL:%.*]]
; CHECK:       no-extract1:
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 1, ptr [[LOCAL1]])
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       codeRepl:
; CHECK-NEXT:    call void @only_lifetime_end_is_cold.cold.1(ptr [[LOCAL1]]) #[[ATTR3]]
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  ; lt.start
  %local1 = alloca i256
  call void @llvm.lifetime.start.p0(i64 1, ptr %local1)
  br i1 %arg, label %no-extract1, label %extract1

no-extract1:
  ; lt.end
  call void @llvm.lifetime.end.p0(i64 1, ptr %local1)
  br label %exit

extract1:
  ; lt.end
  call void @cold_use(ptr %local1)
  call void @llvm.lifetime.end.p0(i64 1, ptr %local1)
  br label %exit

exit:
  ret void
}

; In this CFG, splitting will extract the blocks extract{1,2,3}. Lifting the
; lifetime.end marker would be a miscompile.
define void @do_not_lift_lifetime_end(i1 %arg) {
; CHECK-LABEL: @do_not_lift_lifetime_end(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL1:%.*]] = alloca i256, align 8
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 1, ptr [[LOCAL1]])
; CHECK-NEXT:    br label [[HEADER:%.*]]
; CHECK:       header:
; CHECK-NEXT:    call void @use(ptr [[LOCAL1]])
; CHECK-NEXT:    br i1 [[ARG:%.*]], label [[EXIT:%.*]], label [[CODEREPL:%.*]]
; CHECK:       codeRepl:
; CHECK-NEXT:    [[TARGETBLOCK:%.*]] = call i1 @do_not_lift_lifetime_end.cold.1(ptr [[LOCAL1]], i1 [[ARG]]) #[[ATTR3]]
; CHECK-NEXT:    br i1 [[TARGETBLOCK]], label [[HEADER]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  ; lt.start
  %local1 = alloca i256
  call void @llvm.lifetime.start.p0(i64 1, ptr %local1)
  br label %header

header:
  ; If the lifetime.end marker is lifted, this use becomes dead the second time
  ; the header block is executed.
  call void @use(ptr %local1)
  br i1 %arg, label %exit, label %extract1

extract1:
  call void @cold_use(ptr %local1)
  br i1 %arg, label %extract2, label %extract3

extract2:
  ; Backedge.
  br label %header

extract3:
  ; lt.end
  call void @llvm.lifetime.end.p0(i64 1, ptr %local1)
  br label %exit

exit:
  ret void
}