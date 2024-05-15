import 'package:esof_project/app/controllers/validityControllers.dart';
import 'package:esof_project/app/models/notication.model.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/app/views/extra_pages/notifications/createNotification.widget.dart';
import 'package:esof_project/services/database_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:esof_project/app/models/notication.model.dart' as notif;

import '../models/validity.model.dart';

class NotificationController {
  late DatabaseForNotifications dbService;
  late User user;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  NotificationController(
      [DatabaseForNotifications? dbServiceParam, User? userParam]) {
    user = userParam ?? FirebaseAuth.instance.currentUser!;
    dbService = dbServiceParam ?? DatabaseForNotifications(uid: user.uid);
  }

  Future<void> CreateNotification(
      String productId, String unitTime, int quantity) async {
    isLoading.value = true;

    notif.NotificationModel notification = notif.NotificationModel(
      uid: const Uuid().v4(),
      time: quantity,
      productId: productId,
      unitTime: unitTime,
    );

    await dbService.addNotification(notification);
    isLoading.value = false;
  }

  Future<notif.NotificationModel?> findNotificationByProduct(
      Product product) async {
    List<notif.NotificationModel> allNotifications =
        await dbService.getAllNotifications();

    for (notif.NotificationModel notification in allNotifications) {
      if (notification.productId == product.id) {
        return notification;
      }
    }

    return null;
  }

  Future<notif.NotificationModel?> findNotificationByProductById(
      String productId) async {
    List<notif.NotificationModel> allNotifications =
        await dbService.getAllNotifications();

    for (notif.NotificationModel notification in allNotifications) {
      if (notification.productId == productId) {
        return notification;
      }
    }

    return null;
  }

  Future<void> deleteNotification(Product product) async {
    isLoading.value = true;
    notif.NotificationModel? notification =
        await findNotificationByProduct(product);
    await dbService.deleteNotification(notification!);
    isLoading.value = false;
  }

  Future<void> deleteNotificationById(String productId) async {
    isLoading.value = true;
    notif.NotificationModel? notification =
        await findNotificationByProductById(productId);
    await dbService.deleteNotification(notification!);
    isLoading.value = false;
  }

  Future<void> updateNotification(
      Product product, String unitTime, int quantity) async {
    isLoading.value = true;
    notif.NotificationModel? notification =
        await findNotificationByProduct(product);
    notification!.unitTime = unitTime;
    notification.time = quantity;
    await dbService.updateNotification(notification);
    isLoading.value = false;
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    return await dbService.getAllNotifications();
  }

  Stream<List<NotificationModel>> getNotificationsStream() {
    return dbService.getNotificationsStream();
  }

  Future<Map<Validity, NotificationModel>> getAllNotificationsFiltered() async {
    List<NotificationModel> notifications =
        await dbService.getAllNotifications();

    Map<Validity, NotificationModel> res = {};
    DateTime now = DateTime.now();

    ValidityController validityController = ValidityController();

    for (var notification in notifications) {
      List<Validity> list_validity = await validityController
          .fetchAllValiditiesOfProduct(notification.productId);

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
          res.addEntries([MapEntry(validity, notification)]);
        }
      }
    }

    return res;
  }
}
