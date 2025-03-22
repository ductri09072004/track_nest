import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/data/data_api/type_acc.dart';

//const storage = FlutterSecureStorage();

class LinkEmail extends StatefulWidget {
  const LinkEmail({super.key});

  @override
  State<LinkEmail> createState() => _LinkEmailState();
}

class _LinkEmailState extends State<LinkEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  Future<Map<String, dynamic>?>? futureAccount;
  String? rootKey;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String? uuid = await loadUUID();
    if (uuid != null) {
      setState(() {
        futureAccount = fetchData(uuid);
      });
    }
  }

  Future<void> updatePremium() async {
    String email = emailController.text.trim();

    // Biểu thức chính quy để kiểm tra định dạng email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập email')),
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email không hợp lệ')),
      );
      return;
    }

    if (rootKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy key gốc để cập nhật')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://3.26.221.69:5000/api/account/$rootKey');

    final Map<String, dynamic> updatedData = {
      'email': email,
    };

    try {
      final response = await http.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật email thành công!')),
        );

        _loadData(); // Tải lại dữ liệu sau cập nhật
      } else {
        throw Exception('Cập nhật thất bại, mã lỗi: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void validateAndSend() {
    String email = emailController.text.trim();

    // Biểu thức chính quy để kiểm tra định dạng email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập email')),
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email không hợp lệ')),
      );
      return;
    }

    // Nếu email hợp lệ, thực hiện hành động gửi email
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email hợp lệ, đang gửi...')),
    );

    // Thực hiện logic gửi email ở đây
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: const HeaderA(title: ''),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: futureAccount,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Không tìm thấy dữ liệu'));
          }

          rootKey = snapshot.data!['rootKey'].toString(); // Lưu rootKey

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  child: Text(
                    'Link Email',
                    style: TextStyle(fontSize: 30, fontFamily: 'Lato'),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Link Email',
                  style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
                ),
                const SizedBox(height: 8),
                InputVerify(
                  hintText: 'ex: dtc@gmail.com',
                  controller: emailController,
                  // suffixText: 'Gửi',
                  onSuffixPressed: validateAndSend,
                ),
                // const SizedBox(height: 16),
                // const Text(
                //   'OTP',
                //   style: TextStyle(fontSize: 18, fontFamily: 'Lato'),
                // ),
                // const SizedBox(height: 8),
                // InputVerify(
                //   hintText: 'OTP',
                //   controller: otpController,
                // ),
                const SizedBox(height: 26),
                Button(
                  label: 'Link',
                  onPressed: updatePremium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
