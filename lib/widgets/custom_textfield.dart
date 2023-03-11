import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
 TextEditingController textEditingController;
  String hintText;
  bool ispass;
  TextInputType textInputType;
  
  CustomTextField({super.key, 
  required this.textEditingController, 
  required this.hintText,
  required this.ispass,
  required this.textInputType,
  });
   @override 
    Widget build(BuildContext context) {
      final inputBorder = OutlineInputBorder(
        borderSide:Divider.createBorderSide(context),
      );
     return TextField(
         controller:textEditingController,
         decoration:InputDecoration(
          hintText:hintText,
          border:inputBorder,
          focusedBorder:inputBorder,
          errorBorder:inputBorder,
          filled:true,
          contentPadding:const EdgeInsets.all(16),
          
         ),
        obscureText:ispass,
        keyboardType:textInputType,
        
     );
  }
}