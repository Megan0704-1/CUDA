// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump -DEMPTY \
// RUN:  -DRESOURCE=StructuredBuffer %s | FileCheck -DRESOURCE=StructuredBuffer \
// RUN:  -check-prefix=EMPTY %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump \
// RUN:   -DRESOURCE=StructuredBuffer %s | FileCheck -DRESOURCE=StructuredBuffer \
// RUN:   -check-prefixes=CHECK,CHECK-SRV,CHECK-SUBSCRIPT,CHECK-LOAD %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump -DEMPTY \
// RUN:  -DRESOURCE=RWStructuredBuffer %s | FileCheck -DRESOURCE=RWStructuredBuffer \
// RUN:  -check-prefix=EMPTY %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump \
// RUN:   -DRESOURCE=RWStructuredBuffer %s | FileCheck -DRESOURCE=RWStructuredBuffer \
// RUN:   -check-prefixes=CHECK,CHECK-UAV,CHECK-SUBSCRIPT,CHECK-COUNTER,CHECK-LOAD %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump -DEMPTY \
// RUN:  -DRESOURCE=AppendStructuredBuffer %s | FileCheck -DRESOURCE=AppendStructuredBuffer \
// RUN:  -check-prefix=EMPTY %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump \
// RUN:   -DRESOURCE=AppendStructuredBuffer %s | FileCheck -DRESOURCE=AppendStructuredBuffer \
// RUN:   -check-prefixes=CHECK,CHECK-UAV,CHECK-NOSUBSCRIPT,CHECK-APPEND %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump -DEMPTY \
// RUN:  -DRESOURCE=ConsumeStructuredBuffer %s | FileCheck -DRESOURCE=ConsumeStructuredBuffer \
// RUN:  -check-prefix=EMPTY %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump \
// RUN:   -DRESOURCE=ConsumeStructuredBuffer %s | FileCheck -DRESOURCE=ConsumeStructuredBuffer \
// RUN:   -check-prefixes=CHECK,CHECK-UAV,CHECK-NOSUBSCRIPT,CHECK-CONSUME %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump -DEMPTY \
// RUN:  -DRESOURCE=RasterizerOrderedStructuredBuffer %s | FileCheck -DRESOURCE=RasterizerOrderedStructuredBuffer \
// RUN:  -check-prefix=EMPTY %s
//
// RUN: %clang_cc1 -triple dxil-pc-shadermodel6.0-library -x hlsl -ast-dump \
// RUN:   -DRESOURCE=RasterizerOrderedStructuredBuffer %s | FileCheck -DRESOURCE=RasterizerOrderedStructuredBuffer \
// RUN:   -check-prefixes=CHECK,CHECK-UAV,CHECK-ROV,CHECK-SUBSCRIPT,CHECK-LOAD %s

// This test tests two different AST generations for each structured buffer.
// The "EMPTY" test mode verifies the AST generated by forward declaration
// of the HLSL types which happens on initializing the HLSL external AST with
// an AST Context.

// The non-empty mode has a use that requires the resource type be complete,
// which results in the AST being populated by the external AST source. That
// case covers the full implementation of the template declaration and the
// instantiated specialization.

// EMPTY: ClassTemplateDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> implicit [[RESOURCE]]
// EMPTY-NEXT: TemplateTypeParmDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> typename depth 0 index 0 element_type
// EMPTY-NEXT: ConceptSpecializationExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'bool' Concept 0x{{[0-9A-Fa-f]+}} '__is_structured_resource_element_compatible'
// EMPTY-NEXT: ImplicitConceptSpecializationDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc>
// EMPTY-NEXT: TemplateArgument type 'type-parameter-0-0'
// EMPTY-NEXT: TemplateTypeParmType 0x{{[0-9A-Fa-f]+}} 'type-parameter-0-0' dependent depth 0 index 0
// EMPTY-NEXT: TemplateTypeParm 0x{{[0-9A-Fa-f]+}} ''
// EMPTY-NEXT: TemplateArgument type 'element_type':'type-parameter-0-0'
// EMPTY-NEXT: TemplateTypeParmType 0x{{[0-9A-Fa-f]+}} 'element_type' dependent depth 0 index 0
// EMPTY-NEXT: TemplateTypeParm 0x{{[0-9A-Fa-f]+}} 'element_type'
// EMPTY-NEXT: CXXRecordDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> implicit <undeserialized declarations> class [[RESOURCE]]
// EMPTY-NEXT: FinalAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit final

// There should be no more occurrences of [[RESOURCE]]
// EMPTY-NOT: {{[^[:alnum:]]}}[[RESOURCE]]

#ifndef EMPTY

RESOURCE<float> Buffer;

#endif

// CHECK: ClassTemplateDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> implicit [[RESOURCE]]
// CHECK-NEXT: TemplateTypeParmDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> typename depth 0 index 0 element_type
// CHECK-NEXT: ConceptSpecializationExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'bool' Concept 0x{{[0-9A-Fa-f]+}} '__is_structured_resource_element_compatible'
// CHECK-NEXT: ImplicitConceptSpecializationDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc>
// CHECK-NEXT: TemplateArgument type 'type-parameter-0-0'
// CHECK-NEXT: TemplateTypeParmType 0x{{[0-9A-Fa-f]+}} 'type-parameter-0-0' dependent depth 0 index 0
// CHECK-NEXT: TemplateTypeParm 0x{{[0-9A-Fa-f]+}} ''
// CHECK-NEXT: TemplateArgument type 'element_type':'type-parameter-0-0'
// CHECK-NEXT: TemplateTypeParmType 0x{{[0-9A-Fa-f]+}} 'element_type' dependent depth 0 index 0
// CHECK-NEXT: TemplateTypeParm 0x{{[0-9A-Fa-f]+}} 'element_type'
// CHECK-NEXT: CXXRecordDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> implicit class [[RESOURCE]] definition

// CHECK: FinalAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit final
// CHECK-NEXT: FieldDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> implicit __handle '__hlsl_resource_t
// CHECK-SRV-SAME{LITERAL}: [[hlsl::resource_class(SRV)]]
// CHECK-UAV-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]
// CHECK-NEXT: HLSLResourceAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit RawBuffer

// CHECK-SUBSCRIPT: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> operator[] 'const element_type &(unsigned int) const'
// CHECK-SUBSCRIPT-NEXT: ParmVarDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> Index 'unsigned int'
// CHECK-SUBSCRIPT-NEXT: CompoundStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-SUBSCRIPT-NEXT: ReturnStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-SUBSCRIPT-NEXT: UnaryOperator 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type' prefix '*' cannot overflow
// CHECK-SUBSCRIPT-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type *'
// CHECK-SUBSCRIPT-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_resource_getpointer' 'void (...) noexcept'
// CHECK-SUBSCRIPT-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-SUBSCRIPT-SAME{LITERAL}: [[hlsl::resource_class(
// CHECK-SUBSCRIPT-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-SUBSCRIPT-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]
// CHECK-SUBSCRIPT-SAME: ' lvalue .__handle 0x{{[0-9A-Fa-f]+}}
// CHECK-SUBSCRIPT-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'const [[RESOURCE]]<element_type>' lvalue implicit this
// CHECK-SUBSCRIPT-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'unsigned int' ParmVar 0x{{[0-9A-Fa-f]+}} 'Index' 'unsigned int'
// CHECK-SUBSCRIPT-NEXT: AlwaysInlineAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit always_inline

// CHECK-SUBSCRIPT-NEXT: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> operator[] 'element_type &(unsigned int)'
// CHECK-SUBSCRIPT-NEXT: ParmVarDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> Index 'unsigned int'
// CHECK-SUBSCRIPT-NEXT: CompoundStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-SUBSCRIPT-NEXT: ReturnStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-SUBSCRIPT-NEXT: UnaryOperator 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type' prefix '*' cannot overflow
// CHECK-SUBSCRIPT-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type *'
// CHECK-SUBSCRIPT-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_resource_getpointer' 'void (...) noexcept'
// CHECK-SUBSCRIPT-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-SUBSCRIPT-SAME{LITERAL}: [[hlsl::resource_class(
// CHECK-SUBSCRIPT-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-SUBSCRIPT-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]
// CHECK-SUBSCRIPT-SAME: ' lvalue .__handle 0x{{[0-9A-Fa-f]+}}
// CHECK-SUBSCRIPT-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '[[RESOURCE]]<element_type>' lvalue implicit this
// CHECK-SUBSCRIPT-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'unsigned int' ParmVar 0x{{[0-9A-Fa-f]+}} 'Index' 'unsigned int'
// CHECK-SUBSCRIPT-NEXT: AlwaysInlineAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit always_inline

// CHECK-NOSUBSCRIPT-NOT: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> operator[] 'const element_type &(unsigned int) const'
// CHECK-NOSUBSCRIPT-NOT: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> operator[] 'element_type &(unsigned int)'

// CHECK-LOAD: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> Load 'element_type (unsigned int)'
// CHECK-LOAD-NEXT: ParmVarDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> Index 'unsigned int'
// CHECK-LOAD-NEXT: CompoundStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-LOAD-NEXT: ReturnStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-LOAD-NEXT: UnaryOperator 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type' prefix '*' cannot overflow
// CHECK-LOAD-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type *'
// CHECK-LOAD-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_resource_getpointer' 'void (...) noexcept'
// CHECK-LOAD-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-LOAD-SAME{LITERAL}: [[hlsl::resource_class(
// CHECK-LOAD-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]
// CHECK-LOAD-SAME: ' lvalue .__handle 0x{{[0-9A-Fa-f]+}}
// CHECK-LOAD-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '[[RESOURCE]]<element_type>' lvalue implicit this
// CHECK-LOAD-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'unsigned int' ParmVar 0x{{[0-9A-Fa-f]+}} 'Index' 'unsigned int'
// CHECK-LOAD-NEXT: AlwaysInlineAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit always_inline

// CHECK-COUNTER: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> IncrementCounter 'unsigned int ()'
// CHECK-COUNTER-NEXT: CompoundStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-COUNTER-NEXT: ReturnStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-COUNTER-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'unsigned int'
// CHECK-COUNTER-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_buffer_update_counter' 'unsigned int (...) noexcept'
// CHECK-COUNTER-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-COUNTER-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-COUNTER-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-COUNTER-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]' lvalue .__handle
// CHECK-COUNTER-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'RWStructuredBuffer<element_type>' lvalue implicit this
// CHECK-COUNTER-NEXT: IntegerLiteral 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'int' 1
// CHECK-COUNTER-NEXT: AlwaysInlineAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit always_inline

// CHECK-COUNTER-NEXT: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> DecrementCounter 'unsigned int ()'
// CHECK-COUNTER-NEXT: CompoundStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-COUNTER-NEXT: ReturnStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-COUNTER-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'unsigned int'
// CHECK-COUNTER-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_buffer_update_counter' 'unsigned int (...) noexcept'
// CHECK-COUNTER-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-COUNTER-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-COUNTER-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-COUNTER-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]' lvalue .__handle
// CHECK-COUNTER-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'RWStructuredBuffer<element_type>' lvalue implicit this
// CHECK-COUNTER-NEXT: IntegerLiteral 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'int' -1
// CHECK-COUNTER-NEXT: AlwaysInlineAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit always_inline

// CHECK-APPEND: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> Append 'void (element_type)'
// CHECK-APPEND-NEXT: ParmVarDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> value 'element_type'
// CHECK-APPEND-NEXT: CompoundStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-APPEND-NEXT: BinaryOperator 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type' '='
// CHECK-APPEND-NEXT: UnaryOperator 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type' prefix '*' cannot overflow
// CHECK-APPEND-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type *'
// CHECK-APPEND-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_resource_getpointer' 'void (...) noexcept'
// CHECK-APPEND-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-APPEND-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-APPEND-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-APPEND-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]' lvalue .__handle
// CHECK-APPEND-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '[[RESOURCE]]<element_type>' lvalue implicit this
// CHECK-APPEND-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'unsigned int'
// CHECK-APPEND-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_buffer_update_counter' 'unsigned int (...) noexcept'
// CHECK-APPEND-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-APPEND-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-APPEND-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-APPEND-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]' lvalue .__handle
// CHECK-APPEND-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '[[RESOURCE]]<element_type>' lvalue implicit this
// CHECK-APPEND-NEXT: IntegerLiteral 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'int' 1
// CHECK-APPEND-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type' ParmVar 0x{{[0-9A-Fa-f]+}} 'value' 'element_type'

// CHECK-CONSUME: CXXMethodDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> Consume 'element_type ()'
// CHECK-CONSUME-NEXT: CompoundStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-CONSUME-NEXT: ReturnStmt 0x{{[0-9A-Fa-f]+}} <<invalid sloc>>
// CHECK-CONSUME-NEXT: UnaryOperator 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type' prefix '*' cannot overflow
// CHECK-CONSUME-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'element_type *'
// CHECK-CONSUME-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_resource_getpointer' 'void (...) noexcept'
// CHECK-CONSUME-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-CONSUME-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-CONSUME-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-CONSUME-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]' lvalue .__handle
// CHECK-CONSUME-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '[[RESOURCE]]<element_type>' lvalue implicit this
// CHECK-CONSUME-NEXT: CallExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'unsigned int'
// CHECK-CONSUME-NEXT: DeclRefExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '<builtin fn type>' Function 0x{{[0-9A-Fa-f]+}} '__builtin_hlsl_buffer_update_counter' 'unsigned int (...) noexcept'
// CHECK-CONSUME-NEXT: MemberExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '__hlsl_resource_t
// CHECK-CONSUME-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-CONSUME-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-CONSUME-SAME{LITERAL}: [[hlsl::contained_type(element_type)]]' lvalue .__handle
// CHECK-CONSUME-NEXT: CXXThisExpr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> '[[RESOURCE]]<element_type>' lvalue implicit this
// CHECK-CONSUME-NEXT: IntegerLiteral 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> 'int' -1

// CHECK: ClassTemplateSpecializationDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> class [[RESOURCE]] definition

// CHECK: TemplateArgument type 'float'
// CHECK-NEXT: BuiltinType 0x{{[0-9A-Fa-f]+}} 'float'
// CHECK-NEXT: FinalAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit final
// CHECK-NEXT: FieldDecl 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> <invalid sloc> implicit __handle '__hlsl_resource_t
// CHECK-SRV-SAME{LITERAL}: [[hlsl::resource_class(SRV)]]
// CHECK-UAV-SAME{LITERAL}: [[hlsl::resource_class(UAV)]]
// CHECK-ROV-SAME{LITERAL}: [[hlsl::is_rov]]
// CHECK-SAME{LITERAL}: [[hlsl::raw_buffer]]
// CHECK-SAME{LITERAL}: [[hlsl::contained_type(float)]]
// CHECK-NEXT: HLSLResourceAttr 0x{{[0-9A-Fa-f]+}} <<invalid sloc>> Implicit RawBuffer