import 'package:cloud_firestore/cloud_firestore.dart';

import '../app/models/notication.model.dart';

class DatabaseForNotifications {
  final String uid;

  DatabaseForNotifications({required this.uid});

  // collection reference
  final CollectionReference notificationCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addNotification(NotificationModel notification) async {
    return await notificationCollection
        .doc(uid)
        .collection('notifications')
        .doc(notification.uid)
        .set(notification.toJson());
  }

  Future<void> updateNotification(NotificationModel notification) async {
    return await notificationCollection
        .doc(uid)
        .collection('notifications')
        .doc(notification.uid)
        .update(notification.toJson());
  }

  Future<void> deleteNotification(NotificationModel notification) async {
    return await notificationCollection
        .doc(uid)
        .collection('notifications')
        .doc(notification.uid)
        .delete();
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    QuerySnapshot snapshot =
        await notificationCollection.doc(uid).collection('notifications').get();

    return snapshot.docs.map((doc) {
      return NotificationModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<NotificationModel?> getNotificationById(String notificationId) async {
    DocumentSnapshot doc = await notificationCollection
        .doc(uid)
        .collection('notifications')
        .doc(notificationId)
        .get();

    if (doc.exists) {
      return NotificationModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
