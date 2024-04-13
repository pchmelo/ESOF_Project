import 'package:flutter/material.dart';
import '../../../models/product.model.dart';
import '../../extra_pages/product.view.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProducDetailsPage(product: product)));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            tileColor: Colors.white,
            leading: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.yellow[100],
                backgroundImage: const AssetImage('assets/product_mock.png'),
              ),
            ),
            title: Text(product!.name!),
            subtitle: Text('Threshold: ${product!.threshold}'),
            trailing: Text('Quantity: ${product!.quantity}'),
          ),
        ),
      ),
    );
  }
}
