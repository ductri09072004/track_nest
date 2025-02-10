import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/feature/add_categories/components/body_addcate.dart';
import 'package:testverygood/feature/add_categories/components/content.dart';
import 'package:testverygood/feature/statistical/components/barchart.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';
class BodyMain extends StatelessWidget {
const BodyMain({ super.key });

  @override
  Widget build(BuildContext context){
    //       // Nút thêm bạn bè (luôn cố định dưới cùng)
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: GestureDetector(
    //           onTap: () {
    //             // Chuyển đến màn hình AddGroupPage
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => const AddCatePage()),
    //             );
    //           },
    //           child: SvgPicture.asset(
    //             'lib/assets/icon/active_navbar/addA_icon.svg',
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );


    // return Container(
    //   color: Colors.blueAccent,
    //   width: double.infinity,
    //   height: MediaQuery.of(context).size.height,
    //   // padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
    //   child: Column(
    //     children: [
    //       // TabBar (Income & Expenses)
    //       const DefaultTabController(
    //         length: 2,
    //         child: Column(
    //           children: [
    //             TabBar(
    //               labelColor: Colors.black,
    //               unselectedLabelColor: Colors.grey,
    //               indicatorColor: Colors.purple,
    //               tabs: [
    //                 Tab(text: "Income"),
    //                 Tab(text: "Expenses"),
    //               ],
    //             ),
    //             SizedBox(height: 10), // Khoảng cách dưới TabBar

    //             // Nội dung thay đổi theo tab
    //             // Expanded(
    //             //   child: Text('data'),
    //             // ),
    //           ],
    //         ),
    //       ),

    //       // Nút thêm category (luôn cố định dưới cùng)
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: GestureDetector(
    //           onTap: () {
    //             // Chuyển đến màn hình AddCatePage
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => const AddCatePage()),
    //             );
    //           },
    //           child: SvgPicture.asset(
    //             'lib/assets/icon/active_navbar/addA_icon.svg',
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );



    // return Positioned(
    //   top: MediaQuery.of(context).size.height/5,
    //   left: 0,
    //   right: 0,
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     // padding: const EdgeInsets.only(top: 12, bottom: 110),
    //     padding: const EdgeInsets.only(bottom: 110),
    //     decoration: const BoxDecoration(
    //       color: Color(0xFFFDFDFD),
    //     ),
    //     child: DefaultTabController(
    //       length: 2, // Số lượng tab
    //       child: Column(
    //         children: [
    //           Expanded(
    //             // Đảm bảo nút trượt chiếm toàn bộ chiều ngang
    //             child: ExInBtn(
    //               labels: const ['Expenses', 'Income'],
    //               onToggle: (index) {},
    //             ),
    //           ),
    //           const Expanded(
    //             child: TabBarView(
    //               children: [
    //                 // Nội dung cho tab "Income"
    //                 Column(
    //                   children: [
    //                     Expanded(
    //                       child: SingleChildScrollView(
    //                         padding: EdgeInsets.only(bottom: 110),
    //                         child: Content(),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 // Nội dung cho tab "Expenses"
    //                 Column(
    //                   children: [
    //                     Expanded(
    //                       child: SingleChildScrollView(
    //                         padding: EdgeInsets.only(bottom: 110),
    //                         child:
    //                             Content(), // Có thể thay đổi nội dung khác nếu cần
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );



    return Positioned(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                // Đảm bảo nút trượt chiếm toàn bộ chiều ngang
                child: ExInBtn(
                  labels: const ['Expenses', 'Income'],
                  onToggle: (index) {},
                ),
              ),
            ],
          ),
          const Expanded(
            child: Column(
              children: [
                Text('data'),
                // Nội dung cho tab "Income"
                Expanded(
                  child: SingleChildScrollView(
                    // padding: EdgeInsets.only(bottom: 110),
                    child: Content(),
                  ),
                ),
                // Nội dung cho tab "Expenses"
                Expanded(
                  child: SingleChildScrollView(
                    // padding: EdgeInsets.only(bottom: 110),
                    child: Content(), // Có thể thay đổi nội dung khác nếu cần
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




  static const TextStyle txtcate = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Lato',
  );

  static const TextStyle txtmem = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Lato_Regular',
  );
}
