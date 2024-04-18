import 'package:esof_project/services/database_list_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../services/database_product.dart';

class ShoppingListControllers {
  late DatabaseForProducts dbService;
  late User user;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  ProductControllers([DatabaseForProducts? dbServiceParam, User? userParam]) {
    user = userParam ?? FirebaseAuth.instance.currentUser!;
    dbService = dbServiceParam ?? DatabaseForListProduct(uid: user.uid);
  }
}
