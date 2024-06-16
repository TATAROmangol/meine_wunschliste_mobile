import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Инициализация временной зоны
    tz.initializeTimeZones();

    // Инициализация flutter_local_notifications
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
    required DateTime scheduledDate,
    int id = 0, // ID уведомления
  }) async {
    // Получение текущего часового пояса
    const String timeZoneName = 'Europe/Moscow';
    final tz.Location timeZone = tz.getLocation(timeZoneName);

    // Преобразование DateTime в TZDateTime с учетом часового пояса
    final tz.TZDateTime scheduledDateTime =
        tz.TZDateTime.from(scheduledDate, timeZone);

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id', // ID канала уведомлений
      title, // Название канала уведомлений
      body, // Описание канала уведомлений
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
    // Отмена старого уведомления по его ID
    await cancelNotification(id);

    // Планирование нового уведомления с обновленным временем
    await scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: newScheduledDate,
    );
  }

  static Future<void> cancelNotification(int id) async {
    // Отмена уведомления по его ID
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
