import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShoppingListModel', () {
    final shoppingList = ShoppingList(
      uid: '1',
      name: 'Queima das fitas',
      products: {'idVodka': {1: true}, 'idSalGrosso': {2: false}},
    );

    test('toJson returns correct map representation', () {
      final result = shoppingList.toJson();
      expect(result, {
        'uid': '1',
        'name': 'Queima das fitas',
        'products': {'idVodka': {'1': true}, 'idSalGrosso': {'2': false}},
      });
    });

    test('fromJson creates a shopping list from a map', () {
      var shoppingListFromJson = ShoppingList.fromJson({
        'uid': '2',
        'name': 'Pool Party',
        'products': {'idRibs': {'3' : true}, 'idBBQSauce': {'4' : false}},
      });

      expect(shoppingListFromJson.uid, '2');
      expect(shoppingListFromJson.name, 'Pool Party');
      expect(shoppingListFromJson.products, {'idRibs': {3 : true}, 'idBBQSauce': {4 : false}});
    });

    test('updateProductQuantity updates the quantity of a product', () {
      shoppingList.updateProductQuantity('idVodka', 5);
      expect(shoppingList.products, {'idVodka': {5: true}, 'idSalGrosso': {2: false}});
    });

    test('removeProduct removes a product from the list', () {
      shoppingList.removeProduct('idVodka');
      expect(shoppingList.products, {'idSalGrosso': {2: false}});
    });

    test('updateProducts updates the products in the list', () {
      shoppingList.updateProducts({'product5': {5: true}});
      expect(shoppingList.products, {'product5': {5: true}});
    });
  });
}