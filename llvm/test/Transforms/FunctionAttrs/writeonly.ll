; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt -passes=function-attrs -S < %s | FileCheck --check-prefixes=COMMON,FNATTRS %s
; RUN: opt -passes=attributor-light -S < %s | FileCheck --check-prefixes=COMMON,ATTRIBUTOR %s

define void @nouses-argworn-funrn(ptr writeonly %.aaa) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; FNATTRS-LABEL: define {{[^@]+}}@nouses-argworn-funrn
; FNATTRS-SAME: (ptr nocapture readnone [[DOTAAA:%.*]]) #[[ATTR0:[0-9]+]] {
; FNATTRS-NEXT:  nouses-argworn-funrn_entry:
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@nouses-argworn-funrn
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[DOTAAA:%.*]]) #[[ATTR0:[0-9]+]] {
; ATTRIBUTOR-NEXT:  nouses-argworn-funrn_entry:
; ATTRIBUTOR-NEXT:    ret void
;
nouses-argworn-funrn_entry:
  ret void
}

define void @nouses-argworn-funro(ptr writeonly %.aaa, ptr %.bbb) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read)
; FNATTRS-LABEL: define {{[^@]+}}@nouses-argworn-funro
; FNATTRS-SAME: (ptr nocapture readnone [[DOTAAA:%.*]], ptr nocapture readonly [[DOTBBB:%.*]]) #[[ATTR1:[0-9]+]] {
; FNATTRS-NEXT:  nouses-argworn-funro_entry:
; FNATTRS-NEXT:    [[VAL:%.*]] = load i32, ptr [[DOTBBB]], align 4
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@nouses-argworn-funro
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[DOTAAA:%.*]], ptr nocapture nofree nonnull readonly [[DOTBBB:%.*]]) #[[ATTR1:[0-9]+]] {
; ATTRIBUTOR-NEXT:  nouses-argworn-funro_entry:
; ATTRIBUTOR-NEXT:    [[VAL:%.*]] = load i32, ptr [[DOTBBB]], align 4
; ATTRIBUTOR-NEXT:    ret void
;
nouses-argworn-funro_entry:
  %val = load i32 , ptr %.bbb
  ret void
}

%_type_of_d-ccc = type <{ ptr, i8, i8, i8, i8 }>

@d-ccc = internal global %_type_of_d-ccc <{ ptr null, i8 1, i8 13, i8 0, i8 -127 }>, align 8

define void @nouses-argworn-funwo(ptr writeonly %.aaa) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write, argmem: none, inaccessiblemem: none)
; FNATTRS-LABEL: define {{[^@]+}}@nouses-argworn-funwo
; FNATTRS-SAME: (ptr nocapture readnone [[DOTAAA:%.*]]) #[[ATTR2:[0-9]+]] {
; FNATTRS-NEXT:  nouses-argworn-funwo_entry:
; FNATTRS-NEXT:    store i8 0, ptr getelementptr inbounds ([[_TYPE_OF_D_CCC:%.*]], ptr @d-ccc, i32 0, i32 3), align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(write)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@nouses-argworn-funwo
; ATTRIBUTOR-SAME: (ptr nocapture nofree readnone [[DOTAAA:%.*]]) #[[ATTR2:[0-9]+]] {
; ATTRIBUTOR-NEXT:  nouses-argworn-funwo_entry:
; ATTRIBUTOR-NEXT:    store i8 0, ptr getelementptr inbounds ([[_TYPE_OF_D_CCC:%.*]], ptr @d-ccc, i32 0, i32 3), align 1
; ATTRIBUTOR-NEXT:    ret void
;
nouses-argworn-funwo_entry:
  store i8 0, ptr getelementptr inbounds (%_type_of_d-ccc, ptr @d-ccc, i32 0, i32 3)
  ret void
}

define void @test_store(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; FNATTRS-LABEL: define {{[^@]+}}@test_store
; FNATTRS-SAME: (ptr nocapture writeonly initializes((0, 1)) [[P:%.*]]) #[[ATTR3:[0-9]+]] {
; FNATTRS-NEXT:    store i8 0, ptr [[P]], align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_store
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull writeonly [[P:%.*]]) #[[ATTR3:[0-9]+]] {
; ATTRIBUTOR-NEXT:    store i8 0, ptr [[P]], align 1
; ATTRIBUTOR-NEXT:    ret void
;
  store i8 0, ptr %p
  ret void
}

@G = external global ptr
define i8 @test_store_capture(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: read, inaccessiblemem: none)
; FNATTRS-LABEL: define {{[^@]+}}@test_store_capture
; FNATTRS-SAME: (ptr [[P:%.*]]) #[[ATTR4:[0-9]+]] {
; FNATTRS-NEXT:    store ptr [[P]], ptr @G, align 8
; FNATTRS-NEXT:    [[P2:%.*]] = load ptr, ptr @G, align 8
; FNATTRS-NEXT:    [[V:%.*]] = load i8, ptr [[P2]], align 1
; FNATTRS-NEXT:    ret i8 [[V]]
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_store_capture
; ATTRIBUTOR-SAME: (ptr nofree [[P:%.*]]) #[[ATTR4:[0-9]+]] {
; ATTRIBUTOR-NEXT:    store ptr [[P]], ptr @G, align 8
; ATTRIBUTOR-NEXT:    [[P2:%.*]] = load ptr, ptr @G, align 8
; ATTRIBUTOR-NEXT:    [[V:%.*]] = load i8, ptr [[P2]], align 1
; ATTRIBUTOR-NEXT:    ret i8 [[V]]
;
  store ptr %p, ptr @G
  %p2 = load ptr, ptr @G
  %v = load i8, ptr %p2
  ret i8 %v
}

define void @test_addressing(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; FNATTRS-LABEL: define {{[^@]+}}@test_addressing
; FNATTRS-SAME: (ptr nocapture writeonly initializes((8, 12)) [[P:%.*]]) #[[ATTR3]] {
; FNATTRS-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[P]], i64 8
; FNATTRS-NEXT:    store i32 0, ptr [[GEP]], align 4
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_addressing
; ATTRIBUTOR-SAME: (ptr nocapture nofree writeonly [[P:%.*]]) #[[ATTR3]] {
; ATTRIBUTOR-NEXT:    [[GEP:%.*]] = getelementptr i8, ptr [[P]], i64 8
; ATTRIBUTOR-NEXT:    store i32 0, ptr [[GEP]], align 4
; ATTRIBUTOR-NEXT:    ret void
;
  %gep = getelementptr i8, ptr %p, i64 8
  store i32 0, ptr %gep
  ret void
}

define void @test_readwrite(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
; FNATTRS-LABEL: define {{[^@]+}}@test_readwrite
; FNATTRS-SAME: (ptr nocapture [[P:%.*]]) #[[ATTR5:[0-9]+]] {
; FNATTRS-NEXT:    [[V:%.*]] = load i8, ptr [[P]], align 1
; FNATTRS-NEXT:    store i8 [[V]], ptr [[P]], align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_readwrite
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[P:%.*]]) #[[ATTR5:[0-9]+]] {
; ATTRIBUTOR-NEXT:    [[V:%.*]] = load i8, ptr [[P]], align 1
; ATTRIBUTOR-NEXT:    store i8 [[V]], ptr [[P]], align 1
; ATTRIBUTOR-NEXT:    ret void
;
  %v = load i8, ptr %p
  store i8 %v, ptr %p
  ret void
}

define void @test_volatile(ptr %p) {
; FNATTRS: Function Attrs: nofree norecurse nounwind memory(argmem: readwrite, inaccessiblemem: readwrite)
; FNATTRS-LABEL: define {{[^@]+}}@test_volatile
; FNATTRS-SAME: (ptr [[P:%.*]]) #[[ATTR6:[0-9]+]] {
; FNATTRS-NEXT:    store volatile i8 0, ptr [[P]], align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_volatile
; ATTRIBUTOR-SAME: (ptr nofree [[P:%.*]]) #[[ATTR6:[0-9]+]] {
; ATTRIBUTOR-NEXT:    store volatile i8 0, ptr [[P]], align 1
; ATTRIBUTOR-NEXT:    ret void
;
  store volatile i8 0, ptr %p
  ret void
}

define void @test_atomicrmw(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; FNATTRS-LABEL: define {{[^@]+}}@test_atomicrmw
; FNATTRS-SAME: (ptr nocapture [[P:%.*]]) #[[ATTR7:[0-9]+]] {
; FNATTRS-NEXT:    [[TMP1:%.*]] = atomicrmw add ptr [[P]], i8 0 seq_cst, align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_atomicrmw
; ATTRIBUTOR-SAME: (ptr nocapture nofree nonnull [[P:%.*]]) #[[ATTR6]] {
; ATTRIBUTOR-NEXT:    [[TMP1:%.*]] = atomicrmw add ptr [[P]], i8 0 seq_cst, align 1
; ATTRIBUTOR-NEXT:    ret void
;
  atomicrmw add ptr %p, i8 0  seq_cst
  ret void
}

define void @test_ptrmask(ptr %p) {
; FNATTRS: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; FNATTRS-LABEL: define {{[^@]+}}@test_ptrmask
; FNATTRS-SAME: (ptr writeonly [[P:%.*]]) #[[ATTR3]] {
; FNATTRS-NEXT:    [[MASK:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P]], i64 -5)
; FNATTRS-NEXT:    store i8 0, ptr [[MASK]], align 1
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_ptrmask
; ATTRIBUTOR-SAME: (ptr nofree writeonly [[P:%.*]]) #[[ATTR3]] {
; ATTRIBUTOR-NEXT:    [[MASK:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[P]], i64 -5) #[[ATTR9:[0-9]+]]
; ATTRIBUTOR-NEXT:    store i8 0, ptr [[MASK]], align 1
; ATTRIBUTOR-NEXT:    ret void
;
  %mask = call ptr @llvm.ptrmask.p0.i64(ptr %p, i64 -5)
  store i8 0, ptr %mask
  ret void
}

declare ptr @llvm.ptrmask.p0.i64(ptr, i64)

declare void @direct1_callee(ptr %p)

define void @direct1(ptr %p) {
; COMMON-LABEL: define {{[^@]+}}@direct1
; COMMON-SAME: (ptr [[P:%.*]]) {
; COMMON-NEXT:    call void @direct1_callee(ptr [[P]])
; COMMON-NEXT:    ret void
;
  call void @direct1_callee(ptr %p)
  ret void
}

declare void @direct2_callee(ptr %p) writeonly

; writeonly w/o nocapture is not enough
define void @direct2(ptr %p) {
; FNATTRS: Function Attrs: memory(write)
; FNATTRS-LABEL: define {{[^@]+}}@direct2
; FNATTRS-SAME: (ptr [[P:%.*]]) #[[ATTR9:[0-9]+]] {
; FNATTRS-NEXT:    call void @direct2_callee(ptr [[P]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: memory(write)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@direct2
; ATTRIBUTOR-SAME: (ptr writeonly [[P:%.*]]) #[[ATTR8:[0-9]+]] {
; ATTRIBUTOR-NEXT:    call void @direct2_callee(ptr [[P]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @direct2_callee(ptr %p)
  ; read back from global, read through pointer...
  ret void
}

define void @direct2b(ptr %p) {
; FNATTRS: Function Attrs: memory(write)
; FNATTRS-LABEL: define {{[^@]+}}@direct2b
; FNATTRS-SAME: (ptr nocapture writeonly [[P:%.*]]) #[[ATTR9]] {
; FNATTRS-NEXT:    call void @direct2_callee(ptr nocapture [[P]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: memory(write)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@direct2b
; ATTRIBUTOR-SAME: (ptr nocapture writeonly [[P:%.*]]) #[[ATTR8]] {
; ATTRIBUTOR-NEXT:    call void @direct2_callee(ptr nocapture writeonly [[P]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @direct2_callee(ptr nocapture %p)
  ret void
}

declare void @direct3_callee(ptr nocapture writeonly %p)

define void @direct3(ptr %p) {
; FNATTRS-LABEL: define {{[^@]+}}@direct3
; FNATTRS-SAME: (ptr nocapture writeonly [[P:%.*]]) {
; FNATTRS-NEXT:    call void @direct3_callee(ptr [[P]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define {{[^@]+}}@direct3
; ATTRIBUTOR-SAME: (ptr nocapture writeonly [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    call void @direct3_callee(ptr nocapture writeonly [[P]])
; ATTRIBUTOR-NEXT:    ret void
;
  call void @direct3_callee(ptr %p)
  ret void
}

define void @direct3b(ptr %p) {
; COMMON-LABEL: define {{[^@]+}}@direct3b
; COMMON-SAME: (ptr [[P:%.*]]) {
; COMMON-NEXT:    call void @direct3_callee(ptr [[P]]) [ "may-read-and-capture"(ptr [[P]]) ]
; COMMON-NEXT:    ret void
;
  call void @direct3_callee(ptr %p) ["may-read-and-capture"(ptr %p)]
  ret void
}

define void @direct3c(ptr %p) {
; FNATTRS-LABEL: define {{[^@]+}}@direct3c
; FNATTRS-SAME: (ptr nocapture [[P:%.*]]) {
; FNATTRS-NEXT:    call void @direct3_callee(ptr [[P]]) [ "may-read"() ]
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define {{[^@]+}}@direct3c
; ATTRIBUTOR-SAME: (ptr nocapture [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    call void @direct3_callee(ptr nocapture [[P]]) [ "may-read"() ]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @direct3_callee(ptr %p) ["may-read"()]
  ret void
}

define void @fptr_test1(ptr %p, ptr %f) {
; FNATTRS-LABEL: define {{[^@]+}}@fptr_test1
; FNATTRS-SAME: (ptr [[P:%.*]], ptr nocapture readonly [[F:%.*]]) {
; FNATTRS-NEXT:    call void [[F]](ptr [[P]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define {{[^@]+}}@fptr_test1
; ATTRIBUTOR-SAME: (ptr [[P:%.*]], ptr nocapture nofree nonnull [[F:%.*]]) {
; ATTRIBUTOR-NEXT:    call void [[F]](ptr [[P]])
; ATTRIBUTOR-NEXT:    ret void
;
  call void %f(ptr %p)
  ret void
}

define void @fptr_test2(ptr %p, ptr %f) {
; FNATTRS-LABEL: define {{[^@]+}}@fptr_test2
; FNATTRS-SAME: (ptr nocapture writeonly [[P:%.*]], ptr nocapture readonly [[F:%.*]]) {
; FNATTRS-NEXT:    call void [[F]](ptr nocapture writeonly [[P]])
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define {{[^@]+}}@fptr_test2
; ATTRIBUTOR-SAME: (ptr nocapture [[P:%.*]], ptr nocapture nofree nonnull [[F:%.*]]) {
; ATTRIBUTOR-NEXT:    call void [[F]](ptr nocapture writeonly [[P]])
; ATTRIBUTOR-NEXT:    ret void
;
  call void %f(ptr nocapture writeonly %p)
  ret void
}

define void @fptr_test3(ptr %p, ptr %f) {
; FNATTRS: Function Attrs: memory(write)
; FNATTRS-LABEL: define {{[^@]+}}@fptr_test3
; FNATTRS-SAME: (ptr nocapture writeonly [[P:%.*]], ptr nocapture readonly [[F:%.*]]) #[[ATTR9]] {
; FNATTRS-NEXT:    call void [[F]](ptr nocapture [[P]]) #[[ATTR9]]
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR: Function Attrs: memory(write)
; ATTRIBUTOR-LABEL: define {{[^@]+}}@fptr_test3
; ATTRIBUTOR-SAME: (ptr nocapture writeonly [[P:%.*]], ptr nocapture nofree nonnull writeonly [[F:%.*]]) #[[ATTR8]] {
; ATTRIBUTOR-NEXT:    call void [[F]](ptr nocapture [[P]]) #[[ATTR8]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void %f(ptr nocapture %p) writeonly
  ret void
}

define void @test_argmem_none_callee(ptr %p) {
; FNATTRS-LABEL: define {{[^@]+}}@test_argmem_none_callee
; FNATTRS-SAME: (ptr nocapture readnone [[P:%.*]]) {
; FNATTRS-NEXT:    call void @direct1_callee(ptr nocapture [[P]]) #[[ATTR10:[0-9]+]]
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_argmem_none_callee
; ATTRIBUTOR-SAME: (ptr nocapture [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    call void @direct1_callee(ptr nocapture [[P]]) #[[ATTR10:[0-9]+]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @direct1_callee(ptr nocapture %p) memory(readwrite, argmem: none)
  ret void
}

define void @test_argmem_read_callee(ptr %p) {
; FNATTRS-LABEL: define {{[^@]+}}@test_argmem_read_callee
; FNATTRS-SAME: (ptr nocapture readonly [[P:%.*]]) {
; FNATTRS-NEXT:    call void @direct1_callee(ptr nocapture [[P]]) #[[ATTR11:[0-9]+]]
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_argmem_read_callee
; ATTRIBUTOR-SAME: (ptr nocapture [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    call void @direct1_callee(ptr nocapture [[P]]) #[[ATTR11:[0-9]+]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @direct1_callee(ptr nocapture %p) memory(readwrite, argmem: read)
  ret void
}

define void @test_argmem_write_callee(ptr %p) {
; FNATTRS-LABEL: define {{[^@]+}}@test_argmem_write_callee
; FNATTRS-SAME: (ptr nocapture writeonly [[P:%.*]]) {
; FNATTRS-NEXT:    call void @direct1_callee(ptr nocapture [[P]]) #[[ATTR12:[0-9]+]]
; FNATTRS-NEXT:    ret void
;
; ATTRIBUTOR-LABEL: define {{[^@]+}}@test_argmem_write_callee
; ATTRIBUTOR-SAME: (ptr nocapture [[P:%.*]]) {
; ATTRIBUTOR-NEXT:    call void @direct1_callee(ptr nocapture [[P]]) #[[ATTR12:[0-9]+]]
; ATTRIBUTOR-NEXT:    ret void
;
  call void @direct1_callee(ptr nocapture %p) memory(readwrite, argmem: write)
  ret void
}