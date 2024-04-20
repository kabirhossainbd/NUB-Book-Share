// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nub_book_sharing/controller/localization_controller.dart';
// import 'package:nub_book_sharing/controller/theme_controller.dart';
// import 'package:nub_book_sharing/services/apis.dart';
// import 'package:nub_book_sharing/src/config/themes/custom_theme.dart';
// import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
// import 'package:nub_book_sharing/src/presentation/view/pages/profile/edit_profile.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
// import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
//
// class DarkMode extends StatefulWidget {
//   const DarkMode({super.key});
//
//   @override
//   State<DarkMode> createState() => _DarkModeState();
// }
//
// class _DarkModeState extends State<DarkMode> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final circleOffset = Offset(size.width - 20, size.height - 20);
//     return GetBuilder<ThemeController>(
//       builder: (theme) => DarkTransition(
//         childBuilder: (context, value) => MenuScreen(
//           onTap: () {
//             theme.toggleTheme();
//           },
//         ),
//         offset: circleOffset,
//         isDark: theme.darkTheme,
//       ),
//     );
//   }
// }
//
//
// class MenuScreen extends StatefulWidget {
//   final VoidCallback onTap;
//   const MenuScreen({super.key, required this.onTap});
//
//
//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }
//
// class _MenuScreenState extends State<MenuScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LocalizationController>(
//       builder: (local) => GetBuilder<ThemeController>(
//         builder: (theme) => Scaffold(
//           appBar: CustomAppBar(title: 'menu'.tr, isBackButtonExist: false,),
//           // backgroundColor: Theme.of(context).hoverColor,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Column( crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   GestureDetector(
//                     onTap: (){
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => EditProfileScreen(user: APIs.me)));
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(MySizes.marginSizeDefault),
//                       child: Row(
//                         children: [
//                           const CircleAvatar(
//                             radius: 30,
//                             backgroundImage: NetworkImage('https://i.pinimg.com/736x/ef/96/be/ef96be5425be0fa5d1c817b36bb2020a.jpg'),
//                           ),
//                           const SizedBox(width: MySizes.paddingSizeMiniSmall),
//                           Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('Mr John', style: robotoLight.copyWith(fontSize: MySizes.fontSizeOverLarge)),
//                               Text('app developer', style: robotoRegular.copyWith(fontSize: MySizes.fontSizeDefault)),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                            // SvgPicture.asset(MyImage.language, height: 24, width: 24, color: MyColor.colorPrimary),
//                             const SizedBox(width: MySizes.marginSizeMiniSmall),
//                             Text('change_language'.tr, style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge),),
//                             const Spacer(),
//                             InkWell(
//                               onTap: () => local.toggleLanguage(),
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   // color: MyColor.getBackgroundColor(),
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(color: MyColor.getPrimaryColor(), width: 1)
//                                 ),
//                                 child: Text(
//                                   local.locale.languageCode == 'en'
//                                       ? 'English'.tr
//                                       :'Arabic'.tr,
//                                   style: robotoRegular.copyWith(fontSize: MySizes.fontSizeSmall),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
//                         child: Divider(height: 1,),
//                       ),
//                     ],
//                   ),
//
//                  // _rowItem(MyImage.coin, 'recharge_coin'.tr, onTap: (){}),
//
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                            // SvgPicture.asset(MyImage.darkTheme, height: 24, width: 24, color: MyColor.colorPrimary,),
//                             const SizedBox(width: MySizes.marginSizeMiniSmall),
//                             Text('dark_mode'.tr, style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge),),
//                             const Spacer(),
//
//                             InkWell(
//                               onTap: ()=> theme.toggleTheme(),
//                               child: Container(
//                                 width: 34,
//                                 height: 20,
//                                 padding: const EdgeInsets.symmetric(horizontal: 3),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   color: theme.darkTheme ? MyColor.colorPrimary : Colors.grey.shade300,
//                                 ),
//                                 child: Row(
//                                   children:  [
//                                     if(theme.darkTheme)...[
//                                       const Expanded(child: SizedBox()),
//                                       const Padding(padding: EdgeInsets.all(1.0), child: CircleAvatar(radius: 6, backgroundColor: Colors.white,)),
//                                     ]else...[
//                                       const Padding(padding: EdgeInsets.all(1.0), child: CircleAvatar(radius: 6,backgroundColor: Colors.black)),
//                                       const Expanded(child: SizedBox()),
//                                     ]
//
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
//                         child: Divider(height: 1,),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
