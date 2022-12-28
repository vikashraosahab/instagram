import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/screens/home_screen.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/screens/splash_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';



void main() async{ 
   WidgetsFlutterBinding.ensureInitialized();
    if(kIsWeb){
      // this is for web application
      // this only work when your screen is not a mobile or other small screens
      await Firebase.initializeApp(
        options:const FirebaseOptions(
          apiKey: "AIzaSyA0JHTG-XfBplBvuAAbDFjidJUHIYWJOgA",
          authDomain: "instagram-4fbd7.firebaseapp.com",
          projectId: "instagram-4fbd7",
          storageBucket: "instagram-4fbd7.appspot.com",
          messagingSenderId: "851828105395",
          appId: "1:851828105395:web:a613328cbd7d13742950c6"
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
    return MultiProvider(
      providers:[
       ChangeNotifierProvider(
        create:((context) => UserProvider())),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:ThemeData.dark().copyWith(
        scaffoldBackgroundColor:mobileBackgroundColor,
      ),
      home:const SplashScreen(),
      routes:{
        SignUpScreen.routeName:(context)=> const SignUpScreen(),
        LogInScreen.routeName:(context) => const LogInScreen(),
        HomeScreen.routeName:(context) => const HomeScreen(),
      },
    ));
  }
}