import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FollowerScreen extends StatefulWidget{
   @override 
     FollowerScreenState createState()=> FollowerScreenState();
}

class FollowerScreenState extends State<FollowerScreen>{
  List followers  = [];
  int followersLen  = 0;
   @override
      
       void initState(){
         super.initState();
          fetchFollowerData();
       }

        fetchFollowerData() async{
           final data = await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

           setState(() {
              followers = data.data()!['follower'];
              followersLen = data.data()!['follower'].length;
           });
        }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
        itemCount:followersLen,
        itemBuilder:(context,index){
          return Container(
            child:Text('${followers}'),
          );
        }
      )
    );
  }
}