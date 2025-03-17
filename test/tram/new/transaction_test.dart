import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'api/trans_api.dart';
import 'transaction_test.mocks.dart';

// Mock HTTP Client
@GenerateMocks([http.Client])
// class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  test('Lỗi khi UUID null', () async {
    expect(
      () => TransactionService.saveTransaction(
        uuid: null,
        selectedCategory: '123',
        selectedDate: DateTime.now(),
        money: '1000',
        note: 'Test note',
        toFrom: 'Alice',
        type: 'expense',
      ),
      throwsA(
        predicate(
          (e) =>
              e is Exception && e.toString().contains('UUID không được rỗng'),
        ),
      ),
    );
  });

  test('Lỗi khi số tiền <= 0', () async {
    expect(
      () async => TransactionService.saveTransaction(
        uuid: '123',
        selectedCategory: 'food',
        selectedDate: DateTime.now(),
        money: '0',
        note: 'Ăn sáng',
        toFrom: 'Quán ăn',
        type: 'expense',
      ),
      throwsA(
        predicate(
          (e) =>
              e is Exception && e.toString().contains('Số tiền phải lớn hơn 0'),
        ),
      ),
    );
  });

  test('Lỗi khi ngày giao dịch ở tương lai', () async {
    expect(
      () async => TransactionService.saveTransaction(
        uuid: '123',
        selectedCategory: 'food',
        selectedDate: DateTime.now().add(const Duration(days: 1)),
        money: '10000',
        note: 'Ăn sáng',
        toFrom: 'Quán ăn',
        type: 'expense',
      ),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains('Ngày giao dịch không được ở tương lai'),
        ),
      ),
    );
  });

  test('Lưu giao dịch thất bại', () async {
    when(
      mockClient.post(
        Uri.parse('http://3.26.221.69:5000/api/transactions'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode({'success': false}), 500),
    );

    final result = await TransactionService.saveTransaction(
      uuid: '123',
      selectedCategory: 'food',
      selectedDate: DateTime.now(),
      money: '10000',
      note: 'Ăn sáng',
      toFrom: 'Quán ăn',
      type: 'expense',
      client: mockClient, // 👈 Truyền mockClient vào
    );

    expect(result, false);
  });

  test('Lưu giao dịch thành công', () async {
    when(
      mockClient.post(
        Uri.parse('http://3.26.221.69:5000/api/transactions'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode({'success': true}), 201),
    );

    final result = await TransactionService.saveTransaction(
      uuid: '123',
      selectedCategory: 'food',
      selectedDate: DateTime.now(),
      money: '10000',
      note: 'Ăn sáng',
      toFrom: 'Quán ăn',
      type: 'expense',
    );

    expect(result, true);
  });

  // test('Lưu giao dịch thất bại với lỗi server', () async {
  //   when(mockClient.post(
  //     any,
  //     headers: anyNamed('headers'),
  //     body: anyNamed('body'),
  //   ),).thenAnswer((_) async =>
  //       http.Response(jsonEncode({'error': 'Internal Server Error'}), 500),);

  //   final result = await TransactionService.saveTransaction(
  //     uuid: '123',
  //     selectedCategory: 'food',
  //     selectedDate: DateTime.now(),
  //     money: '10000',
  //     note: 'Ăn sáng',
  //     toFrom: 'Quán ăn',
  //     type: 'expense',
  //   );

  //   expect(result, false);
  // });
}
