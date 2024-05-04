import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String name;
  final int? threshold;
  final int? quantity;
  final List<String>? barcodes;
  bool checked;
  final bool validity;
  final bool notification;
  String imageURL;

  Product({
    required this.id,
    required this.name,
    this.threshold,
    this.quantity,
    this.barcodes,
    this.checked = false,
    required this.validity,
    required this.notification,
    this.imageURL = 'https://firebasestorage.googleapis.com/v0/b/stockoverflow2-4f45a.appspot.com/o/defaultIcon.png?alt=media&token=6915ad4e-2d6d-42de-b196-180da883f6c7',
  });

  Product.withImage({
    required this.id,
    required this.name,
    this.threshold,
    this.quantity,
    this.barcodes,
    this.checked = false,
    required this.validity,
    required this.notification,
    required this.imageURL,
  });

  void main() {
    var uuid = const Uuid();
    Product product = Product(
      id: uuid.v4(), // Generate a unique ID for this product
      name: 'Product Name',
      threshold: 0,
      quantity: 0,
      barcodes: [],
      validity: false,
      checked: false, notification: false,
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
      'validity': validity ? 'true' : 'false',
      'notification': notification ? 'true' : 'false',
      'imageURL': imageURL,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product.withImage(
      id: json['id'],
      name: json['name'],
      threshold: json['threshold'],
      quantity: json['quantity'],
      barcodes: List<String>.from(json['barcodes']),
      validity: json['validity'] == 'true',
      checked: json['checked'] == 'true',
      notification: json['notification'] == 'true',
      imageURL: json['imageURL'],
    );
  }

  void toggleCheckedStatus() {
    checked = !checked;
  }

  void updateImageURL(String url) {
    imageURL = url;
  }
}
