import 'package:esof_project/app/views/extra_pages/changeQuantity.widget.dart';
import 'package:esof_project/app/views/extra_pages/product.view.dart';
import 'package:esof_project/app/views/main_pages/storage/productList.widget.dart';
import 'package:flutter/material.dart';

import '../../../models/product.model.dart';

class ManualProductView extends StatelessWidget {
  final name = 'Choose the Product you want to add to the Storage';
  String currentRoute = '/start/shopping_list';

  @override
  Widget build(BuildContext context) {
    void _handleProductTap(product) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProducDetailsPage(product: product)));
    }

    void _createProductForm(product) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ChangeQuantityProduct(
              product: product,
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductList(
            handleProductTap: _createProductForm,
          ),
        ],
      ),
    );
  }
}
