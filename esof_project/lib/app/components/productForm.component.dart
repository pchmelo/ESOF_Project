import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../views/extra_pages/changeQuantity.widget.dart';
import '../views/extra_pages/editProduct.widget.dart';
import '../views/extra_pages/createProduct.widget.dart';

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

  Future<void> EditProductForm(controller) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: EditProduct(product: product, controller: controller),
          );
        });
  }

  AddProductQuantityForm(product, controller, scancode) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ChangeQuantityProduct(
              product: product,
              controller: controller,
              scancode: scancode,
            ),
          );
        },
      );
    });
  }
}
