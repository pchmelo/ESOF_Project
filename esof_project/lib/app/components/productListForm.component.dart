import 'package:flutter/material.dart';

class ProductListForm {
  final context;
  final list;

  ProductListForm({this.context, this.list});

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
}
