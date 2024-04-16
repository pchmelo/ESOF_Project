import 'package:esof_project/app/views/main_pages/storage/storage.view.dart';
import 'package:flutter/material.dart';

import '../models/user.mode.dart';
import 'authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MyUser? user = Provider.of<MyUser?>(context);
    if (user?.uid != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/start/storage');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<MyUser?>(context);
    return user == null ? const AuthenticateView() : Container();
  }
}
