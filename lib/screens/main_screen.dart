import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:GestureDetector(
          onTap:()async{
           await AuthMethods().signOut();
          },
          child:Text(
            'Sign Out'
          ),
        ),
      ),
    );
  }
}