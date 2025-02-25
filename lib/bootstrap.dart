import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testverygood/components/data_defaut/categories_json.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();
const uuid = Uuid();

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<String> getOrCreateUniqueId() async {
  var uniqueId = await storage.read(key: 'unique_id');

  if (uniqueId == null) {
    uniqueId = uuid.v4(); // Tạo mã số ngẫu nhiên
    await storage.write(key: 'unique_id', value: uniqueId);
    log('New App Unique ID Created: $uniqueId');
  } else {
    log('Existing App Unique ID: $uniqueId');
  }

  return uniqueId;
}

Future<bool> isFirstLaunch() async {
  String? firstLaunch = await storage.read(key: 'is_first_launch');
  log('📌 is_first_launch = $firstLaunch');
  return firstLaunch == null;
}

Future<void> saveTransaction(String uniqueId) async {
  try {
    final url = Uri.parse('http://3.26.221.69:5000/api/categories');

    for (final category in cateList) {
      final transactionData = {
        'icon': category['icon'],
        'name': category['name'],
        'type': category['type'],
        'user_id': uniqueId,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('✔️ Lưu danh mục thành công: ${category['name']}');
      } else {
        log('❌ Lỗi khi lưu danh mục ${category['name']}: ${response.body}');
      }
    }

    // Lưu trạng thái đã chạy lần đầu tiên
    await storage.write(key: 'is_first_launch', value: 'false');
  } catch (e) {
    log('❌ Đã xảy ra lỗi khi lưu danh mục: $e');
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Khởi tạo Flutter & .env
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final apiKey = dotenv.env['API_KEY'];
  log('🔥 Loaded API Key: $apiKey');

  // Lấy hoặc tạo UUID duy nhất cho thiết bị
  final uniqueId = await getOrCreateUniqueId();
  log('🔥 App khởi chạy với ID: $uniqueId');

  // Kiểm tra xem app đã mở lần đầu hay chưa
  final isFirstLaunch = await storage.read(key: 'is_first_launch');
  log('📌 is_first_launch = $isFirstLaunch');

  if (isFirstLaunch == null) {
    log('🆕 Lần đầu mở app, chạy saveTransaction()...');
    await saveTransaction(uniqueId);
    await storage.write(
        key: 'is_first_launch', value: 'false'); // Đánh dấu app đã mở
  } else {
    log('🔄 App đã được mở trước đó, không chạy saveTransaction().');
  }

  runApp(await builder());
}
