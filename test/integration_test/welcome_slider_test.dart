import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testverygood/features/main_navbar.dart';
import 'package:testverygood/features/welcome/view/welcome_screen.dart';
import 'package:testverygood/features/welcome/widgets/page1.dart';
import 'package:testverygood/features/welcome/widgets/page2.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Kiểm tra WelcomeSlider hoạt động đúng',
      (WidgetTester tester) async {
    // Khởi chạy WelcomeSlider
    await tester.pumpWidget(const MaterialApp(home: WelcomeSlider()));

    // Kiểm tra xem PageView có 2 trang không
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(WPage1), findsOneWidget);
    expect(find.byType(WPage2), findsNothing); // Trang đầu tiên đang hiển thị

    // Vuốt sang trang 2
    await tester.drag(find.byType(PageView), const Offset(-300, 0));
    await tester.pumpAndSettle(); // Chờ animation hoàn tất

    // Kiểm tra trang 2 đã hiển thị
    expect(find.byType(WPage2), findsOneWidget);

    // Kiểm tra nút "Get Started" có xuất hiện không
    expect(find.text('Get Started'), findsOneWidget);

    // Nhấn nút "Get Started"
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle(); // Chờ chuyển màn hình hoàn tất

    // Kiểm tra xem có điều hướng đến `MainPage` không
    expect(find.byType(MainPage), findsOneWidget);
  });
}
