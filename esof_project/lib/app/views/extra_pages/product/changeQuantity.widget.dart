import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/services/database_product.dart';

class ChangeQuantityProduct extends StatefulWidget {
  final String scancode;
  final Function controller;
  final product;
  const ChangeQuantityProduct(
      {super.key,
      required this.product,
      required this.controller,
      required this.scancode});

  @override
  State<ChangeQuantityProduct> createState() => _ChangeQuantityProductState();
}

class _ChangeQuantityProductState extends State<ChangeQuantityProduct> {
  final _formKey = GlobalKey<FormState>();

  late User user;
  late DatabaseForProducts _dbService;

  int? _value;

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
              SizedBox(height: 20),
              Text('Product Name: ${widget.product.name}'),
              TextFormField(
                initialValue: "0",
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Enter a quantity' : null,
                onChanged: (val) => setState(() => _value = int.parse(val)),
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
                      if (widget.scancode != null) {
                        await widget.controller(
                            context, widget.product, _value, widget.scancode);
                      } else {
                        await widget.controller(
                            context, widget.product, _value);
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
