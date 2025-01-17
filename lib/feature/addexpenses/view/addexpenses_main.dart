import 'package:flutter/material.dart';
// import 'package:testverygood/assets/icon/figma_svg/svg.dart';
import 'package:testverygood/assets/style/color.dart';
import 'package:testverygood/components/Header.dart';
// import 'package:testverygood/components/Inputbox.dart';

class AddexpensesPage extends StatelessWidget {
  const AddexpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Transaction'),
      body: Padding(
        padding: const EdgeInsets.all(20), // Thêm padding 24 vào tất cả các cạnh
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CustomInputBox(placeholder: 'Enter the amount'),
            Text('Paid by',
              style: txmain,
              textAlign: TextAlign.left,
            ),
            const Inputbox(),

            Text(
              'Amount',
              style: txmain,
              textAlign: TextAlign.left,
            ),
            TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 36),
              decoration: InputDecoration(
                hintText: '100.000',
                hintStyle: TextStyle(
                  color: AppColors.white[200],
                  fontSize: 36,
                  fontFamily: 'Lato',
                ),
              ),
            ),

            Text(
              'Split with',
              style: txmain,
              textAlign: TextAlign.left,
            ),
            const ListItem(),
            const ListItem(),
            const ListItem(),

            Text(
              'Category',
              style: txmain,
              textAlign: TextAlign.left,
            ),
            const CateItem(),
          ],
        ),
      ),
    );
  }
    static TextStyle txmain =
      TextStyle(color: AppColors.black[500], fontSize: 20, fontFamily: 'Lato');
}

class Inputbox extends StatelessWidget {
const Inputbox({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      color: AppColors.white[100],
      height: 46,
      width: double.infinity,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          hintText: 'Enter the amount',
          hintStyle: TextStyle(
            color: AppColors.white[200],
            fontSize: 14,
            fontFamily: 'Lato',),

        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
const ListItem({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
      child: Row(
        children: [
          Text('Name',
            style: textnormal,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'data',
                style: textnormal,
                ),
              ),
            ),
        ],
          ),

    );
  }
static TextStyle textnormal =
      TextStyle(color: AppColors.black[500], fontSize: 16, fontFamily: 'Lato');
}

class CateItem extends StatelessWidget {
const CateItem({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          Text('Eating',
            style: textnormal,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'data',
                style: textnormal,
                ),
              ),
            ),
        ],
          ),
    );
  }
  static TextStyle textnormal =
      TextStyle(color: AppColors.black[500], fontSize: 16, fontFamily: 'Lato');
}
