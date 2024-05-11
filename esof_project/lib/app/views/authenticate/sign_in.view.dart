import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/authenticate.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';

class SignInView extends StatefulWidget {
  final Function toggleView;
  SignInView({required this.toggleView});

  @override
  State<SignInView> createState() => _SignInView();
}

class _SignInView extends State<SignInView> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

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


    if (loading) {
      return Loading();
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            'Login',
            style: TextStyle(
              fontFamily: 'CrimsonPro',
              fontSize: 31,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person,
                color: Colors.white,
              ),
              label: const Text('Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/books.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: TextInputDecoration.copyWith(hintText: 'Email',
                      errorStyle: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.red[200]),
                    ),
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'Enter an email';
                      }else{
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
                    decoration: TextInputDecoration.copyWith(hintText: 'Password',
                      errorStyle: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.red[200]),
                    ),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          () => loading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                              'Could not sign in with those credentials';
                              loading = false;
                            });
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.yellow),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    color: Colors.red[200],
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          ),
      );
    }
  }
}
