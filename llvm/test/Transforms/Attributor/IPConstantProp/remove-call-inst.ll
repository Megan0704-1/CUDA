; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC
; PR5596

; IPSCCP should propagate the 0 argument, eliminate the switch, and propagate
; the result.

; FIXME: Remove obsolete calls/instructions

define i32 @main() noreturn nounwind {
; TUNIT: Function Attrs: mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@main
; TUNIT-SAME: () #[[ATTR0:[0-9]+]] {
; TUNIT-NEXT:  entry:
; TUNIT-NEXT:    ret i32 123
;
; CGSCC: Function Attrs: mustprogress nofree noreturn nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@main
; CGSCC-SAME: () #[[ATTR0:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    [[CALL2:%.*]] = tail call noundef i32 @wwrite() #[[ATTR2:[0-9]+]]
; CGSCC-NEXT:    ret i32 [[CALL2]]
;
entry:
  %call2 = tail call i32 @wwrite(i64 0) nounwind
  ret i32 %call2
}

define internal i32 @wwrite(i64 %i) nounwind readnone {
; CGSCC: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@wwrite
; CGSCC-SAME: () #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  entry:
; CGSCC-NEXT:    switch i64 0, label [[SW_DEFAULT:%.*]] [
; CGSCC-NEXT:      i64 3, label [[RETURN:%.*]]
; CGSCC-NEXT:      i64 10, label [[RETURN]]
; CGSCC-NEXT:    ]
; CGSCC:       sw.default:
; CGSCC-NEXT:    ret i32 123
; CGSCC:       return:
; CGSCC-NEXT:    unreachable
;
entry:
  switch i64 %i, label %sw.default [
  i64 3, label %return
  i64 10, label %return
  ]

sw.default:
  ret i32 123

return:
  ret i32 0
}
;.
; TUNIT: attributes #[[ATTR0]] = { mustprogress nofree norecurse noreturn nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { mustprogress nofree noreturn nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR1]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR2]] = { nofree nosync nounwind willreturn }
;.
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}