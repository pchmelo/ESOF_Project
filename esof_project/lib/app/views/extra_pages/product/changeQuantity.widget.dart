import 'package:esof_project/app/components/changeQuantitity.component.dart';
import 'package:esof_project/app/controllers/validityControllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/services/database_product.dart';

class ChangeQuantityProduct extends StatefulWidget {
  final String scancode;
  final Function controller;
  final product;
  final listUid;
  final String spec;
  const ChangeQuantityProduct({
    super.key,
    required this.listUid,
    required this.controller,
    required this.product,
    required this.scancode,
    required this.spec,
  });

  @override
  State<ChangeQuantityProduct> createState() => _ChangeQuantityProductState();
}

class _ChangeQuantityProductState extends State<ChangeQuantityProduct> {
  final _formKey = GlobalKey<FormState>();
  final DateTime _dateTime = DateTime.now();
  late User user;
  late DatabaseForProducts _dbService;

  int? _value;

  Future<DateTime?> _showDatePicker() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 10),
    );
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _dbService = DatabaseForProducts(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Quantity to a Product',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Text('Product Name: ${widget.product.name}'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChangeQuantityComponent(
                  initialValue: 0,
                  onQuantityChanged: (quantity) {
                    _value = quantity;
                  },
                ),
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
                      if (widget.spec == 'middle') {
                        if (widget.product.validity) {
                          DateTime? selectedDate = await _showDatePicker();
                          if (selectedDate != null) {
                            await ValidityController().CreateValidity(
                                widget.product.id,
                                _value!,
                                selectedDate.day,
                                selectedDate.month,
                                selectedDate.year);
                          }
                        }
                        await widget.controller(widget.listUid, widget.product,
                            _value, widget.scancode);
                      } else {
                        await widget.controller(widget.listUid, widget.product,
                            _value, widget.scancode);
                      }

                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
