import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/home_screen.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/screens/search_screen.dart';
import '../responsive/mobile_layout.dart';

const webScreen = 900;

List<Widget> homeItems=[
  const HomeScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('video stream'),
  ProfileScreen(uid:FirebaseAuth.instance.currentUser!.uid),
];