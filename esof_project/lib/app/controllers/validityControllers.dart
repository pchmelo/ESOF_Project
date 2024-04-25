import 'package:esof_project/app/models/validity.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../services/database_validity.dart';

class ValidityController {
  late User user;
  late DatabaseForValidity dbService;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  ValidityController([DatabaseForValidity? dbServiceParam, User? userParam]) {
    user = userParam ?? FirebaseAuth.instance.currentUser!;
    dbService = dbServiceParam ?? DatabaseForValidity(uid: user.uid);
  }

  Future<void> CreateValidity(
      String productId, int quantity, int day, int month, int year) async {
    isLoading.value = true;
    Validity validity = Validity(
      productId,
      const Uuid().v4(),
      quantity: quantity,
      day: day,
      month: month,
      year: year,
    );
    await dbService.createValidity(validity);
    isLoading.value = false;
  }
}
