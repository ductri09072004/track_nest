import 'package:flutter_test/flutter_test.dart';
import 'package:testverygood/app/app.dart';
import 'package:testverygood/feature/history_main.dart';
import 'package:testverygood/feature/home_main.dart';
import 'package:testverygood/feature/statistical_main.dart';

void main() {
  group('App Widget Tests', () {
    testWidgets('renders App widget and finds CounterPage', (tester) async {
      // Khởi chạy widget App
      await tester.pumpWidget(const App());

      // Kiểm tra xem CounterPage có xuất hiện hay không
      expect(find.byType(SplitMoneyPage), findsOneWidget);
      expect(find.byType(HistoryPage), findsOneWidget);
      expect(find.byType(StatisticalPage), findsOneWidget);
    });

    // Test bổ sung: Đảm bảo không có lỗi trong widget App
    testWidgets('App renders without throwing', (tester) async {
      await tester.pumpWidget(const App());
      expect(tester.takeException(), isNull);
    });
  });
}
