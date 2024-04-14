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
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: ProductTile(
            product: Product.fromJson(widget.foundProducts[index]),
          ),
        );
      },
    );
  }
}
