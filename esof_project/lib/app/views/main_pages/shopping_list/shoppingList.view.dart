import 'package:esof_project/app/components/footer.component.dart';
import 'package:esof_project/app/components/productListForm.component.dart';
import 'package:esof_project/app/controllers/shoppingListControllers.dart';
import 'package:esof_project/app/views/extra_pages/list_products/shoppingListDisplay.dart';
import 'package:esof_project/app/views/main_pages/shopping_list/shoppingList.widgetViewList.dart';
import 'package:flutter/material.dart';

import '../../../models/product.model.dart';

class ShoppingListView extends StatelessWidget {
  final name = 'Shopping Lists';
  String currentRoute = '/start/shopping_list';

  ShoppingListView({super.key});

 @override
Widget build(BuildContext context) {
  final create_controller = ShoppingListControllers().CreateProduct;

  void handleShoppingListTap(String uid, Function controller,
      Product? product, String scan, String spec) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShoppingListDisplay(
                uid: uid,
                controller: controller,
                b: product,
                a: scan,
                c: '')));
  }

  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Shopping Lists',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 31,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
    ),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShoppingListViewList(
                controller: create_controller,
                handleShoppingListTap: handleShoppingListTap),
          ],
        ),
      ),
    ),
    bottomNavigationBar: const Footer(),
  );
}
}
