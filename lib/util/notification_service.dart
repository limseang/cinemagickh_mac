
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';



const AndroidNotificationChannel channel = AndroidNotificationChannel(
  '0', // id
  'My Channel', // title
  importance: Importance.high,
);

class NotificationService {
  static Future init() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
  
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
   var initializationSettingsIOS = DarwinInitializationSettings();
   var initializationSettings = InitializationSettings(
       android: initializationSettingsAndroid,iOS: initializationSettingsIOS);
   flutterLocalNotificationsPlugin.initialize(initializationSettings);


  }

  static Future<void> selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    selectNotificationStream.add(payload);
  }

  static Future<void> showNotification(String title, String body) async {

    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        '0', 'My Channel',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(id++, '$title', '$body', notificationDetails, payload: 'item x');
  }
}


