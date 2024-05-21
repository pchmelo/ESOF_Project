import 'package:esof_project/app/models/notication.model.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:flutter/material.dart';

import '../views/extra_pages/notifications/createNotification.widget.dart';
import '../views/extra_pages/notifications/updateNotification.widget.dart';

class NotificationForm {
  final context;

  NotificationForm({this.context});

  Future<void> createNotificationForm(Product product) async {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateNotification(product: product),
        );
      },
    );
  }

  Future<void> updateNotificationForm(
      Product product, NotificationModel notification) async {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child:
              UpdateNotification(product: product, notification: notification),
        );
      },
    );
  }
}
