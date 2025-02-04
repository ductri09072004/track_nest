import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/dropdown.dart';
import 'package:testverygood/components/friendToggle.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/feature/history/app.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  String? selectedOption;
  final List<String> options = [
    'Trí',
    'Quỳnh',
    'Đạt',
    'Như',
    'Nguyên',
    'chị Nguyên',
  ];

  String? selectedOption2;
  final List<String> options2 = ['Eually', 'As amounts'];
  final TextEditingController numericController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  bool isSwitched = false;

  late List<bool> toggleStates;

  @override
  void initState() {
    super.initState();
    toggleStates = List.generate(
        options.length, (_) => false); // Khởi tạo trạng thái toggle
  }

  @override
  void dispose() {
    numericController.dispose();
    noteController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getSplitDetails() {
    final double eachPersonPays = getEachPersonPays();
    final List<Map<String, dynamic>> splitDetails = [];

    for (int i = 0; i < options.length; i++) {
      if (toggleStates[i]) {
        splitDetails.add({
          'name': options[i],
          'amount': eachPersonPays.round(),
        });
      }
    }
    return splitDetails;
  }

  // Hàm tính toán số tiền mỗi người phải trả
  double getEachPersonPays() {
    // Loại bỏ dấu phân cách nghìn trước khi chuyển đổi
    final String rawValue = numericController.text.replaceAll('.', '');
    final double totalAmount = double.tryParse(rawValue) ?? 0.0;

    // Đếm số người được chọn
    final int selectedCount = toggleStates.where((state) => state).length;

    if (selectedCount > 0 && totalAmount > 0) {
      return totalAmount / selectedCount;
    } else {
      return 0.0; // Nếu không có người nào được chọn hoặc số tiền <= 0, trả về 0
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Split'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Paid by', style: txmain),
          const SizedBox(height: 10),
          Dropdown(
            selectedValue: selectedOption,
            options: options,
            hintText: 'Choose who will pay',
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue;

                // Cập nhật trạng thái toggle để loại bỏ người đã chọn
                final selectedIndex = options.indexOf(newValue ?? '');
                toggleStates[selectedIndex] = true; // Đánh dấu người đã chọn
              });
            },
          ),
          const SizedBox(height: 16),
          const Text('Amount', style: txmain),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: InputField(
                  hintText: '0',
                  controller: numericController,
                  isNumeric: true,
                  maxLength: 9,
                  onChanged: (value) {
                    setState(() {
                      // Cập nhật số tiền khi người dùng thay đổi
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              const Text('VND', style: txtd),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Split with', style: txmain),
              const Spacer(),
              Container(
                width: 143,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Dropdown(
                  selectedValue: selectedOption2,
                  options: options2,
                  hintText: 'Eually',
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption2 = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FriendToggleList(
            options: options,
            initialToggleStates: toggleStates,
            selectedOption: selectedOption, // Truyền người đã chọn vào đây
            onChanged: (index, value) {
              setState(() {
                toggleStates[index] = value;
              });
            },
          ),
          const SizedBox(height: 16),
          const Text('Categories', style: txmain),
          const SizedBox(height: 16),
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time', style: txmain),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today), // Thay thế SVG bằng Icon
                      SizedBox(width: 8),
                      Text('1/1/2025', style: txtpeo),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Note', style: txmain),
                  Text('yoo', style: txtpeo),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Hiển thị số tiền mỗi người phải trả
          Row(
            children: [
              const Text('Each person pays:', style: txmain),
              const Spacer(),
              Text(
                getEachPersonPays() > 0
                    ? '${NumberFormat('#,###', 'en_US').format(getEachPersonPays().round())} VND' // Định dạng số tiền với dấu phẩy
                    : '0 VND', // Trường hợp số tiền là 0, hiển thị 0 đ
                style: txprice,
              ),
            ],
          ),
          const SizedBox(height: 40),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Button(
                  label: 'Save',
                  onPressed: () async {
                    // Tạo danh sách chi tiết từ toggleStates và giá trị chia đều
                    final double amountPerPerson = getEachPersonPays();

                    // Lấy dữ liệu cũ từ SharedPreferences nếu có
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? detailsJson = prefs.getString('details');
                    List<Map<String, dynamic>> details = [];

                    if (detailsJson != null) {
                      // Nếu có dữ liệu cũ, chuyển đổi JSON thành danh sách
                      details = List<Map<String, dynamic>>.from(
                        (jsonDecode(detailsJson) as List<dynamic>)
                            .map((item) => Map<String, dynamic>.from(item)),
                      );
                    }

                    // Thêm dữ liệu mới vào danh sách cũ
                    for (int i = 0; i < options.length; i++) {
                      if (toggleStates[i]) {
                        details.add({
                          'name': options[i],
                          'amount':
                              '${NumberFormat('#,###', 'en_US').format(amountPerPerson)} VND',
                        });
                      }
                    }

                    // Chuyển danh sách chi tiết thành chuỗi JSON
                    final String newDetailsJson = jsonEncode(details);

                    // Lưu chuỗi JSON vào SharedPreferences
                    bool success =
                        await prefs.setString('details', newDetailsJson);

                    // Hiển thị thông báo thành công hoặc thất bại
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Data saved successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to save data.')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
  static const TextStyle txprice =
      TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lato');
  static const TextStyle txtd =
      TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'Lato');
  static const TextStyle txtpeo =
      TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lato_Regular');
}
