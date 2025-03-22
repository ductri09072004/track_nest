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

  Future<void> fetchData() async {
    setState(() => isLoading = true);

    try {
      final email = emailController.text.trim();
      final data = await fetchAccountData(email); // Gọi API từ file riêng

      setState(() => accountData = data);

      // Nếu có user_id thì lưu vào storage
      if (data.isNotEmpty && data[0]['user_id'] != null) {
        await storage.write(
            key: 'unique_id', value: data[0]['user_id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Your account: ${data[0]['user_id']} restore success!')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $error')),
      );
    } finally {
      setState(() => isLoading = false);
    }
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
              label: 'Restore',
              onPressed: fetchData, // Gọi API khi nhấn
            ),
            const SizedBox(height: 26),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              accountData.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: accountData.map((acc) {
                        return Card(
                          child: ListTile(
                            title: Text('UUID: ${acc["user_id"]}'),
                          ),
                        );
                      }).toList(),
                    )
                  : const Text(
                      'Không tìm thấy tài khoản nào',
                      style: TextStyle(color: Colors.red),
                    ),
          ],
        ),
      ),
    );
  }
}
