import 'package:esof_project/app/models/validity.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validity', () {
    test('Validity default constructor', () {
      var validity = Validity();
      var now = DateTime.now();

      expect(validity.name, 'default');
      expect(validity.uid, 'default');
      expect(validity.productId, 'default');
      expect(validity.quantity, 0);
      expect(validity.day, now.day);
      expect(validity.month, now.month);
      expect(validity.year, now.year);
    });

    test('Validity.withValues constructor', () {
      var validity = Validity.withValues('Beans', '1', '1',
          quantity: 5, day: 20, month: 5, year: 2023);

      expect(validity.name, 'Beans');
      expect(validity.uid, '1');
      expect(validity.productId, '1');
      expect(validity.quantity, 5);
      expect(validity.day, 20);
      expect(validity.month, 5);
      expect(validity.year, 2023);
    });

    test('toJson', () {
      var validity = Validity.withValues('Beans', '1', '1',
          quantity: 5, day: 20, month: 5, year: 2023);

      expect(validity.toJson(), {
        'name': 'Beans',
        'uid': '1',
        'productId': '1',
        'quantity': 5,
        'day': 20,
        'month': 5,
        'year': 2023,
      });
    });

    test('fromJson', () {
      var json = {
        'name': 'Beans',
        'uid': '1',
        'productId': '1',
        'quantity': 5,
        'day': 20,
        'month': 5,
        'year': 2023,
      };

      var validity = Validity.fromJson(json);

      expect(validity.name, 'Beans');
      expect(validity.uid, '1');
      expect(validity.productId, '1');
      expect(validity.quantity, 5);
      expect(validity.day, 20);
      expect(validity.month, 5);
      expect(validity.year, 2023);
    });
  });

  group('ValidityNotifier', () {
    test('updateValue', () {
      var validity = Validity.withValues('Beans', '1', '1',
          quantity: 5, day: 20, month: 5, year: 2023);
      var validityNotifier = ValidityNotifier(validity);

      var newValue = Validity.withValues('Rice', '2', '2',
          quantity: 7, day: 22, month: 5, year: 2023);
      validityNotifier.updateValue(newValue);

      expect(validityNotifier.value, newValue);
    });
  });
}
