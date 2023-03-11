import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/home_screen.dart';
import '../responsive/mobile_layout.dart';

const webScreen = 900;

List<Widget> homeItems=[
  const HomeScreen(),
  const Text('search'),
 const AddPostScreen(),
 const Text('video stream'),
 const Text('profile'),
];