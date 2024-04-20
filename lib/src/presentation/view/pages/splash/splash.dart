// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:my_task/blog_model.dart';
// import 'package:my_task/services/apis.dart';
// import 'package:my_task/src/presentation/view/pages/auth/google_signIn.dart';
// import 'package:my_task/src/presentation/view/pages/auth/registation_screen.dart';
// import 'package:my_task/src/presentation/view/pages/home/home_screen.dart';
// import 'package:my_task/src/presentation/view/pages/message/message_users_list.dart';
// import 'package:my_task/src/utils/constants/m_colors.dart';
// import 'package:my_task/src/utils/constants/m_images.dart';
//
//
// //splash screen
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), () {
//       //exit full-screen
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//       SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//           systemNavigationBarColor: Colors.transparent,
//           statusBarColor: Colors.white));
//
//       if (APIs.auth.currentUser != null) {
//         log('\nUser: ${APIs.auth.currentUser}');
//         //navigate to home screen
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) => const ChatHomeScreen()));
//       } else {
//         //navigate to login screen
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) => const RegistrationScreen()));
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //initializing media query (for getting device screen size)
//     mq = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: MyColor.getBackgroundColor(),
//       body: Stack(children: [
//         //app logo
//         Positioned(
//             top: mq.height * .15,
//             right: mq.width * .25,
//             width: mq.width * .5,
//             child: Image.asset(MyImage.image6)),
//
//         //google login button
//         Positioned(
//             bottom: mq.height * .15,
//             width: mq.width,
//             child: const Text('MADE IN INDIA WITH ❤️',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 16, color: Colors.black87, letterSpacing: .5))),
//       ]),
//     );
//   }
// }
