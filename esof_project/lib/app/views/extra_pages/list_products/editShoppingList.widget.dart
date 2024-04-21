import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter/material.dart';

import '../../../controllers/shoppingListControllers.dart';

class EditShoppingList extends StatefulWidget {
  final ShoppingList shoppingList;
  final Function controller = ShoppingListControllers().editShoppingList;

  EditShoppingList({super.key, required this.shoppingList});

  @override
  _EditShoppingListState createState() => _EditShoppingListState();
}

class _EditShoppingListState extends State<EditShoppingList> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Change the Shopping List: ${widget.shoppingList.name}',
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.black),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: const Column(
        children: <Widget>[],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            widget.controller(widget.shoppingList.uid, _nameController.text,
                widget.shoppingList.products);
            Navigator.pushReplacementNamed(context, '/start/shopping_list');
          },
          child: const Text('Confirm'),
        ),
      ),
    );
  }
}
