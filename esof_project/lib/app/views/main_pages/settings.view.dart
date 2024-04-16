import 'package:esof_project/app/components/footer.component.dart';
import 'package:flutter/material.dart';

import '../../../services/authenticate.dart';

class SettingsView extends StatelessWidget {
  final AuthService _auth = AuthService();
  final name = 'Settings';
  String currentRoute = '/start/settings';

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('logout'),
            onPressed: () async {
              try {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context,
                    '/start'); // assuming '/start' is your sign-in route
              } catch (e) {
                print('Error signing out: $e');
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
