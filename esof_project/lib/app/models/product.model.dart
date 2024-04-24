import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String? name;
  final int? threshold;
  final int? quantity;
  final List<String>? barcodes;
  bool checked;

  Product(
      {required this.id,
      this.name,
      this.threshold,
      this.quantity,
      this.barcodes,
      this.checked = false});

  void main() {
    var uuid = const Uuid();
    Product product = Product(
      id: uuid.v4(), // Generate a unique ID for this product
      name: 'Product Name',
      threshold: 0,
      quantity: 0,
      barcodes: [],
      checked: false,
    );
  }

  void addBarcode(String barcode) {
    barcodes!.add(barcode);
  }

  bool isBarcodeExist(String barcode) {
    return barcodes!.contains(barcode);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'threshold': threshold,
      'quantity': quantity,
      'barcodes': barcodes,
      'checked': checked ? 'true' : 'false',
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      threshold: json['threshold'],
      quantity: json['quantity'],
      barcodes: List<String>.from(json['barcodes']),
      checked: json['checked'] == 'true',
    );
  }

  void toggleCheckedStatus() {
    checked = !checked;
  }
}
