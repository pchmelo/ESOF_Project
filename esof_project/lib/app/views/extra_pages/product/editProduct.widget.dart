import 'package:esof_project/app/components/notificationForm.component.dart';
import 'package:esof_project/app/controllers/notificationController.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:flutter/services.dart';

class EditProduct extends StatefulWidget {
  final Function controller;
  final Product product;
  const EditProduct(
      {super.key, required this.product, required this.controller});

  @override
  State<EditProduct> createState() => _EditProdutState();
}

class _EditProdutState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _threshold;
  late bool _validity;
  late bool _notification;

  @override
  void initState() {
    super.initState();
    _validity = widget.product.validity;
    _notification = widget.product.notification;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.5,
      padding: EdgeInsets.all(screenWidth * 0.035),
      child: Column(
        children: <Widget>[
          Text(
            'Edit Product',
            style: TextStyle(
              fontSize: screenHeight * 0.025,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.product.name,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: const OutlineInputBorder(),
                    labelStyle: TextStyle(
                        color: Colors.black, fontSize: screenHeight * 0.025),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => _name = val),
                ),
                Padding(padding: EdgeInsets.only(top: screenHeight * 0.02)),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue: widget.product.threshold.toString(),
                  decoration: InputDecoration(
                    labelText: 'Threshold',
                    border: const OutlineInputBorder(),
                    labelStyle: TextStyle(
                        color: Colors.black, fontSize: screenHeight * 0.025),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter a threshold';
                    }
                    return null;
                  },
                  onChanged: (val) =>
                      setState(() => _threshold = int.parse(val)),
                ),
                CheckboxListTile(
                  title: Text('Expiration Date',
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
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.03),
                  child: ElevatedButton(
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
                        _validity ??= widget.product.validity;
                        widget.controller(
                          context,
                          widget.product,
                          _name,
                          _threshold,
                          widget.product.quantity,
                          _validity,
                          _notification,
                          widget.product.imageURL,
                        );
                      }

                      if (widget.product.notification != _notification) {
                        if (_notification) {
                          await NotificationForm(context: context)
                              .createNotificationForm(widget.product);
                        } else {
                          await NotificationController()
                              .deleteNotification(widget.product);
                        }
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
