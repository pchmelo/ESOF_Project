import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/app/views/main_pages/shopping_list/shoppingListTile.widget.dart';
import 'package:esof_project/app/views/main_pages/shopping_list/shoppingListTileAdd.widget.dart';
import 'package:flutter/material.dart';
import '../../../models/product.model.dart';

class ShoppingListBuilder extends StatefulWidget {
  Product? product;
  final Function controller;
  final List<ShoppingList> foundShoppingList;
  Function handleProductTap;

  ShoppingListBuilder(
      {super.key,
      required this.controller,
      required this.foundShoppingList,
      required this.handleProductTap,
      this.product});

  @override
  State<ShoppingListBuilder> createState() => _ShoppingListBuilderState();
}

class _ShoppingListBuilderState extends State<ShoppingListBuilder> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.foundShoppingList.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.foundShoppingList.length) {
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
              child: const ShoppingListTileAdd(),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 200,
              height: 200,
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
                product: widget.product,
              ),
            ),
          );
        }
      },
    );
  }
}
