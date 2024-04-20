import 'package:esof_project/app/models/shoppingList.model.dart';
import 'package:esof_project/services/database_shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ShoppingListControllers {
  late DatabaseForShoppingList dbService;
  late User user;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  ShoppingListControllers(
      [DatabaseForShoppingList? dbServiceParam, User? userParam]) {
    user = userParam ?? FirebaseAuth.instance.currentUser!;
    dbService = dbServiceParam ?? DatabaseForShoppingList(uid: user.uid);
  }

  Future<void> CreateProduct(context, _name) async {
    isLoading.value = true;
    ShoppingList shoppingList = ShoppingList(
      uid: const Uuid().v4(),
      name: _name,
      products: [],
    );
    await dbService.createShoppingList(user.uid, shoppingList);
    Navigator.pop(context);
    isLoading.value = false;
  }
}
