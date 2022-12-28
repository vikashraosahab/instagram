import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post{
  final String  description;
  final String uid;
  final String username;
  final likes;
  final DateTime datePublished;
  final String postUrl;
  final String postImage;

    const Post({
      required this.description,
      required this.uid,
      required this.username,
      required this.likes,
      required this.datePublished,
      required this.postUrl,
      required this.postImage,
    });

    static Post fromSnap(DocumentSnapshot snap){
       var snapshot = snap.data() as Map<String,dynamic>;

        return Post(
           description:snapshot['description'],
           uid:snapshot['uid'],
           username:snapshot['username'],
           likes:snapshot['likes'],
           datePublished:snapshot['datePublished'],
           postUrl:snapshot['postUrl'],
           postImage:snapshot['postImage'],
      );
  }

  Map<String,dynamic> toJson(){
     return {
        'description':description,
        'userId':uid,
        'username':username,
        'likes':likes,
        'datePublished':datePublished,
        'postUrl':postUrl,
        'postImage':postImage,
     };
  }
}