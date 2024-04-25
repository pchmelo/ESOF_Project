import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esof_project/app/models/validity.model.dart';

class DatabaseForValidity {
  final CollectionReference validityCollection =
      FirebaseFirestore.instance.collection('users');

  final String uid;
  DatabaseForValidity({required this.uid});

  Future<void> createValidity(Validity validity) async {
    await validityCollection
        .doc(uid)
        .collection('validity')
        .doc(validity.uid)
        .set(validity.toJson());
  }

  Future<void> deleteValidity(String validityId) async {
    await validityCollection
        .doc(uid)
        .collection('validity')
        .doc(validityId)
        .delete();
  }

  Future<void> updateValidity(String validityId, Validity validity) async {
    await validityCollection
        .doc(uid)
        .collection('validity')
        .doc(validityId)
        .update(validity.toJson());
  }

  Future<Validity> getValidity(String validityId) async {
    DocumentSnapshot doc = await validityCollection
        .doc(uid)
        .collection('validity')
        .doc(validityId)
        .get();
    return Validity.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<List<Validity>> getAllValidities() async {
    QuerySnapshot querySnapshot =
        await validityCollection.doc(uid).collection('validity').get();

    return querySnapshot.docs.map((doc) {
      return Validity.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Validity>> getAllValiditiesOfProduct(String productId) async {
    QuerySnapshot querySnapshot = await validityCollection
        .doc(uid)
        .collection('validity')
        .where('productId', isEqualTo: productId)
        .get();

    return querySnapshot.docs.map((doc) {
      return Validity.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
