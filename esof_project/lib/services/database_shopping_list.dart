import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/services/database_product.dart';

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

  Stream<Map<Product?, Map<int, bool>>> getProductsInShoppingList(
      ShoppingList shoppingList) {
    DocumentReference shoppingListDoc = shoppingListCollection
        .doc(uid)
        .collection('shoppingList')
        .doc(shoppingList.uid);

    Stream<DocumentSnapshot> shoppingListSnapshot = shoppingListDoc.snapshots();

    return shoppingListSnapshot.asyncMap((snapshot) async {
      Map<String, dynamic> productsData =
          snapshot.get('products') as Map<String, dynamic>;

      Map<Product?, Map<int, bool>> result = {};

      for (var entry in productsData.entries) {
        // Get the quantity and checked status from the entry value
        int quantity = int.parse(entry.value.keys.first);
        bool checked = entry.value.values.first as bool;

        DatabaseForProducts db = DatabaseForProducts(uid: uid);
        // Fetch the Product from the database
        Product? product = await db.getProductById(entry.key);

        // Add the Product and its details to the map
        result[product] = {quantity: checked};
      }

      return result;
    });
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

  Future<void> deleteShoppingList(String listId) async {
    try {
      return await shoppingListCollection
          .doc(uid)
          .collection('shoppingList')
          .doc(listId)
          .delete();
    } catch (e) {
      print('Error deleting shopping list: $e');
      rethrow;
    }
  }
}
