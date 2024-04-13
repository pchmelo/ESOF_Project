import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/services/database.dart';

class EditProduct extends StatefulWidget {
  final product;
  const EditProduct({super.key, required this.product});

  @override
  State<EditProduct> createState() => _EditProdutState();
}

class _EditProdutState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();

  late User user;
  late DatabaseService _dbService;

  String? _name;
  int? _threshold;
  int? _quantity;

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
                    _name ??= widget.product.name;
                    _threshold ??= widget.product.threshold;
                    _quantity ??= widget.product.quantity;

                    Product new_product = Product(
                        id: widget.product.id,
                        name: _name,
                        threshold: _threshold!.toInt(),
                        quantity: _quantity!.toInt());

                    await _dbService.updateProduct(new_product);
                    Navigator.pop(context);
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
