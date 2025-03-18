import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'api/cate_api.dart';
import 'category_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  setUp(() {
    mockClient = MockClient();
  });
  const testUuid = 'tramtest';
  const testIcon = '🍽️';
  const testName = 'Eating';
  const testIsExpense = true;

  group('saveCategory()', () {
    test('Lưu danh mục thành công', () async {
      when(
        mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response('{}', 200));
      final result = await CategoryService.saveCategory(
        uuid: testUuid,
        icon: testIcon,
        name: testName,
        isExpense: testIsExpense,
        client: mockClient,
      );
      expect(result, true);
    });

    test('Lỗi khi uuid null', () async {
      Exception? thrownException;
      try {
        final result = await CategoryService.saveCategory(
          uuid: null,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
      } catch (e) {
        thrownException = e as Exception;
      }
      expect(thrownException, isA<Exception>());
      expect(thrownException.toString(), contains('UUID không được rỗng'));
    });

    test('Lỗi khi uuid rỗng', () async {
      Exception? thrownException;
      try {
        final result = await CategoryService.saveCategory(
          uuid: '',
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
      } catch (e) {
        thrownException = e as Exception;
      }
      expect(thrownException, isA<Exception>());
      expect(thrownException.toString(), contains('UUID không được rỗng'));
    });

    test('Lỗi khi icon null', () async {
      Exception? thrownException;
      try {
        final result = await CategoryService.saveCategory(
          uuid: testUuid,
          icon: null,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
      } catch (e) {
        thrownException = e as Exception;
      }
      expect(thrownException, isA<Exception>());
      expect(thrownException.toString(), contains('Icon không được rỗng'));
    });

    test('Lỗi khi icon rỗng', () async {
      Exception? thrownException;
      try {
        final result = await CategoryService.saveCategory(
          uuid: testUuid,
          icon: '',
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
      } catch (e) {
        thrownException = e as Exception;
      }
      expect(thrownException, isA<Exception>());
      expect(thrownException.toString(), contains('Icon không được rỗng'));
    });

    test('Lỗi khi name null', () async {
      Exception? thrownException;
      try {
        final result = await CategoryService.saveCategory(
          uuid: testUuid,
          icon: testIcon,
          name: null,
          isExpense: testIsExpense,
          client: mockClient,
        );
      } catch (e) {
        thrownException = e as Exception;
      }
      expect(thrownException, isA<Exception>());
      expect(thrownException.toString(), contains('Name không được rỗng'));
    });

    test('Lỗi khi name rỗng', () async {
      Exception? thrownException;
      try {
        final result = await CategoryService.saveCategory(
          uuid: testUuid,
          icon: testIcon,
          name: '',
          isExpense: testIsExpense,
          client: mockClient,
        );
      } catch (e) {
        thrownException = e as Exception;
      }
      expect(thrownException, isA<Exception>());
      expect(thrownException.toString(), contains('Name không được rỗng'));
    });

    test('Lỗi khi server trả về 400', () async {
      when(
        mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response('{"error": "Invalid data"}', 400),
      );

      final result = await CategoryService.saveCategory(
        uuid: testUuid,
        icon: testIcon,
        name: testName,
        isExpense: testIsExpense,
        client: mockClient,
      );
      expect(result, false);
    });

    test('Lỗi khi server không phản hồi', () async {
      when(
        mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenThrow(Exception('Server không phản hồi'));

      final result = await CategoryService.saveCategory(
        uuid: testUuid,
        icon: testIcon,
        name: testName,
        isExpense: testIsExpense,
        client: mockClient,
      );

      expect(result, false);
    });
  });
}
