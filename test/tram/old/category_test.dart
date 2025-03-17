// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:testverygood/data/data_api/add_cate_api.dart';
// import 'package:testverygood/features/groupsplit/history/widgets/content.dart';
// // import 'package:testverygood/data/data_api/cate_api_for_test.dart';
// // import 'category_test.mocks.dart';

// // Mock BuildContext
// class MockBuildContext extends Mock implements BuildContext {}

// // Mock ScaffoldMessengerState
// class MockScaffoldMessengerState extends Mock
//     implements ScaffoldMessengerState {
//   @override
//   String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
//     return super.toString();
//   }
// }

// @GenerateMocks([http.Client])
// void main() {


//   late MockBuildContext mockContext;
//   late MockScaffoldMessengerState mockScaffoldMessenger;

//   setUp(() {
//     mockContext = MockBuildContext();
//     mockScaffoldMessenger = MockScaffoldMessengerState();

//     // Mock phương thức `ScaffoldMessenger.of(context)`
//     when(ScaffoldMessenger.of(mockContext)).thenReturn(mockScaffoldMessenger);

//     // Giả lập `ScaffoldMessenger.of(context)`
//     when(mockContext.findAncestorStateOfType<ScaffoldMessengerState>())
//         .thenReturn(mockScaffoldMessenger);
//   });

//   group('cate()', () {
//     // test('Lưu danh mục thất bại khi uuid rỗng', () async {
//     //   await CategoryService.saveCategory(
//     //     context: mockContext,
//     //     uuid: '',
//     //     icon: 'icon.png',
//     //     name: 'Food',
//     //     isExpense: true,
//     //   );

//     //   // Kiểm tra có hiển thị SnackBar không
//     //   verify(mockScaffoldMessenger.showSnackBar(any<SnackBar>())).called(1);
//     // });

//     // test('Lưu danh mục thất bại khi icon rỗng', () async {
//     //   await CategoryService.saveCategory(
//     //     context: mockContext,
//     //     uuid: '123',
//     //     icon: '',
//     //     name: 'Food',
//     //     isExpense: true,
//     //   );

//     //   verify(mockScaffoldMessenger.showSnackBar(any)).called(1);
//     // });

//     // test('Lưu danh mục thất bại khi name rỗng', () async {
//     //   await CategoryService.saveCategory(
//     //     context: mockContext,
//     //     uuid: '123',
//     //     icon: 'icon.png',
//     //     name: '',
//     //     isExpense: true,
//     //   );

//     //   verify(mockScaffoldMessenger.showSnackBar(any)).called(1);
//     // });

//     test('Lưu danh mục thành công khi đủ thông tin', () async {
//       await CategoryService.saveCategory(
//         context: mockContext,
//         uuid: '123',
//         icon: 'icon.png',
//         name: 'Food',
//         isExpense: true,
//       );

//       verify(mockScaffoldMessenger
//               .showSnackBar(const SnackBar(content: Content('fádf'))))
//           .called(1);
//     });
//   });
// }
