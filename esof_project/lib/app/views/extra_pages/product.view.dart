import 'package:esof_project/app/models/product.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/database.dart';
import 'editProduct.widget.dart';

class ProducDetailsPage extends StatelessWidget {
  final Product product;
  const ProducDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Future<void> _editProduct() async {
      await showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: EditProduct(product: product),
            );
          });
    }

    Future<void> _deleteProduct() async {
      User user = FirebaseAuth.instance.currentUser!;
      DatabaseService _dbService = DatabaseService(uid: user.uid);

      if (product.id != null) {
        await _dbService.deleteProductById(product.id!);
      } else {
        // Handle the case where product.id is null
        print('Error: product.id is null');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('Name: ${product.name}'),
                Text('Threshold: ${product.threshold}'),
                Text('Quantity: ${product.quantity}'),
                TextButton(
                    onPressed: () async {
                      await _editProduct();
                      Navigator.pop(context);
                    },
                    child: const Text('Edit')),
                TextButton(
                    onPressed: () {
                      _deleteProduct();
                      Navigator.pop(context);
                    },
                    child: const Text('Delete')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
