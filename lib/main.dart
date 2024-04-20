import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/controller/localization_controller.dart';
import 'package:nub_book_sharing/controller/theme_controller.dart';
import 'package:nub_book_sharing/services/local_string.dart';
import 'package:nub_book_sharing/services/notification_service.dart';
import 'package:nub_book_sharing/src/config/routes/route_helper.dart';
import 'package:nub_book_sharing/src/config/themes/dark_theme.dart';
import 'package:nub_book_sharing/src/config/themes/light_theme.dart';
import 'package:nub_book_sharing/src/config/themes/m_theme_util.dart';
import 'package:nub_book_sharing/src/utils/constants/m_strings.dart';
import 'src/locator.dart' as di;

late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeUtil.allScreenTheme();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyA4F7oydmo0wWzCcVW7vmoSVuA0g8VZmqo',
          appId: '1:725538464772:android:eb122fbb4a51ccbace8151',
          messagingSenderId: '725538464772',
          projectId: 'nub-book-sharing',
          storageBucket: "nub-book-sharing.appspot.com",
        )
    ).whenComplete(() => FirebaseMessaging.instance.requestPermission().whenComplete((){
      handleNotification();
    }));
  } catch (_) {
    debugPrint("error ");
  }
 //  var result = await FlutterNotificationChannel.registerNotificationChannel(
 //      description: 'For Showing Message Notification',
 //      id: 'chats',
 //      importance: NotificationImportance.IMPORTANCE_HIGH,
 //      name: 'Chats');
 // log('\nNotification Channel Result: $result');
  await di.init();
  Map<String, Map<String, String>> localString = await di.init();
  runApp( MyApp(localString: localString,));
}

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final Map<String, Map<String, String>> localString;
  const MyApp({Key? key, required this.localString}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GetBuilder<ThemeController>(builder: (theme) {
      return GetBuilder<LocalizationController>(builder: (local) {
        return GetMaterialApp(
          locale: local.locale,
          // locale: Get.deviceLocale,
          translations: LocaleString(localString: widget.localString),
          fallbackLocale: const Locale('en', 'US'),
          title: MyStrings.appName,
          initialRoute: MyRouteHelper.splashScreen,
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
          getPages: MyRouteHelper.routes,
          navigatorKey: Get.key,
          theme: theme.darkTheme ? dark : light,
          debugShowCheckedModeBanner: false,
        );
      });
    });
  }
}