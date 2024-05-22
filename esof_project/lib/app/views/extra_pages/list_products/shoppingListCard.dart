import 'package:esof_project/app/components/changeQuantitity.component.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter/material.dart';
import '../../../controllers/shoppingListControllers.dart';
import '../../../models/product.model.dart';
import '../../../shared/loading.dart';

class ShoppingListCard {
  Map<String, Map<int, bool>> _values = {};
  int getValue(String productId) {
    return _values[productId]?.keys.first ?? 0;
  }

  Map<String, Map<int, bool>> getValues() {
    return _values;
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
      height: 80,
      child: Card(
        color: checked ? const Color(0xFF90EE90) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: ShoppingListControllers().isLoading,
                    builder:
                        (BuildContext context, bool isLoading, Widget? child) {
                      if (isLoading) {
                        return Loading();
                      } else {
                        return Checkbox(
                          activeColor: Colors.green,
                          value: checked,
                          onChanged: (bool? value) {
                            if (value != null) {
                              ShoppingListControllers()
                                  .updateProductCheckedStatus(
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
                  Text(
                    product?.name ?? 'Unknown product',
                    style: const TextStyle(fontSize: 25.0),
                  ),
                  Text(
                    ' (x$quantity)',
                    style: const TextStyle(fontSize: 25.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }





Widget editShoppingListCard(
    {required MapEntry<Product, Map<int, bool>> entry,
    required ShoppingList shoppingList}) {
  Product product = entry.key;
  Map<int, bool> productDetails = entry.value;
  int quantity = productDetails.keys.first;
  ValueNotifier<bool> checkedNotifier = ValueNotifier(product.checked);
  return Card(
    elevation: 2,
    margin: const EdgeInsets.all(15),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              product.name ?? 'Unknown product',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            trailing: IconButton(
              icon: ValueListenableBuilder<bool>(
                valueListenable: checkedNotifier,
                builder: (context, value, child) {
                  return Icon(value ? Icons.close : Icons.delete_outline, color: value ? Colors.red : Colors.grey);
                },
              ),
              onPressed: () {
                product.toggleCheckedStatus();
                _values[product.id ?? ''] = {quantity: product.checked};
                checkedNotifier.value = product.checked;
              },
            ),
          ),
          const Divider(),
          const SizedBox(height: 15),
          ChangeQuantityComponent2(
            initialValue: quantity ?? 0,
            onQuantityChanged: (value) {
              _values[product.id ?? ''] = {value: product.checked};
              quantity = value;
            },
          ),
        ],
      ),
    ),
  );
}
}