import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testverygood/features/transaction/scanbill/components/Nest_AI.dart';

import 'nestai_test.mocks.dart';

@GenerateMocks([NestAI])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // late NestAI nestAI;
  late MockNestAI mockNestAI;
  late String imagePath;
  late Map<String, dynamic> expectedOutput;
  late String outputFilePath;

  setUp(() {
    /// Khởi tạo NestAI và đường dẫn ảnh test
    // nestAI = NestAI();
    mockNestAI = MockNestAI();
    imagePath = 'test/test_data/bach-hoa-xanh.jpg';
    expectedOutput = {
      'totalAmount': '213500',
      'date': '11/06/2021',
      'categories': 'Food',
    };
    outputFilePath = 'test/tram/new/scan_result.json';
    when(mockNestAI.processImage(File(imagePath))).thenAnswer((_) async => jsonEncode(expectedOutput));
  });

  test('Bill bách hóa xanh', () async {
    // imagePath = 'test/test_data/bach-hoa-xanh.jpg';
    final result = await mockNestAI.processImage(File(imagePath));
    // late final Map<String, dynamic> expectedOutput = {
    //   'totalAmount': '213500',
    //   'date': '11/06/2021',
    //   'categories': 'Food',
    // };
    print('📸 Kết quả scan: $result');

    final resultJson = jsonDecode(result);
    expect(resultJson['totalAmount'], expectedOutput['totalAmount'],
        reason: '💰 Sai số tiền nhận diện!',);
    expect(resultJson['date'], expectedOutput['date'],
        reason: '📅 Sai ngày nhận diện!',);
    expect(resultJson['categories'], expectedOutput['categories'],
        reason: '🛍 Sai danh mục nhận diện!',);
  });
}
