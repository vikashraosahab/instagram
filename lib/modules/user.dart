
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
   final String userId;
   final String name;
   final String email;
   final String username;
   final String password;
   final String photoUrl;
   final List followers;
   final List following;

    User({
       required this.userId,
       required this.name,
       required this.email,
       required this.username,
       required this.password,
       required this.photoUrl,
       required this.followers,
       required this.following,
    });

    Map<String,dynamic> toJson(){
      return {
        'userId':userId,
        'name':name,
        'email':email,
        'username':username,
        'password':password,
        'photoUrl':photoUrl,
        'followers':followers,
        'following':following,
      };
    }
}