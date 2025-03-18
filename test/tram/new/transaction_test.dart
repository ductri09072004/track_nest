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
    Exception? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: null, // Truyền giá trị null để gây lỗi
        selectedCategory: '123',
        selectedDate: DateTime.now(),
        money: '1000',
        note: 'Test note',
        toFrom: 'Alice',
        type: 'expense',
        client: mockClient,
      );
    } catch (e) {
      thrownException = e as Exception;
    }
    expect(thrownException, isA<Exception>());
    expect(thrownException.toString(), contains('UUID không được rỗng'));
  });

  test('Lỗi khi số tiền <= 0', () async {
    Exception? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: 'tramtest2', // Truyền giá trị null để gây lỗi
        selectedCategory: '123',
        selectedDate: DateTime.now(),
        money: '0',
        note: 'Test note',
        toFrom: 'Alice',
        type: 'expense',
        client: mockClient,
      );
    } catch (e) {
      thrownException = e as Exception;
    }
    expect(thrownException, isA<Exception>());
    expect(thrownException.toString(), contains('Số tiền phải lớn hơn 0'));
  });

  test('Lỗi khi ngày giao dịch ở tương lai', () async {
    Exception? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: 'tramtest2', // Truyền giá trị null để gây lỗi
        selectedCategory: '123',
        selectedDate: DateTime.now().add(const Duration(days: 1)),
        money: '1000',
        note: 'Test note',
        toFrom: 'Alice',
        type: 'expense',
        client: mockClient,
      );
    } catch (e) {
      thrownException = e as Exception;
    }
    expect(thrownException, isA<Exception>());
    expect(
      thrownException.toString(),
      contains('Ngày giao dịch không được ở tương lai'),
    );
  });

  test('Lưu giao dịch thất bại', () async {
    Exception? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: 'tramtest3', // Truyền giá trị null để gây lỗi
        selectedCategory: '',
        selectedDate: DateTime.now().add(const Duration(days: 1)),
        money: '',
        note: '',
        toFrom: '',
        type: '',
        client: mockClient,
      );
    } catch (e) {
      thrownException = e as Exception;
    }
    expect(thrownException, isA<Exception>());
    // expect(
    //   thrownException.toString(),
    //   contains('Ngày giao dịch không được ở tương lai'),
    // );
  });

  test('Lưu giao dịch thành công', () async {
    Exception? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: '123',
        selectedCategory: 'food',
        selectedDate: DateTime.now(),
        money: '10000',
        note: 'Ăn sáng',
        toFrom: 'Quán ăn',
        type: 'expense',
        client: mockClient,
      );
      expect(result, true);
    } catch (e) {
      thrownException = e as Exception;
    }
    expect(thrownException, isNull);
  });
}
