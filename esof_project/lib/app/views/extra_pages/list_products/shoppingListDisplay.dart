import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter/material.dart';

class ShoppingListDisplay extends StatelessWidget {
  final ShoppingList shoppingList;
  final Function controller;
  const ShoppingListDisplay(
      {super.key, required this.shoppingList, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List View"),
      ),
      body: Container(
        child: Text(shoppingList.name),
      ),
    );
  }
}
