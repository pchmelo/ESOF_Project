import 'package:esof_project/app/models/product.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product Model Tests', () {
    test('Product to Json test', () {
      const expectedId = 'test-id';
      const expectedName = 'Test Product';
      const expectedThreshold = 10;
      const expectedQuantity = 20;
      final expectedBarcodes = ['1234567890'];

      final product = Product(
        id: expectedId,
        name: expectedName,
        threshold: expectedThreshold,
        quantity: expectedQuantity,
        barcodes: expectedBarcodes,
      );

      expect(product.id, expectedId);
      expect(product.name, expectedName);
      expect(product.threshold, expectedThreshold);
      expect(product.quantity, expectedQuantity);
      expect(product.barcodes, expectedBarcodes);

      final productJson = product.toJson();
      expect(productJson['id'], expectedId);
      expect(productJson['name'], expectedName);
      expect(productJson['threshold'], expectedThreshold);
      expect(productJson['quantity'], expectedQuantity);
      expect(productJson['barcodes'], expectedBarcodes);
    });

    test('Json to Product test', () {
      final json = {
        'id': 'test-id',
        'name': 'Test Product',
        'threshold': 10,
        'quantity': 20,
        'barcodes': ['1234567890'],
      };

      final product = Product.fromJson(json);

      expect(product.id, json['id']);
      expect(product.name, json['name']);
      expect(product.threshold, json['threshold']);
      expect(product.quantity, json['quantity']);
      expect(product.barcodes, json['barcodes']);
    });

    test('Add var code to a Product test', () {
      const barcode = '1234567890';
      final product = Product(
        id: 'test-id',
        name: 'Test Product',
        threshold: 10,
        quantity: 20,
        barcodes: [],
      );

      product.addBarcode(barcode);

      expect(product.isBarcodeExist(barcode), true);
    });
  });
}
