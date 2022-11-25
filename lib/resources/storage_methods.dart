import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods{
   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    Future<String>uploadImgToStorgage (String childName, Uint8List img, bool isPost)async{

       Reference ref = firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);

       UploadTask uploadTask = ref.putData(img);

       TaskSnapshot taskSnapshot = await uploadTask;

       String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        return downloadUrl;
    }
}