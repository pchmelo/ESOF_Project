import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/product.model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addProduct(Product product) async {
    return await productCollection
        .doc(uid)
        .collection('products')
        .doc(product.id)
        .set(product.toJson());
  }

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        id: doc.get('id') ?? '',
        name: doc.get('name') ?? '',
        quantity: doc.get('quantity') ?? 0,
        threshold: doc.get('threshold') ?? 0,
      );
    }).toList();
  }

  Stream<List<Product>> getProducts() {
    return productCollection
        .doc(uid)
        .collection('products')
        .snapshots()
        .map(_productListFromSnapshot);
  }

  /*
  Future<List<Product>> getProducts() async {
    QuerySnapshot snapshot =
        await productCollection.doc(uid).collection('products').get();
    return snapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
   */

  Future<void> deleteProductById(String productId) async {
    await productCollection
        .doc(uid)
        .collection('products')
        .doc(productId)
        .delete();
  }

  Future<void> updateProduct(Product product) async {
    deleteProductById(product.id!);
    addProduct(product);
  }
}
