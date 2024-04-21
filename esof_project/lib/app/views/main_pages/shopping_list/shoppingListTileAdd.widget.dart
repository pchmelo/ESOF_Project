import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter/material.dart';

import '../../../components/productListForm.component.dart';
import '../../../controllers/shoppingListControllers.dart';

class ShoppingListTileAdd extends StatelessWidget {
  const ShoppingListTileAdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Function create_controller = ShoppingListControllers().CreateProduct;

    return AspectRatio(
      aspectRatio: 1.0, // This makes the tile square
      child: GestureDetector(
        onTap: () {
          return ProductListForm(context: context)
              .CreateProductForm(create_controller);
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
            const Center(
              // This centers its child
              child: Icon(Icons.add, size: 50.0), // Add icon
            ),
          ],
        ),
      ),
    );
  }
}
