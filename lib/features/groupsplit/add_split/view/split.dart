import 'package:flutter/material.dart';
import 'package:testverygood/assets/core/appcolor.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/button_choose_group.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/data/data_api/add_split_api.dart';
import 'package:testverygood/data/data_api/list_friend_split._api.dart';
import 'package:testverygood/features/groupsplit/add_split/components/DropDownFriends.dart';
import 'package:testverygood/features/groupsplit/add_split/components/choose_group.dart';
import 'package:testverygood/features/groupsplit/add_split/components/friendToggle.dart';
import 'package:testverygood/features/transaction/add_trans/widgets/calendar.dart';
import 'package:testverygood/features/transaction/add_trans/widgets/categories.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key, this.data = ''});
  final String data;

  static var txmain;

  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  String? selectedOption;
  bool isLoading = true;
  String? selectedGroupName;

  List<String> options = [];
  String? selectedOption2;
  final TextEditingController numericController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController fromController = TextEditingController();

  List<double> splitAmounts = [];

  bool isSwitched = false;
  late List<bool> toggleStates;
  String selectedCategory = '';
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      numericController.text = widget.data;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showGroupSelectionPopup();
    });
  }

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  @override
  void dispose() {
    numericController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _calculateSplitAmount() {
    if (numericController.text.isNotEmpty) {
      final double totalAmount = double.tryParse(numericController.text) ?? 0;
      final int selectedCount = toggleStates.where((state) => state).length;

      setState(() {
        splitAmounts = selectedCount > 0
            ? List.generate(
                options.length,
                (index) =>
                    toggleStates[index] ? totalAmount / selectedCount : 0)
            : List.filled(options.length, 0);
      });
    }
  }

  void showGroupSelectionPopup() {
    showDialog(
      context: context,
      builder: (context) => PopupGroupSelection(
        onSelectGroup: (selectedGroup) {
          setState(() {
            selectedGroupName = selectedGroup;
            fetchMembers();
          });
        },
      ),
    );
  }

  Future<void> fetchMembers() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? uuid = await loadUUID();
      if (uuid != null && selectedGroupName != null) {
        final List<Map<String, dynamic>> members =
            await fetchData(uuid, selectedGroupName!);
        setState(() {
          options =
              members.map((member) => member['name_mem'].toString()).toList();
          toggleStates = List.generate(options.length, (_) => false);
          isLoading = false;

          // Đặt giá trị mặc định là "Me" nếu tồn tại
          if (options.contains('Me')) {
            selectedOption = 'Me';
          } else if (options.isNotEmpty) {
            selectedOption =
                options.first; // Chọn phần tử đầu tiên nếu không có "Me"
          }
        });
      }
    } catch (e) {
      print('Lỗi tải danh sách thành viên: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Gọi API lưu giao dịch khi nhấn nút Save
  Future<void> _saveTransaction() async {
    String? uuid = await loadUUID(); // Lấy UUID người dùng
    if (uuid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy UUID!')),
      );
      return;
    }

    await TransactionService.saveTransaction(
      context: context,
      uuid: uuid,
      icon: selectedCategory,
      date: selectedDate,
      money: numericController.text,
      note: noteController.text,
      payid: 'k1Swt8AeF3',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HeaderA(title: 'Split'),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    const Text('Paid by', style: txmain),
                    const Spacer(),
                    GroupSelectionButton(
                      onPressed: showGroupSelectionPopup,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                  selectedValue: selectedOption,
                  options: options,
                  hintText: 'Choose who will pay',
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue;
                      final selectedIndex = options.indexOf(newValue ?? '');
                      toggleStates[selectedIndex] = true;
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
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('VND', style: txtd),
                  ],
                ),
                FriendToggleList(
                  options: options,
                  initialToggleStates: toggleStates,
                  selectedOption: selectedOption,
                  onChanged: (index, value) {
                    setState(() {
                      setState(() {
                        toggleStates[index] = value;
                        _calculateSplitAmount();
                      });
                    });
                  },
                  splitAmounts: splitAmounts,
                ),
                const SizedBox(height: 16),
                const Text('Categories', style: txmain),
                const SizedBox(height: 8),
                CategoriesText(
                  isExpense: true,
                  onCategorySelected: (String category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Time', style: txmain),
                          const SizedBox(height: 12),
                          TimePickerComponent(
                            onDateSelected: _updateSelectedDate,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text('From', style: txmain),
                          InputClassic(
                            hintText: 'Write name',
                            hasBorder: false,
                            hasPadding: false,
                            controller: fromController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Button(
                  label: 'Save',
                  onPressed: _saveTransaction, // Gọi hàm lưu giao dịch
                ),
              ],
            ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: AppColor.black, fontSize: 20, fontFamily: 'Lato');
  static const TextStyle txtd =
      TextStyle(color: AppColor.black, fontSize: 30, fontFamily: 'Lato');
}
