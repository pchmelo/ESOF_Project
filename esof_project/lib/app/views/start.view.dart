import 'package:esof_project/app/views/authenticate/authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Authenticate();
    /*
      Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/start/storage',
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(10)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: const Text('StockOverflow'),
          ),
        ],
      ),
    );

       */
  }
}
