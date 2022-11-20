import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/mobile_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/web_layout.dart';
import 'package:instagram/screens/main_screen.dart';

import 'login_screen.dart';

class AppStreamScreen extends StatefulWidget{
  const AppStreamScreen({super.key});
   @override
     AppStreamScreenState createState()=> AppStreamScreenState();
}

class AppStreamScreenState extends State<AppStreamScreen>{
   @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:FirebaseAuth.instance.authStateChanges(),
      builder:(BuildContext context, AsyncSnapshot<User?> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          // this work when your connection is active with firebase 
           if(snapshot.hasData){
             return  const ResponsiveLayout(
              mobileLayout:MobileLayout(),
              webLayout:WebLayout(),
             );
           }else if(snapshot.hasError){
             return Center(
              child:Text(snapshot.hasError.toString()
              ));
           }
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child:CircularProgressIndicator(),
          );
        }
        return const LogInScreen();
      },
    );
  }
}