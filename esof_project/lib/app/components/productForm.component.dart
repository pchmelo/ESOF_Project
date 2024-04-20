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

  void PlusButtonForm(controller) {
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
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
