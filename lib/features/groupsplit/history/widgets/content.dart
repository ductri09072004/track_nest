import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:testverygood/assets/core/appcolor.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late Future<List<dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = fetchData(); // Gọi API khi màn hình được khởi tạo
  }

  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://3.26.221.69:5000/api/grouptrans'));
    if (response.statusCode == 200) {
      // Chuyển dữ liệu JSON thành list
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: FutureBuilder<List<dynamic>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Lỗi: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final transactions = snapshot.data!;
            if (transactions.isEmpty) {
              return const Text('Không có dữ liệu');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: transactions.map((transaction) {
                  // Kiểm tra xem key có tồn tại trong đối tượng hay không
                  final cateId = transaction['cate_id'] ?? 'Không có thông tin';
                  final groupMemId =
                      transaction['money'] ?? 'Không có thông tin';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chi phí vận chuyển: $cateId đ',
                        style: titleprice,
                      ),
                      Text(
                        'Phí dịch vụ: $groupMemId đ',
                        style: titleprice2,
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              );
            }
          } else {
            return const Text('Không có dữ liệu');
          }
        },
      ),
    );
  }

  Widget buildDateSection(String title, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset('lib/assets/icon/home_icon/girl_icon.svg'),
            Text(
              title,
              style: titleText,
            ),
            const Spacer(),
            Text(
              date,
              style: titleText,
            ),
          ],
        ),
        Container(
          height: 2,
          color: AppColor.black,
          width: double.infinity,
        ),
      ],
    );
  }

  static const TextStyle titleText = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle titleicon = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
  );
  static const TextStyle titleprice = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: AppColor.red,
  );
  static const TextStyle titleprice2 = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: AppColor.green,
  );
}
