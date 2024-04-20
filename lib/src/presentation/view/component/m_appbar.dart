import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isBackButtonExist, isShowIcon;
  final VoidCallback? onBackPressed;
  final VoidCallback? onTab;
  final IconData? icon;
  final String? leadingIcon, actionText;

  const CustomAppBar({Key? key, required this.title, this.isBackButtonExist = true, this.isShowIcon = false, this.onBackPressed, this.onTab, this.icon,this.leadingIcon, this.actionText }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.tr, style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.colorWhite,),textDirection: TextDirection.ltr,),
      leading: isBackButtonExist! ? IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        icon: const Icon(Icons.arrow_back, color: MyColor.colorWhite, size: 20,),
        onPressed: () => onBackPressed != null ? onBackPressed!() : Get.back(canPop: true),
      ) : const SizedBox(),
      leadingWidth: isBackButtonExist! ? 50 : 10,
      elevation: 1,
      centerTitle: true,
      backgroundColor: MyColor.colorPrimary,
      shadowColor: MyColor.colorBlack.withOpacity(0.12),
      bottomOpacity: 0.3,
      automaticallyImplyLeading: false,
      titleSpacing: 10,
      actions: [
        if(isShowIcon!)...[
          GestureDetector(
            onTap: onTab,
            child: const Icon(CupertinoIcons.bell),
          ),
          const SizedBox(width: 16)
        ]
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
