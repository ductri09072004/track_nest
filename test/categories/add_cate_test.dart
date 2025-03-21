import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testverygood/features/settings/categories/widgets/body_addcate.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Mock class cho storage và HTTP client
class MockSecureStorage extends Mock implements FlutterSecureStorage {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockSecureStorage mockStorage;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockStorage = MockSecureStorage();
    mockHttpClient = MockHttpClient();
  });

  testWidgets('Hiển thị đúng các thành phần UI', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BodyMain()));

    expect(find.text('Type'), findsOneWidget);
    expect(find.text('Icon'), findsOneWidget);
    expect(find.text('Category name'), findsOneWidget);
    expect(find.byType(InputClassic), findsNWidgets(2));
    expect(find.byType(Button), findsOneWidget);
  });

  testWidgets('Chuyển đổi giữa Expense và Income', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BodyMain()));

    final expenseButton = find.text('Expenses');
    final incomeButton = find.text('Income');

    await tester.tap(incomeButton);
    await tester.pump();
    expect(find.text('Income'), findsOneWidget);
  });

  testWidgets('Nhập icon và category name', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BodyMain()));

    await tester.enterText(find.byType(InputClassic).first, '🔥');
    await tester.enterText(find.byType(InputClassic).last, 'Food');
    await tester.pump();

    expect(find.text('🔥'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
  });

  testWidgets('Hiển thị thông báo khi UUID bị thiếu',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: BodyMain()));

    await tester.tap(find.byType(Button));
    await tester.pump();

    expect(find.text('Không tìm thấy UUID!'), findsOneWidget);
  });
}
