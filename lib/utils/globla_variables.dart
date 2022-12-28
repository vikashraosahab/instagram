import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/home_screen.dart';

const webScreenSize =400;

const applicationPages =[
  HomeScreen(),
  Center(child:Text('Search')),
  AddPostScreen(),
  Center(child:Text('favorite')),
  Center(child:Text('Profile')),
];
