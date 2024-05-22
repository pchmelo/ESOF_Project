import 'package:esof_project/app/components/changeQuantitity.component.dart';
import 'package:esof_project/app/components/productForm.component.dart';
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
        toolbarHeight: 100,
        title: const Text(
          'Add Quantity to a Product',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Container(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 70),
              Text(
                'Product Name: ${widget.product.name}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: ChangeQuantityComponent(
                  initialValue: 0,
                  onQuantityChanged: (quantity) {
                    _value = quantity;
                  },
                ),
              ),
              const SizedBox(height: 230),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF4CAF50)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(330.0, 55.0),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text('Confirm'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.spec == 'middle') {
                        await widget.controller(widget.listUid, widget.product,
                            _value, widget.scancode);
                        Navigator.pop(context);
                        if (widget.product.validity) {
                          await ProductForm(context: context)
                              .CreateValidityForm(widget.product, _value!);
                        }
                      } else if (widget.spec == 'scanner') {
                        await widget.controller(widget.listUid, widget.product,
                            _value, widget.scancode);
                        if (widget.product.validity) {
                          await ProductForm(context: context)
                              .CreateValidityForm(widget.product, _value!);
                        }
                        Navigator.pushReplacementNamed(
                            context, '/start/storage');
                      } else {
                        await widget.controller(widget.listUid, widget.product,
                            _value, widget.scancode);
                        Navigator.pop(context);
                      }
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
