import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../services/database_product.dart';
import '../models/product.model.dart';

class ProductControllers {
  late DatabaseForProducts dbService;
  late User user;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  ProductControllers([DatabaseForProducts? dbServiceParam, User? userParam]) {
    user = userParam ?? FirebaseAuth.instance.currentUser!;
    dbService = dbServiceParam ?? DatabaseForProducts(uid: user.uid);
  }

  Future<void> CreateProduct(context, _name, _threshold, _quantity) async {
    isLoading.value = true;
    Product product = Product(
        id: const Uuid().v4(),
        name: _name,
        threshold: _threshold.toInt(),
        quantity: _quantity.toInt(),
        barcodes: <String>[]);
    await dbService.addProduct(product);
    Navigator.pop(context);
    isLoading.value = false;
  }

  Future<void> EditProduct(
      context, product, _name, _threshold, _quantity) async {
    isLoading.value = true;
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
    isLoading.value = false;
  }

  Future<void> ChangeQuantityProduct(context, product, _value, scancode) async {
    isLoading.value = true;
    List<String> barcodes = product.barcodes;
    if (scancode != '') {
      barcodes.add(scancode);
    }

    _value ??= 0;

    Product newProduct = Product(
      id: product.id,
      name: product.name,
      threshold: product.threshold,
      quantity: product.quantity + _value!,
      barcodes: barcodes,
    );

    await dbService.updateProduct(newProduct);
    Navigator.pushReplacementNamed(context, '/start/add_product');
    isLoading.value = false;
  }
}
