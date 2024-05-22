import 'package:esof_project/app/views/main_pages/shopping_list/shoppingListBuilder.dart';
import 'package:esof_project/services/database_shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/product.model.dart';
import '../../../models/shoppingList.model.dart';
import '../../../shared/loading.dart';

class ShoppingListViewList extends StatefulWidget {
  final Function controller;
  final Function handleShoppingListTap;
  Product? product;
  ShoppingListViewList(
      {super.key,
      required this.controller,
      required this.handleShoppingListTap,
      this.product});

  @override
  State<ShoppingListViewList> createState() => _ShoppingListViewStateViewList();
}

class _ShoppingListViewStateViewList extends State<ShoppingListViewList> {
  late User user;
  late DatabaseForShoppingList _dbService;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _dbService = DatabaseForShoppingList(uid: user.uid);
  }

  List<ShoppingList> _allShoppingLists = [];
  final ValueNotifier<List<ShoppingList>> _foundShoppingLists =
      ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: StreamBuilder<List<ShoppingList>>(
          stream:
              _dbService.getShoppingListStream() as Stream<List<ShoppingList>>?,
          builder: (BuildContext context,
              AsyncSnapshot<List<ShoppingList>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              _allShoppingLists = snapshot.data!;
              _foundShoppingLists.value = List.from(_allShoppingLists);

              return Column(children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _foundShoppingLists,
                    builder: (BuildContext context, List<ShoppingList> value,
                        Widget? child) {
                      return ShoppingListBuilder(
                          controller: widget.controller,
                          foundShoppingList: value,
                          handleProductTap: widget.handleShoppingListTap,
                          product: widget.product);
                    },
                  ),
                ),
              ]);
            }
          },
        ));
  }
}
