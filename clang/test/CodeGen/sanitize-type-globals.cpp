// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --check-globals all --filter-out "attributes" --filter-out "attributes #" --version 5
// RUN: %clang_cc1 -triple x86_64-linux-gnu -emit-llvm -o - %s -fsanitize=type | FileCheck -check-prefix=CHECK %s

//.
// CHECK: @x = global %struct.CompleteS zeroinitializer, align 8
// CHECK: @xExtern = external global %struct.CompleteS, align 8
// CHECK: @y = external global %struct.S, align 1
// CHECK: @d = global %class.b zeroinitializer, align 1
// CHECK: @_ZN1b1eE = external global %class.a, align 1
// CHECK: @__tysan_shadow_memory_address = external global i64
// CHECK: @__tysan_app_memory_mask = external global i64
// CHECK: @__tysan_v1_Simple_20C_2b_2b_20TBAA = linkonce_odr constant { i64, i64, [16 x i8] } { i64 2, i64 0, [16 x i8] c"Simple C++ TBAA\00" }, comdat
// CHECK: @__tysan_v1_omnipotent_20char = linkonce_odr constant { i64, i64, ptr, i64, [16 x i8] } { i64 2, i64 1, ptr @__tysan_v1_Simple_20C_2b_2b_20TBAA, i64 0, [16 x i8] c"omnipotent char\00" }, comdat
// CHECK: @__tysan_v1_int = linkonce_odr constant { i64, i64, ptr, i64, [4 x i8] } { i64 2, i64 1, ptr @__tysan_v1_omnipotent_20char, i64 0, [4 x i8] c"int\00" }, comdat
// CHECK: @__tysan_v1_any_20pointer = linkonce_odr constant { i64, i64, ptr, i64, [12 x i8] } { i64 2, i64 1, ptr @__tysan_v1_omnipotent_20char, i64 0, [12 x i8] c"any pointer\00" }, comdat
// CHECK: @__tysan_v1_p1_20int = linkonce_odr constant { i64, i64, ptr, i64, [7 x i8] } { i64 2, i64 1, ptr @__tysan_v1_any_20pointer, i64 0, [7 x i8] c"p1 int\00" }, comdat
// CHECK: @__tysan_v1___ZTS9CompleteS = linkonce_odr constant { i64, i64, ptr, i64, ptr, i64, [15 x i8] } { i64 2, i64 2, ptr @__tysan_v1_int, i64 0, ptr @__tysan_v1_p1_20int, i64 8, [15 x i8] c"_ZTS9CompleteS\00" }, comdat
// CHECK: @__tysan_v1___ZTS1b = linkonce_odr constant { i64, i64, [7 x i8] } { i64 2, i64 0, [7 x i8] c"_ZTS1b\00" }, comdat
// CHECK: @llvm.used = appending global [8 x ptr] [ptr @tysan.module_ctor, ptr @__tysan_v1_Simple_20C_2b_2b_20TBAA, ptr @__tysan_v1_omnipotent_20char, ptr @__tysan_v1_int, ptr @__tysan_v1_any_20pointer, ptr @__tysan_v1_p1_20int, ptr @__tysan_v1___ZTS9CompleteS, ptr @__tysan_v1___ZTS1b], section "llvm.metadata"
// CHECK: @llvm.global_ctors = appending global [2 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @_GLOBAL__sub_I_sanitize_type_globals.cpp, ptr null }, { i32, ptr, ptr } { i32 0, ptr @tysan.module_ctor, ptr null }]
//.
struct CompleteS {
  int x;
  int *ptr;
};

void f(CompleteS *);
CompleteS x;
extern CompleteS xExtern;
// CHECK-LABEL: define dso_local void @_Z1gv(
// CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
// CHECK:  [[ENTRY:.*:]]
// CHECK:    call void @_Z1fP9CompleteS(ptr noundef @x)
// CHECK:    call void @_Z1fP9CompleteS(ptr noundef @xExtern)
// CHECK:    ret void
//
void g() {
  f(&x);
  f(&xExtern);
}

typedef struct S IncompleteS;
void f(IncompleteS *);
extern IncompleteS y;
// CHECK-LABEL: define dso_local void @_Z1hv(
// CHECK-SAME: ) #[[ATTR0]] {
// CHECK:  [[ENTRY:.*:]]
// CHECK:    call void @_Z1fP1S(ptr noundef @y)
// CHECK:    ret void
//
void h() { f(&y); }

class a;
class b {
public:
  using c = a;
  static c e;
  b(int, c & = e);
} d = 0;

//.
// CHECK: attributes #[[ATTR0]] = { mustprogress noinline nounwind optnone sanitize_type "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+cx8,+mmx,+sse,+sse2,+x87" }
// CHECK: attributes #[[ATTR1:[0-9]+]] = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+cx8,+mmx,+sse,+sse2,+x87" }
// CHECK: attributes #[[ATTR2:[0-9]+]] = { noinline nounwind sanitize_type "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+cx8,+mmx,+sse,+sse2,+x87" }
// CHECK: attributes #[[ATTR3:[0-9]+]] = { nounwind "target-features"="+cx8,+mmx,+sse,+sse2,+x87" }
// CHECK: attributes #[[ATTR4:[0-9]+]] = { nounwind }
//.
// CHECK: [[META0:![0-9]+]] = !{ptr @x, [[META1:![0-9]+]]}
// CHECK: [[META1]] = !{!"_ZTS9CompleteS", [[META2:![0-9]+]], i64 0, [[META5:![0-9]+]], i64 8}
// CHECK: [[META2]] = !{!"int", [[META3:![0-9]+]], i64 0}
// CHECK: [[META3]] = !{!"omnipotent char", [[META4:![0-9]+]], i64 0}
// CHECK: [[META4]] = !{!"Simple C++ TBAA"}
// CHECK: [[META5]] = !{!"p1 int", [[META6:![0-9]+]], i64 0}
// CHECK: [[META6]] = !{!"any pointer", [[META3]], i64 0}
// CHECK: [[META7:![0-9]+]] = !{ptr @d, [[META8:![0-9]+]]}
// CHECK: [[META8]] = !{!"_ZTS1b"}
// CHECK: [[META9:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
// CHECK: [[META10:![0-9]+]] = !{!"{{.*}}clang version {{.*}}"}
//.