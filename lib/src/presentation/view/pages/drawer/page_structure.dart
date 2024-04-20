import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/services/apis.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_toast.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/profile_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:page_transition/page_transition.dart';


class PageStructure extends StatefulWidget {
  final String? title;
  final Widget? child;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;

  const PageStructure({
    Key? key,
    this.title,
    this.child,
    this.actions,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  State<PageStructure> createState() => _PageStructureState();
}

class _PageStructureState extends State<PageStructure> {
  bool _canExit = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
    Get.find<HomeController>().initPageController();

  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) => WillPopScope(
        onWillPop: () async {
          if (home.pageIndex != 0) {
            home.setPage(0);
            return false;
          } else {
            if (_canExit) {
              return true;
            } else {
               myToast('Back again to exit');
              _canExit = true;
              Timer(const Duration(seconds: 2), () {
                _canExit = false;
              });
              return false;
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              ZoomDrawer.of(context)!.toggle();
            }, icon: const Icon(Icons.sort, size: 28,)),
            title:  Text(home.appbarTitle, style: robotoBold.copyWith(fontSize: MySizes.fontSizeExtraLarge),),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, PageTransition(child: const ProfileScreen(), type: PageTransitionType.rightToLeft));
              }, icon: const Icon(CupertinoIcons.person, size: 28,)),
              const SizedBox(width: 8)
            ],
          ),
          backgroundColor: MyColor.getBackgroundColor(),
          bottomNavigationBar: SafeArea(
            child: Container(
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
              padding: const EdgeInsets.fromLTRB(12,8,12,8),
              decoration: BoxDecoration(
                  color: MyColor.getBackgroundColor().withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: MyColor.getGreyColor().withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: const Offset(2,2)
                    )
                  ]
              ),
              child: Row(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(image: CupertinoIcons.home,  title: 'home'.tr, isSelected: home.pageIndex == 0, color: home.pageIndex == 0 ? MyColor.colorPrimary : MyColor.colorGrey,  onTap: () {
                    home.setPage(0);
                  },),
                  BottomNavItem(image: CupertinoIcons.calendar_today,  title: 'chat'.tr, isSelected: home.pageIndex == 1, color: home.pageIndex == 1 ? MyColor.colorPrimary : MyColor.colorGrey,  onTap: () {
                    home.setPage(1);

                  },),

                  addTaskCreate(onTap: ()=> home.setPage(2)),

                  BottomNavItem(image: CupertinoIcons.chat_bubble, title: 'image'.tr, isSelected: home.pageIndex == 3, color: home.pageIndex == 3 ? MyColor.colorPrimary : MyColor.colorGrey, onTap: () {
                    home.setPage(3);
                  },
                  ),
                  BottomNavItem(image: CupertinoIcons.profile_circled,  title: 'menu'.tr, isSelected: home.pageIndex == 4, color: home.pageIndex == 4 ? MyColor.colorPrimary : MyColor.colorGrey, onTap: () {
                    home.setPage(4);
                  }),
                ],
              ),
            ),
          ),
          body: PageView.builder(
            controller: home.pageController,
            itemCount: home.screens.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return home.screens[index].screen;
            },
          ),
        ),
      ),
    );
  }


  Widget addTaskCreate({VoidCallback? onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        width: 56,
        alignment: Alignment.center,
        decoration:  const BoxDecoration(
            color: Color(0xFFA39AFF),
            shape: BoxShape.circle
        ),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData? image;
  final String? title;
  final VoidCallback? onTap;
  final bool? isSelected;
  final Color? color;
  const BottomNavItem({Key? key,  this.image, this.title, this.onTap, this.isSelected = false, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 3.0, color: isSelected! ? MyColor.colorPrimary : Colors.transparent)),
        ),
        child: Icon(image!, size: 24, color: color,
       // child: SvgPicture.asset(image!, width: 24, height: 24, color: color,
        ),
      ),
    );
  }
}