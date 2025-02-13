import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

final storage = FlutterSecureStorage();
final uuid = Uuid();

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
  String? uniqueId = await storage.read(key: 'unique_id');

  if (uniqueId == null) {
    uniqueId = uuid.v4(); // Tạo mã số ngẫu nhiên
    await storage.write(key: 'unique_id', value: uniqueId);
    log('New App Unique ID Created: $uniqueId');
  } else {
    log('Existing App Unique ID: $uniqueId');
  }

  return uniqueId;
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Khởi tạo và lấy UUID
  WidgetsFlutterBinding.ensureInitialized();
  String uniqueId = await getOrCreateUniqueId();

  log('App Started with Unique ID: $uniqueId');

  runApp(await builder());
}
