import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testverygood/data/data_api/add_trans_api.dart';
import 'package:testverygood/features/transaction/add_trans/view/transaction_main.dart';
import 'trans_test.mocks.dart';

@GenerateMocks([TransactionService])
void main() {
  late MockTransactionService mockTransactionService;

  setUp(() {
    mockTransactionService = MockTransactionService();
  });

  testWidgets('Khởi tạo TransactionMain với giá trị mặc định',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TransactionMain()));

    expect(find.text('Transaction'), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);
  });

  // testWidgets('Chọn ảnh từ thư viện', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: TransactionMain()));

  //   final Finder imagePickerButton = find.byType(GestureDetector);
  //   expect(imagePickerButton, findsOneWidget);

  //   await tester.tap(imagePickerButton);
  //   await tester.pump();

  //   // Giả lập chọn ảnh thành công
  //   final picker = ImagePicker();
  //   final XFile? pickedFile =
  //       await picker.pickImage(source: ImageSource.gallery);
  //   expect(pickedFile, isNotNull);
  // });

  // testWidgets('Lưu giao dịch thành công', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: TransactionMain()));

  //   when(mockTransactionService.saveTransaction(
  //     uuid: anyNamed('uuid'),
  //     selectedCategory: anyNamed('selectedCategory'),
  //     selectedDate: anyNamed('selectedDate'),
  //     money: anyNamed('money'),
  //     note: anyNamed('note'),
  //     toFrom: anyNamed('toFrom'),
  //     imageFile: anyNamed('imageFile'),
  //     type: anyNamed('type'),
  //   )).thenAnswer((_) async => true);

  //   final Finder saveButton = find.text('Save');
  //   expect(saveButton, findsOneWidget);

  //   await tester.tap(saveButton);
  //   await tester.pump();

  //   verify(mockTransactionService.saveTransaction(
  //     uuid: anyNamed('uuid'),
  //     selectedCategory: anyNamed('selectedCategory'),
  //     selectedDate: anyNamed('selectedDate'),
  //     money: anyNamed('money'),
  //     note: anyNamed('note'),
  //     toFrom: anyNamed('toFrom'),
  //     imageFile: anyNamed('imageFile'),
  //     type: anyNamed('type'),
  //   )).called(1);
  // });

  // testWidgets('Lưu giao dịch thất bại', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MaterialApp(home: TransactionMain()));

  //   when(mockTransactionService.saveTransaction(
  //     uuid: anyNamed('uuid'),
  //     selectedCategory: anyNamed('selectedCategory'),
  //     selectedDate: anyNamed('selectedDate'),
  //     money: anyNamed('money'),
  //     note: anyNamed('note'),
  //     toFrom: anyNamed('toFrom'),
  //     imageFile: anyNamed('imageFile'),
  //     type: anyNamed('type'),
  //   ),).thenAnswer((_) async => false);

  //   final Finder saveButton = find.text('Save');
  //   expect(saveButton, findsOneWidget);

  //   await tester.tap(saveButton);
  //   await tester.pump();

  //   verify(mockTransactionService.saveTransaction(
  //     uuid: anyNamed('uuid'),
  //     selectedCategory: anyNamed('selectedCategory'),
  //     selectedDate: anyNamed('selectedDate'),
  //     money: anyNamed('money'),
  //     note: anyNamed('note'),
  //     toFrom: anyNamed('toFrom'),
  //     imageFile: anyNamed('imageFile'),
  //     type: anyNamed('type'),
  //   ),).called(1);
  // });

  testWidgets('Lưu giao dịch thành công với dữ liệu đúng',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TransactionMain()));

    // Thiết lập dữ liệu giả định
    const testUUID = 'test-uuid';
    const testCategory = 'Eating';
    final testDate = DateTime(2024, 3, 15);
    const testMoney = '50000';
    const testNote = 'Lunch';
    const testToFrom = 'Restaurant';
    final testImage = File('path/to/image.png');
    const testType = 'expense';

    // Mock hàm saveTransaction trả về true
    when(mockTransactionService.saveTransaction(
      uuid: testUUID,
      selectedCategory: testCategory,
      selectedDate: testDate.toIso8601String(),
      money: testMoney,
      note: testNote,
      toFrom: testToFrom,
      imageFile: testImage.path,
      type: testType,
    ),).thenAnswer((_) async => true);

    // Nhập dữ liệu vào các ô input
    await tester.enterText(find.byType(TextField).at(0), testMoney);
    await tester.enterText(find.byType(TextField).at(1), testToFrom);
    await tester.enterText(find.byType(TextField).at(2), testNote);

    // Chọn danh mục
    // (Cần chỉnh sửa nếu dùng widget khác để chọn danh mục)
    // giả sử CategoriesText có key là 'categories'
    // await tester.tap(find.byKey(const Key('categories_text')));
    // await tester.pump();

    final Finder categoryWidget = find.byKey(const Key('categories_text'));
    expect(categoryWidget, findsOneWidget); // Kiểm tra widget tồn tại
    await tester.tap(categoryWidget);
    await tester.pumpAndSettle();
    await tester.pump();

    // Nhấn nút Save
    final Finder saveButton = find.text('Save');
    await tester.tap(saveButton);
    await tester.pump();

    // Kiểm tra mockService có nhận đúng dữ liệu không
    // verify(mockTransactionService.saveTransaction(
    //   uuid: testUUID,
    //   selectedCategory: testCategory,
    //   selectedDate: testDate.toIso8601String(),
    //   money: testMoney,
    //   note: testNote,
    //   toFrom: testToFrom,
    //   imageFile: testImage.path,
    //   type: testType,
    // ),).called(1);
  });

}
