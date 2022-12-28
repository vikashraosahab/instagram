import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:instagram/modules/post.dart' as Modules;

import '../modules/post.dart';

class FireStoreMethods{
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

     Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profImg,
     )async{
       String result = 'Some error occupied';

        try{
          String postImage = await StorageMethods().uploadImgToStorgage('posts',file,true);
            
            Modules.Post post = Post(
              description: description, 
              uid: uid, username: username, 
              likes:[], 
              datePublished:DateTime.now(),
               postUrl: postImage, 
               postImage: profImg);

              firebaseFirestore.collection('posts').doc(
                FirebaseAuth.instance.currentUser!.uid).set(post.toJson());

          result = 'success';
            
        }catch(e){
           result = e.toString();
        }

        return result;
     }
}