import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';

class DatabaseForListProduct {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid;

  DatabaseForListProduct({required this.uid});

  Future<void> createShoppingList(String uid, ShoppingList shoppingList) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('shoppingList')
        .add(shoppingList.toMap());
  }

  Future<ShoppingList> getShoppingList(String uid, String listId) async {
    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(uid)
        .collection('shoppingList')
        .doc(listId)
        .get();
    return ShoppingList.fromMap(doc.data() as Map<String, dynamic>);
  }

  Stream<List<ShoppingList>> getShoppingListStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('shoppingList')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ShoppingList.fromMap(doc.data());
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
        .update(shoppingList.toMap());
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
