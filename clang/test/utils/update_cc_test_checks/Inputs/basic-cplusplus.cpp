// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --include-generated-funcs --version 5
// Basic C++ test for update_cc_test_checks
// RUN: %clang_cc1 -triple=x86_64-unknown-linux-gnu -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple=x86_64-apple-macho -emit-llvm -o - %s | FileCheck %s --check-prefix=MACHO
// RUN: %clang_cc1 -triple=x86_64-windows-msvc -emit-llvm -o - %s | FileCheck %s --check-prefix=MSVC
// RUN: %clang_cc1 -triple=x86_64-windows-gnu -emit-llvm -o - %s | FileCheck %s --check-prefix=MINGW

class Foo {
  int x;

public:
  explicit Foo(int x);
  ~Foo();
  inline int function_defined_inline(int arg) const {
    return arg + x;
  }
  inline int function_defined_out_of_line(int arg) const;
};

[[clang::noinline]] static int static_noinline_fn(int arg) { return arg; }

Foo::Foo(int x) : x(x) {}
Foo::~Foo() {}
int Foo::function_defined_out_of_line(int arg) const { return x - arg; }

// Call the inline methods to ensure the LLVM IR is generated:
int main() {
  Foo f(1);
  f.function_defined_inline(2);
  f.function_defined_out_of_line(3);
  return static_noinline_fn(0);
}