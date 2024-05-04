import 'package:esof_project/app/models/product.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductModel', () {
    final product = Product(
      id: '1',
      name: 'Beans',
      threshold: 0,
      quantity: 0,
      barcodes: ['0123456789', '9876543210'],
      validity: false,
      notification: false,
    );

    test('addBarcode adds a barcode to the product', () {
      product.addBarcode('1032547698');
      expect(product.barcodes, ['0123456789', '9876543210', '1032547698']);
    });

    test('isBarcodeExist returns true if barcode exists', () {
      expect(product.isBarcodeExist('0123456789'), true);
    });

    test('isBarcodeExist returns false if barcode does not exist', () {
      expect(product.isBarcodeExist('0000000000'), false);
    });

    test('toggleCheckedStatus toggles the checked status of the product', () {
      product.toggleCheckedStatus();
      expect(product.checked, true);
    });

    test('toJson returns a map representation of the product', () {
      expect(product.toJson(), {
        'id': '1',
        'name': 'Beans',
        'threshold': 0,
        'quantity': 0,
        'barcodes': ['0123456789', '9876543210', '1032547698'],
        'checked': 'true',
        'validity': 'false',
      });
    });

    test('Product.fromJson creates a product from a map', () {
      var productFromJson = Product.fromJson({
        'id': '2',
        'name': 'Peas',
        'threshold': 10,
        'quantity': 20,
        'barcodes': ['012349765'],
        'checked': 'false',
        'validity': 'true',
      });

      expect(productFromJson.id, '2');
      expect(productFromJson.name, 'Peas');
      expect(productFromJson.threshold, 10);
      expect(productFromJson.quantity, 20);
      expect(productFromJson.barcodes, ['012349765']);
      expect(productFromJson.checked, false);
      expect(productFromJson.validity, true);
    });
  });
}
