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

    test(
        'sortAlphabeticallyAsc sorts products by name in ascending order and by quantity if names are the same',
        () {
      final result = productFilter.sortAlphabeticallyAsc(products);
      expect(result, [
        {'name': 'Beans', 'quantity': 2},
        {'name': 'Beans', 'quantity': 5},
        {'name': 'Peas', 'quantity': 2},
        {'name': 'Rice', 'quantity': 7},
      ]);
    });

    test(
        'sortAlphabeticallyDesc sorts products by name in descending order and by quantity if names are the same',
        () {
      final result = productFilter.sortAlphabeticallyDesc(products);
      expect(result, [
        {'name': 'Rice', 'quantity': 7},
        {'name': 'Peas', 'quantity': 2},
        {'name': 'Beans', 'quantity': 5},
        {'name': 'Beans', 'quantity': 2},
      ]);
    });

    test(
        'sortByQuantityDesc sorts products by quantity in descending order and by name if quantities are the same',
        () {
      final result = productFilter.sortByQuantityDesc(products);
      expect(result, [
        {'name': 'Rice', 'quantity': 7},
        {'name': 'Beans', 'quantity': 5},
        {'name': 'Peas', 'quantity': 2},
        {'name': 'Beans', 'quantity': 2},
      ]);
    });

    test(
        'sortByQuantityAsc sorts products by quantity in ascending order and by name if quantities are the same',
        () {
      final result = productFilter.sortByQuantityAsc(products);
      expect(result, [
        {'name': 'Beans', 'quantity': 2},
        {'name': 'Peas', 'quantity': 2},
        {'name': 'Beans', 'quantity': 5},
        {'name': 'Rice', 'quantity': 7},
      ]);
    });
  });

  group('ValidityFilter', () {
    final validityFilter = ValidityFilter();
    final validities = [
      {'name': 'Beans', 'quantity': 5, 'year': 2023, 'month': 5, 'day': 20},
      {'name': 'Peas', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 21},
      {'name': 'Rice', 'quantity': 7, 'year': 2023, 'month': 5, 'day': 22},
      {'name': 'Beans', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 23},
    ];

    test('emptyFilter returns the same list', () {
      final result = validityFilter.emptyFilter(validities);
      expect(result, validities);
    });

    test(
        'sortAlphabeticallyAsc sorts validities by name in ascending order and by quantity if names are the same',
        () {
      final result = validityFilter.sortAlphabeticallyAsc(validities);
      expect(result, [
        {'name': 'Beans', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 23},
        {'name': 'Beans', 'quantity': 5, 'year': 2023, 'month': 5, 'day': 20},
        {'name': 'Peas', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 21},
        {'name': 'Rice', 'quantity': 7, 'year': 2023, 'month': 5, 'day': 22},
      ]);
    });

    test(
        'sortAlphabeticallyDesc sorts validities by name in descending order and by quantity if names are the same',
        () {
      final result = validityFilter.sortAlphabeticallyDesc(validities);
      expect(result, [
        {'name': 'Rice', 'quantity': 7, 'year': 2023, 'month': 5, 'day': 22},
        {'name': 'Peas', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 21},
        {'name': 'Beans', 'quantity': 5, 'year': 2023, 'month': 5, 'day': 20},
        {'name': 'Beans', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 23},
      ]);
    });

    test(
        'sortByQuantityDesc sorts validities by quantity in descending order and by name if quantities are the same',
        () {
      final result = validityFilter.sortByQuantityDesc(validities);
      expect(result, [
        {'name': 'Rice', 'quantity': 7, 'year': 2023, 'month': 5, 'day': 22},
        {'name': 'Beans', 'quantity': 5, 'year': 2023, 'month': 5, 'day': 20},
        {'name': 'Peas', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 21},
        {'name': 'Beans', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 23},
      ]);
    });

    test(
        'sortByQuantityAsc sorts validities by quantity in ascending order and by name if quantities are the same',
        () {
      final result = validityFilter.sortByQuantityAsc(validities);
      expect(result, [
        {'name': 'Beans', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 23},
        {'name': 'Peas', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 21},
        {'name': 'Beans', 'quantity': 5, 'year': 2023, 'month': 5, 'day': 20},
        {'name': 'Rice', 'quantity': 7, 'year': 2023, 'month': 5, 'day': 22},
      ]);
    });

    test('sortByValidityDateAsc sorts validities by date in ascending order',
        () {
      final result = validityFilter.sortByValidityDateAsc(validities);
      expect(result, [
        {'name': 'Beans', 'quantity': 5, 'year': 2023, 'month': 5, 'day': 20},
        {'name': 'Peas', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 21},
        {'name': 'Rice', 'quantity': 7, 'year': 2023, 'month': 5, 'day': 22},
        {'name': 'Beans', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 23},
      ]);
    });

    test('sortByValidityDateDesc sorts validities by date in descending order',
        () {
      final result = validityFilter.sortByValidityDateDesc(validities);
      expect(result, [
        {'name': 'Beans', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 23},
        {'name': 'Rice', 'quantity': 7, 'year': 2023, 'month': 5, 'day': 22},
        {'name': 'Peas', 'quantity': 2, 'year': 2023, 'month': 5, 'day': 21},
        {'name': 'Beans', 'quantity': 5, 'year': 2023, 'month': 5, 'day': 20},
      ]);
    });
  });
}
