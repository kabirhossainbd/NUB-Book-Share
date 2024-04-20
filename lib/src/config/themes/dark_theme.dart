import 'package:flutter/material.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';


ThemeData dark = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: MyColor.colorPrimary,
    primaryColorLight: MyColor.colorPrimary,
    primaryColorDark: MyColor.colorPrimary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: MyColor.getBackgroundColor(),
    hintColor: MyColor.colorWhite,
    focusColor: MyColor.colorGrey,
    useMaterial3: true,
    /// for text color
    canvasColor: MyColor.colorWhite,
    /// for bg
    highlightColor: MyColor.colorBlack,
    buttonTheme:  const ButtonThemeData(
      buttonColor: MyColor.colorPrimary,
    ),
    cardColor: MyColor.getBackgroundColor(),
    appBarTheme: AppBarTheme(
        backgroundColor: MyColor.getBackgroundColor(),
        elevation: 0,
        titleTextStyle: robotoRegular.copyWith(color: MyColor.colorWhite),
        iconTheme:  const IconThemeData(
            size: 20,
            color: MyColor.colorWhite
        )
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(MyColor.colorWhite),
      fillColor: MaterialStateProperty.all(MyColor.colorWhite),
      overlayColor: MaterialStateProperty.all(MyColor.colorPrimary),
    ));