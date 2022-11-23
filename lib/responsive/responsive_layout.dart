import 'package:flutter/material.dart';
import 'package:instagram/utils/globla_variables.dart';

class ResponsiveLayout extends StatefulWidget{
  final webLayout;
  final mobileLayout;
  const ResponsiveLayout({
    super.key,
    required this.webLayout, 
    required this.mobileLayout
  });
   @override
    ResponsiveLayoutState createState()=> ResponsiveLayoutState();
}

class ResponsiveLayoutState extends State<ResponsiveLayout>{
   @override
  Widget build(BuildContext context) {
   return LayoutBuilder(
     builder:(context,constraints){
       if(constraints.maxWidth > webScreenSize){
         return widget.webLayout;
       }
       return widget.mobileLayout;
     },
   );
  }
}