import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/data/data_api/filter_restore.dart'; // Import file API

class RestoreAcc extends StatefulWidget {
  const RestoreAcc({super.key});

  @override
  State<RestoreAcc> createState() => _RestoreAccState();
}

class _RestoreAccState extends State<RestoreAcc> {
  final TextEditingController emailController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  List<Map<String, dynamic>> accountData = [];
  bool isLoading = false;
  String? selectedUserId; // Lưu user_id được chọn để link
  bool hasSearched = false;

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      hasSearched = true; // Đánh dấu đã thực hiện tìm kiếm
    });

    try {
      final email = emailController.text.trim();
      final data = await fetchAccountData(email); // Gọi API từ file riêng

      setState(() => accountData = data);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $error')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Hiển thị popup xác nhận
  void _showConfirmDialog(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Bo góc popup
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon xác nhận
                const Icon(
                  Icons.link_rounded,
                  size: 50,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 12),
                // Tiêu đề
                const Text(
                  'Confirm Link Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                // Nội dung
                Text(
                  'Do you want to link this account (UUID: $userId)?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                // Nút hành động
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), // Đóng popup
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent, // Màu đỏ cho hủy
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(fontFamily: 'Lato', fontSize: 16),),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await storage.write(key: 'unique_id', value: userId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Account $userId linked successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context); // Đóng popup
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF013CBC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10,),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Lato',
                            fontSize: 16,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HeaderA(title: ''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              child: Text(
                'Restore account',
                style: TextStyle(fontSize: 30, fontFamily: 'Lato'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Restore by email',
              style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
            ),
            const SizedBox(height: 8),
            InputVerify(
              hintText: 'ex: adrree@gmail.com',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            Button(
              label: 'Find',
              onPressed: fetchData, // Gọi API khi nhấn
            ),
            const SizedBox(height: 26),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (accountData.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: accountData.map((acc) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8,), // Khoảng cách giữa các card
                    decoration: BoxDecoration(
                      color: Colors.white, // Nền trắng
                      borderRadius: BorderRadius.circular(12), // Bo góc
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Bóng mờ nhẹ
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3), // Đổ bóng xuống dưới
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16,),
                      title: Text(
                        'UUID: ${acc["user_id"]}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () =>
                            _showConfirmDialog(acc['user_id'].toString()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF013CBC), // Màu xanh hiện đại
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Bo tròn nút
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8,),
                        ),
                        child: const Text(
                          'Link',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            else if (hasSearched) // Chỉ hiển thị nếu đã tìm nhưng không có kết quả
              const Text(
                'Could not find any accounts',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
