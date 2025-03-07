import 'package:testverygood/data/data_api/home_data.dart';
import 'package:testverygood/features/home/domain/models/transaction_model.dart';

class TransactionService {
  Future<List<TransactionModel>> fetchTransactions(String? uuid) async {
    if (uuid == null) return [];

    try {
      final List<Map<String, dynamic>> rawData = await fetchData(uuid);
      return rawData.map(TransactionModel.fromJson).toList();
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }
}
