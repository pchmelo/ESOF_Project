import 'package:esof_project/app/models/notication.model.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/app/views/extra_pages/notifications/createNotification.widget.dart';
import 'package:esof_project/services/database_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:esof_project/app/models/notication.model.dart' as notif;

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

  Future<void> deleteNotification(Product product) async {
    isLoading.value = true;
    notif.NotificationModel? notification =
        await findNotificationByProduct(product);
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
}
