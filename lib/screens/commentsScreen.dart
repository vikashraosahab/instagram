import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/firebase_firestore.dart';
import 'package:instagram/widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget{
  final postId;
  final username;

  const CommentsScreen({Key ? key , required this.postId, required this.username}):super(key:key);
   @override 
  
  CommentScreenState createState()=> CommentScreenState();
}

class CommentScreenState extends State<CommentsScreen>{
  final TextEditingController commentController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String uid ='';
  String name ='';
  String profileImg ='';

    @override 
      void initState(){
        super.initState();
        getData();
      }

     getData() async{
        DocumentSnapshot snap = await firebaseFirestore.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

        setState(() {
           uid =(snap.data()! as Map<String,dynamic>)['uid'];
           name = (snap.data()! as Map<String,dynamic>)['name'];
           profileImg = (snap.data()! as Map<String,dynamic>)['photoUrl'];
        });
      }

      Future<void> commentPost()async{
        String result = await FirestoreMethods().postComment(
        widget.postId,
        commentController.text, 
        name, 
        uid, 
        profileImg
      );
     if(result =='Success'){
       print('Success');
       setState(() {
         commentController.text == null;
       });
     }else{
      print('this is error page');
     }
      
    }
    @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar:AppBar(
        title:const Text(
          'Comments',style:TextStyle(
            fontSize:20,
            letterSpacing:1.2,
          )),
        automaticallyImplyLeading:false,
        leading:IconButton(
          onPressed:(){
            Navigator.pop(context);
          }, 
          icon:const Icon(Icons.arrow_back_ios_new_outlined)
        ),
      ),
      body:StreamBuilder(
        stream:firebaseFirestore.collection('posts').doc(widget.postId).collection('comments').snapshots(),
        builder:(context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>  snapshots){
          
           if(snapshots.connectionState == ConnectionState.waiting){
             return const CircularProgressIndicator();
           }
          return Container(
            child:ListView.builder(
            itemCount:snapshots.data!.docs.length,
            itemBuilder:(context,index)=>CommentCard(snap:snapshots.data!.docs[index])),
          );
        },
      ),
      bottomNavigationBar:SafeArea(
        child:Container(
          height:kToolbarHeight,
          margin:EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
          padding:const EdgeInsets.only(left:3,right:3,bottom:4,top:4),
          child:Row(
            children: [
              Container(
                child:CircleAvatar(
                  radius:30,
                  backgroundImage:NetworkImage(profileImg),
                ),
              ),
              const SizedBox(width:4,),
              Expanded(
                child:Container(
                  child:TextField(
                    controller:commentController,
                   decoration:InputDecoration(
                   hintText:'add a comment for ${widget.username}',
                   filled:true,
                   contentPadding:EdgeInsets.all(5),
                   border:OutlineInputBorder(
                    borderSide:BorderSide.none,
                   ),   
                )),
                ),
              ),
              IconButton(
                onPressed:commentPost, 
              icon:const Icon(Icons.send_outlined)),
            ],
          )
        ),
      ),
     );
  }
}