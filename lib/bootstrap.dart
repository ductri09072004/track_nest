import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testverygood/data/data_api/type_acc.dart';
import 'package:testverygood/data/data_defaut/categories_json.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Import Google Mobile Ads

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

Future<void> saveCate(String uniqueId) async {
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

    await storage.write(key: 'is_first_launch', value: 'false');
  } catch (e) {
    log('❌ Đã xảy ra lỗi khi lưu danh mục: $e');
  }
}

Future<void> createAccount(String uniqueId) async {
  try {
    final url = Uri.parse('http://3.26.221.69:5000/api/account');

    final transactionData = {
      'date_buy': 'null',
      'email': 'null',
      'type_id': 'free',
      'user_id': uniqueId,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transactionData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('✔️ Tạo tài khoản thành công: ${transactionData['user_id']}');
    } else {
      log('❌ Lỗi khi tạo tài khoản ${transactionData['user_id']}: ${response.body}');
    }

    await storage.write(key: 'is_first_launch', value: 'false');
  } catch (e) {
    log('❌ Đã xảy ra lỗi khi tạo tài khoản: $e');
  }
}

Future<String?> fetchAndSaveTypeId() async {
  try {
    final uuid = await loadUUID();
    if (uuid == null) {
      log('❌ UUID không tồn tại, không thể lấy dữ liệu.');
      return null;
    }

    final data = await fetchData(uuid);
    if (data != null) {
      final transaction = data['transaction'] as Map<String, dynamic>;
      final typeId = transaction['type_id']?.toString();

      if (typeId != null) {
        log('📌 type_id: $typeId');

        // Lưu typeId vào storage
        await storage.write(key: 'type_id', value: typeId);
        log('💾 type_id đã được lưu vào storage: $typeId');

        return typeId;
      } else {
        log('⚠️ Không tìm thấy type_id trong dữ liệu giao dịch.');
      }
    } else {
      log('⚠️ Không tìm thấy dữ liệu giao dịch cho UUID: $uuid.');
    }
  } catch (e) {
    log('❌ Lỗi khi tải dữ liệu: $e');
  }
  return null;
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

  // Khởi tạo Google Mobile Ads
  await MobileAds.instance.initialize();
  log('📢 Google Mobile Ads SDK đã được khởi tạo.');

  // Lấy hoặc tạo UUID duy nhất cho thiết bị
  final uniqueId = await getOrCreateUniqueId();

  // Lấy hoặc cập nhật type_id mỗi lần chạy app
  final typeId = await fetchAndSaveTypeId();
  if (typeId != null) {
    log('✅ type_id cập nhật: $typeId');
  } else {
    log('❌ Không lấy được type_id');
  }

  final storedTypeId = await storage.read(key: 'type_id');
  if (storedTypeId != null) {
    log('🔄 Đọc từ storage: type_id = $storedTypeId');
  } else {
    final typeId = await fetchAndSaveTypeId();
    if (typeId != null) {
      log('✅ Lấy type_id từ API và lưu vào storage: $typeId');
    } else {
      log('❌ Không lấy được type_id');
    }
  }

  // Kiểm tra lần đầu mở app
  final isFirstLaunch = await storage.read(key: 'is_first_launch');
  log('📌 is_first_launch = $isFirstLaunch');

  if (isFirstLaunch == null) {
    log('🆕 Lần đầu mở app, chạy saveTransaction()...');
    await saveCate(uniqueId);
    await createAccount(uniqueId);

    final storedTypeId = await storage.read(key: 'type_id');
    if (storedTypeId != null) {
      log('🔄 Đọc từ storage: type_id = $storedTypeId');
    } else {
      final typeId = await fetchAndSaveTypeId();
      if (typeId != null) {
        log('✅ Lấy type_id từ API và lưu vào storage: $typeId');
      } else {
        log('❌ Không lấy được type_id');
      }
    }

    await storage.write(key: 'is_first_launch', value: 'false');
  } else {
    log('🔄 App đã được mở trước đó, không chạy saveTransaction().');
  }

  runApp(await builder());
}
