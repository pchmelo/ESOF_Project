import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';

class DatabaseForShoppingList {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid;

  DatabaseForShoppingList({required this.uid});

  Future<void> createShoppingList(String uid, ShoppingList shoppingList) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('shoppingList')
        .add(shoppingList.toJson());
  }

  Future<ShoppingList> getShoppingList(String uid, String listId) async {
    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(uid)
        .collection('shoppingList')
        .doc(listId)
        .get();
    return ShoppingList.fromJson(doc.data() as Map<String, dynamic>);
  }

  Stream<List<ShoppingList>> getShoppingListStream(String uid) {
    return _firestore
        .collection('users')
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
      String uid, String listId, ShoppingList shoppingList) async {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('shoppingList')
        .doc(listId)
        .update(shoppingList.toJson());
  }

  Future<void> deleteShoppingList(String uid, String listId) async {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('shoppingList')
        .doc(listId)
        .delete();
  }
}
