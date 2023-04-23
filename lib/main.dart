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
      apiKey: "AIzaSyDONvLsI7diTQ9EWVfgn_dvFQyhhUpDoPI",
      authDomain: "instagramclone-c9fae.firebaseapp.com",
      projectId: "instagramclone-c9fae",
      storageBucket: "instagramclone-c9fae.appspot.com",
      messagingSenderId: "328840119095",
      appId: "1:328840119095:web:50de4835a235d6474290b2"
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


