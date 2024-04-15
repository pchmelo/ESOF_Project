import 'package:esof_project/app/controllers/ProductControllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/services/database.dart';

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
  int? _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.product.name,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (val) =>
                    val!.isEmpty ? 'Enter a product name' : null,
                onChanged: (val) => setState(() => _name = val),
              ),
              TextFormField(
                initialValue: widget.product.threshold.toString(),
                decoration: const InputDecoration(labelText: 'Threshold'),
                validator: (val) => val!.isEmpty ? 'Enter a threshold' : null,
                onChanged: (val) => setState(() => _threshold = int.parse(val)),
              ),
              TextFormField(
                initialValue: widget.product.quantity.toString(),
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (val) => val!.isEmpty ? 'Enter a quantity' : null,
                onChanged: (val) => setState(() => _quantity = int.parse(val)),
              ),
              ElevatedButton(
                child: const Text('Edit Product'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    widget.controller(
                        context, widget.product, _name, _threshold, _quantity);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
