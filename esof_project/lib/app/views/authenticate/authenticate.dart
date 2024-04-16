import 'package:esof_project/app/views/authenticate/register.view.dart';
import 'package:esof_project/app/views/authenticate/sign_in.view.dart';
import 'package:flutter/material.dart';

class AuthenticateView extends StatefulWidget {
  const AuthenticateView({super.key});

  @override
  State<AuthenticateView> createState() => _AuthenticateView();
}

class _AuthenticateView extends State<AuthenticateView> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInView(toggleView: toggleView);
    } else {
      return RegisterView(toggleView: toggleView);
    }
  }
}
