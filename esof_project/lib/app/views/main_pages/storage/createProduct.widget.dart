import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/services/database.dart';

class CreateProdut extends StatefulWidget {
  const CreateProdut({super.key});

  @override
  State<CreateProdut> createState() => _CreateProdutState();
}

class _CreateProdutState extends State<CreateProdut> {
  final _formKey = GlobalKey<FormState>();

  late User user;
  late DatabaseService _dbService;

  String _name = '';
  int _threshold = 0;
  int _quantity = 0;

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
        title: const Text('Create Product'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (val) =>
                    val!.isEmpty ? 'Enter a product name' : null,
                onChanged: (val) => setState(() => _name = val),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Threshold'),
                validator: (val) => val!.isEmpty ? 'Enter a threshold' : null,
                onChanged: (val) => setState(() => _threshold = int.parse(val)),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (val) => val!.isEmpty ? 'Enter a quantity' : null,
                onChanged: (val) => setState(() => _quantity = int.parse(val)),
              ),
              ElevatedButton(
                child: const Text('Create Product'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Product product = Product(
                        name: _name,
                        threshold: _threshold.toInt(),
                        quantity: _quantity.toInt());
                    await _dbService.addProduct(product);
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
