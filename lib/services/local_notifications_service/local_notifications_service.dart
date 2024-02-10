import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:scheduling_local_notifications_app/constants/constants.dart'
    as constants;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('notify_icon');
    DarwinInitializationSettings iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _localNotificationPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    await _requestPermissions();
  }

  // to schedule a local notification
  Future showScheduleNotification({
    required String title,
    required String body,
    required String payload,
    required int timestamp,
    required List<int> idList,
    int? recurring,
  }) async {
    final NotificationDetails details = await _notificationDetails();
    DateTime now = DateTime.now();
    DateTime timestampDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = timestampDateTime.difference(now);

    tz.initializeTimeZones();

    if (recurring != null) {
      // recurring notifications

      final tz.TZDateTime scheduledTime =
          tz.TZDateTime.now(tz.local).add(Duration(minutes: recurring));

      for (int i = 0; i < constants.Values.repeatNotification; i++) {
        final int id = idList[i];
        final tz.TZDateTime notificationTime = scheduledTime.add(
          Duration(minutes: recurring * i),
        );

        await _localNotificationPlugin.zonedSchedule(
          id,
          title,
          body,
          notificationTime,
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
        );

        debugPrint(notificationTime.toString());
      }
    } else {
      final int id = idList.first;

      await _localNotificationPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(difference),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );

      debugPrint((tz.TZDateTime.now(tz.local).add(difference)).toString());
    }
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return _localNotificationPlugin.show(
        id, title, body, await _notificationDetails());
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> _requestPermissions() async {
    await _localNotificationPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> cancelNotification(List<int> notifyIdList) async {
    for (int id in notifyIdList) {
      await _localNotificationPlugin.cancel(id);
    }
  }
}
