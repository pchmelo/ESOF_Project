import 'package:esof_project/app/controllers/notificationController.dart';
import 'package:esof_project/app/controllers/shoppingListControllers.dart';
import 'package:esof_project/app/controllers/validityControllers.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';
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

  Future<void> CreateProduct(Product product) async {
    isLoading.value = true;
    await dbService.addProduct(product);
    isLoading.value = false;
  }

  Future<void> EditQuantity(Product product, int quantity) async {
    isLoading.value = true;
    Product newProduct = Product.withImage(
      id: product.id,
      name: product.name,
      threshold: product.threshold,
      quantity: quantity,
      barcodes: product.barcodes,
      validity: product.validity,
      notification: product.notification,
      imageURL: product.imageURL,
    );
    dbService.updateProduct(newProduct);
    isLoading.value = false;
  }

  Future<void> PlusButton(
      context, _name, _threshold, _quantity, _imageURL) async {
    isLoading.value = true;
    Product product = Product.withImage(
        notification: false,
        validity: false,
        id: const Uuid().v4(),
        name: _name,
        threshold: _threshold.toInt(),
        quantity: _quantity.toInt(),
        barcodes: <String>[],
        imageURL: _imageURL);
    await dbService.addProduct(product);
    Navigator.pop(context);
    isLoading.value = false;
  }

  Future<void> EditProduct(context, product, _name, _threshold, _quantity,
      _validity, _notification, _imageURL) async {
    isLoading.value = true;
    _name ??= product.name;
    _threshold ??= product.threshold;
    _quantity ??= product.quantity;
    _validity ??= product.validity;

    if (_validity != product.validity) {
      if (!_validity) {
        ValidityController validityController = ValidityController();
        validityController.deleteAllValiditiesOfProduct(product.id);
      }
      _quantity = 0;
    }

    Product newProduct = Product.withImage(
      id: product.id,
      name: _name,
      threshold: _threshold!.toInt(),
      quantity: _quantity!.toInt(),
      barcodes: product.barcodes,
      validity: _validity,
      notification: _notification,
      imageURL: _imageURL,
    );

    await dbService.updateProduct(newProduct);
    isLoading.value = false;
  }

  Future<void> ChangeQuantityProduct(id, product, _value, scancode) async {
    isLoading.value = true;
    List<String> barcodes = product.barcodes;
    if (scancode != '') {
      barcodes.add(scancode);
    }

    _value ??= 0;

    Product newProduct = Product.withImage(
      validity: product.validity,
      id: product.id,
      name: product.name,
      threshold: product.threshold,
      quantity: product.quantity + _value!,
      barcodes: barcodes,
      notification: product.notification,
      imageURL: product.imageURL,
    );

    await dbService.updateProduct(newProduct);
    isLoading.value = false;
  }

  Future<void> addQuantitiesToProducts(ShoppingList shoppingList) async {
    for (var entry in shoppingList.products.entries) {
      String productId = entry.key;
      int quantityToAdd = entry.value.keys.first;

      Product product = await dbService.getProductById(productId);
      await ChangeQuantityProduct(productId, product, quantityToAdd, '');
    }
  }

  Future<void> deleteProduct(String productId) async {
    isLoading.value = true;

    ShoppingListControllers shoppingListControllers = ShoppingListControllers();
    shoppingListControllers.deleteProductFromAllLists(productId);

    ValidityController validityController = ValidityController();
    validityController.deleteAllValiditiesOfProduct(productId);

    NotificationController notification = NotificationController();
    notification.deleteNotificationById(productId);

    await dbService.deleteProductById(productId);
    isLoading.value = false;
  }

  Future<void> removeQuantityFromProduct(
      String productId, int quantityToRemove) async {
    isLoading.value = true;

    Product product = await dbService.getProductById(productId);
    int newQuantity = product.quantity! - quantityToRemove;

    newQuantity = newQuantity < 0 ? 0 : newQuantity;

    Product updatedProduct = Product(
      validity: product.validity,
      id: product.id,
      name: product.name,
      threshold: product.threshold,
      quantity: newQuantity,
      barcodes: product.barcodes,
      notification: product.notification,
    );

    await dbService.updateProduct(updatedProduct);

    isLoading.value = false;
  }

  Future<Product> getProductById(String productId) async {
    isLoading.value = true;

    Product product = await dbService.getProductById(productId);
    isLoading.value = false;

    return product;
  }

  Future<void> updateImageURL(Product product, String imageURL) async {
    isLoading.value = true;

    product.imageURL = imageURL;
    await dbService.updateProduct(product);

    isLoading.value = false;
  }

  Future<Product> fetchProduct(Product product) async {
    isLoading.value = true;
    Product fetched_product = await dbService.getProductById(product.id);
    isLoading.value = false;
    return fetched_product;
  }
}
