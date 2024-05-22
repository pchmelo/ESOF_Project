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
    return SizedBox(
      height: 113,
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      (product.name?.length ?? 0) > 6
                          ? '${product.name.substring(0, 6) ?? ''}...'
                          : product.name ?? 'Unknown product',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    width: 235,
                    height: 85,
                    child: ChangeQuantityComponent(
                      initialValue: quantity ?? 0,
                      onQuantityChanged: (value) {
                        _values[product.id ?? ''] = {value: product.checked};
                        quantity = value;
                      },
                    ),
                  ),
                  IconButton(
                    icon: ValueListenableBuilder<bool>(
                      valueListenable: checkedNotifier,
                      builder: (context, value, child) {
                        return Icon(value ? Icons.close : Icons.delete);
                      },
                    ),
                    onPressed: () {
                      product.toggleCheckedStatus();
                      _values[product.id ?? ''] = {quantity: product.checked};
                      checkedNotifier.value = product.checked;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
