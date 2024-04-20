
import 'package:flutter/material.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MySizes.paddingSizeLarge),
      child: Align(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [

          // Lottie.asset(
          //   MyImage.chatRobot,
          //   width: MediaQuery.of(context).size.height*0.6, height: MediaQuery.of(context).size.height*.3,
          // ),

          Text(
            'Nothing Found',
            style: robotoBold.copyWith(color: MyColor.getPrimaryColor(), fontSize: MediaQuery.of(context).size.height*0.02),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
