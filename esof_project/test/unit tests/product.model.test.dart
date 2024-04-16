import 'package:esof_project/app/models/product.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product Model Tests', () {
    test('Product constructor and toJson test', () {
      // Arrange
      final expectedId = 'test-id';
      final expectedName = 'Test Product';
      final expectedThreshold = 10;
      final expectedQuantity = 20;
      final expectedBarcodes = ['1234567890'];

      // Act
      final product = Product(
        id: expectedId,
        name: expectedName,
        threshold: expectedThreshold,
        quantity: expectedQuantity,
        barcodes: expectedBarcodes,
      );

      // Assert
      expect(product.id, expectedId);
      expect(product.name, expectedName);
      expect(product.threshold, expectedThreshold);
      expect(product.quantity, expectedQuantity);
      expect(product.barcodes, expectedBarcodes);

      // Convert the product to JSON and validate the result
      final productJson = product.toJson();
      expect(productJson['id'], expectedId);
      expect(productJson['name'], expectedName);
      expect(productJson['threshold'], expectedThreshold);
      expect(productJson['quantity'], expectedQuantity);
      expect(productJson['barcodes'], expectedBarcodes);
    });

    test('Product fromJson test', () {
      // Arrange
      final json = {
        'id': 'test-id',
        'name': 'Test Product',
        'threshold': 10,
        'quantity': 20,
        'barcodes': ['1234567890'],
      };

      // Act
      final product = Product.fromJson(json);

      // Assert
      expect(product.id, json['id']);
      expect(product.name, json['name']);
      expect(product.threshold, json['threshold']);
      expect(product.quantity, json['quantity']);
      expect(product.barcodes, json['barcodes']);
    });

    test('Product addBarcode and isBarcodeExist test', () {
      // Arrange
      final barcode = '1234567890';
      final product = Product(
        id: 'test-id',
        name: 'Test Product',
        threshold: 10,
        quantity: 20,
        barcodes: [],
      );

      // Act
      product.addBarcode(barcode);

      // Assert
      expect(product.isBarcodeExist(barcode), true);
    });
  });
}
