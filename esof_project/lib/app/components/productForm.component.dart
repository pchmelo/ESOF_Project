import 'package:esof_project/app/shared/plusButton.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/shoppingListControllers.dart';
import '../models/product.model.dart';
import '../models/shoppingList.model.dart';
import '../views/extra_pages/list_products/shoppingListDisplay.dart';
import '../views/extra_pages/product/changeQuantity.widget.dart';
import '../views/extra_pages/product/createProduct.widget.dart';
import '../views/extra_pages/product/editProduct.widget.dart';
import '../views/main_pages/addProduct/manualAddProduct.view.dart';
import '../views/main_pages/shopping_list/shoppingList.widgetViewList.dart';

class ProductForm {
  final context;
  final product;

  ProductForm({this.context, this.product});

  void CreateProductForm(controller) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateProdut(controller: controller),
        );
      },
    );
  }

  void PlusButtonForm(controller) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: PlusButton(controller: controller),
        );
      },
    );
  }

  Future<void> EditProductForm(controller) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: EditProduct(product: product, controller: controller),
          );
        });
  }

  AddProductQuantityForm(
      String listUid, Function controller, Product? product, String scancode) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ChangeQuantityProduct(
              listUid: listUid,
              controller: controller,
              product: product,
              scancode: scancode,
            ),
          );
        },
      );
    });
  }
}

class ShoppingListForm {
  final context;
  ShoppingListForm({this.context});

  Widget SelectShoppingListForm(Product product) {
    return Builder(builder: (BuildContext context) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text('Select a Shopping List'),
                ),
                body: ShoppingListViewList(
                  controller: ShoppingListControllers().addProductToList,
                  handleShoppingListTap:
                      ProductForm(context: context).AddProductQuantityForm,
                  product: product,
                ),
              ),
            );
          },
        );
      });
      return const SizedBox
          .shrink(); // Return an empty widget if there's no data
    });
  }
}
