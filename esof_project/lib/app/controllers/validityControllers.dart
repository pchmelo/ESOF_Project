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

  Future<void> CreateValidity(String productId, int quantity, int day,
      int month, int year, String name) async {
    isLoading.value = true;
    Validity validity = Validity.withValues(
      name,
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

  Future<void> deleteValidity(String validityId) async {
    isLoading.value = true;
    await dbService.deleteValidity(validityId);
    isLoading.value = false;
  }

  Future<void> deleteAllValiditiesOfProduct(String productId) async {
    isLoading.value = true;
    List<Validity> validities =
        await dbService.getAllValiditiesOfProduct(productId);
    for (Validity validity in validities) {
      await dbService.deleteValidity(validity.uid);
    }
    validities = await dbService.getAllValiditiesOfProduct(productId);

    isLoading.value = false;
  }

  Future<List<Validity>> fetchAllValidities() async {
    isLoading.value = true;
    List<Validity> validities = await dbService.getAllValidities();
    isLoading.value = false;
    return validities;
  }
}
