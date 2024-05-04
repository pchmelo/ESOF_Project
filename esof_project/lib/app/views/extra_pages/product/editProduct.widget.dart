import 'package:esof_project/app/components/notificationForm.component.dart';
import 'package:esof_project/app/controllers/notificationController.dart';
import 'package:esof_project/app/controllers/productControllers.dart';
import 'package:esof_project/app/models/notication.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/services/database_product.dart';
import 'package:flutter/services.dart';

class EditProduct extends StatefulWidget {
  final Function controller;
  final product;
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
    return Container(
      height: 425,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Edit Product',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.product.name,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter a product name' : null,
                  onChanged: (val) => setState(() => _name = val),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue: widget.product.threshold.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Threshold',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter a threshold' : null,
                  onChanged: (val) =>
                      setState(() => _threshold = int.parse(val)),
                ),
                CheckboxListTile(
                  title: const Text('Validity'),
                  value: _validity,
                  onChanged: (bool? value) {
                    setState(() {
                      _validity = value!;
                      _notification = false;
                    });
                  },
                ),
                if (_validity)
                  CheckboxListTile(
                    title: const Text('Notification'),
                    value: _notification,
                    onChanged: (bool? value) {
                      setState(() {
                        _notification = value!;
                      });
                    },
                  ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
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
                        _validity ??= widget.product.validity;
                        widget.controller(
                            context,
                            widget.product,
                            _name,
                            _threshold,
                            widget.product.quantity,
                            _validity,
                            _notification);
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
