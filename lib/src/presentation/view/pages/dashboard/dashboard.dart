// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nub_book_sharing/services/apis.dart';
// import 'package:nub_book_sharing/src/presentation/view/pages/home/home_screen.dart';
// import 'package:nub_book_sharing/src/presentation/view/pages/message/message_users_list.dart';
// import 'package:nub_book_sharing/src/presentation/view/pages/my_book/my_book_screen.dart';
// import 'package:nub_book_sharing/src/presentation/view/pages/profile/profile_screen.dart';
// import 'package:nub_book_sharing/src/presentation/view/pages/today_task/create_task_screen.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//
//   late PageController _pageController;
//   int _pageIndex = 0;
//   late List<Widget> _screens;
//   final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
//   bool _canExit = GetPlatform.isWeb ? true : false;
//
//   @override
//   void initState() {
//     super.initState();
//     APIs.getSelfInfo();
//     _pageController = PageController(initialPage: 0);
//     _screens = [
//       const HomeScreen(),
//       const MyBookScreen(),
//       const AddBookScreen(),
//       const ChatHomeScreen(),
//       const ProfileScreen(fromOthers: false,)
//      // const MeScreen()
//     ];
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_pageIndex != 0) {
//           _setPage(0);
//           return false;
//         } else {
//           if (_canExit) {
//             return true;
//           } else {
//             // showCustomToast(translatedText('again_to_exit', context)!, isError: false);
//             _canExit = true;
//             Timer(const Duration(seconds: 2), () {
//               _canExit = false;
//             });
//             return false;
//           }
//         }
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: MyColor.getBackgroundColor(),
//         bottomNavigationBar: SafeArea(
//           child: Container(
//             height: 55,
//             margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
//             padding: const EdgeInsets.fromLTRB(12,8,12,8),
//             decoration: BoxDecoration(
//               color: MyColor.getBackgroundColor().withOpacity(0.9),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: MyColor.getGreyColor().withOpacity(0.3),
//                   blurRadius: 5,
//                   spreadRadius: 2,
//                   offset: const Offset(2,2)
//                 )
//               ]
//             ),
//             child: Row(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 BottomNavItem(image: CupertinoIcons.home,  title: 'home'.tr, isSelected: _pageIndex == 0, color: _pageIndex == 0 ? MyColor.colorPrimary : MyColor.colorGrey,  onTap: () {
//                   _setPage(0);
//                 },),
//                 BottomNavItem(image: CupertinoIcons.calendar_today,  title: 'chat'.tr, isSelected: _pageIndex == 1, color: _pageIndex == 1 ? MyColor.colorPrimary : MyColor.colorGrey,  onTap: () {
//                   _setPage(1);
//
//                 },),
//
//                 addTaskCreate(onTap: ()=> _setPage(2)),
//
//                 BottomNavItem(image: CupertinoIcons.chat_bubble, title: 'image'.tr, isSelected: _pageIndex == 3, color: _pageIndex == 3 ? MyColor.colorPrimary : MyColor.colorGrey, onTap: () {
//                   _setPage(3);
//                 },
//                 ),
//                 BottomNavItem(image: CupertinoIcons.profile_circled,  title: 'menu'.tr, isSelected: _pageIndex == 4, color: _pageIndex == 4 ? MyColor.colorPrimary : MyColor.colorGrey, onTap: () {
//                   _setPage(4);
//                 }),
//               ],
//             ),
//           ),
//         ),
//         body: PageView.builder(
//           controller: _pageController,
//           itemCount: _screens.length,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return _screens[index];
//           },
//         ),
//       ),
//     );
//   }
//
//   void _setPage(int pageIndex) {
//     setState(() {
//       _pageController.jumpToPage(pageIndex);
//       _pageIndex = pageIndex;
//     });
//   }
//
//   Widget addTaskCreate({VoidCallback? onTap}){
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 56,
//         width: 56,
//         alignment: Alignment.center,
//         decoration:  const BoxDecoration(
//             color: Color(0xFFA39AFF),
//             shape: BoxShape.circle
//         ),
//         child: const Icon(CupertinoIcons.add),
//       ),
//     );
//   }
// }
//
// class BottomNavItem extends StatelessWidget {
//   final IconData? image;
//   final String? title;
//   final VoidCallback? onTap;
//   final bool? isSelected;
//   final Color? color;
//   const BottomNavItem({Key? key,  this.image, this.title, this.onTap, this.isSelected = false, this.color}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       hoverColor: Colors.transparent,
//       focusColor: Colors.transparent,
//       child: Container(
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           border: Border(bottom: BorderSide(width: 3.0, color: isSelected! ? MyColor.colorPrimary : Colors.transparent)),
//         ),
//         child: Icon(image!, size: 24, color: color,
//        // child: SvgPicture.asset(image!, width: 24, height: 24, color: color,
//         ),
//       ),
//     );
//   }
// }
