import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:themanager/features/todo/pages/view_note.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/task_model.dart';

class NotificationHelper {
  final WidgetRef ref;
  NotificationHelper({required this.ref});

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? selectednotificationPayload;

  final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject();

  initializeNotification() async {
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: ondidreceivelocalnotification);
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (data) async {
      selectNotificationSubject.add(data.payload);
    });
  }

  void requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    const String timezone = 'Asia/Shanghai';
    tz.setLocalLocation(tz.getLocation(timezone));
  }

  Future<void> ondidreceivelocalnotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
        context: ref.context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title ?? ''),
              content: Text(body ?? ''),
              actions: [
                CupertinoDialogAction(
                  child: Text("Close"),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text("View"),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  void scheduleNotification(
      int days, int hours, int minutes, int seconds, Task task) async {
  

    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id ?? 0,
        task.title,
        task.desc,
        tz.TZDateTime.now(tz.local).add(Duration(
            days: days, hours: hours, minutes: minutes, seconds: seconds)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel_id', // The same ID used to create the channel
            'Default Channel', // Use a unique channel name
            // Use a unique channel description
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload:
            "${task.title}|${task.desc}|${task.date}|${task.startTime}|${task.endTime}");
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      var title = payload!.split('|')[0];
      var body = payload.split('|')[1];
      showDialog(
          context: ref.context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(title),
                content: Text(
                  body,
                  textAlign: TextAlign.justify,
                  maxLines: 4,
                ),
                actions: [
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Close")),
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NotificationsPage(payload: payload)));
                      },
                      child: Text("View")),
                ],
              ));
    });
  }
}
