import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/authenticate.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';
import 'package:esof_project/app/components/footer.component.dart';
import '../extra_pages/notifications/notificationsDisplay.widget.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AuthService _auth = AuthService();
  final name = 'Settings';
  String currentRoute = '/start/settings';

  final gestures = Gesture();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              gestures.swipeLeft(context);
            } else if (details.primaryVelocity! < 0) {
              gestures.swipeRight(context);
            }
          },
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person, size: 30),
                  title: const Text('User', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: const Text('Change Password',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  trailing: IconButton(
                    icon: const Icon(
                        Icons.arrow_forward_ios, size: 30, color: Colors.black),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ChangeEmailPasswordPage()),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationsDisplay(),
                      ),
                    );
                  },
                  leading: const Icon(
                      Icons.circle_notifications_rounded, size: 30,
                      color: Colors.black),
                  title: const Text('Alerts', style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  onTap: () async {
                    try {
                      await _auth.signOut();
                      Navigator.pushReplacementNamed(context, '/start');
                    } catch (e) {
                      print('Error signing out: $e');
                    }
                  },
                  leading: const Icon(
                      Icons.logout, color: Colors.black, size: 30),
                  title: const Text('Logout', style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}

class ChangeEmailPasswordPage extends StatefulWidget {
  @override
  _ChangeEmailPasswordPageState createState() =>
      _ChangeEmailPasswordPageState();
}

class _ChangeEmailPasswordPageState extends State<ChangeEmailPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String actualPassword = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  bool loading = false;

@override
Widget build(BuildContext context) {
  return loading
      ? Loading()
      : Scaffold(
          appBar: AppBar(
            title: const Text(
              'Change Password',
              style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Password', style: TextStyle(fontFamily: 'Roboto', fontSize: 16)),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your current password',
                      hintStyle: TextStyle(color: Colors.grey),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    obscureText: true,
                    validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() {
                        actualPassword = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text('New Password', style: TextStyle(fontFamily: 'Roboto', fontSize: 16)),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your new password',
                      hintStyle: TextStyle(color: Colors.grey),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    obscureText: true,
                    validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text('Confirm Password', style: TextStyle(fontFamily: 'Roboto', fontSize: 16)),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Confirm your new password',
                      hintStyle: TextStyle(color: Colors.grey),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    obscureText: true,
                    validator: (val) {
                      if (val!.length < 6) {
                        return 'Enter a password 6+ chars long';
                      } else if (val != password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        confirmPassword = val;
                      });
                    },
                  ),
                  SizedBox(height: 30.0),
                  Center(
                    child: OutlinedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          try {
                            User user = _auth.currentUser!;
                            email = user.email!;

                            AuthCredential credential = EmailAuthProvider.credential(
                                email: email, password: actualPassword);
                            await user.reauthenticateWithCredential(credential);

                            if (password.isNotEmpty) {
                              await user.updatePassword(password);
                            }

                            Navigator.pop(context);
                          } catch (e) {
                            setState(() {
                              loading = false;
                              error = 'Failed to update password';
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Center(
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
}
