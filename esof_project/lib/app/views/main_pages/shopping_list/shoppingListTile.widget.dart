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
    return GestureDetector(
      onTap: () {
        onShoppingListTap(shoppingList, controller);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.yellow[100],
                  backgroundImage: const AssetImage(
                      'assets/images/default_product_image.png'),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shoppingList.name!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
