// import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// import 'package:mockito/mockito.dart';
import 'api/trans_api.dart';
import 'transaction_test.mocks.dart';
// import 'package:testverygood/assets/png/logo_app.png';

// Mock HTTP Client
@GenerateMocks([http.Client])
// class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  const testUuid = 'tramtest';
  const testType = 'expense';
  const testTofrom = 'Dtri';
  const testNote = 'Buy a book';
  const testMoney = '150000';
  // const testDate = '15/03/2025';
  const testCateid = 'Shopping';
  // const testImage = 'path/to/image.png';

  test('Lỗi khi UUID null', () async {
    Object? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: null,
        selectedCategory: testCateid,
        selectedDate: DateTime.now(),
        money: '0',
        note: testNote,
        toFrom: testTofrom,
        type: testType,
        client: mockClient,
      );
    } catch (e) {
      thrownException = e;
    }
    expect(thrownException, isA<Exception>());
    expect(thrownException.toString(), contains('UUID không được rỗng'));
  });

  test('Lỗi khi UUID rỗng', () async {
    Object? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: '',
        selectedCategory: testCateid,
        selectedDate: DateTime.now(),
        money: '0',
        note: testNote,
        toFrom: testTofrom,
        type: testType,
        client: mockClient,
      );
    } catch (e) {
      thrownException = e;
    }
    expect(thrownException, isA<Exception>());
    expect(thrownException.toString(), contains('UUID không được rỗng'));
  });

  test('Lỗi khi số tiền = 0', () async {
    Object? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: testUuid,
        selectedCategory: testCateid,
        selectedDate: DateTime.now(),
        money: '0',
        note: testNote,
        toFrom: testTofrom,
        type: testType,
        client: mockClient,
      );
    } catch (e) {
      thrownException = e;
    }
    expect(thrownException, isA<Exception>());
    expect(thrownException.toString(), contains('Số tiền phải lớn hơn 0'));
    // print('$thrownException');
  });

  test('Lỗi khi số tiền < 0', () async {
    Object? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: testUuid,
        selectedCategory: testCateid,
        selectedDate: DateTime.now(),
        money: '-90000',
        note: testNote,
        toFrom: testTofrom,
        type: testType,
        client: mockClient,
      );
    } catch (e) {
      thrownException = e;
    }
    expect(thrownException, isA<Exception>());
    expect(thrownException.toString(), contains('Số tiền phải lớn hơn 0'));
    // print('$thrownException');
  });

  test('Lỗi khi số tiền không đúng định dạng', () async {
    Object? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: testUuid,
        selectedCategory: testCateid,
        selectedDate: DateTime.now(),
        money: '50aaa',
        note: testNote,
        toFrom: testTofrom,
        type: testType,
        client: mockClient,
      );
    } catch (e) {
      thrownException = e;
    }
    expect(thrownException, isA<Exception>());
    expect(thrownException.toString(), contains('Số tiền chỉ được chứa chữ'));
    // print('$thrownException');
  });

  test('Lỗi khi ngày giao dịch ở tương lai', () async {
    Object? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: testUuid,
        selectedCategory: testCateid,
        selectedDate: DateTime.now().add(const Duration(days: 10)),
        money: testMoney,
        note: testNote,
        toFrom: testTofrom,
        type: testType,
        client: mockClient,
      );
    } catch (e) {
      thrownException = e;
    }
    expect(thrownException, isA<Exception>());
    expect(
      thrownException.toString(),
      contains('Ngày giao dịch không được ở tương lai'),
    );
    // print('$thrownException');
  });

  test('Lưu giao dịch thất bại', () async {
    Object? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: testUuid,
        selectedCategory: '',
        selectedDate: DateTime.now(),
        money: '',
        note: '',
        toFrom: '',
        type: '',
        client: mockClient,
      );
    } catch (e) {
      thrownException = e;
      // print('⚠️ Lỗi khi lưu giao dịch: $e');
    }
    expect(thrownException, isA<Exception>());
    // expect(
    //   thrownException.toString(),
    //   contains('Ngày giao dịch không được ở tương lai'),
    // );
  });

  test('Lưu giao dịch thành công', () async {
    Object? thrownException;
    try {
      final result = await TransactionService.saveTransaction(
        uuid: testUuid,
        selectedCategory: testCateid,
        selectedDate: DateTime.now(),
        money: testMoney,
        note: testNote,
        toFrom: testTofrom,
        type: testType,
        client: mockClient,
      );
      expect(result, true);
    } catch (e) {
      // thrownException = e as Exception;
      thrownException = e; // Lưu lỗi mà không ép kiểu
      // print('⚠️ Lỗi khi lưu giao dịch: $e');
      // print(stackTrace);
    }
    expect(thrownException, isNull);
  });

  //có lưu vào db
  test('Lưu giao dịch thất bại vì lỗi server', () async {
    Object? thrownException;
    when(
      mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ),
    ).thenAnswer((_) async => http.Response('Lỗi server', 500));
    try {
      final result = await TransactionService.saveTransaction(
        uuid: testUuid,
        selectedCategory: testCateid,
        selectedDate: DateTime.now(),
        money: testMoney,
        note: testNote,
        toFrom: testTofrom,
        type: testType,
        client: mockClient,
      );
      expect(result, false);
    } catch (e) {
      // thrownException = e as Exception;
      thrownException = e; // Lưu lỗi mà không ép kiểu
      // print('⚠️ Lỗi khi lưu giao dịch: $e');
      // print(stackTrace);
    }
    expect(thrownException, isNull);
  });
}
