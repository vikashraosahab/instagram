import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/screens/main_screen.dart';
import 'package:instagram/screens/signin_screen.dart';
import 'package:instagram/screens/signup_screen.dart';
import './utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
     await Firebase.initializeApp(
    options:const FirebaseOptions(
      apiKey: "AIzaSyAiSkVC4CQAYBmQ7gQIyq3yw9XBFNjdb1I",
      authDomain: "instagram-7dbe0.firebaseapp.com",
      projectId: "instagram-7dbe0",
      storageBucket: "instagram-7dbe0.appspot.com",
      messagingSenderId: "971264024565",
      appId: "1:971264024565:web:8825e56dff2c8b0c27cabc"
   ));
  }else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Instagram',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:mobileBackgroundColor,
      ),
      routes:{
        SignInScreen.routeName:(ctx)=> const SignInScreen(),
        SignUpScreen.routeName:(ctx)=> const SignUpScreen(),
      },
      home:const MainScreen(),
    );
  }
}


