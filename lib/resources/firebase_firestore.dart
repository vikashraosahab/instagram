
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/modules/post.dart' as Module; 
import 'package:uuid/uuid.dart';
import '../resources/firebase_firestore.dart';
class FirestoreMethods{
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

   Future<String> uploadPost({
    required String uid,
    required String name,
    required String email,
    required String description,
    required String username,
    required String photoUrl,
    required String profile
   }) async{
       String result = 'Something occured';
     try{
       final postId = const Uuid().v1();
      Module.Post post = Module.Post(
        uid:uid, 
        name: name, 
        description: description,
        datePublished:DateTime.now(), 
        username: username, 
        email:email, 
        postId: postId, 
        postUrl:photoUrl, 
        likes:[],
        profileImage:profile
      );
    firebaseFirestore.collection('posts').doc(FirebaseAuth.instance.currentUser!.uid).set(post.toJson());
    result ='Success';
     }catch(e){
       print(e.toString());
     }

     return result;
   }
  // like post etc
   Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        firebaseFirestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
   // post comments 

   Future<String> postComment(
    String postId,
    String text, 
    String name,
    String uid, 
    String profilePic,
    )async{
     String result = 'Something wrong';
     final commentId = const Uuid().v1();
      try{
        if(text.isNotEmpty){
          await firebaseFirestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
            'postId':postId,
            'text':text,
            'name':name,
            'uid':uid,
            'profilePic':profilePic,
            'datePublished': DateTime.now(),
            'likes':[],
          });
          result = 'Success';
        }else{
          result =' Please write your comment first';
        }
      }catch(e){
        print(e.toString());
      }

      return result;
   }

} 