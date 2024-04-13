import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/services/database.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

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
    return Container(
        height: 425,
        padding: const EdgeInsets.all(15.0),
        child: Form(
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
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Enter a quantity' : null,
                onChanged: (val) => setState(() => _quantity = int.parse(val)),
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
                  } else if (int.parse(val) > _quantity) {
                    return 'Threshold must be less than quantity';
                  }
                  return null;
                },
                onChanged: (val) => setState(() => _threshold = int.parse(val)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Create Product'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Product product = Product(
                        id: const Uuid().v4(),
                        name: _name,
                        threshold: _threshold.toInt(),
                        quantity: _quantity.toInt());
                    await _dbService.addProduct(product);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ));
  }
}
