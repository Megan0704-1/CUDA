// RUN: %clang_cc1 %s -fopenacc -verify

typedef struct IsComplete {
  struct S { int A; } CompositeMember;
  int ScalarMember;
  float ArrayMember[5];
  void *PointerMember;
} Complete;
void uses(int IntParam, short *PointerParam, float ArrayParam[5], Complete CompositeParam) {
  int LocalInt;
  short *LocalPointer;
  float LocalArray[5];
  Complete LocalComposite;
  // Check Appertainment:
#pragma acc parallel loop firstprivate(LocalInt)
  for (int i = 5; i < 10; ++i);
#pragma acc serial loop firstprivate(LocalInt)
  for (int i = 5; i < 10; ++i);
  // expected-error@+1{{OpenACC 'firstprivate' clause is not valid on 'kernels loop' directive}}
#pragma acc kernels loop firstprivate(LocalInt)
  for (int i = 5; i < 10; ++i);

  // Valid cases:
#pragma acc parallel loop firstprivate(LocalInt, LocalPointer, LocalArray)
  for (int i = 5; i < 10; ++i);
#pragma acc serial loop firstprivate(LocalArray[2:1])
  for (int i = 5; i < 10; ++i);

#pragma acc parallel loop firstprivate(LocalComposite.ScalarMember, LocalComposite.ScalarMember)
  for (int i = 5; i < 10; ++i);

  // expected-error@+1{{OpenACC variable is not a valid variable name, sub-array, array element, member of a composite variable, or composite variable member}}
#pragma acc serial loop firstprivate(1 + IntParam)
  for (int i = 5; i < 10; ++i);

  // expected-error@+1{{OpenACC variable is not a valid variable name, sub-array, array element, member of a composite variable, or composite variable member}}
#pragma acc serial loop firstprivate(+IntParam)
  for (int i = 5; i < 10; ++i);

  // expected-error@+1{{OpenACC sub-array length is unspecified and cannot be inferred because the subscripted value is not an array}}
#pragma acc parallel loop firstprivate(PointerParam[2:])
  for (int i = 5; i < 10; ++i);

  // expected-error@+1{{OpenACC sub-array specified range [2:5] would be out of the range of the subscripted array size of 5}}
#pragma acc serial loop firstprivate(ArrayParam[2:5])
  for (int i = 5; i < 10; ++i);

  // expected-error@+2{{OpenACC sub-array specified range [2:5] would be out of the range of the subscripted array size of 5}}
  // expected-error@+1{{OpenACC variable is not a valid variable name, sub-array, array element, member of a composite variable, or composite variable member}}
#pragma acc parallel loop firstprivate((float*)ArrayParam[2:5])
  for (int i = 5; i < 10; ++i);
  // expected-error@+1{{OpenACC variable is not a valid variable name, sub-array, array element, member of a composite variable, or composite variable member}}
#pragma acc serial loop firstprivate((float)ArrayParam[2])
  for (int i = 5; i < 10; ++i);
}