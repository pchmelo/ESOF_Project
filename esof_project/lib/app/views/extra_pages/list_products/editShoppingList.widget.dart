import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/app/views/extra_pages/list_products/shoppingListCard.dart';
import 'package:esof_project/app/views/extra_pages/list_products/showProductsShoppingListBuilder.dart';
import 'package:flutter/material.dart';
import '../../../controllers/shoppingListControllers.dart';

class EditShoppingList extends StatefulWidget {
  final ShoppingList shoppingList;
  final Function controller = ShoppingListControllers().editShoppingList;
  final shoppingListCard = ShoppingListCard();

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
          backgroundColor: const Color(0xFF4CAF50),
          title: SizedBox(
            width: double.infinity,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Editing Shopping List: ${widget.shoppingList.name}',
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ShowProductsShoppingListBuilder(
                  shoppingList: widget.shoppingList,
                  shoppingListCard:
                      widget.shoppingListCard.editShoppingListCard),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              backgroundColor: const Color(0xFF4CAF50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () async {
              ShoppingListControllers shoppingListControllers =
                  ShoppingListControllers();
              var products_p = await shoppingListControllers
                  .fetchProducts(widget.shoppingList);

              var new_shops = widget.shoppingList;
              new_shops.updateProducts(products_p);

              for (var entry in products_p.entries) {
                String productId = entry.key;
                var quantity =
                    widget.shoppingListCard.getValue(productId ?? '');
                bool deletion =
                    widget.shoppingListCard.getDelete(productId ?? '');

                if (deletion) {
                  new_shops.removeProduct(productId);
                } else if (quantity != 0 && !deletion) {
                  new_shops.updateProductQuantity(productId, quantity);
                }
              }

              String newName = _nameController.text.isEmpty
                  ? widget.shoppingList.name
                  : _nameController.text;

              widget.controller(
                  widget.shoppingList.uid, newName, new_shops.products);

              Navigator.pop(context);
            },
            child: const Text(
              'Confirm',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ));
  }
}
