import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {

  //show toast
  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30, width: 30,child: Center(child: CircularProgressIndicator(strokeWidth: 3,))),
              const SizedBox(width: 15),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}

bool validateEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRegex.hasMatch(email);
}