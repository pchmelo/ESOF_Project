import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter/material.dart';

class ShoppingListTile extends StatelessWidget {
  final ShoppingList shoppingList;
  final Function controller;
  final Function onShoppingListTap;

  const ShoppingListTile(
      {super.key,
      required this.shoppingList,
      required this.controller,
      required this.onShoppingListTap});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // This makes the tile square
      child: GestureDetector(
        onTap: () {
          onShoppingListTap(shoppingList, controller);
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
