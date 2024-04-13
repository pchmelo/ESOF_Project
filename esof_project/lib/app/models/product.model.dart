import 'package:uuid/uuid.dart';

class Product {
  final String? id;
  final String? name;
  final int? threshold;
  final int? quantity;

  Product({this.id, this.name, this.threshold, this.quantity});

  void main() {
    var uuid = const Uuid();
    Product product = Product(
      id: uuid.v4(), // Generate a unique ID for this product
      name: 'Product Name',
      threshold: 10,
      quantity: 20,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'threshold': threshold,
      'quantity': quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      threshold: json['threshold'],
      quantity: json['quantity'],
    );
  }
}
