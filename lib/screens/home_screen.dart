import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/feed_card_widget.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
   @override 
    HomeScreenState createState()=> HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor:mobileBackgroundColor,
          title:Image.asset(
            'lib/assets/instagram.png',
            color:Colors.white,
            height:50
         ),
         actions: [
          IconButton(
          onPressed:(){
           
          }, 
          icon:const Icon(Icons.favorite_border_outlined)),
          IconButton(
            onPressed:(){}, 
            icon:const Icon(Icons.message_outlined)
          ),
         ],
        ),
      body:Container(
        padding:const EdgeInsets.only(top:2,bottom:4),
        child:StreamBuilder(
          stream:FirebaseFirestore.instance.collection('posts').snapshots(),
          builder:(context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
                    return Container(
                      alignment:Alignment.center,
                      child:const CircularProgressIndicator(color:Colors.red,)
                    );
            }
            return ListView.builder(
              itemCount:snapshot.data!.docs.length,
              itemBuilder:(context,index){
                return Container(
                  padding:const EdgeInsets.only(top:20),
                  child:PostCard(
                    snap:snapshot.data!.docs[index].data(),
                  ),
                );
              },
            );
          },
      )),
    );
  }
}