import 'package:flutter/material.dart';

import 'app_strem_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
    @override 
  SplashScreenState createState()=> SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{
   @override 
     void initState(){
       super.initState();
         
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {closeSplashScreen();});
     }

     closeSplashScreen(){
       Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=> const AppStreamScreen()));
     }
   @override
  Widget build(BuildContext context)=>Scaffold(
    body:Container(
       alignment:Alignment.center,
       padding:const EdgeInsets.symmetric(horizontal:32),
      child:Image.asset(
        'lib/assets/instagram-text.png',
         color:Colors.white,
        ),
    ),
  );
}