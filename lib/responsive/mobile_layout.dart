import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/modules/user.dart' as Model;
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget{
  const MobileLayout({super.key});
   @override
    MobileLayoutState createState()=> MobileLayoutState();
}

class MobileLayoutState extends State<MobileLayout>{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String name ='';
  String email='';
  String userName='';
  List followers =[];
  List following =[];
  @override
    void initState(){
       super.initState();
       addData();
    }

    void addData() async{
      final userData = await firebaseFirestore.collection(
        'userCollection'
        ).doc(firebaseAuth.currentUser!.uid).get();
     
      setState(() {
      name =userData['name'];
      email =userData['email'];
      userName = userData['username'];
      followers = userData['followers'];
      following = userData['following'];
      });

    }
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
             InkWell(
              onTap:()async{
                await AuthMethods().signOut();
              },
              child:Text(email),
             )
          ],
        ),
      ),
    );
  }
}