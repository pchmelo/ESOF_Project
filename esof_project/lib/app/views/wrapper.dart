import 'package:esof_project/app/views/main_pages/storage/storage.view.dart';
import 'package:flutter/material.dart';
import '../../services/notificationService.dart';
import '../models/user.mode.dart';
import '../shared/loading.dart';
import 'authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<void>? initFuture;
  late NotificationsService notificationsService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<MyUser?>(context);
    if (user == null) {
      return const AuthenticateView();
    } else {
      return FutureBuilder(
        future: initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const StorageView();
          }
        },
      );
    }
  }
}
