; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -msan-check-access-address=0 -S -passes=msan 2>&1                       | FileCheck %s
; RUN: opt < %s -msan-check-access-address=0 -S -passes=msan -msan-track-origins=1 2>&1 | FileCheck %s --check-prefixes=ORIGIN
; RUN: opt < %s -msan-check-access-address=0 -S -passes="msan<track-origins=1>"    2>&1 | FileCheck %s --check-prefixes=ORIGIN
; RUN: opt < %s -msan-check-access-address=0 -S -passes=msan -msan-track-origins=2 2>&1 | FileCheck %s --check-prefixes=ORIGIN2

; Test that shadow and origin are stored for variadic function params.

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "i386-unknown-linux-gnu"

%struct.__va_list_tag = type { i32, i32, ptr, ptr }

define dso_local i32 @test(i32 %a, i32 %b, i32 %c) local_unnamed_addr {
; CHECK-LABEL: define dso_local i32 @test(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]], i32 [[C:%.*]]) local_unnamed_addr {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    store i32 0, ptr @__msan_param_tls, align 8
; CHECK-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; CHECK-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 16) to ptr), align 8
; CHECK-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 24) to ptr), align 8
; CHECK-NEXT:    store i32 0, ptr @__msan_va_arg_tls, align 8
; CHECK-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 8) to ptr), align 8
; CHECK-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 16) to ptr), align 8
; CHECK-NEXT:    store i64 24, ptr @__msan_va_arg_overflow_size_tls, align 8
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    [[CALL:%.*]] = tail call i32 (i32, ...) @sum(i32 3, i32 [[A]], i32 [[B]], i32 [[C]])
; CHECK-NEXT:    [[_MSRET:%.*]] = load i32, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    ret i32 [[CALL]]
;
; ORIGIN-LABEL: define dso_local i32 @test(
; ORIGIN-SAME: i32 [[A:%.*]], i32 [[B:%.*]], i32 [[C:%.*]]) local_unnamed_addr {
; ORIGIN-NEXT:  [[ENTRY:.*:]]
; ORIGIN-NEXT:    [[TMP2:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN-NEXT:    call void @llvm.donothing()
; ORIGIN-NEXT:    store i32 0, ptr @__msan_param_tls, align 8
; ORIGIN-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; ORIGIN-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 16) to ptr), align 8
; ORIGIN-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 24) to ptr), align 8
; ORIGIN-NEXT:    store i32 0, ptr @__msan_va_arg_tls, align 8
; ORIGIN-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 8) to ptr), align 8
; ORIGIN-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 16) to ptr), align 8
; ORIGIN-NEXT:    store i64 24, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; ORIGIN-NEXT:    [[CALL:%.*]] = tail call i32 (i32, ...) @sum(i32 3, i32 [[A]], i32 [[B]], i32 [[C]])
; ORIGIN-NEXT:    [[_MSRET:%.*]] = load i32, ptr @__msan_retval_tls, align 8
; ORIGIN-NEXT:    [[TMP0:%.*]] = load i32, ptr @__msan_retval_origin_tls, align 4
; ORIGIN-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; ORIGIN-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; ORIGIN-NEXT:    ret i32 [[CALL]]
;
; ORIGIN2-LABEL: define dso_local i32 @test(
; ORIGIN2-SAME: i32 [[A:%.*]], i32 [[B:%.*]], i32 [[C:%.*]]) local_unnamed_addr {
; ORIGIN2-NEXT:  [[ENTRY:.*:]]
; ORIGIN2-NEXT:    [[TMP2:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN2-NEXT:    call void @llvm.donothing()
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_param_tls, align 8
; ORIGIN2-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; ORIGIN2-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 16) to ptr), align 8
; ORIGIN2-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 24) to ptr), align 8
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_va_arg_tls, align 8
; ORIGIN2-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 8) to ptr), align 8
; ORIGIN2-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 16) to ptr), align 8
; ORIGIN2-NEXT:    store i64 24, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; ORIGIN2-NEXT:    [[CALL:%.*]] = tail call i32 (i32, ...) @sum(i32 3, i32 [[A]], i32 [[B]], i32 [[C]])
; ORIGIN2-NEXT:    [[_MSRET:%.*]] = load i32, ptr @__msan_retval_tls, align 8
; ORIGIN2-NEXT:    [[TMP0:%.*]] = load i32, ptr @__msan_retval_origin_tls, align 4
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; ORIGIN2-NEXT:    ret i32 [[CALL]]
;
entry:
  %call = tail call i32 (i32, ...) @sum(i32 3, i32 %a, i32 %b, i32 %c)
  ret i32 %call
}

define dso_local i32 @sum(i32 %n, ...) local_unnamed_addr #0 {
; CHECK-LABEL: define dso_local i32 @sum(
; CHECK-SAME: i32 [[N:%.*]], ...) local_unnamed_addr {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; CHECK-NEXT:    [[TMP2:%.*]] = alloca i8, i64 [[TMP1]], align 8
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP2]], i8 0, i64 [[TMP1]], i1 false)
; CHECK-NEXT:    [[TMP3:%.*]] = call i64 @llvm.umin.i64(i64 [[TMP1]], i64 800)
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP2]], ptr align 8 @__msan_va_arg_tls, i64 [[TMP3]], i1 false)
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[ARGS:%.*]] = alloca [1 x %struct.__va_list_tag], align 16
; CHECK-NEXT:    [[TMP4:%.*]] = ptrtoint ptr [[ARGS]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = and i64 [[TMP4]], -2147483649
; CHECK-NEXT:    [[TMP6:%.*]] = inttoptr i64 [[TMP5]] to ptr
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 16 [[TMP6]], i8 0, i64 24, i1 false)
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 24, ptr nonnull [[ARGS]])
; CHECK-NEXT:    [[TMP7:%.*]] = ptrtoint ptr [[ARGS]] to i64
; CHECK-NEXT:    [[TMP8:%.*]] = and i64 [[TMP7]], -2147483649
; CHECK-NEXT:    [[TMP9:%.*]] = inttoptr i64 [[TMP8]] to ptr
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP9]], i8 0, i64 4, i1 false)
; CHECK-NEXT:    call void @llvm.va_start.p0(ptr nonnull [[ARGS]])
; CHECK-NEXT:    [[TMP10:%.*]] = ptrtoint ptr [[ARGS]] to i64
; CHECK-NEXT:    [[TMP11:%.*]] = inttoptr i64 [[TMP10]] to ptr
; CHECK-NEXT:    [[TMP12:%.*]] = load ptr, ptr [[TMP11]], align 8
; CHECK-NEXT:    [[TMP13:%.*]] = ptrtoint ptr [[TMP12]] to i64
; CHECK-NEXT:    [[TMP14:%.*]] = and i64 [[TMP13]], -2147483649
; CHECK-NEXT:    [[TMP15:%.*]] = inttoptr i64 [[TMP14]] to ptr
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP15]], ptr align 8 [[TMP2]], i64 [[TMP1]], i1 false)
; CHECK-NEXT:    [[TMP25:%.*]] = xor i32 [[N]], -2147483648
; CHECK-NEXT:    [[TMP26:%.*]] = and i32 [[TMP25]], -1
; CHECK-NEXT:    [[TMP27:%.*]] = or i32 [[TMP25]], 0
; CHECK-NEXT:    [[TMP28:%.*]] = icmp ugt i32 [[TMP26]], -2147483648
; CHECK-NEXT:    [[TMP29:%.*]] = icmp ugt i32 [[TMP27]], -2147483648
; CHECK-NEXT:    [[TMP30:%.*]] = xor i1 [[TMP28]], [[TMP29]]
; CHECK-NEXT:    [[CMP9:%.*]] = icmp sgt i32 [[N]], 0
; CHECK-NEXT:    br i1 [[CMP9]], label %[[FOR_BODY_LR_PH:.*]], label %[[FOR_END:.*]]
; CHECK:       [[FOR_BODY_LR_PH]]:
; CHECK-NEXT:    [[TMP31:%.*]] = getelementptr inbounds [1 x %struct.__va_list_tag], ptr [[ARGS]], i64 0, i64 0, i32 3
; CHECK-NEXT:    [[OVERFLOW_ARG_AREA_P:%.*]] = getelementptr inbounds [1 x %struct.__va_list_tag], ptr [[ARGS]], i64 0, i64 0, i32 2
; CHECK-NEXT:    [[GP_OFFSET_PRE:%.*]] = load i32, ptr [[ARGS]], align 16
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[GP_OFFSET:%.*]] = phi i32 [ [[GP_OFFSET_PRE]], %[[FOR_BODY_LR_PH]] ], [ [[GP_OFFSET12:%.*]], %[[VAARG_END:.*]] ]
; CHECK-NEXT:    [[SUM_011:%.*]] = phi i32 [ 0, %[[FOR_BODY_LR_PH]] ], [ [[ADD:%.*]], %[[VAARG_END]] ]
; CHECK-NEXT:    [[I_010:%.*]] = phi i32 [ 0, %[[FOR_BODY_LR_PH]] ], [ [[INC:%.*]], %[[VAARG_END]] ]
; CHECK-NEXT:    [[TMP32:%.*]] = and i32 [[GP_OFFSET]], -1
; CHECK-NEXT:    [[TMP33:%.*]] = or i32 [[GP_OFFSET]], 0
; CHECK-NEXT:    [[TMP34:%.*]] = icmp ult i32 [[TMP32]], 41
; CHECK-NEXT:    [[TMP35:%.*]] = icmp ult i32 [[TMP33]], 41
; CHECK-NEXT:    [[TMP36:%.*]] = xor i1 [[TMP34]], [[TMP35]]
; CHECK-NEXT:    [[FITS_IN_GP:%.*]] = icmp ult i32 [[GP_OFFSET]], 41
; CHECK-NEXT:    br i1 [[FITS_IN_GP]], label %[[VAARG_IN_REG:.*]], label %[[VAARG_IN_MEM:.*]]
; CHECK:       [[VAARG_IN_REG]]:
; CHECK-NEXT:    [[REG_SAVE_AREA:%.*]] = load ptr, ptr [[TMP31]], align 16
; CHECK-NEXT:    [[TMP37:%.*]] = sext i32 [[GP_OFFSET]] to i64
; CHECK-NEXT:    [[TMP38:%.*]] = getelementptr i8, ptr [[REG_SAVE_AREA]], i64 [[TMP37]]
; CHECK-NEXT:    [[TMP39:%.*]] = add i32 [[GP_OFFSET]], 8
; CHECK-NEXT:    [[TMP40:%.*]] = ptrtoint ptr [[ARGS]] to i64
; CHECK-NEXT:    [[TMP41:%.*]] = and i64 [[TMP40]], -2147483649
; CHECK-NEXT:    [[TMP42:%.*]] = inttoptr i64 [[TMP41]] to ptr
; CHECK-NEXT:    store i32 0, ptr [[TMP42]], align 16
; CHECK-NEXT:    store i32 [[TMP39]], ptr [[ARGS]], align 16
; CHECK-NEXT:    br label %[[VAARG_END]]
; CHECK:       [[VAARG_IN_MEM]]:
; CHECK-NEXT:    [[OVERFLOW_ARG_AREA:%.*]] = load ptr, ptr [[OVERFLOW_ARG_AREA_P]], align 8
; CHECK-NEXT:    [[OVERFLOW_ARG_AREA_NEXT:%.*]] = getelementptr i8, ptr [[OVERFLOW_ARG_AREA]], i64 8
; CHECK-NEXT:    [[TMP43:%.*]] = ptrtoint ptr [[OVERFLOW_ARG_AREA_P]] to i64
; CHECK-NEXT:    [[TMP44:%.*]] = and i64 [[TMP43]], -2147483649
; CHECK-NEXT:    [[TMP45:%.*]] = inttoptr i64 [[TMP44]] to ptr
; CHECK-NEXT:    store i64 0, ptr [[TMP45]], align 8
; CHECK-NEXT:    store ptr [[OVERFLOW_ARG_AREA_NEXT]], ptr [[OVERFLOW_ARG_AREA_P]], align 8
; CHECK-NEXT:    br label %[[VAARG_END]]
; CHECK:       [[VAARG_END]]:
; CHECK-NEXT:    [[GP_OFFSET12]] = phi i32 [ [[TMP39]], %[[VAARG_IN_REG]] ], [ [[GP_OFFSET]], %[[VAARG_IN_MEM]] ]
; CHECK-NEXT:    [[VAARG_ADDR_IN:%.*]] = phi ptr [ [[TMP38]], %[[VAARG_IN_REG]] ], [ [[OVERFLOW_ARG_AREA]], %[[VAARG_IN_MEM]] ]
; CHECK-NEXT:    [[TMP46:%.*]] = load i32, ptr [[VAARG_ADDR_IN]], align 4
; CHECK-NEXT:    [[ADD]] = add nsw i32 [[TMP46]], [[SUM_011]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[I_010]], 1
; CHECK-NEXT:    [[TMP47:%.*]] = xor i32 [[INC]], [[N]]
; CHECK-NEXT:    [[TMP48:%.*]] = and i32 -1, [[TMP47]]
; CHECK-NEXT:    [[TMP49:%.*]] = icmp eq i32 [[TMP48]], 0
; CHECK-NEXT:    [[_MSPROP_ICMP:%.*]] = and i1 false, [[TMP49]]
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_END]], label %[[FOR_BODY]]
; CHECK:       [[FOR_END]]:
; CHECK-NEXT:    [[SUM_0_LCSSA:%.*]] = phi i32 [ 0, %[[ENTRY]] ], [ [[ADD]], %[[VAARG_END]] ]
; CHECK-NEXT:    call void @llvm.va_end.p0(ptr nonnull [[ARGS]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 24, ptr nonnull [[ARGS]])
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    ret i32 [[SUM_0_LCSSA]]
;
; ORIGIN-LABEL: define dso_local i32 @sum(
; ORIGIN-SAME: i32 [[N:%.*]], ...) local_unnamed_addr {
; ORIGIN-NEXT:  [[ENTRY:.*]]:
; ORIGIN-NEXT:    [[TMP1:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN-NEXT:    [[TMP2:%.*]] = alloca i8, i64 [[TMP1]], align 8
; ORIGIN-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP2]], i8 0, i64 [[TMP1]], i1 false)
; ORIGIN-NEXT:    [[TMP3:%.*]] = call i64 @llvm.umin.i64(i64 [[TMP1]], i64 800)
; ORIGIN-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP2]], ptr align 8 @__msan_va_arg_tls, i64 [[TMP3]], i1 false)
; ORIGIN-NEXT:    call void @llvm.donothing()
; ORIGIN-NEXT:    [[ARGS:%.*]] = alloca [1 x %struct.__va_list_tag], align 16
; ORIGIN-NEXT:    [[TMP5:%.*]] = ptrtoint ptr [[ARGS]] to i64
; ORIGIN-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], -2147483649
; ORIGIN-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to ptr
; ORIGIN-NEXT:    [[TMP8:%.*]] = add i64 [[TMP6]], 1073741824
; ORIGIN-NEXT:    [[TMP9:%.*]] = and i64 [[TMP8]], -4
; ORIGIN-NEXT:    [[TMP10:%.*]] = inttoptr i64 [[TMP9]] to ptr
; ORIGIN-NEXT:    call void @llvm.memset.p0.i64(ptr align 16 [[TMP7]], i8 0, i64 24, i1 false)
; ORIGIN-NEXT:    call void @llvm.lifetime.start.p0(i64 24, ptr nonnull [[ARGS]])
; ORIGIN-NEXT:    [[TMP23:%.*]] = ptrtoint ptr [[ARGS]] to i64
; ORIGIN-NEXT:    [[TMP11:%.*]] = and i64 [[TMP23]], -2147483649
; ORIGIN-NEXT:    [[TMP12:%.*]] = inttoptr i64 [[TMP11]] to ptr
; ORIGIN-NEXT:    [[TMP13:%.*]] = add i64 [[TMP11]], 1073741824
; ORIGIN-NEXT:    [[TMP14:%.*]] = inttoptr i64 [[TMP13]] to ptr
; ORIGIN-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP12]], i8 0, i64 4, i1 false)
; ORIGIN-NEXT:    call void @llvm.va_start.p0(ptr nonnull [[ARGS]])
; ORIGIN-NEXT:    [[TMP15:%.*]] = ptrtoint ptr [[ARGS]] to i64
; ORIGIN-NEXT:    [[TMP16:%.*]] = inttoptr i64 [[TMP15]] to ptr
; ORIGIN-NEXT:    [[TMP17:%.*]] = load ptr, ptr [[TMP16]], align 8
; ORIGIN-NEXT:    [[TMP18:%.*]] = ptrtoint ptr [[TMP17]] to i64
; ORIGIN-NEXT:    [[TMP19:%.*]] = and i64 [[TMP18]], -2147483649
; ORIGIN-NEXT:    [[TMP20:%.*]] = inttoptr i64 [[TMP19]] to ptr
; ORIGIN-NEXT:    [[TMP21:%.*]] = add i64 [[TMP19]], 1073741824
; ORIGIN-NEXT:    [[TMP22:%.*]] = inttoptr i64 [[TMP21]] to ptr
; ORIGIN-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP20]], ptr align 8 [[TMP2]], i64 [[TMP1]], i1 false)
; ORIGIN-NEXT:    [[TMP36:%.*]] = xor i32 [[N]], -2147483648
; ORIGIN-NEXT:    [[TMP37:%.*]] = and i32 [[TMP36]], -1
; ORIGIN-NEXT:    [[TMP38:%.*]] = or i32 [[TMP36]], 0
; ORIGIN-NEXT:    [[TMP39:%.*]] = icmp ugt i32 [[TMP37]], -2147483648
; ORIGIN-NEXT:    [[TMP40:%.*]] = icmp ugt i32 [[TMP38]], -2147483648
; ORIGIN-NEXT:    [[TMP41:%.*]] = xor i1 [[TMP39]], [[TMP40]]
; ORIGIN-NEXT:    [[CMP9:%.*]] = icmp sgt i32 [[N]], 0
; ORIGIN-NEXT:    br i1 [[CMP9]], label %[[FOR_BODY_LR_PH:.*]], label %[[FOR_END:.*]]
; ORIGIN:       [[FOR_BODY_LR_PH]]:
; ORIGIN-NEXT:    [[TMP42:%.*]] = getelementptr inbounds [1 x %struct.__va_list_tag], ptr [[ARGS]], i64 0, i64 0, i32 3
; ORIGIN-NEXT:    [[OVERFLOW_ARG_AREA_P:%.*]] = getelementptr inbounds [1 x %struct.__va_list_tag], ptr [[ARGS]], i64 0, i64 0, i32 2
; ORIGIN-NEXT:    [[GP_OFFSET_PRE:%.*]] = load i32, ptr [[ARGS]], align 16
; ORIGIN-NEXT:    br label %[[FOR_BODY:.*]]
; ORIGIN:       [[FOR_BODY]]:
; ORIGIN-NEXT:    [[GP_OFFSET:%.*]] = phi i32 [ [[GP_OFFSET_PRE]], %[[FOR_BODY_LR_PH]] ], [ [[GP_OFFSET12:%.*]], %[[VAARG_END:.*]] ]
; ORIGIN-NEXT:    [[SUM_011:%.*]] = phi i32 [ 0, %[[FOR_BODY_LR_PH]] ], [ [[ADD:%.*]], %[[VAARG_END]] ]
; ORIGIN-NEXT:    [[I_010:%.*]] = phi i32 [ 0, %[[FOR_BODY_LR_PH]] ], [ [[INC:%.*]], %[[VAARG_END]] ]
; ORIGIN-NEXT:    [[TMP43:%.*]] = and i32 [[GP_OFFSET]], -1
; ORIGIN-NEXT:    [[TMP44:%.*]] = or i32 [[GP_OFFSET]], 0
; ORIGIN-NEXT:    [[TMP45:%.*]] = icmp ult i32 [[TMP43]], 41
; ORIGIN-NEXT:    [[TMP46:%.*]] = icmp ult i32 [[TMP44]], 41
; ORIGIN-NEXT:    [[TMP47:%.*]] = xor i1 [[TMP45]], [[TMP46]]
; ORIGIN-NEXT:    [[FITS_IN_GP:%.*]] = icmp ult i32 [[GP_OFFSET]], 41
; ORIGIN-NEXT:    br i1 [[FITS_IN_GP]], label %[[VAARG_IN_REG:.*]], label %[[VAARG_IN_MEM:.*]]
; ORIGIN:       [[VAARG_IN_REG]]:
; ORIGIN-NEXT:    [[REG_SAVE_AREA:%.*]] = load ptr, ptr [[TMP42]], align 16
; ORIGIN-NEXT:    [[TMP48:%.*]] = sext i32 [[GP_OFFSET]] to i64
; ORIGIN-NEXT:    [[TMP49:%.*]] = getelementptr i8, ptr [[REG_SAVE_AREA]], i64 [[TMP48]]
; ORIGIN-NEXT:    [[TMP50:%.*]] = add i32 [[GP_OFFSET]], 8
; ORIGIN-NEXT:    [[TMP51:%.*]] = ptrtoint ptr [[ARGS]] to i64
; ORIGIN-NEXT:    [[TMP52:%.*]] = and i64 [[TMP51]], -2147483649
; ORIGIN-NEXT:    [[TMP53:%.*]] = inttoptr i64 [[TMP52]] to ptr
; ORIGIN-NEXT:    [[TMP54:%.*]] = add i64 [[TMP52]], 1073741824
; ORIGIN-NEXT:    [[TMP55:%.*]] = inttoptr i64 [[TMP54]] to ptr
; ORIGIN-NEXT:    store i32 0, ptr [[TMP53]], align 16
; ORIGIN-NEXT:    store i32 [[TMP50]], ptr [[ARGS]], align 16
; ORIGIN-NEXT:    br label %[[VAARG_END]]
; ORIGIN:       [[VAARG_IN_MEM]]:
; ORIGIN-NEXT:    [[OVERFLOW_ARG_AREA:%.*]] = load ptr, ptr [[OVERFLOW_ARG_AREA_P]], align 8
; ORIGIN-NEXT:    [[OVERFLOW_ARG_AREA_NEXT:%.*]] = getelementptr i8, ptr [[OVERFLOW_ARG_AREA]], i64 8
; ORIGIN-NEXT:    [[TMP56:%.*]] = ptrtoint ptr [[OVERFLOW_ARG_AREA_P]] to i64
; ORIGIN-NEXT:    [[TMP57:%.*]] = and i64 [[TMP56]], -2147483649
; ORIGIN-NEXT:    [[TMP58:%.*]] = inttoptr i64 [[TMP57]] to ptr
; ORIGIN-NEXT:    [[TMP59:%.*]] = add i64 [[TMP57]], 1073741824
; ORIGIN-NEXT:    [[TMP60:%.*]] = inttoptr i64 [[TMP59]] to ptr
; ORIGIN-NEXT:    store i64 0, ptr [[TMP58]], align 8
; ORIGIN-NEXT:    store ptr [[OVERFLOW_ARG_AREA_NEXT]], ptr [[OVERFLOW_ARG_AREA_P]], align 8
; ORIGIN-NEXT:    br label %[[VAARG_END]]
; ORIGIN:       [[VAARG_END]]:
; ORIGIN-NEXT:    [[GP_OFFSET12]] = phi i32 [ [[TMP50]], %[[VAARG_IN_REG]] ], [ [[GP_OFFSET]], %[[VAARG_IN_MEM]] ]
; ORIGIN-NEXT:    [[VAARG_ADDR_IN:%.*]] = phi ptr [ [[TMP49]], %[[VAARG_IN_REG]] ], [ [[OVERFLOW_ARG_AREA]], %[[VAARG_IN_MEM]] ]
; ORIGIN-NEXT:    [[TMP61:%.*]] = load i32, ptr [[VAARG_ADDR_IN]], align 4
; ORIGIN-NEXT:    [[ADD]] = add nsw i32 [[TMP61]], [[SUM_011]]
; ORIGIN-NEXT:    [[INC]] = add nuw nsw i32 [[I_010]], 1
; ORIGIN-NEXT:    [[TMP62:%.*]] = xor i32 [[INC]], [[N]]
; ORIGIN-NEXT:    [[TMP63:%.*]] = and i32 -1, [[TMP62]]
; ORIGIN-NEXT:    [[TMP64:%.*]] = icmp eq i32 [[TMP63]], 0
; ORIGIN-NEXT:    [[_MSPROP_ICMP:%.*]] = and i1 false, [[TMP64]]
; ORIGIN-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], [[N]]
; ORIGIN-NEXT:    br i1 [[EXITCOND]], label %[[FOR_END]], label %[[FOR_BODY]]
; ORIGIN:       [[FOR_END]]:
; ORIGIN-NEXT:    [[SUM_0_LCSSA:%.*]] = phi i32 [ 0, %[[ENTRY]] ], [ [[ADD]], %[[VAARG_END]] ]
; ORIGIN-NEXT:    call void @llvm.va_end.p0(ptr nonnull [[ARGS]])
; ORIGIN-NEXT:    call void @llvm.lifetime.end.p0(i64 24, ptr nonnull [[ARGS]])
; ORIGIN-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; ORIGIN-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; ORIGIN-NEXT:    ret i32 [[SUM_0_LCSSA]]
;
; ORIGIN2-LABEL: define dso_local i32 @sum(
; ORIGIN2-SAME: i32 [[N:%.*]], ...) local_unnamed_addr {
; ORIGIN2-NEXT:  [[ENTRY:.*]]:
; ORIGIN2-NEXT:    [[TMP1:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN2-NEXT:    [[TMP2:%.*]] = alloca i8, i64 [[TMP1]], align 8
; ORIGIN2-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP2]], i8 0, i64 [[TMP1]], i1 false)
; ORIGIN2-NEXT:    [[TMP3:%.*]] = call i64 @llvm.umin.i64(i64 [[TMP1]], i64 800)
; ORIGIN2-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP2]], ptr align 8 @__msan_va_arg_tls, i64 [[TMP3]], i1 false)
; ORIGIN2-NEXT:    call void @llvm.donothing()
; ORIGIN2-NEXT:    [[ARGS:%.*]] = alloca [1 x %struct.__va_list_tag], align 16
; ORIGIN2-NEXT:    [[TMP5:%.*]] = ptrtoint ptr [[ARGS]] to i64
; ORIGIN2-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], -2147483649
; ORIGIN2-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to ptr
; ORIGIN2-NEXT:    [[TMP8:%.*]] = add i64 [[TMP6]], 1073741824
; ORIGIN2-NEXT:    [[TMP9:%.*]] = and i64 [[TMP8]], -4
; ORIGIN2-NEXT:    [[TMP10:%.*]] = inttoptr i64 [[TMP9]] to ptr
; ORIGIN2-NEXT:    call void @llvm.memset.p0.i64(ptr align 16 [[TMP7]], i8 0, i64 24, i1 false)
; ORIGIN2-NEXT:    call void @llvm.lifetime.start.p0(i64 24, ptr nonnull [[ARGS]])
; ORIGIN2-NEXT:    [[TMP23:%.*]] = ptrtoint ptr [[ARGS]] to i64
; ORIGIN2-NEXT:    [[TMP11:%.*]] = and i64 [[TMP23]], -2147483649
; ORIGIN2-NEXT:    [[TMP12:%.*]] = inttoptr i64 [[TMP11]] to ptr
; ORIGIN2-NEXT:    [[TMP13:%.*]] = add i64 [[TMP11]], 1073741824
; ORIGIN2-NEXT:    [[TMP14:%.*]] = inttoptr i64 [[TMP13]] to ptr
; ORIGIN2-NEXT:    call void @llvm.memset.p0.i64(ptr align 8 [[TMP12]], i8 0, i64 4, i1 false)
; ORIGIN2-NEXT:    call void @llvm.va_start.p0(ptr nonnull [[ARGS]])
; ORIGIN2-NEXT:    [[TMP15:%.*]] = ptrtoint ptr [[ARGS]] to i64
; ORIGIN2-NEXT:    [[TMP16:%.*]] = inttoptr i64 [[TMP15]] to ptr
; ORIGIN2-NEXT:    [[TMP17:%.*]] = load ptr, ptr [[TMP16]], align 8
; ORIGIN2-NEXT:    [[TMP18:%.*]] = ptrtoint ptr [[TMP17]] to i64
; ORIGIN2-NEXT:    [[TMP19:%.*]] = and i64 [[TMP18]], -2147483649
; ORIGIN2-NEXT:    [[TMP20:%.*]] = inttoptr i64 [[TMP19]] to ptr
; ORIGIN2-NEXT:    [[TMP21:%.*]] = add i64 [[TMP19]], 1073741824
; ORIGIN2-NEXT:    [[TMP22:%.*]] = inttoptr i64 [[TMP21]] to ptr
; ORIGIN2-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 8 [[TMP20]], ptr align 8 [[TMP2]], i64 [[TMP1]], i1 false)
; ORIGIN2-NEXT:    [[TMP36:%.*]] = xor i32 [[N]], -2147483648
; ORIGIN2-NEXT:    [[TMP37:%.*]] = and i32 [[TMP36]], -1
; ORIGIN2-NEXT:    [[TMP38:%.*]] = or i32 [[TMP36]], 0
; ORIGIN2-NEXT:    [[TMP39:%.*]] = icmp ugt i32 [[TMP37]], -2147483648
; ORIGIN2-NEXT:    [[TMP40:%.*]] = icmp ugt i32 [[TMP38]], -2147483648
; ORIGIN2-NEXT:    [[TMP41:%.*]] = xor i1 [[TMP39]], [[TMP40]]
; ORIGIN2-NEXT:    [[CMP9:%.*]] = icmp sgt i32 [[N]], 0
; ORIGIN2-NEXT:    br i1 [[CMP9]], label %[[FOR_BODY_LR_PH:.*]], label %[[FOR_END:.*]]
; ORIGIN2:       [[FOR_BODY_LR_PH]]:
; ORIGIN2-NEXT:    [[TMP42:%.*]] = getelementptr inbounds [1 x %struct.__va_list_tag], ptr [[ARGS]], i64 0, i64 0, i32 3
; ORIGIN2-NEXT:    [[OVERFLOW_ARG_AREA_P:%.*]] = getelementptr inbounds [1 x %struct.__va_list_tag], ptr [[ARGS]], i64 0, i64 0, i32 2
; ORIGIN2-NEXT:    [[GP_OFFSET_PRE:%.*]] = load i32, ptr [[ARGS]], align 16
; ORIGIN2-NEXT:    br label %[[FOR_BODY:.*]]
; ORIGIN2:       [[FOR_BODY]]:
; ORIGIN2-NEXT:    [[GP_OFFSET:%.*]] = phi i32 [ [[GP_OFFSET_PRE]], %[[FOR_BODY_LR_PH]] ], [ [[GP_OFFSET12:%.*]], %[[VAARG_END:.*]] ]
; ORIGIN2-NEXT:    [[SUM_011:%.*]] = phi i32 [ 0, %[[FOR_BODY_LR_PH]] ], [ [[ADD:%.*]], %[[VAARG_END]] ]
; ORIGIN2-NEXT:    [[I_010:%.*]] = phi i32 [ 0, %[[FOR_BODY_LR_PH]] ], [ [[INC:%.*]], %[[VAARG_END]] ]
; ORIGIN2-NEXT:    [[TMP43:%.*]] = and i32 [[GP_OFFSET]], -1
; ORIGIN2-NEXT:    [[TMP44:%.*]] = or i32 [[GP_OFFSET]], 0
; ORIGIN2-NEXT:    [[TMP45:%.*]] = icmp ult i32 [[TMP43]], 41
; ORIGIN2-NEXT:    [[TMP46:%.*]] = icmp ult i32 [[TMP44]], 41
; ORIGIN2-NEXT:    [[TMP47:%.*]] = xor i1 [[TMP45]], [[TMP46]]
; ORIGIN2-NEXT:    [[FITS_IN_GP:%.*]] = icmp ult i32 [[GP_OFFSET]], 41
; ORIGIN2-NEXT:    br i1 [[FITS_IN_GP]], label %[[VAARG_IN_REG:.*]], label %[[VAARG_IN_MEM:.*]]
; ORIGIN2:       [[VAARG_IN_REG]]:
; ORIGIN2-NEXT:    [[REG_SAVE_AREA:%.*]] = load ptr, ptr [[TMP42]], align 16
; ORIGIN2-NEXT:    [[TMP48:%.*]] = sext i32 [[GP_OFFSET]] to i64
; ORIGIN2-NEXT:    [[TMP49:%.*]] = getelementptr i8, ptr [[REG_SAVE_AREA]], i64 [[TMP48]]
; ORIGIN2-NEXT:    [[TMP50:%.*]] = add i32 [[GP_OFFSET]], 8
; ORIGIN2-NEXT:    [[TMP51:%.*]] = ptrtoint ptr [[ARGS]] to i64
; ORIGIN2-NEXT:    [[TMP52:%.*]] = and i64 [[TMP51]], -2147483649
; ORIGIN2-NEXT:    [[TMP53:%.*]] = inttoptr i64 [[TMP52]] to ptr
; ORIGIN2-NEXT:    [[TMP54:%.*]] = add i64 [[TMP52]], 1073741824
; ORIGIN2-NEXT:    [[TMP55:%.*]] = inttoptr i64 [[TMP54]] to ptr
; ORIGIN2-NEXT:    store i32 0, ptr [[TMP53]], align 16
; ORIGIN2-NEXT:    store i32 [[TMP50]], ptr [[ARGS]], align 16
; ORIGIN2-NEXT:    br label %[[VAARG_END]]
; ORIGIN2:       [[VAARG_IN_MEM]]:
; ORIGIN2-NEXT:    [[OVERFLOW_ARG_AREA:%.*]] = load ptr, ptr [[OVERFLOW_ARG_AREA_P]], align 8
; ORIGIN2-NEXT:    [[OVERFLOW_ARG_AREA_NEXT:%.*]] = getelementptr i8, ptr [[OVERFLOW_ARG_AREA]], i64 8
; ORIGIN2-NEXT:    [[TMP56:%.*]] = ptrtoint ptr [[OVERFLOW_ARG_AREA_P]] to i64
; ORIGIN2-NEXT:    [[TMP57:%.*]] = and i64 [[TMP56]], -2147483649
; ORIGIN2-NEXT:    [[TMP58:%.*]] = inttoptr i64 [[TMP57]] to ptr
; ORIGIN2-NEXT:    [[TMP59:%.*]] = add i64 [[TMP57]], 1073741824
; ORIGIN2-NEXT:    [[TMP60:%.*]] = inttoptr i64 [[TMP59]] to ptr
; ORIGIN2-NEXT:    store i64 0, ptr [[TMP58]], align 8
; ORIGIN2-NEXT:    store ptr [[OVERFLOW_ARG_AREA_NEXT]], ptr [[OVERFLOW_ARG_AREA_P]], align 8
; ORIGIN2-NEXT:    br label %[[VAARG_END]]
; ORIGIN2:       [[VAARG_END]]:
; ORIGIN2-NEXT:    [[GP_OFFSET12]] = phi i32 [ [[TMP50]], %[[VAARG_IN_REG]] ], [ [[GP_OFFSET]], %[[VAARG_IN_MEM]] ]
; ORIGIN2-NEXT:    [[VAARG_ADDR_IN:%.*]] = phi ptr [ [[TMP49]], %[[VAARG_IN_REG]] ], [ [[OVERFLOW_ARG_AREA]], %[[VAARG_IN_MEM]] ]
; ORIGIN2-NEXT:    [[TMP61:%.*]] = load i32, ptr [[VAARG_ADDR_IN]], align 4
; ORIGIN2-NEXT:    [[ADD]] = add nsw i32 [[TMP61]], [[SUM_011]]
; ORIGIN2-NEXT:    [[INC]] = add nuw nsw i32 [[I_010]], 1
; ORIGIN2-NEXT:    [[TMP62:%.*]] = xor i32 [[INC]], [[N]]
; ORIGIN2-NEXT:    [[TMP63:%.*]] = and i32 -1, [[TMP62]]
; ORIGIN2-NEXT:    [[TMP64:%.*]] = icmp eq i32 [[TMP63]], 0
; ORIGIN2-NEXT:    [[_MSPROP_ICMP:%.*]] = and i1 false, [[TMP64]]
; ORIGIN2-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], [[N]]
; ORIGIN2-NEXT:    br i1 [[EXITCOND]], label %[[FOR_END]], label %[[FOR_BODY]]
; ORIGIN2:       [[FOR_END]]:
; ORIGIN2-NEXT:    [[SUM_0_LCSSA:%.*]] = phi i32 [ 0, %[[ENTRY]] ], [ [[ADD]], %[[VAARG_END]] ]
; ORIGIN2-NEXT:    call void @llvm.va_end.p0(ptr nonnull [[ARGS]])
; ORIGIN2-NEXT:    call void @llvm.lifetime.end.p0(i64 24, ptr nonnull [[ARGS]])
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; ORIGIN2-NEXT:    ret i32 [[SUM_0_LCSSA]]
;
entry:
  %args = alloca [1 x %struct.__va_list_tag], align 16
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %args) #2
  call void @llvm.va_start(ptr nonnull %args)
  %cmp9 = icmp sgt i32 %n, 0
  br i1 %cmp9, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %0 = getelementptr inbounds [1 x %struct.__va_list_tag], ptr %args, i64 0, i64 0, i32 3
  %overflow_arg_area_p = getelementptr inbounds [1 x %struct.__va_list_tag], ptr %args, i64 0, i64 0, i32 2
  %gp_offset.pre = load i32, ptr %args, align 16
  br label %for.body

for.body:                                         ; preds = %vaarg.end, %for.body.lr.ph
  %gp_offset = phi i32 [ %gp_offset.pre, %for.body.lr.ph ], [ %gp_offset12, %vaarg.end ]
  %sum.011 = phi i32 [ 0, %for.body.lr.ph ], [ %add, %vaarg.end ]
  %i.010 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %vaarg.end ]
  %fits_in_gp = icmp ult i32 %gp_offset, 41
  br i1 %fits_in_gp, label %vaarg.in_reg, label %vaarg.in_mem

vaarg.in_reg:                                     ; preds = %for.body
  %reg_save_area = load ptr, ptr %0, align 16
  %1 = sext i32 %gp_offset to i64
  %2 = getelementptr i8, ptr %reg_save_area, i64 %1
  %3 = add i32 %gp_offset, 8
  store i32 %3, ptr %args, align 16
  br label %vaarg.end

vaarg.in_mem:                                     ; preds = %for.body
  %overflow_arg_area = load ptr, ptr %overflow_arg_area_p, align 8
  %overflow_arg_area.next = getelementptr i8, ptr %overflow_arg_area, i64 8
  store ptr %overflow_arg_area.next, ptr %overflow_arg_area_p, align 8
  br label %vaarg.end

vaarg.end:                                        ; preds = %vaarg.in_mem, %vaarg.in_reg
  %gp_offset12 = phi i32 [ %3, %vaarg.in_reg ], [ %gp_offset, %vaarg.in_mem ]
  %vaarg.addr.in = phi ptr [ %2, %vaarg.in_reg ], [ %overflow_arg_area, %vaarg.in_mem ]
  %4 = load i32, ptr %vaarg.addr.in, align 4
  %add = add nsw i32 %4, %sum.011
  %inc = add nuw nsw i32 %i.010, 1
  %exitcond = icmp eq i32 %inc, %n
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %vaarg.end, %entry
  %sum.0.lcssa = phi i32 [ 0, %entry ], [ %add, %vaarg.end ]
  call void @llvm.va_end(ptr nonnull %args)
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %args) #2
  ret i32 %sum.0.lcssa
}


; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0(i64, ptr nocapture) #1

; Function Attrs: nounwind
declare void @llvm.va_start(ptr) #2

; Function Attrs: nounwind
declare void @llvm.va_end(ptr) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0(i64, ptr nocapture) #1

declare dso_local i80 @sum_i80(i32, ...) local_unnamed_addr

; Unaligned types like i80 should also work.
define dso_local i80 @test_i80(i80 %a, i80 %b, i80 %c) local_unnamed_addr {
; CHECK-LABEL: define dso_local i80 @test_i80(
; CHECK-SAME: i80 [[A:%.*]], i80 [[B:%.*]], i80 [[C:%.*]]) local_unnamed_addr {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    store i32 0, ptr @__msan_param_tls, align 8
; CHECK-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; CHECK-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 24) to ptr), align 8
; CHECK-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 40) to ptr), align 8
; CHECK-NEXT:    store i80 0, ptr @__msan_va_arg_tls, align 8
; CHECK-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 16) to ptr), align 8
; CHECK-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 32) to ptr), align 8
; CHECK-NEXT:    store i64 48, ptr @__msan_va_arg_overflow_size_tls, align 8
; CHECK-NEXT:    store i80 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    [[CALL:%.*]] = tail call i80 (i32, ...) @sum_i80(i32 3, i80 [[A]], i80 [[B]], i80 [[C]])
; CHECK-NEXT:    [[_MSRET:%.*]] = load i80, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i80 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    ret i80 [[CALL]]
;
; ORIGIN-LABEL: define dso_local i80 @test_i80(
; ORIGIN-SAME: i80 [[A:%.*]], i80 [[B:%.*]], i80 [[C:%.*]]) local_unnamed_addr {
; ORIGIN-NEXT:  [[ENTRY:.*:]]
; ORIGIN-NEXT:    [[TMP2:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN-NEXT:    call void @llvm.donothing()
; ORIGIN-NEXT:    store i32 0, ptr @__msan_param_tls, align 8
; ORIGIN-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; ORIGIN-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 24) to ptr), align 8
; ORIGIN-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 40) to ptr), align 8
; ORIGIN-NEXT:    store i80 0, ptr @__msan_va_arg_tls, align 8
; ORIGIN-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 16) to ptr), align 8
; ORIGIN-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 32) to ptr), align 8
; ORIGIN-NEXT:    store i64 48, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN-NEXT:    store i80 0, ptr @__msan_retval_tls, align 8
; ORIGIN-NEXT:    [[CALL:%.*]] = tail call i80 (i32, ...) @sum_i80(i32 3, i80 [[A]], i80 [[B]], i80 [[C]])
; ORIGIN-NEXT:    [[_MSRET:%.*]] = load i80, ptr @__msan_retval_tls, align 8
; ORIGIN-NEXT:    [[TMP0:%.*]] = load i32, ptr @__msan_retval_origin_tls, align 4
; ORIGIN-NEXT:    store i80 0, ptr @__msan_retval_tls, align 8
; ORIGIN-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; ORIGIN-NEXT:    ret i80 [[CALL]]
;
; ORIGIN2-LABEL: define dso_local i80 @test_i80(
; ORIGIN2-SAME: i80 [[A:%.*]], i80 [[B:%.*]], i80 [[C:%.*]]) local_unnamed_addr {
; ORIGIN2-NEXT:  [[ENTRY:.*:]]
; ORIGIN2-NEXT:    [[TMP2:%.*]] = load i64, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN2-NEXT:    call void @llvm.donothing()
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_param_tls, align 8
; ORIGIN2-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; ORIGIN2-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 24) to ptr), align 8
; ORIGIN2-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 40) to ptr), align 8
; ORIGIN2-NEXT:    store i80 0, ptr @__msan_va_arg_tls, align 8
; ORIGIN2-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 16) to ptr), align 8
; ORIGIN2-NEXT:    store i80 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_va_arg_tls to i64), i64 32) to ptr), align 8
; ORIGIN2-NEXT:    store i64 48, ptr @__msan_va_arg_overflow_size_tls, align 8
; ORIGIN2-NEXT:    store i80 0, ptr @__msan_retval_tls, align 8
; ORIGIN2-NEXT:    [[CALL:%.*]] = tail call i80 (i32, ...) @sum_i80(i32 3, i80 [[A]], i80 [[B]], i80 [[C]])
; ORIGIN2-NEXT:    [[_MSRET:%.*]] = load i80, ptr @__msan_retval_tls, align 8
; ORIGIN2-NEXT:    [[TMP0:%.*]] = load i32, ptr @__msan_retval_origin_tls, align 4
; ORIGIN2-NEXT:    store i80 0, ptr @__msan_retval_tls, align 8
; ORIGIN2-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; ORIGIN2-NEXT:    ret i80 [[CALL]]
;
entry:
  %call = tail call i80 (i32, ...) @sum_i80(i32 3, i80 %a, i80 %b, i80 %c)
  ret i80 %call
}