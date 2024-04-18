import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/shoppingList.model.dart';

class DatabaseForListProduct {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createListProduct(String uid, ShoppingList listProduct) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('listProducts')
        .add(listProduct.toMap());
  }

  Future<ShoppingList> getListProduct(String uid, String listId) async {
    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(uid)
        .collection('listProducts')
        .doc(listId)
        .get();
    return ShoppingList.fromMap(doc.data() as Map<String, dynamic>);
  }

  Stream<List<ShoppingList>> getListProductsStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('listProducts')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ShoppingList.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> updateListProduct(
      String uid, String listId, ShoppingList listProduct) async {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('listProducts')
        .doc(listId)
        .update(listProduct.toMap());
  }

  Future<void> deleteListProduct(String uid, String listId) async {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('listProducts')
        .doc(listId)
        .delete();
  }
}
