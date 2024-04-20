import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/auth_controller.dart';
import 'package:nub_book_sharing/controller/save_controller.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  initState() {
    Get.find<SavedController>().initSavedList();
    _route();
    super.initState();
  }

  void _route() {
    Timer(const Duration(seconds: 2), () async {
      Get.find<AuthController>().isLogin();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration:  BoxDecoration(
               color: MyColor.getSurfaceColor(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text('NUB Book', style: robotoRegular.copyWith(color: MyColor.colorPrimary, fontSize: 35),),
            ),
          ],
        )
    );
  }
}

