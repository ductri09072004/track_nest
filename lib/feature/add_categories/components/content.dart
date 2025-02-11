import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Container(
    //       height: MediaQuery.of(context).size.height,
    //       // width: 0,
    //       // padding: const EdgeInsets.only(bottom: 110),
    //       color: const Color(0xFF791CAC),
    //       child: const Text('dataasfasfasdffasf'),
    //     ),
    //   ],
    // );

    return Container(
      width: double.infinity, // Chiếm toàn bộ chiều rộng màn hình
      height: MediaQuery.of(context)
          .size
          .height, // Chiếm toàn bộ chiều cao màn hình
      padding: const EdgeInsets.only(top: 10, bottom: 240),
      child: Column(
        children: [
          // Danh sách có thể cuộn
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom:8,
                          left: 6,),
                      ),
                      const Text('🍽️',style: txticon,),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text('Eating', style: txt),
                      const Spacer(),
                      // SvgPicture.asset('lib/assets/icon/figma_svg/close.svg'),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Đã xóa!"),
                              duration:
                                  Duration(seconds: 2), // Thời gian hiển thị
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'lib/assets/icon/figma_svg/close.svg',
                        ),
                      ),
                      const SizedBox(width: 6,),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 6,
                        ),
                      ),
                      const Text(
                        '🍽️',
                        style: txticon,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text('Eating', style: txt),
                      const Spacer(),
                      // SvgPicture.asset('lib/assets/icon/figma_svg/close.svg'),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Đã xóa!"),
                              duration:
                                  Duration(seconds: 2), // Thời gian hiển thị
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'lib/assets/icon/figma_svg/close.svg',
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 6,
                        ),
                      ),
                      const Text(
                        '🍽️',
                        style: txticon,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text('Eating', style: txt),
                      const Spacer(),
                      // SvgPicture.asset('lib/assets/icon/figma_svg/close.svg'),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Đã xóa!"),
                              duration:
                                  Duration(seconds: 2), // Thời gian hiển thị
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'lib/assets/icon/figma_svg/close.svg',
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle txticon = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontFamily: 'Lato',
  );

  static const TextStyle txt = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Lato_Regular',
  );
}
