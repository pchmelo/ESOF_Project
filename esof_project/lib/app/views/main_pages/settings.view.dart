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
      appBar: AppBar(automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'CrimsonPro',
            fontSize: 31,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          const SizedBox(height: 100),
          Transform.rotate(
              angle: -0.785,
              child: const Text(
                  'IN PROGRESS',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 50 )
              )
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
