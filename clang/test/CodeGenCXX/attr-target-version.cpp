// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --check-globals all --include-generated-funcs --global-value-regex ".*" --version 5
// RUN: %clang_cc1 -std=c++11 -triple aarch64-linux-gnu -emit-llvm %s -o - | FileCheck %s

int __attribute__((target_version("sme-f64f64+bf16"))) foo(int) { return 1; }
int __attribute__((target_version("default"))) foo(int) { return 2; }
int __attribute__((target_version("sm4+bf16"))) foo(void) { return 3; }
int __attribute__((target_version("default"))) foo(void) { return 4; }

struct MyClass {
  int __attribute__((target_version("dotprod"))) goo(int);
  int __attribute__((target_version("crc"))) goo(int);
  int __attribute__((target_version("default"))) goo(int);

  // This should generate one target version but no resolver.
  int __attribute__((target_version("default"))) unused_with_forward_default_decl(void);
  int __attribute__((target_version("mops"))) unused_with_forward_default_decl(void);

  // This should also generate one target version but no resolver.
  int unused_with_implicit_forward_default_decl(void);
  int __attribute__((target_version("dotprod"))) unused_with_implicit_forward_default_decl(void);

  // This should also generate one target version but no resolver.
  int __attribute__((target_version("aes"))) unused_with_default_decl(void);
  int __attribute__((target_version("default"))) unused_with_default_decl(void);

  // This should generate two target versions and the resolver.
  int __attribute__((target_version("sve"))) unused_with_default_def(void);
  int __attribute__((target_version("default"))) unused_with_default_def(void);

  // This should also generate two target versions and the resolver.
  int __attribute__((target_version("fp16"))) unused_with_implicit_default_def(void);
  int unused_with_implicit_default_def(void);

  // This should also generate two target versions and the resolver.
  int unused_with_implicit_forward_default_def(void);
  int __attribute__((target_version("lse"))) unused_with_implicit_forward_default_def(void);

  // This should generate a target version despite the default not being declared.
  int __attribute__((target_version("rdm"))) unused_without_default(void);
};

int __attribute__((target_version("default"))) MyClass::goo(int) { return 1; }
int __attribute__((target_version("crc"))) MyClass::goo(int) { return 2; }
int __attribute__((target_version("dotprod"))) MyClass::goo(int) { return 3; }

int __attribute__((target_version("mops"))) MyClass::unused_with_forward_default_decl(void) { return 0; }
int __attribute__((target_version("dotprod"))) MyClass::unused_with_implicit_forward_default_decl(void) { return 0; }
int __attribute__((target_version("aes"))) MyClass::unused_with_default_decl(void) { return 0; }
int __attribute__((target_version("sve"))) MyClass::unused_with_default_def(void) { return 0; }
int __attribute__((target_version("default"))) MyClass::unused_with_default_def(void) { return 1; }
int __attribute__((target_version("fp16"))) MyClass::unused_with_implicit_default_def(void) { return 0; }
int MyClass::unused_with_implicit_default_def(void) { return 1; }
int MyClass::unused_with_implicit_forward_default_def(void) { return 0; }
int __attribute__((target_version("lse"))) MyClass::unused_with_implicit_forward_default_def(void) { return 1; }
int __attribute__((target_version("rdm"))) MyClass::unused_without_default(void) { return 0; }

int bar() {
  MyClass m;
  return m.goo(1) + foo(1) + foo();
}

//.
// CHECK: @__aarch64_cpu_features = external dso_local global { i64 }
// CHECK: @_Z3fooi = weak_odr ifunc i32 (i32), ptr @_Z3fooi.resolver
// CHECK: @_Z3foov = weak_odr ifunc i32 (), ptr @_Z3foov.resolver
// CHECK: @_ZN7MyClass3gooEi = weak_odr ifunc i32 (ptr, i32), ptr @_ZN7MyClass3gooEi.resolver
// CHECK: @_ZN7MyClass23unused_with_default_defEv = weak_odr ifunc i32 (ptr), ptr @_ZN7MyClass23unused_with_default_defEv.resolver
// CHECK: @_ZN7MyClass32unused_with_implicit_default_defEv = weak_odr ifunc i32 (ptr), ptr @_ZN7MyClass32unused_with_implicit_default_defEv.resolver
// CHECK: @_ZN7MyClass40unused_with_implicit_forward_default_defEv = weak_odr ifunc i32 (ptr), ptr @_ZN7MyClass40unused_with_implicit_forward_default_defEv.resolver
//.
// CHECK-LABEL: define dso_local noundef i32 @_Z3fooi._Mbf16Msme-f64f64(
// CHECK-SAME: i32 noundef [[TMP0:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[DOTADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[TMP0]], ptr [[DOTADDR]], align 4
// CHECK-NEXT:    ret i32 1
//
//
// CHECK-LABEL: define dso_local noundef i32 @_Z3fooi.default(
// CHECK-SAME: i32 noundef [[TMP0:%.*]]) #[[ATTR1:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[DOTADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[TMP0]], ptr [[DOTADDR]], align 4
// CHECK-NEXT:    ret i32 2
//
//
// CHECK-LABEL: define dso_local noundef i32 @_Z3foov._Mbf16Msm4(
// CHECK-SAME: ) #[[ATTR2:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    ret i32 3
//
//
// CHECK-LABEL: define dso_local noundef i32 @_Z3foov.default(
// CHECK-SAME: ) #[[ATTR1]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    ret i32 4
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass3gooEi.default(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]], i32 noundef [[TMP0:%.*]]) #[[ATTR1]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    store i32 [[TMP0]], ptr [[DOTADDR]], align 4
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 1
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass3gooEi._Mcrc(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]], i32 noundef [[TMP0:%.*]]) #[[ATTR3:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    store i32 [[TMP0]], ptr [[DOTADDR]], align 4
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 2
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass3gooEi._Mdotprod(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]], i32 noundef [[TMP0:%.*]]) #[[ATTR4:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    store i32 [[TMP0]], ptr [[DOTADDR]], align 4
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 3
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass32unused_with_forward_default_declEv._Mmops(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR5:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass41unused_with_implicit_forward_default_declEv._Mdotprod(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR4]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass24unused_with_default_declEv._Maes(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR6:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass23unused_with_default_defEv._Msve(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR7:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass23unused_with_default_defEv.default(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR1]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 1
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass32unused_with_implicit_default_defEv._Mfp16(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR8:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass32unused_with_implicit_default_defEv.default(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR1]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 1
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass40unused_with_implicit_forward_default_defEv.default(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR1]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass40unused_with_implicit_forward_default_defEv._Mlse(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR9:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 1
//
//
// CHECK-LABEL: define dso_local noundef i32 @_ZN7MyClass22unused_without_defaultEv._Mrdm(
// CHECK-SAME: ptr noundef nonnull align 1 dereferenceable(1) [[THIS:%.*]]) #[[ATTR10:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[THIS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[THIS]], ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    [[THIS1:%.*]] = load ptr, ptr [[THIS_ADDR]], align 8
// CHECK-NEXT:    ret i32 0
//
//
// CHECK-LABEL: define dso_local noundef i32 @_Z3barv(
// CHECK-SAME: ) #[[ATTR11:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    [[M:%.*]] = alloca [[STRUCT_MYCLASS:%.*]], align 1
// CHECK-NEXT:    [[CALL:%.*]] = call noundef i32 @_ZN7MyClass3gooEi(ptr noundef nonnull align 1 dereferenceable(1) [[M]], i32 noundef 1)
// CHECK-NEXT:    [[CALL1:%.*]] = call noundef i32 @_Z3fooi(i32 noundef 1)
// CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[CALL]], [[CALL1]]
// CHECK-NEXT:    [[CALL2:%.*]] = call noundef i32 @_Z3foov()
// CHECK-NEXT:    [[ADD3:%.*]] = add nsw i32 [[ADD]], [[CALL2]]
// CHECK-NEXT:    ret i32 [[ADD3]]
//
//
// CHECK-LABEL: define weak_odr ptr @_Z3fooi.resolver() comdat {
// CHECK-NEXT:  [[RESOLVER_ENTRY:.*:]]
// CHECK-NEXT:    call void @__init_cpu_features_resolver()
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 36033195199759104
// CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 36033195199759104
// CHECK-NEXT:    [[TMP3:%.*]] = and i1 true, [[TMP2]]
// CHECK-NEXT:    br i1 [[TMP3]], label %[[RESOLVER_RETURN:.*]], label %[[RESOLVER_ELSE:.*]]
// CHECK:       [[RESOLVER_RETURN]]:
// CHECK-NEXT:    ret ptr @_Z3fooi._Mbf16Msme-f64f64
// CHECK:       [[RESOLVER_ELSE]]:
// CHECK-NEXT:    ret ptr @_Z3fooi.default
//
//
// CHECK-LABEL: define weak_odr ptr @_Z3foov.resolver() comdat {
// CHECK-NEXT:  [[RESOLVER_ENTRY:.*:]]
// CHECK-NEXT:    call void @__init_cpu_features_resolver()
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 134218528
// CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 134218528
// CHECK-NEXT:    [[TMP3:%.*]] = and i1 true, [[TMP2]]
// CHECK-NEXT:    br i1 [[TMP3]], label %[[RESOLVER_RETURN:.*]], label %[[RESOLVER_ELSE:.*]]
// CHECK:       [[RESOLVER_RETURN]]:
// CHECK-NEXT:    ret ptr @_Z3foov._Mbf16Msm4
// CHECK:       [[RESOLVER_ELSE]]:
// CHECK-NEXT:    ret ptr @_Z3foov.default
//
//
// CHECK-LABEL: define weak_odr ptr @_ZN7MyClass3gooEi.resolver() comdat {
// CHECK-NEXT:  [[RESOLVER_ENTRY:.*:]]
// CHECK-NEXT:    call void @__init_cpu_features_resolver()
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 1024
// CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 1024
// CHECK-NEXT:    [[TMP3:%.*]] = and i1 true, [[TMP2]]
// CHECK-NEXT:    br i1 [[TMP3]], label %[[RESOLVER_RETURN:.*]], label %[[RESOLVER_ELSE:.*]]
// CHECK:       [[RESOLVER_RETURN]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass3gooEi._Mcrc
// CHECK:       [[RESOLVER_ELSE]]:
// CHECK-NEXT:    [[TMP4:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP5:%.*]] = and i64 [[TMP4]], 784
// CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i64 [[TMP5]], 784
// CHECK-NEXT:    [[TMP7:%.*]] = and i1 true, [[TMP6]]
// CHECK-NEXT:    br i1 [[TMP7]], label %[[RESOLVER_RETURN1:.*]], label %[[RESOLVER_ELSE2:.*]]
// CHECK:       [[RESOLVER_RETURN1]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass3gooEi._Mdotprod
// CHECK:       [[RESOLVER_ELSE2]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass3gooEi.default
//
//
// CHECK-LABEL: define weak_odr ptr @_ZN7MyClass23unused_with_default_defEv.resolver() comdat {
// CHECK-NEXT:  [[RESOLVER_ENTRY:.*:]]
// CHECK-NEXT:    call void @__init_cpu_features_resolver()
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 1073807616
// CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 1073807616
// CHECK-NEXT:    [[TMP3:%.*]] = and i1 true, [[TMP2]]
// CHECK-NEXT:    br i1 [[TMP3]], label %[[RESOLVER_RETURN:.*]], label %[[RESOLVER_ELSE:.*]]
// CHECK:       [[RESOLVER_RETURN]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass23unused_with_default_defEv._Msve
// CHECK:       [[RESOLVER_ELSE]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass23unused_with_default_defEv.default
//
//
// CHECK-LABEL: define weak_odr ptr @_ZN7MyClass32unused_with_implicit_default_defEv.resolver() comdat {
// CHECK-NEXT:  [[RESOLVER_ENTRY:.*:]]
// CHECK-NEXT:    call void @__init_cpu_features_resolver()
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 65792
// CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 65792
// CHECK-NEXT:    [[TMP3:%.*]] = and i1 true, [[TMP2]]
// CHECK-NEXT:    br i1 [[TMP3]], label %[[RESOLVER_RETURN:.*]], label %[[RESOLVER_ELSE:.*]]
// CHECK:       [[RESOLVER_RETURN]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass32unused_with_implicit_default_defEv._Mfp16
// CHECK:       [[RESOLVER_ELSE]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass32unused_with_implicit_default_defEv.default
//
//
// CHECK-LABEL: define weak_odr ptr @_ZN7MyClass40unused_with_implicit_forward_default_defEv.resolver() comdat {
// CHECK-NEXT:  [[RESOLVER_ENTRY:.*:]]
// CHECK-NEXT:    call void @__init_cpu_features_resolver()
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__aarch64_cpu_features, align 8
// CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], 128
// CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 128
// CHECK-NEXT:    [[TMP3:%.*]] = and i1 true, [[TMP2]]
// CHECK-NEXT:    br i1 [[TMP3]], label %[[RESOLVER_RETURN:.*]], label %[[RESOLVER_ELSE:.*]]
// CHECK:       [[RESOLVER_RETURN]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass40unused_with_implicit_forward_default_defEv._Mlse
// CHECK:       [[RESOLVER_ELSE]]:
// CHECK-NEXT:    ret ptr @_ZN7MyClass40unused_with_implicit_forward_default_defEv.default
//
//.
// CHECK: [[META0:![0-9]+]] = !{i32 1, !"wchar_size", i32 4}
// CHECK: [[META1:![0-9]+]] = !{!"{{.*}}clang version {{.*}}"}
//.