import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        appBar: const CustomAppBar(title: 'Notification Screen',),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade200,
                  ),
                  color: MyColor.colorWhite,
                ),
                child: SwitchListTile(
                  value: home.isNotifications,
                  onChanged: (bool isActive) => home.toggleNotification(),
                  title: Text('Notification',
                      style: robotoRegular.copyWith(
                          fontSize: MySizes.fontSizeLarge)),
                  activeColor: MyColor.getPrimaryColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
