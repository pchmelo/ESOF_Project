import 'package:esof_project/app/components/changeQuantitity.component.dart';
import 'package:esof_project/app/models/validity.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/services/database_product.dart';

class ChangeQuantityValidity extends StatefulWidget {
  final Validity validity;
  const ChangeQuantityValidity({
    super.key,
    required this.validity,
  });

  @override
  State<ChangeQuantityValidity> createState() => _ChangeQuantityValidityState();
}

class _ChangeQuantityValidityState extends State<ChangeQuantityValidity> {
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
        automaticallyImplyLeading: false,
        title: const Text(
          'Change Quantity to a Expiration Date',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              Text(
                'Expiration Date Name: ${widget.validity.name}',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChangeQuantityComponent(
                  initialValue: widget.validity.quantity,
                  onQuantityChanged: (quantity) {
                    _value = quantity;
                  },
                ),
              ),
              const SizedBox(height: 375),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(350.0, 60.0),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Text('Confirm'),
                  onPressed: () async {
                    Navigator.pop(context);
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
