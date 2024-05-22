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
import '../../main_pages/shopping_list/shoppingList.view.dart';
import 'editShoppingList.widget.dart';

class ShoppingListDisplay extends StatelessWidget {
  String? a;
  Product? b;
  String? c;
  final String uid;
  late ShoppingList shoppingList;
  final Function controller;
  final Function controller_addProductToList =
      ShoppingListControllers().addProductToList;

  final Function shoppingListCard = ShoppingListCard().shoppingListCard;

  ShoppingListDisplay(
      {super.key,
      required this.uid,
      required this.controller,
      this.b,
      this.a,
      this.c});

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

  Future<void> deleteshoppingList(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Loading();
      },
    );

    User user = FirebaseAuth.instance.currentUser!;
    DatabaseForShoppingList dbService = DatabaseForShoppingList(uid: user.uid);

    await dbService.deleteShoppingList(shoppingList.uid, context);

    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingListView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingListView(),
                      ),
                    );
                  },
                ),
                title: Text(shoppingList.name,
                    style: const TextStyle(color: Colors.white)),
                centerTitle: true,
                backgroundColor: const Color(0xFF4CAF50),
                actions: <Widget>[
                  PopupMenuButton(
                    color: const Color(0xFF4CAF50),
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
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ShowProductsShoppingListBuilder(
                          shoppingList: shoppingList,
                          shoppingListCard: shoppingListCard),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 110, right: 110, bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(10),
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
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
