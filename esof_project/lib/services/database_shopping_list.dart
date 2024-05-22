import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/services/database_product.dart';
import 'package:flutter/cupertino.dart';
import '../app/models/product.model.dart';

class DatabaseForShoppingList {
  final CollectionReference shoppingListCollection =
      FirebaseFirestore.instance.collection('users');
  final String uid;
  DatabaseForShoppingList({required this.uid});

  Future<void> createShoppingList(ShoppingList shoppingList) async {
    await shoppingListCollection
        .doc(uid)
        .collection('shoppingList')
        .doc(shoppingList.uid)
        .set(shoppingList.toJson());
  }

  Future<ShoppingList> getShoppingList(String listId) async {
    DocumentSnapshot doc = await shoppingListCollection
        .doc(uid)
        .collection('shoppingList')
        .doc(listId)
        .get();
    return ShoppingList.fromJson(doc.data() as Map<String, dynamic>);
  }

  Stream<Map<Product, Map<int, bool>>> getProductsInShoppingList(
      ShoppingList shoppingList) {
    DocumentReference shoppingListDoc = shoppingListCollection
        .doc(uid)
        .collection('shoppingList')
        .doc(shoppingList.uid);

    Stream<DocumentSnapshot> shoppingListSnapshot = shoppingListDoc.snapshots();

    return shoppingListSnapshot.asyncMap((snapshot) async {
      Map<String, dynamic> productsData =
          snapshot.get('products') as Map<String, dynamic>;

      Map<Product, Map<int, bool>> result = {};

      for (var entry in productsData.entries) {
        int quantity = int.parse(entry.value.keys.first);
        bool checked = entry.value.values.first as bool;

        DatabaseForProducts db = DatabaseForProducts(uid: uid);
        Product product = await db.getProductById(entry.key);

        result[product] = {quantity: checked};
      }

      return result;
    });
  }

  Future<Map<String, Map<int, bool>>> getProductsInShoppingListFuture(
      ShoppingList shoppingList) async {
    DocumentReference shoppingListDoc = shoppingListCollection
        .doc(uid)
        .collection('shoppingList')
        .doc(shoppingList.uid);

    DocumentSnapshot snapshot = await shoppingListDoc.get();

    Map<String, dynamic> productsData =
        snapshot.get('products') as Map<String, dynamic>;

    Map<String, Map<int, bool>> result = {};

    for (var entry in productsData.entries) {
      int quantity = int.parse(entry.value.keys.first);
      bool checked = entry.value.values.first as bool;

      result[entry.key] = {quantity: checked};
    }

    return result;
  }

  Stream<List<ShoppingList>> getShoppingListStream() {
    return shoppingListCollection
        .doc(uid)
        .collection('shoppingList')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ShoppingList.fromJson(doc.data());
      }).toList();
    });
  }

  Future<void> updateShoppingList(
      String listId, ShoppingList shoppingList) async {
    return shoppingListCollection
        .doc(uid)
        .collection('shoppingList')
        .doc(listId)
        .update(shoppingList.toJson());
  }

  Future<void> deleteShoppingList(String listId, context) async {
    try {
      await shoppingListCollection
          .doc(uid)
          .collection('shoppingList')
          .doc(listId)
          .delete();
      return Navigator.pop(context);
    } catch (e) {
      print('Error deleting shopping list: $e');
      rethrow;
    }
  }
}
