
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/model/repo/home_repo.dart';
import 'package:nub_book_sharing/model/response/book_model.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/drawer/main_menu.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/home/home_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/message/message_users_list.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/my_book/my_book_screen.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/profile/profile_screen.dart';
import 'package:nub_book_sharing/src/utils/constants/m_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../src/presentation/view/pages/today_task/create_task_screen.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRequest homeRequest;
  final SharedPreferences sharedPreferences;
  HomeController({required this.homeRequest, required this.sharedPreferences}){
    _getNotificationState();
  }

  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  /// book list
  List<BookModel> _boolList = [];
  List<BookModel> get boolList => _boolList;

  void getBookList() async{
    Response response = await homeRequest.getBookList();
    if(response.statusCode == 200){
      _boolList = [];
      _boolList.addAll(response.body);
    }else{
      debugPrint(response.statusText);
    }
    update();
  }

  int _selectTrendingIndex = 0;
  int get selectTrendingIndex => _selectTrendingIndex;

  setTrendingIndex(int index, bool notify){
    _selectTrendingIndex = index;
    if(notify){
      update();
    }
  }


  int _categoryIndex = -1;
  int get categoryIndex => _categoryIndex;

  setCategoryIndex(int index, bool notify){
    _categoryIndex = index;
    if(notify){
      update();
    }
  }


  /// for banner

  int _selectBannerIndex = 0;
  int get selectBannerIndex => _selectBannerIndex;
  void changeSelectBannerIndex(int index) {
    _selectBannerIndex = index;
    update();
  }

  /// for notification
  bool _isNotifications = true;
  bool get isNotifications => _isNotifications;

  void toggleNotification() {
    _isNotifications = !_isNotifications;
    sharedPreferences.setBool(MyKey.notification, _isNotifications);
    if (_isNotifications) {
      subscribeTopicForNotification(MyKey.notification);
    } else {
      unSubscribeTopicForNotification(MyKey.notification);
    }
    update();
  }

  void _getNotificationState() async {
    _isNotifications = sharedPreferences.getBool(MyKey.notification) ?? true;
    if (_isNotifications) {
      subscribeTopicForNotification(MyKey.notification);
    } else {
      unSubscribeTopicForNotification(MyKey.notification);
    }
  }

  void unSubscribeTopicForNotification(String topic) {
    debugPrint("unsub -> $topic");
    messaging.unsubscribeFromTopic(topic);
  }

  void subscribeTopicForNotification(String topic) {
    debugPrint("sub -> $topic");
    messaging.subscribeToTopic(topic);
  }

  late PageController _pageController;
  PageController get pageController => _pageController;

  initPageController(){
    _pageController = PageController(initialPage: 0);
    print('-------------------:::::::::::initial pageController---');
  }
  final List<MenuClass> _screens = [
    const MenuClass("Home", Icons.home_filled, 0, HomeScreen()),
    const MenuClass("My Book", Icons.book, 1, MyBookScreen()),
    const MenuClass("Add Book", Icons.add, 2, AddBookScreen()),
    const MenuClass("Chat", CupertinoIcons.chat_bubble, 3, ChatHomeScreen()),
    const MenuClass("Profile", Icons.person, 4, ProfileScreen(fromOthers: false,)),
  ];
  List<MenuClass> get screens => _screens;

  String _appbarTitle = 'Home';
  String get appbarTitle => _appbarTitle;
  setAppbarTitle(String val){
    _appbarTitle = val;
    update();
  }
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  void setPage(int pageIndex) {
   if(_pageController.hasClients){
     _pageController.jumpToPage(pageIndex);
   }

   print('--------------------:::::::::$_pageIndex');
    _pageIndex = pageIndex;
    setAppbarTitle(_screens[_pageIndex].title);
    update();
  }

}
