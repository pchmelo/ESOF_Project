import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/app/views/main_pages/shopping_list/shoppingListTile.widget.dart';
import 'package:flutter/material.dart';

class ShoppingListBuilder extends StatefulWidget {
  final Function controller;
  final List<ShoppingList> foundShoppingList;
  Function handleProductTap;

  ShoppingListBuilder(
      {super.key,
      required this.controller,
      required this.foundShoppingList,
      required this.handleProductTap});

  @override
  State<ShoppingListBuilder> createState() => _ShoppingListBuilderState();
}

class _ShoppingListBuilderState extends State<ShoppingListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.foundShoppingList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ShoppingListTile(
              shoppingList: widget.foundShoppingList[index],
              onShoppingListTap: widget.handleProductTap,
              controller: widget.controller,
            ),
          ),
        );
      },
    );
  }
}
