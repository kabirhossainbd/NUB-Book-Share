import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/theme_controller.dart';

class MyColor {
  static Color getPrimaryColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF45436E) : const Color(0xFF333192);
  }

  static Color getSecondaryColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFA39AFF) : const Color(0xFF866EE1);
  }
  static Color getGreyColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF6f7275) : const Color(0xFFD1D0CC);
  }

  static Color getBackgroundColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF000000) : const Color(0xFFF9F8FF);
  }

  static Color getBorderColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF525257) : const Color(0xFFE9E9E9);
  }


  static Color getTextColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  }

  static Color getTitleColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF787C80);
  }

  static Color getDisableColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFBEC1C6) : const Color(0xFF98A2B3);
  }

  static Color getDisableBgColor() {
    return Get.find<ThemeController>().darkTheme ? const Color(0xFFEAECF0).withOpacity(0.35) : const Color(0xFFEAECF0);
  }


  static Color getSurfaceColor(){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF2C2C2E) : const Color(0xFFFFFFFF);
  }

  static Color getCardColor(){
    return Get.find<ThemeController>().darkTheme ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }



  static const Color colorPrimary = Color(0xFF45436E);
  static  Color colorSecondary = const Color(0xFFF1F0FF);
  static const Color colorGrey = Color(0xFF999999);
  static const Color colorHint = Color(0xFFD1D1D6);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorRed = Colors.red;

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };
}
