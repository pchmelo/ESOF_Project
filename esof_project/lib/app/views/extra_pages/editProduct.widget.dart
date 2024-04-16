import 'package:esof_project/app/controllers/ProductControllers.dart';
import 'package:esof_project/app/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/services/database.dart';
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
  final ProductControllers productControllers = ProductControllers();

  String? _name;
  int? _threshold;
  int? _quantity;

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
                decoration: const InputDecoration(labelText: 'Product Name',
                border: OutlineInputBorder(),),
                validator: (val) =>
                    val!.isEmpty ? 'Enter a product name' : null,
                onChanged: (val) => setState(() => _name = val),
              ),
              const Padding(padding: EdgeInsets.only(top:20)),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                initialValue: widget.product.quantity.toString(),
                decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),),
                validator: (val) => val!.isEmpty ? 'Enter a quantity' : null,
                onChanged: (val) => setState(() => _quantity = int.parse(val)),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: productControllers.isLoading,
                builder: (context, isLoading, child) {
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await widget.controller(context, widget.product,
                                  _name, _threshold, _quantity);
                            }
                          },
                    child: isLoading ? Loading() : const Text('Edit Product'),
                  );
                },
              const Padding(padding: EdgeInsets.only(top: 20)),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                initialValue: widget.product.threshold.toString(),
                decoration: const InputDecoration(
                    labelText: 'Threshold',
                    border: OutlineInputBorder(),),
                validator: (val) => val!.isEmpty ? 'Enter a threshold' : null,
                onChanged: (val) => setState(() => _threshold = int.parse(val)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
                        borderRadius: BorderRadius.circular(10.0), // Decreasing border radius
                      ),
                    ),
                  ),
                  child: const Text('Confirm'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.controller(
                          context,
                          widget.product,
                          _name,
                          _threshold,
                          _quantity
                      );
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
