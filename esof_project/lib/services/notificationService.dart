import 'dart:async';
import 'package:esof_project/app/controllers/notificationController.dart';
import 'package:esof_project/app/models/notication.model.dart';
import 'package:esof_project/app/models/validity.model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../app/controllers/validityControllers.dart';

class NotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late List<NotificationModel> notifications;
  late StreamSubscription<List<NotificationModel>> _notificationSubscription;
  List<NotificationModel> scheduledNotifications = [];

  Future<void> initializeNotification() async {
    tz.initializeTimeZones();
    NotificationController notificationController = NotificationController();
    notifications = await notificationController.getAllNotifications();
    _notificationSubscription = notificationController
        .getNotificationsStream()
        .listen((newNotifications) {
      notifications = newNotifications;
    });

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification() async {
    await initializeNotification();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    ValidityController validityController = ValidityController();

    for (var notification in notifications) {
      List<Validity> list_validity = await validityController
          .fetchAllValiditiesOfProduct(notification.productId);
      DateTime now = DateTime.now();

      for (var validity in list_validity) {
        DateTime expirationDate =
            DateTime(validity.year, validity.month, validity.day);
        if (notification.unitTime == "days") {
          expirationDate =
              expirationDate.subtract(Duration(days: notification.time));
        } else if (notification.unitTime == "weeks") {
          expirationDate =
              expirationDate.subtract(Duration(days: notification.time * 7));
        } else {
          expirationDate =
              expirationDate.subtract(Duration(days: notification.time * 30));
        }

        if (expirationDate.isBefore(now) ||
            expirationDate.isAtSameMomentAs(now)) {
          String notificationDetails =
              'Product ${validity.name} it will expire in ${validity.day}/${validity.month}/${validity.year}';

          tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();

          await flutterLocalNotificationsPlugin.zonedSchedule(
              0,
              'scheduled title',
              notificationDetails,
              scheduledDate,
              platformChannelSpecifics,
              androidAllowWhileIdle: true,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime);

          scheduledNotifications.add(notification);
          var i = 10;
        }
      }
    }
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate =
          tz.TZDateTime(tz.local, now.year, now.month, now.day + 1, 10);
    }
    return scheduledDate;
  }

  Future<void> testNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'test_channel_id',
      'test_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Test Notification',
        'This is a test notification',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  List<NotificationModel> getScheduledNotifications() {
    return scheduledNotifications;
  }
}
