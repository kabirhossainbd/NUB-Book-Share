import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/auth_controller.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/services/apis.dart';
import 'package:nub_book_sharing/src/presentation/view/component/profile_avatar.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/home/home_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/message/message_users_list.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/my_book/my_book_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/edit_profile.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/profile_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/today_task/create_task_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:page_transition/page_transition.dart';

class MenuScreen extends StatefulWidget {
  final void Function(int)? callback;
  final int current;
  final ZoomDrawerController controller;
  const MenuScreen({super.key, this.callback, required this.current, required this.controller});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

   List<MenuClass> mainMenu = [
    const MenuClass("Home", Icons.home_filled, 0, HomeScreen()),
    const MenuClass("My Book", Icons.book, 1, MyBookScreen()),
    const MenuClass("Add Book", Icons.add, 2, AddBookScreen()),
    const MenuClass("Chat", CupertinoIcons.chat_bubble, 3, ChatHomeScreen()),
    const MenuClass("Profile", Icons.person, 4, ProfileScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    const androidStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    const style = androidStyle;

    return GetBuilder<HomeController>(
      builder: (home) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Colors.indigo,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 50, 24,24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: ()=> Navigator.push(context, PageTransition(child: EditProfileScreen(user: APIs.me), type: PageTransitionType.rightToLeft)).then((value) =>  setState(() {})),
                              child: ProfileAvatar(url: APIs.me.profile ?? "", height: 90, width: 90,)),
                          const SizedBox(height: 12),
                          Text(APIs.me.name ?? "", style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeOverLarge), maxLines: 1,),
                          const SizedBox(height: 2),
                          Text(APIs.me.email ?? "", style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeSmall),),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    ...mainMenu.map((item) => TextButton(
                      onPressed: () {
                        home.setPage(item.index);
                        widget.controller.toggle?.call();
                        },
                      style: TextButton.styleFrom(
                        foregroundColor: widget.current == item.index ? const Color(0x44000000) : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            color: Colors.white,
                            size: 24,
                          ),
                         const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              item.title,
                              style: style,
                            ),
                          )
                        ],
                      ),
                    )).toList(),


                    GetBuilder<AuthController>(
                      builder: (auth) => Padding(
                        padding: const EdgeInsets.fromLTRB(14, 50, 24,24),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white, width: 2.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _customLogout(auth, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Logout",
                              style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: MySizes.fontSizeLarge)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _customLogout(AuthController auth, BuildContext context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  alignment: Alignment.center,
                  backgroundColor: MyColor.getBackgroundColor(),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () => Get.back(),
                                child: Text('cancel'.tr,
                                  style: robotoRegular.copyWith(
                                      color: MyColor.colorGrey,
                                      fontSize:
                                      MySizes.fontSizeDefault),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )),
                            const SizedBox(width: 50,),
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: ()=> auth.logOut(),
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: MyColor.getPrimaryColor(),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "log_out".tr,
                                    style: robotoRegular.copyWith(
                                        color: MyColor.colorWhite,
                                        fontSize:
                                        MySizes.fontSizeDefault),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                            )
                          ]),
                    )
                  ],
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  title: Text('log_out'.tr, style: robotoLight.copyWith(
                      color: MyColor.getTextColor(),
                      fontSize: 28),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                  content:  Text( 'are_you_sure_want'.tr,
                    style: robotoLight.copyWith(
                        color: MyColor.getTextColor(),
                        fontSize:
                        MySizes.fontSizeLarge),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
  }
}


class MenuClass {
  final String title;
  final IconData icon;
  final int index;
  final Widget screen;
  const MenuClass(this.title, this.icon, this.index, this.screen);
}