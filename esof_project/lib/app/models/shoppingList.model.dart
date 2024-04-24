class ShoppingList {
  final String uid;
  final String name;
  final Map<String, Map<int, bool>> products;

  ShoppingList({required this.uid, required this.name, required this.products});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'products': products.map((key, value) =>
          MapEntry(key, value.map((k, v) => MapEntry(k.toString(), v)))),
    };
  }

  static ShoppingList fromJson(Map<String, dynamic> map) {
    return ShoppingList(
      uid: map['uid'],
      name: map['name'],
      products: (map['products'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as Map<String, dynamic>).map(
            (k, v) => MapEntry(int.parse(k), v as bool),
          ),
        ),
      ),
    );
  }

  void updateProductQuantity(String productId, int quantity) {
    if (products.containsKey(productId)) {
      products[productId] = {quantity: products[productId]!.values.first};
    }
  }
}
