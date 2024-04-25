import 'package:esof_project/app/controllers/productControllers.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/services/database_product.dart';
import 'package:esof_project/services/database_shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../models/product.model.dart';


class ShoppingListControllers {
  late DatabaseForShoppingList dbService;
  late DatabaseForProducts dbServiceProduct;
  late User user;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  ShoppingListControllers(
      [DatabaseForShoppingList? dbServiceParam, User? userParam]) {
    user = userParam ?? FirebaseAuth.instance.currentUser!;
    dbService = dbServiceParam ?? DatabaseForShoppingList(uid: user.uid);
    dbServiceProduct = DatabaseForProducts(uid: user.uid);
  }

  Future<void> CreateProduct(
    context,
    _name,
  ) async {
    isLoading.value = true;
    ShoppingList shoppingList = ShoppingList(
      uid: const Uuid().v4(),
      name: _name,
      products: <String, Map<int, bool>>{},
    );
    await dbService.createShoppingList(shoppingList);
    Navigator.pop(context);
    isLoading.value = false;
  }

  Future<void> editShoppingList(
      String listId, String name, Map<String, Map<int, bool>> products) async {
    isLoading.value = true;

    ShoppingList newShoppingList = ShoppingList(
      uid: listId,
      name: name,
      products: products,
    );

    await dbService.updateShoppingList(listId, newShoppingList);
    isLoading.value = false;
  }

  Future<void> addProductToList(
      listId, Product product, int quantity, scancode) async {
    isLoading.value = true;
    ShoppingList shoppingList = await dbService.getShoppingList(listId);

    quantity ??= 0;

    if (shoppingList.products.containsKey(product.id)) {
      int currentQuantity = shoppingList.products[product.id]!.keys.first;
      shoppingList.products[product.id] = {currentQuantity + quantity: false};
    } else {
      shoppingList.products[product.id] = {quantity: false};
    }

    await dbService.updateShoppingList(listId, shoppingList);
    isLoading.value = false;
  }

  Future<void> updateProductCheckedStatus(
      String listId, String productId, bool newStatus) async {
    isLoading.value = true;
    ShoppingList shoppingList = await dbService.getShoppingList(listId);

    if (shoppingList.products.containsKey(productId)) {
      int currentQuantity = shoppingList.products[productId]!.keys.first;
      shoppingList.products[productId] = {currentQuantity: newStatus};
    }

    await dbService.updateShoppingList(listId, shoppingList);
    isLoading.value = false;
  }

  Future<void> removeProductFromShoppingList(
      String listId, String productId) async {
    isLoading.value = true;
    ShoppingList shoppingList = await dbService.getShoppingList(listId);

    if (shoppingList.products.containsKey(productId)) {
      shoppingList.products.remove(productId);
    }

    await dbService.updateShoppingList(listId, shoppingList);
    isLoading.value = false;
  }

  Future<Map<String, Map<int, bool>>> fetchProducts(ShoppingList listId) {
    return dbService.getProductsInShoppingListFuture(listId);
  }

  Future<void> resetProductStatus(ShoppingList shoppingList) async {
    ShoppingList new_shoppingList =
        await dbService.getShoppingList(shoppingList.uid);

    for (var entry in new_shoppingList.products.entries) {
      String productId = entry.key;
      int currentQuantity = entry.value.keys.first;

      if (entry.value.values.first == true) {
        Product product = await dbServiceProduct.getProductById(productId);
        await ProductControllers()
            .ChangeQuantityProduct(productId, product, currentQuantity, '');
      }
      new_shoppingList.products[productId] = {currentQuantity: false};
    }

    await dbService.updateShoppingList(new_shoppingList.uid, new_shoppingList);
  }
}
