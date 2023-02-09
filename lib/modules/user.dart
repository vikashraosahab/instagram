import 'dart:typed_data';

import 'package:flutter/material.dart';

class User{
  final String name;
  final String email;
  final String password;
  final String username;
  final Uint8List? image;

   User({
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    required this.image,
   });

  Map <String,dynamic> toJson()=>{
     "name":name,
     "email":email,
     "password":password,
     'username':username,
     'photoUrl':image,
  };
}