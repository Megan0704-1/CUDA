; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
define double @test_mul_fast_flags(ptr %arr_d) {
; CHECK-LABEL: @test_mul_fast_flags(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp samesign ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret double 0.000000e+00
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %f_prod.01 = phi double [ 0.000000e+00, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds [1000 x double], ptr %arr_d, i64 0, i64 %i.02
  %0 = load double, ptr %arrayidx, align 8
  %mul = fmul fast double %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi double [ %mul, %for.body ]
  ret double %f_prod.0.lcssa
}

define double @test_nsz_nnan_flags_enabled(ptr %arr_d) {
; CHECK-LABEL: @test_nsz_nnan_flags_enabled(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp samesign ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret double 0.000000e+00
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %f_prod.01 = phi double [ 0.000000e+00, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds [1000 x double], ptr %arr_d, i64 0, i64 %i.02
  %0 = load double, ptr %arrayidx, align 8
  %mul = fmul nsz nnan double %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi double [ %mul, %for.body ]
  ret double %f_prod.0.lcssa
}

define double @test_nnan_flag_enabled(ptr %arr_d) {
; CHECK-LABEL: @test_nnan_flag_enabled(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi double [ 0.000000e+00, [[ENTRY]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw [1000 x double], ptr [[ARR_D:%.*]], i64 0, i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[MUL]] = fmul nnan double [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp samesign ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret double [[MUL]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %f_prod.01 = phi double [ 0.000000e+00, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds [1000 x double], ptr %arr_d, i64 0, i64 %i.02
  %0 = load double, ptr %arrayidx, align 8
  %mul = fmul nnan double %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi double [ %mul, %for.body ]
  ret double %f_prod.0.lcssa
}

define double @test_ninf_flag_enabled(ptr %arr_d) {
; CHECK-LABEL: @test_ninf_flag_enabled(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi double [ 0.000000e+00, [[ENTRY]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw [1000 x double], ptr [[ARR_D:%.*]], i64 0, i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[MUL]] = fmul ninf double [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp samesign ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret double [[MUL]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %f_prod.01 = phi double [ 0.000000e+00, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds [1000 x double], ptr %arr_d, i64 0, i64 %i.02
  %0 = load double, ptr %arrayidx, align 8
  %mul = fmul ninf double %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi double [ %mul, %for.body ]
  ret double %f_prod.0.lcssa
}

define double @test_nsz_flag_enabled(ptr %arr_d) {
; CHECK-LABEL: @test_nsz_flag_enabled(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi double [ 0.000000e+00, [[ENTRY]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw [1000 x double], ptr [[ARR_D:%.*]], i64 0, i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[MUL]] = fmul nsz double [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp samesign ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret double [[MUL]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %f_prod.01 = phi double [ 0.000000e+00, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds [1000 x double], ptr %arr_d, i64 0, i64 %i.02
  %0 = load double, ptr %arrayidx, align 8
  %mul = fmul nsz double %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi double [ %mul, %for.body ]
  ret double %f_prod.0.lcssa
}

define double @test_phi_initalise_to_non_zero(ptr %arr_d) {
; CHECK-LABEL: @test_phi_initalise_to_non_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi double [ 1.000000e+00, [[ENTRY]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw [1000 x double], ptr [[ARR_D:%.*]], i64 0, i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[MUL]] = fmul fast double [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp samesign ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret double [[MUL]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %f_prod.01 = phi double [ 1.000000e+00, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds [1000 x double], ptr %arr_d, i64 0, i64 %i.02
  %0 = load double, ptr %arrayidx, align 8
  %mul = fmul fast double %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi double [ %mul, %for.body ]
  ret double %f_prod.0.lcssa
}

define double @test_multiple_phi_operands(ptr %arr_d, i1 %entry_cond) {
; CHECK-LABEL: @test_multiple_phi_operands(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[ENTRY_COND:%.*]], label [[FOR_BODY:%.*]], label [[ENTRY_2:%.*]]
; CHECK:       entry_2:
; CHECK-NEXT:    br label [[FOR_BODY]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ 0, [[ENTRY_2]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi double [ 0.000000e+00, [[ENTRY]] ], [ 0.000000e+00, [[ENTRY_2]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw [1000 x double], ptr [[ARR_D:%.*]], i64 0, i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[MUL]] = fmul fast double [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret double [[MUL]]
;
entry:
  br i1 %entry_cond, label %for.body, label %entry_2

entry_2:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [0, %entry_2], [ %inc, %for.body ]
  %f_prod.01 = phi double [ 0.0, %entry ], [0.0, %entry_2], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds [1000 x double], ptr %arr_d, i64 0, i64 %i.02
  %0 = load double, ptr %arrayidx, align 8
  %mul = fmul fast double %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi double [ %mul, %for.body ]
  ret double %f_prod.0.lcssa
}

define double @test_multiple_phi_operands_with_non_zero(ptr %arr_d, i1 %entry_cond) {
; CHECK-LABEL: @test_multiple_phi_operands_with_non_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[ENTRY_COND:%.*]], label [[FOR_BODY:%.*]], label [[ENTRY_2:%.*]]
; CHECK:       entry_2:
; CHECK-NEXT:    br label [[FOR_BODY]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ 0, [[ENTRY_2]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi double [ 1.000000e+00, [[ENTRY]] ], [ 0.000000e+00, [[ENTRY_2]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw [1000 x double], ptr [[ARR_D:%.*]], i64 0, i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[MUL]] = fmul fast double [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret double [[MUL]]
;
entry:
  br i1 %entry_cond, label %for.body, label %entry_2

entry_2:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [0, %entry_2], [ %inc, %for.body ]
  %f_prod.01 = phi double [ 1.0, %entry ], [0.0, %entry_2], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds [1000 x double], ptr %arr_d, i64 0, i64 %i.02
  %0 = load double, ptr %arrayidx, align 8
  %mul = fmul fast double %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi double [ %mul, %for.body ]
  ret double %f_prod.0.lcssa
}

define i32 @test_int_phi_operands(ptr %arr_d) {
; CHECK-LABEL: @test_int_phi_operands(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw i32, ptr [[ARR_D:%.*]], i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[MUL]] = mul nsw i32 [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp samesign ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret i32 [[MUL]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %f_prod.01 = phi i32 [ 0, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %arr_d, i64 %i.02
  %0 = load i32, ptr %arrayidx, align 4
  %mul = mul nsw i32 %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                 ; preds = %for.body
  %f_prod.0.lcssa = phi i32 [ %mul, %for.body ]
  ret i32 %f_prod.0.lcssa
}

define i32 @test_int_phi_operands_initalise_to_non_zero(ptr %arr_d) {
; CHECK-LABEL: @test_int_phi_operands_initalise_to_non_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw i32, ptr [[ARR_D:%.*]], i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[MUL]] = mul i32 [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp samesign ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret i32 [[MUL]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %f_prod.01 = phi i32 [ 1, %entry ], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %arr_d, i64 %i.02
  %0 = load i32, ptr %arrayidx, align 4
  %mul = mul i32 %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                 ; preds = %for.body
  %f_prod.0.lcssa = phi i32 [ %mul, %for.body ]
  ret i32 %f_prod.0.lcssa
}

define i32 @test_multiple_int_phi_operands(ptr %arr_d, i1 %entry_cond) {
; CHECK-LABEL: @test_multiple_int_phi_operands(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[ENTRY_COND:%.*]], label [[FOR_BODY:%.*]], label [[ENTRY_2:%.*]]
; CHECK:       entry_2:
; CHECK-NEXT:    br label [[FOR_BODY]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ 0, [[ENTRY_2]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ 0, [[ENTRY_2]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw i32, ptr [[ARR_D:%.*]], i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[MUL]] = mul i32 [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret i32 [[MUL]]
;
entry:
  br i1 %entry_cond, label %for.body, label %entry_2

entry_2:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [0, %entry_2], [ %inc, %for.body ]
  %f_prod.01 = phi i32 [ 0, %entry ], [0, %entry_2], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %arr_d, i64 %i.02
  %0 = load i32, ptr %arrayidx, align 4
  %mul = mul i32 %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi i32 [ %mul, %for.body ]
  ret i32 %f_prod.0.lcssa
}

define i32 @test_multiple_int_phi_operands_initalise_to_non_zero(ptr %arr_d, i1 %entry_cond) {
; CHECK-LABEL: @test_multiple_int_phi_operands_initalise_to_non_zero(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[ENTRY_COND:%.*]], label [[FOR_BODY:%.*]], label [[ENTRY_2:%.*]]
; CHECK:       entry_2:
; CHECK-NEXT:    br label [[FOR_BODY]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_02:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ 0, [[ENTRY_2]] ], [ [[INC:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[F_PROD_01:%.*]] = phi i32 [ 0, [[ENTRY]] ], [ 1, [[ENTRY_2]] ], [ [[MUL:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds nuw i32, ptr [[ARR_D:%.*]], i64 [[I_02]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[MUL]] = mul i32 [[F_PROD_01]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i64 [[I_02]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[I_02]], 999
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret i32 [[MUL]]
;
entry:
  br i1 %entry_cond, label %for.body, label %entry_2

entry_2:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [0, %entry_2], [ %inc, %for.body ]
  %f_prod.01 = phi i32 [ 0, %entry ], [1, %entry_2], [ %mul, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr %arr_d, i64 %i.02
  %0 = load i32, ptr %arrayidx, align 4
  %mul = mul i32 %f_prod.01, %0
  %inc = add i64 %i.02, 1
  %cmp = icmp ult i64 %inc, 1000
  br i1 %cmp, label %for.body, label %end

end:                                              ; preds = %for.body
  %f_prod.0.lcssa = phi i32 [ %mul, %for.body ]
  ret i32 %f_prod.0.lcssa
}