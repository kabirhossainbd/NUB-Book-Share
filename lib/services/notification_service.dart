import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nub_book_sharing/model/response/chatuser_model.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/message/message_box_screen.dart';

class LocalNotification {
  static final client = FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin getLocalPlugin() {
    return client;
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message");
  var valueMap = message.data;
  debugPrint("notification message -> $valueMap");
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'nub_channel',
  'nub_channelName',
  description: 'NUB Book Notification',
  importance: Importance.max,
  sound: RawResourceAndroidNotificationSound('notification'),
);


void handleNotification() async {
  await LocalNotification().getLocalPlugin().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    // var remoteData = message.data;

    var initializationSettingsAndroid = const AndroidInitializationSettings('notification_icon.png');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    LocalNotification().getLocalPlugin().initialize(initializationSettings, onSelectNotification: (st) {
      debugPrint("data ---------------------> $st");
      Map valueMap = jsonDecode(st ?? '');
      debugPrint("value Map -> $valueMap");
    });

    AwesomeNotifications().initialize(null, [NotificationChannel(
      channelKey: 'nub_channel',
      channelName: 'nub_channelName',
      channelDescription: 'NUB Book Notification',
      ledColor: Colors.white,
      importance: NotificationImportance.Max,
    )]);

    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });


    /// show the notification for user
    if (notification != null && android != null) {
      Map<String, String> stringQueryParameters = message.data.map((key, value) => MapEntry(key, value!.toString()));
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: notification.hashCode,
            channelKey: 'nub_channel',
            title: notification.title,
            body: notification.body,
            payload: stringQueryParameters,
            criticalAlert: true,
            wakeUpScreen: true,
            notificationLayout: NotificationLayout.Default,
            displayOnBackground: true,
            roundedBigPicture: true,
            roundedLargeIcon: true,
            displayOnForeground: true
        ),
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    debugPrint(" ${message.data["data"]}---onMessageOpenedApp----: \n${message.data.toString()}");
  }).onData((data) {
    var valueMap = data.data;
      Get.to(ChatScreen(user: ChatUser.fromJson(valueMap)));
      debugPrint("This is for background notification data -> $valueMap");
  });
  FirebaseMessaging.instance.getInitialMessage().then((value) => value != null ? firebaseMessagingBackgroundHandler : false);
}




class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod( ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
    var valueMap = receivedAction.payload;

    if(valueMap != null){
      try{
        var userData = ChatUser.fromJson(receivedAction.payload ?? {});
         Get.to(ChatScreen(user: userData));
      }catch(e){
        debugPrint("notification data userData on Foreground ->$e" );
      }
    }
    debugPrint("notification data userData on Foreground ->" );
  }
}