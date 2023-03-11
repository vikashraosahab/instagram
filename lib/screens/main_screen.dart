import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/mobile_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/web_layout.dart';
import 'package:instagram/screens/signin_screen.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override 
    MainScreenState createState()=> MainScreenState();
}

class MainScreenState extends State<MainScreen>{
   @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder:(context,AsyncSnapshot<User?> snap){
            if(snap.connectionState == ConnectionState.active){
               if(snap.hasData){
                  return Scaffold(
                    body:ResponsiveLayout(
                      mobileLayout:MobileLayout(), 
                      webLayout:const WebLayout()
                    )
                  );
               }else if(snap.hasError){
                 return const Scaffold(
                  body:Center(
                    child:Text('Sorry connection failled')
                  ),
                 );
               }
            }
          
          // if connection more time to connect 

          if(snap.connectionState == ConnectionState.waiting){
             return const Scaffold(
               body:Center(
                child:CircularProgressIndicator(color:Colors.white)
               ),
             );
          }
           return const SignInScreen();
        },
    );
  }
}