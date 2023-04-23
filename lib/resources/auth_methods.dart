import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../modules/user.dart' as Module;
import '../modules/post.dart' as Module;
import '../resources/storage_methods.dart';

class AuthMethods{
   final FirebaseAuth auth = FirebaseAuth.instance;
   final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
     
     // this is for new signUpUser
     // singUpUser have used for that new user sign our applications
     // this is take name ,id , username , email  , password etc
      Future<String> signUpUser({
        required String name,
        required String email,
        required String password,
        required String username,
        required Uint8List photoUrl,
      })async {
        String result ='Something error occupied';
        try{
          
          if(name.isNotEmpty || email.isNotEmpty || password.isNotEmpty || photoUrl != null){
             UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
            String images = await StorageMethods().uploadImage('profilepics',photoUrl,false);

             Module.User user = Module.User(
              uid:cred.user!.uid,
              name:name, 
              email: email, 
              password: password, 
              username: username,
              image:images,
            );

             await firebaseFirestore.collection('user').doc(auth.currentUser!.uid).set(user.toJson());
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

  // signInUser have used for signIn our old user that have i account in our app
  // its have connected with firebase methods

   Future<String> signInUser({
    required String email,
    required String password,
   }) async{
      String result = 'Something wrong with the application';
      try{
        if(email.isNotEmpty || password.isNotEmpty){
            auth.signInWithEmailAndPassword(
            email: email, 
            password: password
          );

          result = 'Success';
        }else{
          result = 'Please fill all your fields';
        }
      } catch(e){
        print(e.toString());
      }
      return result;
   }

  // signOutUser for sign out current user from firebase
  // it help to log out data from firebase firestore 
   Future<void> signOutUser()async{
     await auth.signOut();
   }

}

