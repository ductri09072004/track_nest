class BalanceData {
  final int expense;
  final int income;

  BalanceData({required this.expense, required this.income});

  factory BalanceData.fromJson(Map<String, dynamic> json) {
    return BalanceData(
      expense: (json['expense'] as int?) ?? 0,
      income: (json['income'] as int?) ?? 0,
    );
  }
}
