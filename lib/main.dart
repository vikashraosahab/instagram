import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/screens/signin_screen.dart';
import 'package:instagram/screens/signup_screen.dart';
import './utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
     await Firebase.initializeApp(
    options:const FirebaseOptions(
    apiKey: "AIzaSyDreiOkr9XleOMfZV7Qg6DEd4NmcvA9ZDE",
    authDomain: "instagram-d7ede.firebaseapp.com",
    projectId: "instagram-d7ede",
    storageBucket: "instagram-d7ede.appspot.com",
    messagingSenderId: "644650106948",
    appId: "1:644650106948:web:7212689dd8a39f350bbc11"
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
      theme: ThemeData(
        scaffoldBackgroundColor:mobileBackgroundColor,
      ),
      routes:{
        SignInScreen.routeName:(ctx)=> const SignInScreen(),
        SignUpScreen.routeName:(ctx)=> const SignUpScreen(),
      },
      home:const SignUpScreen(),
    );
  }
}


