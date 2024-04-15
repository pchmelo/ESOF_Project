import 'package:esof_project/app/views/extra_pages/changeQuantity.widget.dart';
import 'package:esof_project/app/views/main_pages/storage/createProduct.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../services/database.dart';
import '../models/product.model.dart';

class ProductControllers {
  late DatabaseService dbService;
  late User user;

  ProductControllers() {
    user = FirebaseAuth.instance.currentUser!;
    dbService = DatabaseService(uid: user.uid);
  }

  CreateProduct(context, _name, _threshold, _quantity) async {
    Product product = Product(
        id: const Uuid().v4(),
        name: _name,
        threshold: _threshold.toInt(),
        quantity: _quantity.toInt(),
        barcodes: <String>[]);
    await dbService.addProduct(product);
    Navigator.pop(context);
  }

  EditProduct(context, product, _name, _threshold, _quantity) async {
    _name ??= product.name;
    _threshold ??= product.threshold;
    _quantity ??= product.quantity;

    Product newProduct = Product(
        id: product.id,
        name: _name,
        threshold: _threshold!.toInt(),
        quantity: _quantity!.toInt(),
        barcodes: product.barcodes);

    await dbService.updateProduct(newProduct);
    Navigator.pop(context);
  }

  ChangeQuantityProduct(context, product, _value) async {
    _value ??= 0;

    Product newProduct = Product(
      id: product.id,
      name: product.name,
      threshold: product.threshold,
      quantity: product.quantity + _value!,
      barcodes: product.barcodes,
    );

    await dbService.updateProduct(newProduct);
    Navigator.pushReplacementNamed(context, '/start/add_product');
  }
}
