import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/widgets.dart';
import '../../../services/authenticate.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';
import 'package:esof_project/app/components/footer.component.dart';


class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AuthService _auth = AuthService();
  final name = 'Settings';
  String currentRoute = '/start/settings';
  bool _notifications = false; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 31,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500,),),
          ),
          const SizedBox(height: 20,),
          Container(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.person, size: 50,),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Text('Change Settings', style: TextStyle(fontSize: 16, color: Colors.grey),),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                      size: 50,
                      color: Colors.white,),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangeEmailPasswordPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500,),),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade200,
                    ),
                    child: Icon(Icons.circle_notifications_rounded, size: 50, color: Colors.black,),
                  ),
                  const SizedBox(width: 20,),
                  Text('Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                  const Spacer(),
                  Checkbox(
                    value: _notifications,
                    onChanged: (bool? value) {
                      setState(() {
                        _notifications = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () async {
                    try {
                      await _auth.signOut();
                      Navigator.pushReplacementNamed(context, '/start'); // assuming '/start' is your sign-in route
                    } catch (e) {
                      print('Error signing out: $e');
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person, color: Colors.black, size: 50),
                      const SizedBox(width: 20,), // Adjust the width to increase or decrease the space
                      const Text('Logout',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

class ChangeEmailPasswordPage extends StatefulWidget {
  @override
  _ChangeEmailPasswordPageState createState() => _ChangeEmailPasswordPageState();
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
    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isNotEmpty && !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }

    return loading
        ? Loading()
        : Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: TextInputDecoration.copyWith(
                  hintText: 'Email',
                  errorStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.red[200],
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter an email';
                  } else {
                    return validateEmail(val);
                  }
                },
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: TextInputDecoration.copyWith(
                  hintText: 'Actual Password',
                  errorStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.red[200],
                  ),
                ),
                obscureText: true,
                validator: (val) =>
                val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() {
                    actualPassword = val;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: TextInputDecoration.copyWith(
                  hintText: 'New Password',
                  errorStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.red[200],
                  ),
                ),
                obscureText: true,
                validator: (val) =>
                val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: TextInputDecoration.copyWith(
                  hintText: 'Confirm Password',
                  errorStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.red[200],
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
              const SizedBox(height: 30.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        try {
                          // Get current user
                          User user = _auth.currentUser!;

                          // Verify email matches current email
                          if (email.isNotEmpty && email != user.email) {
                            throw 'Entered email does not match the current email';
                          }

                          // Reauthenticate user
                          AuthCredential credential = EmailAuthProvider.credential(email: email, password: actualPassword);
                          await user.reauthenticateWithCredential(credential);

                          // Update password if provided
                          if (password.isNotEmpty) {
                            await user.updatePassword(password);
                          }

                          Navigator.pop(context); // Go back to the previous screen
                        } catch (e) {
                          setState(() {
                            loading = false;
                            error = 'Failed to update password: Incorrect Email or Password';
                          });
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}