import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/app/shared/loading.dart';
import 'package:esof_project/app/views/extra_pages/list_products/shoppingListCard.dart';
import 'package:esof_project/app/views/extra_pages/list_products/showProductsShoppingListBuilder.dart';
import 'package:esof_project/services/database_shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../controllers/shoppingListControllers.dart';
import '../../../models/product.model.dart';
import '../../main_pages/addProduct/manualAddProduct.view.dart';
import 'editShoppingList.widget.dart';

class ShoppingListDisplay extends StatelessWidget {
  String? a;
  Product? b;
  final String uid;
  late ShoppingList shoppingList;
  final Function controller;
  final Function controller_addProductToList =
      ShoppingListControllers().addProductToList;

  final Function shoppingListCard = ShoppingListCard().shoppingListCard;

  ShoppingListDisplay(
      {super.key, required this.uid, required this.controller, this.b, this.a});

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

  Future<void> fetchData() async {
    User user = FirebaseAuth.instance.currentUser!;
    DatabaseForShoppingList dbService = DatabaseForShoppingList(uid: user.uid);

    await dbService.getShoppingList(uid).then((value) {
      shoppingList = value;
    });
  }

  Future<void> deleteshoppingList(context) async {
    User user = FirebaseAuth.instance.currentUser!;
    DatabaseForShoppingList dbService = DatabaseForShoppingList(uid: user.uid);

    await dbService.deleteShoppingList(shoppingList.uid, context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            shoppingList.products == null) {
          return Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(shoppingList.name),
              centerTitle: true,
              actions: <Widget>[
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: const Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                            child: Icon(Icons.add),
                          ),
                          Text('Add Product'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManualProductView(
                              listUid: shoppingList.uid,
                              controller: controller_addProductToList,
                              spec: 'list',
                            ),
                          ),
                        );
                      },
                    ),
                    PopupMenuItem<int>(
                      value: 0,
                      child: const Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                            child: Icon(Icons.edit),
                          ),
                          Text('Edit'),
                        ],
                      ),
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
                      child: const Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                            child: Icon(Icons.delete),
                          ),
                          Text('Delete'),
                        ],
                      ),
                      onTap: () {
                        deleteshoppingList(context);
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
                  margin: const EdgeInsets.only(bottom: 30),
                  padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20, top: 20),

                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await ShoppingListControllers()
                          .resetProductStatus(shoppingList, context);
                    },
                    child: const Text(
                      'CHECKOUT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
