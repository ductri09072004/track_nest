class TransactionModel {
  final String transId;
  final String cateId;
  final String type;
  final int amount;
  final String date;

  TransactionModel({
    required this.transId,
    required this.cateId,
    required this.type,
    required this.amount,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transId: json['trans_id'] as String? ?? '',
      cateId: json['cate_id'] as String? ?? '',
      type: json['type'] as String? ?? 'expense',
      amount: int.tryParse(json['money'].toString()) ?? 0,
      date: json['date'] as String? ?? '',
    );
  }
}
