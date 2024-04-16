import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int _quantity = 0;

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
                    widget.controller(context, _name, _threshold, _quantity);
                  }
                },
              ),
            ],
          ),
        ));
  }
}
