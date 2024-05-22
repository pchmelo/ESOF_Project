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
      aspectRatio: 1.0,
      child: GestureDetector(
        onTap: () {
          return ProductListForm(context: context)
              .CreateProductForm(create_controller);
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
            const Center(
              child: Icon(Icons.add, size: 50.0),
            ),
          ],
        ),
      ),
    );
  }
}
