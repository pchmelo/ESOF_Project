import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/services/database.dart';

import '../../controllers/ProductControllers.dart';

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
  late DatabaseService _dbService;

  int? _value;
  final ProductControllers productControllers = ProductControllers();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _dbService = DatabaseService(uid: user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Quantity to a Product'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Product Name: ${widget.product.name}'),
              TextFormField(
                initialValue: "0",
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (val) => val!.isEmpty ? 'Enter a quantity' : null,
                onChanged: (val) => setState(() => _value = int.parse(val)),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: productControllers.isLoading,
                builder: (context, isLoading, child) {
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              if (widget.scancode != '') {
                                await widget.controller(context, widget.product,
                                    _value, widget.scancode);
                              } else {
                                await widget.controller(
                                    context, widget.product, _value);
                              }
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Edit Product'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
