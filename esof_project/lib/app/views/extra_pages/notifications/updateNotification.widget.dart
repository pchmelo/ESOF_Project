import 'package:esof_project/app/controllers/notificationController.dart';
import 'package:esof_project/app/models/notication.model.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateNotification extends StatefulWidget {
  final Product product;
  final NotificationModel notification;
  const UpdateNotification(
      {super.key, required this.product, required this.notification});

  @override
  State<UpdateNotification> createState() => _UpdateNotificationState();
}

class _UpdateNotificationState extends State<UpdateNotification> {
  final _formKey = GlobalKey<FormState>();
  late String timeUnit;
  late int time;
  late TextEditingController timeController;

  @override
  void initState() {
    super.initState();
    timeUnit = widget.notification.unitTime!;
    time = widget.notification.time!;
    timeController = TextEditingController(text: time.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 425,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Text(
            'Edit the Notification of the product ${widget.product.name}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20), // Adjust as needed for spacing

          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: timeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter a number',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            time = int.parse(value);
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: DropdownButton<String>(
                        value: timeUnit,
                        items: <String>['days', 'weeks', 'years']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            timeUnit = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.yellow),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(150.0, 50.0),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Decreasing border radius
                      ),
                    ),
                  ),
                  child: const Text('Confirm'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await NotificationController()
                          .updateNotification(widget.product, timeUnit, time);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
