import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final FirebaseStorage fb_storage = FirebaseStorage.instance;
final FirebaseFirestore fb_firestore = FirebaseFirestore.instance;

class UploadData{
  Future<String> uploadImage(String child, Uint8List image) async{
    Reference reference = fb_storage.ref().child(child);
    UploadTask uploadTask = reference.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String download = await snapshot.ref.getDownloadURL();

    return download;
  }

  Future<String> saveImage({required Uint8List image}) async{
    String response = "An error occurred while uploading the image";
    try{
      String iconUrl = await uploadImage('ProductIcon', image);

      await fb_firestore.collection('ProductIcon').add({
        'iconUrl': iconUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      response = "Image uploaded successfully";
    }
        catch(error){
          response = error.toString();
        }
        return response;
  }
}
