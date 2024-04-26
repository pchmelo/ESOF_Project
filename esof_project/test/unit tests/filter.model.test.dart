import 'package:esof_project/app/shared/filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductFilter', () {
    final productFilter = ProductFilter();
    final products = [
      {'name': 'Beans', 'quantity': 5},
      {'name': 'Peas', 'quantity': 2},
      {'name': 'Rice', 'quantity': 7},
      {'name': 'Beans', 'quantity': 2},
    ];

    test('emptyFilter returns the same list', () {
      final result = productFilter.emptyFilter(products);
      expect(result, products);
    });

    test('sortAlphabeticallyAsc sorts products by name in ascending order and by quantity if names are the same', () {
      final result = productFilter.sortAlphabeticallyAsc(products);
      expect(result, [
        {'name': 'Beans', 'quantity': 2},
        {'name': 'Beans', 'quantity': 5},
        {'name': 'Peas', 'quantity': 2},
        {'name': 'Rice', 'quantity': 7},
      ]);
    });

    test('sortAlphabeticallyDesc sorts products by name in descending order and by quantity if names are the same', () {
      final result = productFilter.sortAlphabeticallyDesc(products);
      expect(result, [
        {'name': 'Rice', 'quantity': 7},
        {'name': 'Peas', 'quantity': 2},
        {'name': 'Beans', 'quantity': 5},
        {'name': 'Beans', 'quantity': 2},
      ]);
    });

    test('sortByQuantityDesc sorts products by quantity in descending order and by name if quantities are the same', () {
      final result = productFilter.sortByQuantityDesc(products);
      expect(result, [
        {'name': 'Rice', 'quantity': 7},
        {'name': 'Beans', 'quantity': 5},
        {'name': 'Peas', 'quantity': 2},
        {'name': 'Beans', 'quantity': 2},
      ]);
    });

    test('sortByQuantityAsc sorts products by quantity in ascending order and by name if quantities are the same', () {
      final result = productFilter.sortByQuantityAsc(products);
      expect(result, [
        {'name': 'Beans', 'quantity': 2},
        {'name': 'Peas', 'quantity': 2},
        {'name': 'Beans', 'quantity': 5},
        {'name': 'Rice', 'quantity': 7},
      ]);
    });
  });
}