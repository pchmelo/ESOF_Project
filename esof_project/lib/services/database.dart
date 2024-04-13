import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/product.model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('users');

  Future<DocumentReference<Map<String, dynamic>>> addProduct(
      Product product) async {
    return await productCollection
        .doc(uid)
        .collection('products')
        .add(product.toJson());
  }

  Future<List<Product>> getProducts() async {
    QuerySnapshot snapshot =
        await productCollection.doc(uid).collection('products').get();
    return snapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteProductByName(String productName) async {
    QuerySnapshot snapshot = await productCollection
        .doc(uid)
        .collection('products')
        .where('name', isEqualTo: productName)
        .get();

    snapshot.docs.forEach((doc) async {
      await doc.reference.delete();
    });
  }

  Future<void> updateProductByName(
      String productName, Product newProductData) async {
    QuerySnapshot snapshot = await productCollection
        .doc(uid)
        .collection('products')
        .where('name', isEqualTo: productName)
        .get();

    snapshot.docs.forEach((doc) async {
      await doc.reference.update(newProductData.toJson());
    });
  }
}
