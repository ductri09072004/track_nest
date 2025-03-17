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

  group('saveCategory()', () {
    test('Lưu danh mục thành công (status 200)', () async {
      when(
        mockClient.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response('{}', 200));

      final result = await CategoryService.saveCategory(
        uuid: 'test-uuid',
        icon: 'test-icon',
        name: 'test-name',
        isExpense: true,
        client: mockClient,
      );


      expect(result, true);
    });

    test('Lỗi khi uuid null', () async {
      final result = await CategoryService.saveCategory(
        uuid: null,
        icon: 'test-icon',
        name: 'test-name',
        isExpense: true,
        client: mockClient,
      );

      // throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('fádfádfád')));
      expect(result, false);

    });

    test('Lỗi khi uuid rỗng', () async {
      final result = await CategoryService.saveCategory(
        uuid: '',
        icon: 'test-icon',
        name: 'test-name',
        isExpense: true,
        client: mockClient,
      );

      expect(result, false);
    });

    test('Lỗi khi icon null', () async {
      final result = await CategoryService.saveCategory(
        uuid: 'test-uuid',
        icon: null,
        name: 'test-name',
        isExpense: true,
        client: mockClient,
      );

      expect(result, false);
    });

    test('Lỗi khi icon rỗng', () async {
      final result = await CategoryService.saveCategory(
        uuid: 'test-uuid',
        icon: '',
        name: 'test-name',
        isExpense: true,
        client: mockClient,
      );

      expect(result, false);
    });

    test('Lỗi khi name null', () async {
      final result = await CategoryService.saveCategory(
        uuid: 'test-uuid',
        icon: 'test-icon',
        name: null,
        isExpense: true,
        client: mockClient,
      );

      expect(result, false);
    });

    test('Lỗi khi name rỗng', () async {
      final result = await CategoryService.saveCategory(
        uuid: 'test-uuid',
        icon: 'test-icon',
        name: '',
        isExpense: true,
        client: mockClient,
      );

      expect(result, false);
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
        uuid: 'test-uuid',
        icon: 'test-icon',
        name: 'test-name',
        isExpense: true,
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
        uuid: 'test-uuid',
        icon: 'test-icon',
        name: 'test-name',
        isExpense: true,
        client: mockClient,
      );

      expect(result, false);
    });
  });
}
