import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/modules/user.dart' as Modules;

class AuthMethods{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // this is getting user details from firebase
  // this is only use for get user details from database
  // this is connect with provider refresh function and ChangeNotifier
    
    // this is used for sign or register new user account on the application database 
  Future<String> signUpUser({
       required String name,
       required String email,
       required String username,
       required String password,
       required Uint8List? file,
    })async{
      String result = 'Email address is already sign Up';
       try{
         if(
          name.isNotEmpty || 
          email.isNotEmpty || 
          username.isNotEmpty || 
          password.isNotEmpty ||
          file !=null
          ){
            
            UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
            
            Modules.User users =Modules.User(
              userId:cred.user!.uid,
              name:name,
              email:email,
              username:username,
              password:password,
              photoUrl:file.toString(),
              followers:[],
              following:[],


            );

            await firebaseFirestore.collection('userCollection').doc(cred.user!.uid).set(
              users.toJson(),
            );
           result ='success';
         }else{
          result ='Please filled all fields';
         }
       }catch(e){
           print(e.toString());
       }
      return result;
    }

// this is sign In page authentication with old password and email of user
  Future<String> signInUser({
      required String email,
      required String password,
    })async{
      // this is when user want log in with old email and password
      
     String result ='This email address is in-valid';
      try{
        if(
          email.isNotEmpty ||
          password.isNotEmpty
        ){
          await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          
          result ='success';
        }else{
           result = 'Please fill your all fields';
        }
      }catch(e){
        print(e.toString());
      }
       
       return result;
    }

    // this singout functionality for signout from current account 

     Future<void> signOut()async{
        await firebaseAuth.signOut();
     }
}