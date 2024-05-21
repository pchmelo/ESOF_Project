import 'package:esof_project/app/models/product.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product', () {
    test('Product constructor', () {
      var product = Product(
        id: '1',
        name: 'Product Name',
        threshold: 0,
        quantity: 0,
        barcodes: [],
        validity: false,
        notification: false,
      );

      expect(product.id, '1');
      expect(product.name, 'Product Name');
      expect(product.threshold, 0);
      expect(product.quantity, 0);
      expect(product.barcodes, []);
      expect(product.validity, false);
      expect(product.notification, false);
    });

    test('Product.withImage constructor', () {
      var product = Product.withImage(
        id: '1',
        name: 'Product Name',
        threshold: 0,
        quantity: 0,
        barcodes: [],
        validity: false,
        notification: false,
        imageURL: 'https://example.com/image.png',
      );

      expect(product.id, '1');
      expect(product.name, 'Product Name');
      expect(product.threshold, 0);
      expect(product.quantity, 0);
      expect(product.barcodes, []);
      expect(product.validity, false);
      expect(product.notification, false);
      expect(product.imageURL, 'https://example.com/image.png');
    });

    test('addBarcode', () {
      var product = Product(
        id: '1',
        name: 'Product Name',
        threshold: 0,
        quantity: 0,
        barcodes: [],
        validity: false,
        notification: false,
      );

      product.addBarcode('123456');
      expect(product.barcodes, ['123456']);
    });

    test('isBarcodeExist', () {
      var product = Product(
        id: '1',
        name: 'Product Name',
        threshold: 0,
        quantity: 0,
        barcodes: ['123456'],
        validity: false,
        notification: false,
      );

      expect(product.isBarcodeExist('123456'), true);
      expect(product.isBarcodeExist('654321'), false);
    });

    test('toggleCheckedStatus', () {
      var product = Product(
        id: '1',
        name: 'Product Name',
        threshold: 0,
        quantity: 0,
        barcodes: [],
        validity: false,
        notification: false,
      );

      product.toggleCheckedStatus();
      expect(product.checked, true);

      product.toggleCheckedStatus();
      expect(product.checked, false);
    });

    test('updateImageURL', () {
      var product = Product(
        id: '1',
        name: 'Product Name',
        threshold: 0,
        quantity: 0,
        barcodes: [],
        validity: false,
        notification: false,
      );

      product.updateImageURL('https://example.com/new_image.png');
      expect(product.imageURL, 'https://example.com/new_image.png');
    });
  });

  test('toJson', () {
    var product = Product(
      id: '1',
      name: 'Product Name',
      threshold: 0,
      quantity: 0,
      barcodes: ['123456'],
      validity: false,
      notification: false,
    );

    expect(product.toJson(), {
      'id': '1',
      'name': 'Product Name',
      'threshold': 0,
      'quantity': 0,
      'barcodes': ['123456'],
      'checked': 'false',
      'validity': 'false',
      'notification': 'false',
      'imageURL':
          'https://firebasestorage.googleapis.com/v0/b/stockoverflow2-4f45a.appspot.com/o/defaultIcon.png?alt=media&token=6915ad4e-2d6d-42de-b196-180da883f6c7',
    });
  });

  test('fromJson', () {
    var json = {
      'id': '1',
      'name': 'Product Name',
      'threshold': 0,
      'quantity': 0,
      'barcodes': ['123456'],
      'checked': 'false',
      'validity': 'false',
      'notification': 'false',
      'imageURL': 'https://example.com/image.png',
    };

    var product = Product.fromJson(json);

    expect(product.id, '1');
    expect(product.name, 'Product Name');
    expect(product.threshold, 0);
    expect(product.quantity, 0);
    expect(product.barcodes, ['123456']);
    expect(product.validity, false);
    expect(product.notification, false);
    expect(product.imageURL, 'https://example.com/image.png');
  });
}
