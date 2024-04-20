import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateProdutList extends StatefulWidget {
  final Function controller;
  const CreateProdutList({super.key, required this.controller});

  @override
  State<CreateProdutList> createState() => _CreateProdutListState();
}

class _CreateProdutListState extends State<CreateProdutList> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 425,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Create Shopping List',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20), // Adjust as needed for spacing

          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Shopping List Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Enter a Shopping List name' : null,
                  onChanged: (val) => setState(() => _name = val),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
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
                      Size(150.0, 50.0),
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
                      widget.controller(context, _name);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
