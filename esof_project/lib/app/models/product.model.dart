class Product {
  final String? name;
  final int? threshold;
  final int? quantity;

  Product({this.name, this.threshold, this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'threshold': threshold,
      'quantity': quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      threshold: json['threshold'],
      quantity: json['quantity'],
    );
  }
}
