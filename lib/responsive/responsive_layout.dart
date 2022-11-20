import 'package:flutter/material.dart';
import 'package:instagram/utils/globla_variables.dart';

import 'mobile_layout.dart';
import 'web_layout.dart';

class ResponsiveLayout extends StatefulWidget{
  final webLayout;
  final mobileLayout;
  const ResponsiveLayout({super.key,required this.webLayout, required this.mobileLayout});
   @override
    ResponsiveLayoutState createState()=> ResponsiveLayoutState();
}

class ResponsiveLayoutState extends State<ResponsiveLayout>{
   @override
  Widget build(BuildContext context) {
   return LayoutBuilder(
     builder:(context,constraints){
       if(webScreenSize > 400){
         return widget.webLayout;
       }
       return widget.mobileLayout;
     },
   );
  }
}