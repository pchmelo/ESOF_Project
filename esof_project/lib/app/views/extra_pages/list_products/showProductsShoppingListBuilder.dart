import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/app/shared/loading.dart';
import 'package:esof_project/services/database_shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';

class ShowProductsShoppingListBuilder extends StatefulWidget {
  final Function shoppingListCard;
  final ShoppingList shoppingList;
  const ShowProductsShoppingListBuilder(
      {super.key, required this.shoppingList, required this.shoppingListCard});

  @override
  State<ShowProductsShoppingListBuilder> createState() =>
      _ShowProductsShoppingListBuilderState();
}

class _ShowProductsShoppingListBuilderState
    extends State<ShowProductsShoppingListBuilder> {
  late Stream<Map<Product, Map<int, bool>>> productsStream;

  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser!;
    productsStream = DatabaseForShoppingList(uid: user.uid)
        .getProductsInShoppingList(widget.shoppingList);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<Product, Map<int, bool>>>(
      stream: productsStream,
      builder: (BuildContext context,
          AsyncSnapshot<Map<Product, Map<int, bool>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Waiting for data...');
          return Loading();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            Map<Product, Map<int, bool>> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                MapEntry<Product?, Map<int, bool>> entry =
                    products.entries.elementAt(index);
                return widget.shoppingListCard(
                    entry: entry, shoppingList: widget.shoppingList);
              },
            );
          } else {
            print('No data received');
            return const Text('No data available');
          }
        }
      },
    );
  }
}
