import 'package:esof_project/app/views/extra_pages/notifications/notificationList.widget.dart';
import 'package:flutter/material.dart';

class NotificationsDisplay extends StatefulWidget {
  const NotificationsDisplay({super.key});

  @override
  State<NotificationsDisplay> createState() => _NotificationsDisplayState();
}

class _NotificationsDisplayState extends State<NotificationsDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Notifications'),
        ),
        body: NotificationsList());
  }
}
