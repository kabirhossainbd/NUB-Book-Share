// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// class MyNotification {
//   static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize = const AndroidInitializationSettings('notification_icon');
//     var iOSInitialize = const IOSInitializationSettings();
//     var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
//     flutterLocalNotificationsPlugin.initialize(initializationsSettings, onSelectNotification: (String? payload) async {
//       try{
//         if(payload != null && payload.isNotEmpty) {
//
//         }
//       }catch (e) {}
//       return;
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("onMessage: ${jsonEncode(message.data)}");
//       MyNotification.showNotification(message.data, flutterLocalNotificationsPlugin);
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("onMessageApp: ${message.data}");
//     });
//   }
//
//   static Future<void> showNotification(Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
//     if(message['profile'] != null && message['profile'].isNotEmpty) {
//       try{
//         await showBigPictureNotificationHiddenLargeIcon(message, fln);
//       }catch(e) {
//         await showBigTextNotification(message, fln);
//       }
//     }else {
//       await showBigTextNotification(message, fln);
//     }
//   }
//
//   static Future<void> showTextNotification(Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
//     String _title = message['name'];
//     String _body = message['body'];
//     String _orderID = message['id'];
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your channel id', 'your channel name', sound: RawResourceAndroidNotificationSound('notification'),
//       importance: Importance.max, priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, _title, _body, platformChannelSpecifics, payload: _orderID);
//   }
//
//   static Future<void> showBigTextNotification(Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
//
//     print('----------------:::::::Message ${jsonEncode(message.values)}');
//     String _title = message['name'];
//     String _body = message['name'];
//     String _orderID = message['id'];
//
//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       _body, htmlFormatBigText: true,
//       contentTitle: _title, htmlFormatContentTitle: true,
//     );
//     AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'big text channel id', 'big text channel name', importance: Importance.max,
//       styleInformation: bigTextStyleInformation, priority: Priority.high, sound: const RawResourceAndroidNotificationSound('notification'),
//     );
//     NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, _title, _body, platformChannelSpecifics);
//   }
//
//   static Future<void> showBigPictureNotificationHiddenLargeIcon(Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
//     String _title = message['name'];
//     String _body = message['name'];
//     String _orderID = message['id'];
//     String _image = message['image'];
//     final String largeIconPath = await _downloadAndSaveFile(_image, 'largeIcon');
//     final String bigPicturePath = await _downloadAndSaveFile(_image, 'bigPicture');
//     final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
//       FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
//       contentTitle: _title, htmlFormatContentTitle: true,
//       summaryText: _body, htmlFormatSummaryText: true,
//     );
//     final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'big text channel id', 'big text channel name',
//       largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.high, sound: const RawResourceAndroidNotificationSound('notification'),
//       styleInformation: bigPictureStyleInformation, importance: Importance.max,
//     );
//     final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, _title, _body, platformChannelSpecifics, payload: _orderID);
//   }
//
//   static Future<String> _downloadAndSaveFile(String url, String fileName) async {
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/$fileName';
//     http.Response remoteResponse = await http.get(Uri.parse(url));
//     final File file = File(filePath);
//     await file.writeAsBytes(remoteResponse.bodyBytes);
//     return filePath;
//   }
//
// }
//
// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
//   print('background: ${message.data}');
//   var androidInitialize = const AndroidInitializationSettings('notification_icon');
//   var iOSInitialize = const IOSInitializationSettings();
//   var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   flutterLocalNotificationsPlugin.initialize(initializationsSettings);
//   MyNotification.showNotification(message.data, flutterLocalNotificationsPlugin);
// }