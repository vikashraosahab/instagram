
import 'package:flutter/material.dart';

class User{
  final String uid;
  final String name;
  final String email;
  final String password;
  final String username;
  final String image;

   User({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    required this.image,
   });

  Map <String,dynamic> toJson()=>{
     "uid":uid,
     "name":name,
     "email":email,
     "password":password,
     'username':username,
     'photoUrl':image,
  };
}