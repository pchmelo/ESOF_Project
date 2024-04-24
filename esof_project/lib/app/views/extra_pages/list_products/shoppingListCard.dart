import 'package:esof_project/app/components/changeQuantitity.component.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter/material.dart';

import '../../../controllers/shoppingListControllers.dart';
import '../../../models/product.model.dart';
import '../../../shared/loading.dart';

class ShoppingListCard {
  Map<String, Map<int, bool>> _values = {};

  bool delete = false;

  int getValue(String productId) {
    return _values[productId]?.keys.first ?? 0;
  }

  bool getDelete(String productId) {
    return _values[productId]?.values.first ?? false;
  }

  Widget shoppingListCard(
      {required MapEntry<Product?, Map<int, bool>> entry,
      required ShoppingList shoppingList}) {
    Product? product = entry.key;
    Map<int, bool> productDetails = entry.value;
    int quantity = productDetails.keys.first;
    bool checked = productDetails.values.first;

    return SizedBox(
      height: 115, // Set the height of the card
      child: Card(
        color: checked ? Colors.green[100] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Increase padding to make the card look bigger
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.name ?? 'Unknown product',
                    style: const TextStyle(
                        fontSize:
                            25.0), // Increase font size to make the card look bigger
                  ),
                  Text(
                    'x$quantity',
                    style: const TextStyle(
                        fontSize:
                            25.0), // Increase font size to make the card look bigger
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: ShoppingListControllers().isLoading,
                builder: (BuildContext context, bool isLoading, Widget? child) {
                  if (isLoading) {
                    return Loading();
                  } else {
                    return Checkbox(
                      value: checked,
                      onChanged: (bool? value) {
                        if (value != null) {
                          ShoppingListControllers().updateProductCheckedStatus(
                            shoppingList.uid,
                            product?.id ?? '',
                            value,
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editShoppingListCard(
      {required MapEntry<Product?, Map<int, bool>> entry,
      required ShoppingList shoppingList}) {
    Product? product = entry.key;
    Map<int, bool> productDetails = entry.value;
    int quantity = productDetails.keys.first;

    return Card(
      child: ListTile(
        title: Text(
            product?.name ?? 'Unknown product'), // Display the product name
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // Set the main axis size to minimum
          children: <Widget>[
            ChangeQuantityComponent(
              initialValue: quantity ?? 0,
              onQuantityChanged: (quantity) {
                _values[product?.id ?? ''] = {quantity: delete};
              },
            ),
            IconButton(
              icon: Icon(delete ? Icons.close : Icons.delete),
              onPressed: () {
                delete = !delete;
                _values[product?.id ?? ''] = {quantity: !delete};
                int i = 9;
              },
            ),
          ],
        ),
      ),
    );
  }
}
