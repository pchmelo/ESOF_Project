import 'package:flutter/material.dart';
import '../../../models/product.model.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final Function controller;
  final Function onProductTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.controller,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onProductTap(product, controller);
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.yellow[100],
                    backgroundImage: const AssetImage(
                        'assets/images/default_product_image.png'),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name!),
                  Text('Threshold: ${product.threshold}'),
                  Text('Quantity: ${product.quantity}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
