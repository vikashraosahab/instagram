import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../modules/user.dart' as Module;
class AuthMethods{
   final FirebaseAuth auth = FirebaseAuth.instance;
   final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
     
     // this is for new signUpUser
      Future<String> signUpUser({
        required String name,
        required String email,
        required String password,
        required String username,
        required Uint8List? photoUrl,
      })async {
        String result ='Something error occupied';
        try{
          
          if(name.isNotEmpty || email.isNotEmpty || password.isNotEmpty){
             auth.createUserWithEmailAndPassword(email: email, password: password);

             Module.User user = Module.User(
              name:name, 
              email: email, 
              password: password, 
              username: username,
              image:photoUrl,
            );
             firebaseFirestore.collection('user').doc(auth.currentUser!.uid).set(user.toJson());
             result ='Success';
          }else{
            print(result);
          }
          result ='Please enter your valid fields';
        }catch(e){
          print(e);
        }

        return result;
      }
}