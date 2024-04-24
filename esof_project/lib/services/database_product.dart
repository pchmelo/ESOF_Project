import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/product.model.dart';

import '../app/models/shoppingList.model.dart';

class DatabaseForProducts {
  final String uid;
  DatabaseForProducts({required this.uid});

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
    return snapshot.docs
        .map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          if (!data.containsKey('id')) {
            print('Error: "id" field does not exist in the document');
            // Handle the error appropriately
            return null;
          }

          return Product(
            id: data['id'] ?? '',
            name: data['name'] ?? '',
            quantity: data['quantity'] ?? 0,
            threshold: data['threshold'] ?? 0,
            barcodes: List<String>.from(data['barcodes'] ?? []),
          );
        })
        .where((product) => product != null)
        .cast<Product>()
        .toList();
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

  Future<Product?> getProductByBarcode(String barcode) async {
    QuerySnapshot snapshot =
        await productCollection.doc(uid).collection('products').get();
    for (var doc in snapshot.docs) {
      Product product = Product.fromJson(doc.data() as Map<String, dynamic>);
      if (product.isBarcodeExist(barcode)) {
        return product;
      }
    }
    return null;
  }

  Future<Product> getProductById(String productId) async {
    DocumentSnapshot doc = await productCollection
        .doc(uid)
        .collection('products')
        .doc(productId)
        .get();
    return Product.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<Map<Product?, Map<int, bool>>> getProductsInShoppingList(
      ShoppingList shoppingList) async {
    Map<Product?, Map<int, bool>> productMap = {};

    for (var entry in shoppingList.products.entries) {
      String? productId = entry.key;
      int quantity = entry.value.keys.first;
      bool checked = entry.value.values.first;

      Product? product = await getProductById(productId!);

      productMap[product] = {quantity: checked};
    }

    return productMap;
  }
}
