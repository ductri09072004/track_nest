import 'package:testverygood/data/data_api/balence_api.dart';
import 'package:testverygood/features/home/domain/models/balance_model.dart';

class BalanceService {
  final DataService dataService = DataService();

  Future<BalanceData> getBalanceData() async {
    try {
      final uuid = await dataService.loadUUID();
      if (uuid == null) throw Exception('UUID không hợp lệ');

      final data = await dataService.fetchData(uuid);
      return BalanceData.fromJson(data);
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }
}
