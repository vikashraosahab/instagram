import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget{
  final dynamic textValue;
  final Function()? function;
  final dynamic backgroundColor;
  final dynamic borderColor;
  final dynamic textColor;
  const ProfileButton({
    Key ? key, 
    required this.textValue,
    this.function,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    }):super(key:key);
    @override 
       Widget build(BuildContext context) {
         return Container(
                alignment:Alignment.center,
                height:42,
                width:240,
                decoration:BoxDecoration(
                  color:backgroundColor,
                  border:Border.all(color:borderColor),
                  borderRadius:BorderRadius.circular(12),
                ),
              child:GestureDetector(
                onTap:function,
                child:Text(
                  textValue,style:TextStyle(
                    color:textColor,
                    fontSize:22
                  )),
              )
         );
  }
}