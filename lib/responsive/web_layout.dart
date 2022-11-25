import 'package:flutter/material.dart';

class WebLayout extends StatefulWidget{
  const WebLayout({super.key});
   @override 
    WebLayoutState createState()=> WebLayoutState();
}

class WebLayoutState extends State<WebLayout>{
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Image.asset(
          'lib/assets/instagram-text.png',
          height:32,
       ),
        actions: [
          IconButton(
            onPressed:(){}, 
            icon:Icon(
              Icons.home,
            ),
           ),
           IconButton(
            onPressed:(){}, 
            icon:Icon(
              Icons.home,
            ),
           ),
           IconButton(
            onPressed:(){}, 
            icon:Icon(
              Icons.home,
            ),
           ),
           IconButton(
            onPressed:(){}, 
            icon:Icon(
              Icons.home,
            ),
           ),
           IconButton(
            onPressed:(){}, 
            icon:Icon(
              Icons.home,
            ),
           )
        ],
      ),
      body:Center(
        child:Text('This is web layout'),
      ),
    );
  }
}