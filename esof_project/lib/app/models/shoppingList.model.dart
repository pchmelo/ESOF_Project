class ShoppingList {
  final String uid;
  final String name;
  final List<Map<String, dynamic>> products;

  ShoppingList({required this.uid, required this.name, required this.products});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'products': products,
    };
  }

  static ShoppingList fromJson(Map<String, dynamic> map) {
    return ShoppingList(
      uid: map['uid'],
      name: map['name'],
      products: List<Map<String, dynamic>>.from(map['products']),
    );
  }
}
