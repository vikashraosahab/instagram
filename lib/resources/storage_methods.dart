import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods{
   final FirebaseAuth auth = FirebaseAuth.instance;
   final FirebaseStorage storage = FirebaseStorage.instance;

   Future<String>uploadImage(String name, Uint8List image, bool isPost) async {
         Reference ref = storage.ref().child(name).child(auth.currentUser!.uid);

         TaskSnapshot snapshot = await ref.putData(image);
         String downloadUrl =await snapshot.ref.getDownloadURL();
         return downloadUrl;
      }
}