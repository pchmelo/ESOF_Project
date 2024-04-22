import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/app/views/extra_pages/list_products/shoppingListCard.dart';
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

  final Function shoppingListCard = ShoppingListCard().shoppingListCard;

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
            Expanded(
              child: ShowProductsShoppingListBuilder(
                  shoppingList: shoppingList,
                  shoppingListCard: shoppingListCard),
            ),
            Container(
              padding: const EdgeInsets.all(
                  20), // Increase the padding to make the button bigger
              decoration: BoxDecoration(
                color: Colors.blue, // Set the color of the button
                borderRadius: BorderRadius.circular(
                    10), // Set the border radius of the button
                boxShadow: [
                  // Add a shadow to the button
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  // Add the action of the button here
                },
                child: const Text(
                  'Finish your Shopps :)',
                  style: TextStyle(
                    color: Colors.white, // Set the color of the text
                    fontSize:
                        20, // Increase the font size to make the text bigger
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
