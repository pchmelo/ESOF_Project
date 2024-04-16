import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/database.dart';
import 'editProduct.widget.dart';

class ProducDetailsPage extends StatelessWidget {
  final Function controller;
  final Product product;
  const ProducDetailsPage(
      {super.key, required this.product, required this.controller});

  @override
  Widget build(BuildContext context) {
    Future<void> deleteProduct() async {
      User user = FirebaseAuth.instance.currentUser!;
      DatabaseService dbService = DatabaseService(uid: user.uid);

      if (product.id != null) {
        await dbService.deleteProductById(product.id!);
      } else {
        // Handle the case where product.id is null
        print('Error: product.id is null');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Text('Name: ${product.name}',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text('Threshold: ${product.threshold}',
                    style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text('Quantity: ${product.quantity}',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 400),
                FloatingActionButton(
                    onPressed: () async {
                      await ProductForm(product: product, context: context)
                          .EditProductForm(controller);
                      Navigator.pop(context);
                    },
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[100],
                    child: const Text('Edit')),
                SizedBox(height: 15),
                FloatingActionButton(
                    onPressed: () {
                      deleteProduct();
                      Navigator.pop(context);
                    },
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.red,
                    child: const Text('Delete')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
