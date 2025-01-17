import 'package:flutter/material.dart';
import 'package:testverygood/assets/style/color.dart';

class CustomInputBox extends StatelessWidget {
  final String placeholder;
  // final TextEditingController controller;
  final TextInputType keyboardType;
  // final Function(String)? onChanged;

  // ignore: sort_constructors_first, use_super_parameters
  const CustomInputBox({
    Key? key,
    // ignore: always_put_required_named_parameters_first
    required this.placeholder,
    // required this.controller,
    this.keyboardType = TextInputType.text,
    // this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: 50,
      width: 33,
    );
  }
}
