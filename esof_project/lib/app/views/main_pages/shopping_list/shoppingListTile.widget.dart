import 'package:esof_project/app/controllers/shoppingListControllers.dart';
import 'package:esof_project/app/models/product.model.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter/material.dart';

class ShoppingListTile extends StatefulWidget {
  ShoppingList shoppingList;
  final Function controller;
  final Function onShoppingListTap;
  Product? product;

  ShoppingListTile(
      {Key? key,
      required this.shoppingList,
      required this.controller,
      required this.onShoppingListTap,
      this.product})
      : super(key: key);

  @override
  _ShoppingListTileState createState() => _ShoppingListTileState();
}

class _ShoppingListTileState extends State<ShoppingListTile> {
  late Map<Product, int> products = {};

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    ShoppingListControllers controller = ShoppingListControllers();
    var newShoppingList =
        await controller.fetchShoppingList(widget.shoppingList.uid);
    var newProducts =
        await controller.getProductsInShoppingList(newShoppingList);

    setState(() {
      widget.shoppingList = newShoppingList;
      products = newProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: InkWell(
        onTap: () {
          print(widget.onShoppingListTap);
          widget.onShoppingListTap(widget.shoppingList.uid, widget.controller,
              widget.product, '', 'info');
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Positioned(
              top: 5.0,
              left: 5.0,
              right: 5.0,
              bottom: 5.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.shoppingList.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (var entry in products.entries.take(3))
                    Row(
                      children: [
                        Expanded(
                          flex: 3, // takes 75% of the space
                          child: Text(
                            entry.key.name,
                            style: const TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1, // takes 25% of the space
                          child: Text(
                            "x${entry.value}",
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
