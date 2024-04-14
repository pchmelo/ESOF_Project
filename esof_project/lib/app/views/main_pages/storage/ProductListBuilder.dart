import 'package:esof_project/app/views/main_pages/storage/productTile.widget.dart';
import 'package:flutter/material.dart';
import '../../../models/product.model.dart';

class ProductListBuilder extends StatefulWidget {
  final List<Map<String, dynamic>> foundProducts;

  const ProductListBuilder({super.key, required this.foundProducts});

  @override
  _ProductListBuilderState createState() => _ProductListBuilderState();
}

class _ProductListBuilderState extends State<ProductListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.foundProducts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ProductTile(
              product: Product.fromJson(widget.foundProducts[index]),
            ),
          ),
        );
      },
    );
  }
}
