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
    return Container(
      height: 425,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Add Product',
            style: TextStyle(
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
                TextFormField(
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
                  decoration: const InputDecoration(
                    labelText: 'Threshold',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter a threshold';
                    }
                    return null;
                  },
                  onChanged: (val) =>
                      setState(() => _threshold = int.parse(val)),
                ),
                CheckboxListTile(
                  title: const Text('Expires'),
                  value: _validity,
                  onChanged: (bool? value) {
                    setState(() {
                      _validity = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Notification'),
                  value: _notification,
                  onChanged: (bool? value) {
                    setState(() {
                      _notification = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
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
    );
  }
}
