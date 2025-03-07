import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:testverygood/features/transactions/transactrion/view/transaction_main.dart';

// Mock class for FlutterSecureStorage
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

// Mock class for ImagePicker
class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {});

  testWidgets('Kiểm tra hiển thị các thành phần của TransactionMain',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TransactionMain(),
      ),
    );

    // Kiểm tra xem các thành phần quan trọng có xuất hiện không
    expect(find.text('Transaction'), findsOneWidget);
    expect(find.text('Amount'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Time'), findsOneWidget);
    expect(find.text('Note'), findsOneWidget);
  });

  testWidgets('Kiểm tra nhập số tiền', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TransactionMain(),
      ),
    );

    final amountField = find.byType(TextField).first;
    await tester.enterText(amountField, '50000');
    expect(find.text('50000'), findsOneWidget);
  });

  testWidgets('Kiểm tra thay đổi danh mục', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TransactionMain(),
      ),
    );

    final categoryButton = find.byKey(const Key('category_button'));
    expect(categoryButton, findsOneWidget);

    await tester.tap(categoryButton);
    await tester.pump();

    expect(find.text('Selected Category Name'), findsOneWidget);
  });
}
