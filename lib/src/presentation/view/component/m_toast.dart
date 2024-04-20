import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void myToast(String message,{bool isCenter = false, bool isDark = false}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: isDark ? Colors.black.withOpacity(0.8) : const Color(0xF0F0F0EB),
    textColor: isDark ? Colors.white : const Color(0xFF252525),
    // gravity: isCenter ? ToastGravity.CENTER : ToastGravity.BOTTOM_RIGHT
  );
}