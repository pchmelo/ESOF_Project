import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter/material.dart';

class ShoppingListTile extends StatelessWidget {
  final ShoppingList shoppingList;
  final Function controller;
  final Function onShoppingListTap;
  Product? product;

  ShoppingListTile(
      {super.key,
      required this.shoppingList,
      required this.controller,
      required this.onShoppingListTap,
      this.product});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // This makes the tile square
      child: InkWell(
        onTap: () {
          print(onShoppingListTap);
          onShoppingListTap(shoppingList.uid, controller, product, '', 'info');
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // This gives the tile a white background
                border: Border.all(
                    color: Colors.black), // This gives the tile a black border
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Positioned(
              top: 5.0, // Adjust this value as needed
              left: 5.0, // Adjust this value as needed
              child: Text(shoppingList.name!),
            ),
          ],
        ),
      ),
    );
  }
}
