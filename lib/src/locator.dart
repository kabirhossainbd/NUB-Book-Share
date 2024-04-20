import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/auth_controller.dart';
import 'package:nub_book_sharing/controller/book_controller.dart';
import 'package:nub_book_sharing/controller/home_controller.dart';
import 'package:nub_book_sharing/controller/localization_controller.dart';
import 'package:nub_book_sharing/controller/save_controller.dart';
import 'package:nub_book_sharing/controller/splash_controller.dart';
import 'package:nub_book_sharing/controller/theme_controller.dart';
import 'package:nub_book_sharing/model/repo/home_repo.dart';
import 'package:nub_book_sharing/model/repo/save_repo.dart';
import 'package:nub_book_sharing/model/repo/splash_repo.dart';
import 'package:nub_book_sharing/model/response/language_model.dart';
import 'package:nub_book_sharing/src/data/datasource/remote/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/chat_controller.dart';
import 'utils/constants/m_key.dart';


Future<Map<String, Map<String, String>>> init() async {

  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: '',  sharedPreferences: Get.find()));


  /// Request
  Get.lazyPut(() => SplashRequest(apiSource: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRequest(apiSource: Get.find()));
  Get.lazyPut(() => SavedRepo(apiSource: Get.find(), sharedPreferences: Get.find()));

  /// Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => HomeController(homeRequest: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ChatController());
  Get.lazyPut(() => BookController());
  Get.lazyPut(() => SavedController(savedRepo: Get.find()));

  /// read from json file
  Map<String, Map<String, String>> langFiles = {};
  for(LanguageModel languageModel in MyKey.languages) {
    String jsonToString =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonToString);
    Map<String, String> convertToJson = {};
    mappedJson.forEach((key, value) {
      convertToJson[key] = value.toString();
    });
    langFiles['${languageModel.languageCode}_${languageModel.countryCode}'] = convertToJson;
  }
  return langFiles;
}

