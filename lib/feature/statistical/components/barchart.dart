import 'package:flutter/material.dart';

class Barchart extends StatefulWidget {
  const Barchart({super.key});

  @override
  _BarchartState createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  Map<String, dynamic>? customerData;
  String errorMessage = '';

  // @override
  // void initState() {
  //   super.initState();
  //   fetchCustomerData();
  // }

  // Future<void> fetchCustomerData() async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('http://blueduck97.ddns.net:5000/api/request'));

  //     if (response.statusCode == 200) {
  //       var rawData = response.body;
  //       print('Raw Data từ API: $rawData');

  //       var data = json.decode(rawData);

  //       if (data is List && data.isNotEmpty) {
  //         setState(() {
  //           customerData = data.first as Map<String, dynamic>;
  //         });
  //       } else if (data is Map<String, dynamic>) {
  //         setState(() {
  //           customerData = data;
  //         });
  //       } else {
  //         setState(() {
  //           errorMessage = 'Dữ liệu từ API không đúng định dạng!';
  //         });
  //       }
  //     } else {
  //       setState(() {
  //         errorMessage = 'Lỗi kết nối API: ${response.statusCode}';
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       errorMessage = 'Lỗi khi tải dữ liệu: $e';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 147,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 222,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : customerData == null
                  ? const Center(child: CircularProgressIndicator())
                  : _buildUserList(),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    final userList = customerData?['user1'];

    if (userList == null) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    if (userList is! List) {
      return const Center(
        child: Text('Lỗi: Dữ liệu không phải danh sách'),
      );
    }

    if (userList.isEmpty) {
      return const Center(child: Text('Danh sách rỗng'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: userList
          .whereType<Map<String, dynamic>>() // Lọc phần tử đúng kiểu
          .map((user) {
        return Text('Tên: ${user["name"] ?? "Không có dữ liệu"}');
      }).toList(),
    );
  }
}
