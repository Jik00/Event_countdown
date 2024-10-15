import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  // create object
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  //basic Notification
  static void showBasicNotification() async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
        'id 1', 'basic notification',
        importance: Importance.max,
        priority: Priority.high,
    );
        NotificationDetails details = NotificationDetails(
        android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Event Update !',
      'your Event has been updated successfully',
      details,
      payload: "Payload Data",
    );
  }

  //Scheduled Notification
  static Future<void> showScheduledNotification(DateTime eventDate) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'scheduled_notification', // Unique ID for this notification channel
      'Scheduled Notification', // Channel name
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails details = const NotificationDetails(
      android: android,
    );

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    log(currentTimeZone);
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    log(tz.TZDateTime.now(tz.local).hour.toString());

    // Get the date at 00:00 on the event date
    final scheduledDate = tz.TZDateTime(tz.local, eventDate.year, eventDate.month, eventDate.day);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'Event Reminder',
        'Check today\'s Event',
        scheduledDate,
        details,
        payload: 'zonedSchedule',
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        );
   }
}