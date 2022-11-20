import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/screens/splash_screen.dart';
import 'package:instagram/utils/colors.dart';


void main() async{ 
   WidgetsFlutterBinding.ensureInitialized();
    if(kIsWeb){
      // this is for web application
      // this only work when your screen is not a mobile or other small screens
      await Firebase.initializeApp(
        options:const FirebaseOptions(
          apiKey:"AIzaSyBeT5bNNalwHZBwax9Xc4LlaWjFQVPDy4g", 
          appId:"1:606237185103:web:1406c96bc83c68a36ec63a",
          messagingSenderId:"606237185103",
          projectId:"instagram-ed76e",
        ),
      );
    }else {
      // this work when your screen size is a mobile or other small screens
       await Firebase.initializeApp();
    }
   runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  // this is your root widget of the application
   const MyApp({super.key});
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:ThemeData.dark().copyWith(
        scaffoldBackgroundColor:backGroundColor,
      ),
      home:const SplashScreen(),
      routes:{
        SignUpScreen.routeName:(context)=> const SignUpScreen(),
        LogInScreen.routeName:(context) => const  LogInScreen(),
      },
    );
  }
}