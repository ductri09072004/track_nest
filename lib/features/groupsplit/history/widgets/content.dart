import 'package:flutter/material.dart';
import 'package:testverygood/assets/core/appcolor.dart';
import 'package:testverygood/data/data_api/Split/mempay_data.dart';
import 'package:testverygood/data/data_api/Split/split_trans_api.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late Future<List<Map<String, dynamic>>> data;
  Map<String, List<Map<String, dynamic>>> mempayDataMap = {};
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    data = _loadData();
  }

  Future<List<Map<String, dynamic>>> _loadData() async {
    try {
      final storedUUID = await loadUUID();
      if (storedUUID == null) {
        throw Exception('Không tìm thấy UUID');
      }

      final splitResult = await fetchData(storedUUID);
      if (splitResult.isNotEmpty) {
        final List<String> groupMempay = splitResult
            .map<String>((item) => item['pay_id'].toString())
            .toSet()
            .toList();
        await _loadDataMempay(groupMempay);
      }

      return splitResult;
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi khi tải dữ liệu: $e';
      });
      return [];
    }
  }

  Future<void> _loadDataMempay(List<String> groupMempayList) async {
    if (groupMempayList.isEmpty) return;

    try {
      Map<String, List<Map<String, dynamic>>> tempMempayDataMap = {};
      for (var payId in groupMempayList) {
        final mempayItems = await fetchDataMem(payId);
        tempMempayDataMap[payId] =
            mempayItems; // Lưu từng nhóm mempay theo pay_id
      }

      setState(() {
        mempayDataMap = tempMempayDataMap;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi khi tải dữ liệu Mempay: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final transactions = snapshot.data!;
          if (transactions.isEmpty) {
            return const Center(child: Text('Không có dữ liệu'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: transactions.map((transaction) {
                final cateId = transaction['cate_id'] ?? 'Không có thông tin';
                final groupDate = transaction['date'] ?? 'Không có thông tin';
                final payId = transaction['pay_id']?.toString() ??
                    ''; // Lấy pay_id của từng transaction
                final mempayList = mempayDataMap[payId] ??
                    []; // Chỉ lấy dữ liệu mempay của đúng pay_id
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('$cateId', style: titlecate),
                          const Spacer(),
                          Text('$groupDate', style: titleprice2),
                        ],
                      ),
                      const Divider(thickness: 1),

                      // Hiển thị danh sách mempay tương ứng
                      if (mempayList.isNotEmpty)
                        Builder(builder: (context) {
                          // Tìm người có pay_main = true
                          final mainPayer = mempayList.firstWhere(
                            (item) => item['pay_main']?.toString() == "true",
                            orElse: () => <String, dynamic>{},
                          );

                          final mainPayerName =
                              mainPayer != null ? mainPayer['name_pay'] : '';

                          return Column(
                            children: mempayList.map((mempayItem) {
                              final mempayName =
                                  mempayItem['name_pay'] ?? 'Không có tên';
                              final mempayAmount =
                                  mempayItem['money_pay'] ?? '0';
                              final payMain =
                                  mempayItem['pay_main']?.toString() ?? 'false';

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      '$mempayName ${payMain == "true" ? "payed" : "own ${mainPayerName}"}',
                                      style: titlename,
                                    ),
                                    const Spacer(),
                                    Text(
                                      '$mempayAmount đ',
                                      style: payMain == "true"
                                          ? titlemoneypay
                                          : titlemoney,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        },)
                      else
                        const Center(child: Text('Không có dữ liệu Mempay')),
                    ],
                  ),
                );
              }).toList(),
            );
          }
        } else {
          return const Center(child: Text('Không có dữ liệu'));
        }
      },
    );
  }

  static const TextStyle titlecate = TextStyle(
    fontSize: 20,
    fontFamily: 'Lato',
    color: AppColor.black,
  );
  static const TextStyle titleprice2 = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
    color: AppColor.black,
  );
  static const TextStyle titlename = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato-Regular',
    color: AppColor.black,
  );
  static const TextStyle titlemoney = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato-Regular',
    color: AppColor.green,
  );
  static const TextStyle titlemoneypay = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato-Regular',
    color: AppColor.red,
  );
}
