import 'package:flutter/material.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';

ThemeData light = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: MyColor.colorPrimary,
    primaryColorLight: MyColor.colorPrimary,
    primaryColorDark: MyColor.colorPrimary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MyColor.colorGrey.withOpacity(0.3),
    hintColor: MyColor.colorBlack,
  useMaterial3: true,
    /// for text color
    canvasColor: MyColor.colorBlack,
    /// for bg
    highlightColor: MyColor.colorWhite,
    buttonTheme: const ButtonThemeData(
      buttonColor: MyColor.colorPrimary,
    ),
    cardColor: MyColor.getBackgroundColor(),
    appBarTheme: AppBarTheme(
        backgroundColor: MyColor.colorPrimary,
        elevation: 0,
        titleTextStyle: robotoRegular.copyWith(color: MyColor.colorWhite),
        iconTheme:  const IconThemeData(
            size: 20,
            color: MyColor.colorWhite,
        )
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.colorPrimary),
    ),
);
