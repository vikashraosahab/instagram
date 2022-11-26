import 'package:flutter/material.dart';

class TextTypeInput extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  bool isPass;

     TextTypeInput({
      Key ? key, 
      required this.controller, 
      required this.hintText,
      required this.textInputType,
      required this.isPass,
    }):super(key:key);
  @override
  Widget build(BuildContext context) {
   final inputBorder = OutlineInputBorder(
    borderSide:Divider.createBorderSide(context),
   );
    return TextField(
      controller:controller,
      decoration:InputDecoration(
        hintText:hintText,
        filled:true,
        border:inputBorder,
        enabledBorder:inputBorder,
        focusedBorder:inputBorder,
        contentPadding:const EdgeInsets.all(4),
      ),
      keyboardType:textInputType,
      obscureText:isPass,
    );
  }
}