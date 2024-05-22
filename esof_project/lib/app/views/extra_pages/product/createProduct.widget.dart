import 'package:esof_project/app/components/notificationForm.component.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class CreateProdut extends StatefulWidget {
  final Function controller;
  const CreateProdut({super.key, required this.controller});

  @override
  State<CreateProdut> createState() => _CreateProdutState();
}

class _CreateProdutState extends State<CreateProdut> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  int _threshold = 0;
  bool _validity = false;
  bool _notification = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.5,
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Add Product',
              style: TextStyle(
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black, fontSize: screenHeight * 0.025),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter a product name';
                      } else if (val.length > 20) {
                        return 'Product name cannot exceed 20 characters';
                      }
                      return null;
                    },
                    onChanged: (val) => setState(() => _name = val),
                  ),
                  Padding(padding: EdgeInsets.only(top: screenHeight * 0.025)),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Threshold',
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.black, fontSize: screenHeight * 0.025),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a threshold' : null,
                    onChanged: (val) =>
                        setState(() => _threshold = int.parse(val)),
                  ),
                  CheckboxListTile(
                    title: Text('Expires',
                        style: TextStyle(fontSize: screenHeight * 0.025)),
                    value: _validity,
                    activeColor: Colors.amber,
                    checkColor: Colors.black,
                    onChanged: (bool? value) {
                      setState(() {
                        _validity = value!;
                        _notification = false;
                      });
                    },
                  ),
                  if (_validity)
                    CheckboxListTile(
                      title: Text('Notification',
                          style: TextStyle(fontSize: screenHeight * 0.025)),
                      value: _notification,
                      activeColor: Colors.amber,
                      checkColor: Colors.black,
                      onChanged: (bool? value) {
                        setState(() {
                          _notification = value!;
                        });
                      },
                    ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.018,
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(screenWidth * 0.9, screenHeight * 0.07),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text('Confirm',
                        style: TextStyle(fontSize: screenHeight * 0.025)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Product product = Product(
                          validity: _validity,
                          id: const Uuid().v4(),
                          name: _name,
                          threshold: _threshold,
                          quantity: 0,
                          barcodes: [],
                          notification: _notification,
                        );

                        widget.controller(product);

                        if (_notification) {
                          await NotificationForm(context: context)
                              .createNotificationForm(product);
                        }

                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
