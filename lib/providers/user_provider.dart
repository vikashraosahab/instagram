import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
   
    User? _user;

   final AuthMethods authMethods = AuthMethods();

    User get getUser=> _user!;

     Future<void> refreshUser() async{
         User user = await authMethods.getUserDetails() as User;

          _user=user;

          notifyListeners();
     }

}