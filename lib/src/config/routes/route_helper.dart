import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/home/home_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/splash/splash_screen.dart';

class MyRouteHelper {
  static const String splashScreen = '/splash';
  static const String home = '/';
  static const String onBoarding = '/onBoarding';
  static const String successfulScreen = '/successful';
  static const String productDetails = '/product-branch';
  static const String searchResult = '/search-result';
  static const String searchScreen = '/search';
  static const String notification = '/notification';
  static const String favourite = '/favourite';

  static String getSplashRoute() => splashScreen;
  static String getOnBoardingRoute() => onBoarding;
  static String getHomeRoute() => home;


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onBoarding, page: () => Container()),
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
