import 'package:esof_project/app/components/productForm.component.dart';
import 'package:esof_project/app/views/main_pages/storage/productList.widget.dart';
import 'package:flutter/material.dart';
import '../../../controllers/productControllers.dart';

class ManualProductView extends StatelessWidget {
  final listUid;
  final Function controller;
  final name = 'Choose the Product you want to add to the Storage';
  String currentRoute = '/start/shopping_list';

  ManualProductView(
      {super.key, required this.controller, required this.listUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductList(
            handleProductTap: (product, controller) {
              ProductForm(context: context)
                  .AddProductQuantityForm(listUid, controller, product, '');
            },
            controller: controller,
          ),
        ],
      ),
    );
  }
}
