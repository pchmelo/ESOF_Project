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
        child: Card(
          margin: const EdgeInsets.fromLTRB(0,0,0,0),
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
                      backgroundImage: const AssetImage('assets/images/default_product_image.png'),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product!.name!),
                    Text('Threshold: ${product!.threshold}'),
                    Text('Quantity: ${product!.quantity}'),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
