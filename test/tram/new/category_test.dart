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

  group('Lưu danh mục', () {
    const testUuid = 'tramtest-1';
    const testIcon = '🍽️';
    const testName = 'Eating';
    const testIsExpense = true;

    group('Lưu thành công với dữ liệu hợp lệ', () {
      test('Lưu thành công statusCode = 200', () async {
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

      test('Lưu thành công statusCode = 201', () async {
        when(
          mockClient.post(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 201));
        final result = await CategoryService.saveCategory(
          uuid: testUuid,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
        expect(result, true);
      });
    });

    group('Trường hợp thất bại với dữ liệu không hợp lệ', () {
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
        final result = await CategoryService.saveCategory(
          uuid: testUuid,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
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
        final result = await CategoryService.saveCategory(
          uuid: testUuid,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Lỗi khi uuid rỗng', () async {
        Exception? thrownException;
        try {
          await CategoryService.saveCategory(
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

      test('Lỗi khi icon rỗng', () async {
        Exception? thrownException;
        try {
          await CategoryService.saveCategory(
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

      test('Lỗi khi name rỗng', () async {
        Exception? thrownException;
        try {
          await CategoryService.saveCategory(
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
  });

  group('Xóa danh mục', () {
    const testCategoryId = 'tramtest-2';

    group('Trường hợp thành công', () {
      test('Xóa thành công với status 200', () async {
        when(
          mockClient.delete(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 200));
        final result = await CategoryService.deleteCategory(
          categoryId: testCategoryId,
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
        final result = await CategoryService.deleteCategory(
          categoryId: testCategoryId,
          client: mockClient,
        );
        expect(result, true);
      });
    });

    group('Trường hợp thất bại', () {
      test('Xóa thất bại với lỗi server (status 400)', () async {
        when(
          mockClient.delete(
            any,
          ),
        ).thenAnswer((_) async => http.Response('Bad Request', 400));
        final result = await CategoryService.deleteCategory(
          categoryId: testCategoryId,
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
        final result = await CategoryService.deleteCategory(
          categoryId: testCategoryId,
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
        final result = await CategoryService.deleteCategory(
          categoryId: testCategoryId,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Lỗi khi categoryId rỗng', () async {
        Exception? thrownException;
        try {
          await CategoryService.deleteCategory(
            categoryId: '',
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(),
            contains('Category ID không được rỗng'),);
      });
    });
  });

  group('Cập nhật danh mục', () {
    const testCategoryId = 'tramtest-3';
    const testIcon = '🍽️';
    const testName = 'Eating';
    const testIsExpense = true;

    group('Trường hợp thành công', () {
      test('Cập nhật thành công với status 200', () async {
        when(
          mockClient.put(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 200));
        final result = await CategoryService.updateCategory(
          categoryId: testCategoryId,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
        expect(result, true);
      });

      test('Cập nhật thành công với status 204', () async {
        when(
          mockClient.put(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('{}', 204));
        final result = await CategoryService.updateCategory(
          categoryId: testCategoryId,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
        expect(result, true);
      });
    });

    group('Trường hợp thất bại', () {
      test('Cập nhật thất bại với lỗi server (status 400)', () async {
        when(
          mockClient.put(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response('Bad Request', 400));
        final result = await CategoryService.updateCategory(
          categoryId: testCategoryId,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
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
        final result = await CategoryService.updateCategory(
          categoryId: testCategoryId,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
        expect(result, false);
      });

      test('Lỗi khi categoryId rỗng', () async {
        Exception? thrownException;
        try {
          await CategoryService.updateCategory(
            categoryId: '',
            icon: testIcon,
            name: testName,
            isExpense: testIsExpense,
            client: mockClient,
          );
        } catch (e) {
          thrownException = e as Exception;
        }
        expect(thrownException, isA<Exception>());
        expect(thrownException.toString(),
            contains('Category ID không được rỗng'),);
      });

      test('Lỗi khi icon rỗng', () async {
        Exception? thrownException;
        try {
          await CategoryService.updateCategory(
            categoryId: testCategoryId,
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

      test('Lỗi khi name rỗng', () async {
        Exception? thrownException;
        try {
          await CategoryService.updateCategory(
            categoryId: testCategoryId,
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

      test('Lỗi khi server không phản hồi', () async {
        when(
          mockClient.put(
            any,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenThrow(Exception('Server không phản hồi'));
        final result = await CategoryService.updateCategory(
          categoryId: testCategoryId,
          icon: testIcon,
          name: testName,
          isExpense: testIsExpense,
          client: mockClient,
        );
        expect(result, false);
      });
    });
  });
}
