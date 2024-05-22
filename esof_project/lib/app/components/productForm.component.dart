import 'package:esof_project/app/models/validity.model.dart';
import 'package:esof_project/app/shared/plusButton.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/shoppingListControllers.dart';
import '../models/product.model.dart';
import '../views/extra_pages/product/changeQuantity.widget.dart';
import '../views/extra_pages/product/createProduct.widget.dart';
import '../views/extra_pages/product/editProduct.widget.dart';
import '../views/extra_pages/product/removeQuantity.widget.dart';
import '../views/extra_pages/validity/createValidity.view.dart';
import '../views/extra_pages/validity/editValidity.widget.dart';
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

  AddProductQuantityForm(String listUid, Function controller, Product? product,
      String scancode, String spec) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height, // Full height
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChangeQuantityProduct(
                listUid: listUid,
                controller: controller,
                product: product,
                scancode: scancode,
                spec: spec,
              ),
            ),
          );
        },
      );
    });
  }

  Future<void> CreateValidityForm(Product product, int quantity) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateValidity(product: product, quantity: quantity),
        );
      },
    );
  }

  Future<void> removeQuantityForm() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: RemoveQuantityProduct(product: product),
        );
      },
    );
  }
}

class ShoppingListForm {
  final context;
  ShoppingListForm({this.context});

  Future<void> SelectShoppingListForm(Product product) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              toolbarHeight: 100,
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
  }
}

class ValidityForm {
  final context;
  ValidityForm({this.context});

  Future<void> EditValidityForm(
      Validity validity, EditValidity editValidity) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: editValidity,
        );
      },
    );
  }
}
