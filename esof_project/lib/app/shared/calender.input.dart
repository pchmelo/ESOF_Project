import 'package:flutter/material.dart';

class CalenderInput extends StatefulWidget {
  const CalenderInput({super.key});

  @override
  State<CalenderInput> createState() => _CalenderInputState();
}

class _CalenderInputState extends State<CalenderInput> {
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Choose Date',
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
          )),
    ));
  }
}
