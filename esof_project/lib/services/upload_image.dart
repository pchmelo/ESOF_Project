import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

final FirebaseStorage fb_storage = FirebaseStorage.instance;

class UploadData {
  Future<String> uploadImage(String child, Uint8List image) async {
    Reference reference = fb_storage.ref().child(child);
    UploadTask uploadTask = reference.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String download = await snapshot.ref.getDownloadURL();

    return download;
  }
}
