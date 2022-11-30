import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

class AddPostScreen extends StatefulWidget{
  const AddPostScreen({super.key});
   @override 
    AddPostScreenState createState()=> AddPostScreenState();
}

class AddPostScreenState extends State<AddPostScreen>{
   @override
  Widget build(BuildContext context) {
   /* return Center(
    child:IconButton(
      onPressed:(){}, 
      icon:const Icon(
        Icons.arrow_upward_rounded,
        size:30,
      ),
    )
   );

   */

  return Scaffold(
    appBar:AppBar(
      backgroundColor:mobileBackgroundColor,
     leading:IconButton(
      icon:const Icon(Icons.arrow_back),
      onPressed:(){},
     ),
     title:const Text(
      'Post to'
     ),
     centerTitle:false,
     actions: [
      TextButton(
        onPressed:(){}, 
        child:const Text(
          'Post',style:TextStyle(fontSize:24),),
       ),
     ],
    ),
    body:Row(
      children:[
        CircleAvatar(
          radius:55,
          backgroundImage:NetworkImage(''),
        ),
        TextField()
      ]
    ),
   );
  }
}