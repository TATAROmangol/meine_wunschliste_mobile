import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:realm/realm.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime? scheduledDate,
    int id = 0,
  }) async {
    if (scheduledDate == null) {
      print('Scheduled date is null, notification not scheduled.');
      return;
    }

    print('Scheduled date received: $scheduledDate');

    final tz.TZDateTime scheduledDateTime =
        tz.TZDateTime.from(scheduledDate, tz.local);

    print('Scheduled date in local timezone: $scheduledDateTime');

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      title,
      body,
      importance: Importance.max,
      priority: Priority.high,
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> updateScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime newScheduledDate,
  }) async {
    await cancelNotification(id);
    await scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: newScheduledDate,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
