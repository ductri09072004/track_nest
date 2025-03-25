import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'api/trans_api.dart';
import 'transaction_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  setUp(() {
    mockClient = MockClient();
  });

  // const testUuid = 'tramtest';
  // const testType = 'expense';
  // const testTofrom = 'Dtri';
  // const testNote = 'Buy a book';
  // const testMoney = '150000';
  // // const testDate = '15/03/2025';
  // const testCateid = 'Shopping';
  // // const testImage = 'path/to/image.png';

  group('Lưu giao dịch', () {
    const testUuid = 'tramtest-1';
    const testselectedCategory = 'Shopping';
    final testselectedDate = DateTime.now();
    const testMoney = '150000';
    const testNote = 'Buy a book';
    const testTofrom = 'Dtri';
    const testType = 'expense';

    group('Lưu thành công', () {
      test('Lưu thành công statusCode = 200', () async {
        when(
          mockClient.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 200));
        final result = await TransactionService.saveTransaction(
          uuid: testUuid,
          selectedCategory: testselectedCategory,
          selectedDate: testselectedDate,
          money: testMoney,
          note: testNote,
          toFrom: testTofrom,
          type: testType,
          client: mockClient,
        );
        expect(result, true);
      });

      test('Lưu thành công statusCode = 201', () async {
        when(
          mockClient.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 201));
        final result = await TransactionService.saveTransaction(
          uuid: testUuid,
          selectedCategory: testselectedCategory,
          selectedDate: testselectedDate,
          money: testMoney,
          note: '',
          toFrom: '',
          type: 'income',
          client: mockClient,
        );
        expect(result, true);
      });
    });

    group('Lưu thất bại', () {
      test('Lưu thất bại statusCode = 400', () async {
        when(
          mockClient.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('{"error": "Invalid data"}', 400),
        );
        final result = await TransactionService.saveTransaction(
          uuid: testUuid,
          selectedCategory: testselectedCategory,
          selectedDate: testselectedDate,
          money: testMoney,
          note: testNote,
          toFrom: testTofrom,
          type: testType,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Lưu thất bại statusCode = 500', () async {
        when(
          mockClient.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('{"error": "Invalid data"}', 500),
        );
        final result = await TransactionService.saveTransaction(
          uuid: testUuid,
          selectedCategory: testselectedCategory,
          selectedDate: testselectedDate,
          money: testMoney,
          note: testNote,
          toFrom: testTofrom,
          type: testType,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Lỗi khi uuid rỗng', () async {
        Exception? thrownException;
        try {
          await TransactionService.saveTransaction(
            uuid: '',
            selectedCategory: testselectedCategory,
            selectedDate: testselectedDate,
            money: testMoney,
            note: testNote,
            toFrom: testTofrom,
            type: testType,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(), contains('UUID không được rỗng'));
      });

      test('Lỗi khi category rỗng', () async {
        Exception? thrownException;
        try {
          await TransactionService.saveTransaction(
            uuid: testUuid,
            selectedCategory: '',
            selectedDate: testselectedDate,
            money: testMoney,
            note: testNote,
            toFrom: testTofrom,
            type: testType,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(
            thrownException.toString(), contains('Category không được rỗng'));
      });

      test('Lỗi khi money rỗng', () async {
        Exception? thrownException;
        try {
          await TransactionService.saveTransaction(
            uuid: testUuid,
            selectedCategory: testselectedCategory,
            selectedDate: testselectedDate,
            money: '',
            note: testNote,
            toFrom: testTofrom,
            type: testType,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(), contains('money không được rỗng'));
      });

      test('Lỗi khi type rỗng', () async {
        Exception? thrownException;
        try {
          await TransactionService.saveTransaction(
            uuid: testUuid,
            selectedCategory: testselectedCategory,
            selectedDate: testselectedDate,
            money: testMoney,
            note: testNote,
            toFrom: testTofrom,
            type: '',
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(), contains('type không được rỗng'));
      });

      test('Lỗi khi money chứa chữ cái', () async {
        Exception? thrownException;
        try {
          await TransactionService.saveTransaction(
            uuid: testUuid,
            selectedCategory: testselectedCategory,
            selectedDate: testselectedDate,
            money: 'afe',
            note: testNote,
            toFrom: testTofrom,
            type: testType,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(),
            contains('Số tiền không được chứa chữ cái'));
      });

      test('Lỗi khi money < 0', () async {
        Exception? thrownException;
        try {
          await TransactionService.saveTransaction(
            uuid: testUuid,
            selectedCategory: testselectedCategory,
            selectedDate: testselectedDate,
            money: '-90000',
            note: testNote,
            toFrom: testTofrom,
            type: testType,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(), contains('Số tiền phải lớn hơn 0'));
      });

      test('Lỗi khi money = 0', () async {
        Exception? thrownException;
        try {
          await TransactionService.saveTransaction(
            uuid: testUuid,
            selectedCategory: testselectedCategory,
            selectedDate: testselectedDate,
            money: '0',
            note: testNote,
            toFrom: testTofrom,
            type: testType,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(), contains('Số tiền phải lớn hơn 0'));
      });
    });
  });

  group('Xóa giao dịch', () {
    const testtransactionId = 'tramtest-2';

    group('Xóa thành công', () {
      test('Xóa thành công với status 200', () async {
        when(
          mockClient.delete(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 200));
        final result = await TransactionService.deleteTransaction(
          transactionId: testtransactionId,
          client: mockClient,
        );
        expect(result, true);
      });

      test('Xóa thành công với status 204', () async {
        when(
          mockClient.delete(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 204));
        final result = await TransactionService.deleteTransaction(
          transactionId: testtransactionId,
          client: mockClient,
        );
        expect(result, true);
      });
    });

    group('Xóa thất bại', () {
      test('Xóa thất bại với lỗi server (status 400)', () async {
        when(
          mockClient.delete(
            any,
          ),
        ).thenAnswer((_) async => http.Response('Bad Request', 400));
        final result = await TransactionService.deleteTransaction(
          transactionId: testtransactionId,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Xóa thất bại với lỗi server (status 500)', () async {
        when(
          mockClient.delete(
            any,
          ),
        ).thenAnswer((_) async => http.Response('Bad Request', 500));
        final result = await TransactionService.deleteTransaction(
          transactionId: testtransactionId,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Xóa thất bại do server không phản hồi', () async {
        when(
          mockClient.delete(
            any,
          ),
        ).thenThrow(Exception('Failed to connect'));
        final result = await TransactionService.deleteTransaction(
          transactionId: testtransactionId,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Lỗi khi transactionId rỗng', () async {
        Exception? thrownException;
        try {
          await TransactionService.deleteTransaction(
            transactionId: '',
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(
          thrownException.toString(),
          contains('ID giao dịch không được rỗng'),
        );
      });
    });
  });

  group('Cập nhật giao dịch', () {
    final testselectedDate = DateTime.now();
    const testMoney = 150000;
    const testNote = 'Buy a book';
    const testTofrom = 'Dtri';
    const testtransactionId = 'tramtest-3';

    group('Cập nhật thành công', () {
      test('Cập nhật thành công với status 200', () async {
        when(
          mockClient.put(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 200));
        final result = await TransactionService.updateTransaction(
          transactionId: testtransactionId,
          money: testMoney,
          note: testNote,
          toFrom: testTofrom,
          selectedDate: testselectedDate,
          client: mockClient,
        );
        expect(result, true);
      });
    });

    group('Cập nhật thất bại', () {
      test('Cập nhật thất bại với lỗi server (status 400)', () async {
        when(
          mockClient.put(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('Bad Request', 400));
        final result = await TransactionService.updateTransaction(
          transactionId: testtransactionId,
          money: testMoney,
          note: testNote,
          toFrom: testTofrom,
          selectedDate: testselectedDate,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Cập nhật thất bại với lỗi server (status 500)', () async {
        when(
          mockClient.put(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('Bad Request', 400));
        final result = await TransactionService.updateTransaction(
          transactionId: testtransactionId,
          money: testMoney,
          note: testNote,
          toFrom: testTofrom,
          selectedDate: testselectedDate,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Lỗi khi transactionId rỗng', () async {
        Exception? thrownException;
        try {
          await TransactionService.updateTransaction(
            transactionId: '',
            money: testMoney,
            note: testNote,
            toFrom: testTofrom,
            selectedDate: testselectedDate,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(),
            contains('ID giao dịch không được rỗng'),);
      });

      test('Lỗi khi số tiền < 0', () async {
        Exception? thrownException;
        try {
          await TransactionService.updateTransaction(
            transactionId: testtransactionId,
            money: -90500,
            note: testNote,
            toFrom: testTofrom,
            selectedDate: testselectedDate,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(), contains('Số tiền phải lớn hơn 0'));
      });
    });
  });
}
