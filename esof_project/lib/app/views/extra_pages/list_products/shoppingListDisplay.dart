import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/app/views/extra_pages/list_products/showProductsShoppingListBuilder.dart';
import 'package:esof_project/services/database_shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../controllers/shoppingListControllers.dart';
import '../../main_pages/addProduct/manualAddProduct.view.dart';
import 'editShoppingList.widget.dart';

class ShoppingListDisplay extends StatelessWidget {
  final ShoppingList shoppingList;
  final Function controller;
  final Function controller_addProductToList =
      ShoppingListControllers().addProductToList;

  ShoppingListDisplay(
      {super.key, required this.shoppingList, required this.controller});

  SelectedItem(BuildContext context, item) async {
    switch (item) {
      case 0:
        print('Add Product');
        break;
      case 1:
        break;
      case 2:
        Navigator.pop(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> deleteshoppingList() async {
      User user = FirebaseAuth.instance.currentUser!;
      DatabaseForShoppingList dbService =
          DatabaseForShoppingList(uid: user.uid);

      await dbService.deleteShoppingList(shoppingList.uid);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(shoppingList.name),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: const Text('Add Product'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManualProductView(
                          listUid: shoppingList.uid,
                          controller: controller_addProductToList,
                        ),
                      ),
                    );
                  },
                ),
                PopupMenuItem<int>(
                  value: 0,
                  child: const Text('Edit'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditShoppingList(
                          shoppingList: shoppingList,
                        ),
                      ),
                    );
                  },
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: const Text('Delete'),
                  onTap: () {
                    deleteshoppingList();
                  },
                ),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0), // Adjust the padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Text(
                    'Quantity',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  ShowProductsShoppingListBuilder(shoppingList: shoppingList),
            ),
          ],
        ));
  }
}
