
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

    // this is for getUserDetails  function 
    // this is used for getting value from firebase with help of providers and snapshot

    static User fromSnap(DocumentSnapshot snap){
       final Snapshot =snap.data() as Map<String,dynamic>;
        return User(
          userId:Snapshot['userId'],
          name:Snapshot['name'], 
          email:Snapshot['email'], 
          username:Snapshot['username'], 
          password:Snapshot['password'], 
          photoUrl:Snapshot['photoUrl'], 
          followers:Snapshot['followers'], 
          following:Snapshot['following']
        );
    }

}