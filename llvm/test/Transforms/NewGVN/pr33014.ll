; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; Make sure we don't end up in an infinite recursion in singleReachablePHIPath().
; RUN: opt < %s -passes=newgvn -S | FileCheck %s

@c = external global i64, align 8


define void @tinkywinky(i1 %arg) {
; CHECK-LABEL: define void @tinkywinky(i1 %arg) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 %arg, label [[L2:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       ph:
; CHECK-NEXT:    br label [[FOR_BODY]]
; CHECK:       for.body:
; CHECK-NEXT:    br i1 %arg, label [[ONTRUE:%.*]], label [[ONFALSE:%.*]]
; CHECK:       onfalse:
; CHECK-NEXT:    [[PATATINO:%.*]] = load i64, ptr @c, align 4
; CHECK-NEXT:    ret void
; CHECK:       ontrue:
; CHECK-NEXT:    [[DIPSY:%.*]] = load i64, ptr @c, align 4
; CHECK-NEXT:    br label [[PH:%.*]]
; CHECK:       back:
; CHECK-NEXT:    store i8 poison, ptr null, align 1
; CHECK-NEXT:    br label [[PH]]
; CHECK:       end:
; CHECK-NEXT:    ret void
; CHECK:       l2:
; CHECK-NEXT:    br i1 false, label [[BACK:%.*]], label [[END:%.*]]
;
entry:
  br i1 %arg, label %l2, label %if.then
if.then:
  br label %for.body
ph:
  br label %for.body
for.body:
  br i1 %arg, label %ontrue, label %onfalse
onfalse:
  %patatino = load i64, ptr @c
  store i64 %patatino, ptr @c
  ret void
ontrue:
  %dipsy = load i64, ptr @c
  store i64 %dipsy, ptr @c
  br label %ph
back:
  br label %ph
end:
  ret void
l2:
  br i1 false, label %back, label %end
}