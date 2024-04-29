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
    try {
      await validityCollection
          .doc(uid)
          .collection('validity')
          .doc(validityId)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateValidity(Validity validity) async {
    await validityCollection
        .doc(uid)
        .collection('validity')
        .doc(validity.uid)
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

  Stream<List<Validity>> getAllValiditiesOfProductStream(String productId) {
    return validityCollection
        .doc(uid)
        .collection('validity')
        .where('productId', isEqualTo: productId)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Validity.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
