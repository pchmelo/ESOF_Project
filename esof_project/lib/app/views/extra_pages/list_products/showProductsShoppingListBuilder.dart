import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/app/shared/loading.dart';
import 'package:esof_project/services/database_shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esof_project/app/models/product.model.dart';

class ShowProductsShoppingListBuilder extends StatefulWidget {
  final ShoppingList shoppingList;
  const ShowProductsShoppingListBuilder(
      {super.key, required this.shoppingList});

  @override
  State<ShowProductsShoppingListBuilder> createState() =>
      _ShowProductsShoppingListBuilderState();
}

class _ShowProductsShoppingListBuilderState
    extends State<ShowProductsShoppingListBuilder> {
  late Stream<Map<Product?, Map<int, bool>>> productsStream;

  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser!;
    productsStream = DatabaseForShoppingList(uid: user.uid)
        .getProductsInShoppingList(widget.shoppingList);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<Product?, Map<int, bool>>>(
      stream: productsStream,
      builder: (BuildContext context,
          AsyncSnapshot<Map<Product?, Map<int, bool>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Waiting for data...');
          return Loading();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            Map<Product?, Map<int, bool>> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                MapEntry<Product?, Map<int, bool>> entry =
                    products.entries.elementAt(index);
                Product? product = entry.key;
                Map<int, bool> productDetails = entry.value;
                int quantity = productDetails.keys.first;
                bool checked = productDetails.values.first;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Flexible(
                          child: Text(
                            product?.name ?? 'Unknown product',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'x$quantity',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Checkbox(
                        value: checked,
                        onChanged: (bool? value) {
                          // Handle when the checkbox is tapped
                        },
                      ),
                    ],
                  ),
                );
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
