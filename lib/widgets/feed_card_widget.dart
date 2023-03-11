
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/firebase_firestore.dart';
import 'package:instagram/screens/commentsScreen.dart';
import 'package:intl/intl.dart';


class PostCard extends StatefulWidget{
  final dynamic snap;

  const PostCard({super.key,required this.snap});
 @override
  PostCardState createState()=> PostCardState();
}

class PostCardState extends State<PostCard>{
  final TextEditingController commentConteroller = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth  auth  = FirebaseAuth.instance;
  String profile = '';
  String username ='';
  String uid = '';

    
    @override 
     void initState(){
      super.initState();
       getUserData();
     }

      getUserData () async{
         DocumentSnapshot snap = await firebaseFirestore.collection('user').doc(auth.currentUser!.uid).get();
    
         setState(() {
            profile = (snap.data()! as Map<String,dynamic>)['photoUrl'];
            username = (snap.data()! as Map<String,dynamic>)['username'];
            uid = (snap.data() ! as Map<String,dynamic>)['uid'];
         });
      }

      Future<void> liked() async{
          String result = await FirestoreMethods().likePost(
            widget.snap['postId'].toString(),
            uid, 
            widget.snap['likes'],
          );

          if(result =='Success'){
            print('success');
          }else{
            print(result);
          }
      }
   @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(top:5,bottom:5),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          Container(
            margin:const EdgeInsets.symmetric(horizontal:10),
            child:Row(
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment:MainAxisAlignment.start,
             children: [
              CircleAvatar(
                radius:25,
                backgroundColor:Colors.white,
                backgroundImage:NetworkImage(
                  widget.snap['profileImg'].toString(),
                  
                ),
              ),
              const SizedBox(width:12),
              Container(
                child:Text(
                  widget.snap['username'],
                 style:const TextStyle(
                  fontSize:18,
                  letterSpacing:.2
                 )
                ),
              ),
              Flexible(flex:2,child:Container()),
              Align(
                alignment:Alignment.topLeft,
               child:IconButton(
                onPressed:(){}, 
                icon:const Icon(
                  Icons.more_vert_rounded,
                  size:24,
               )),
              )
            ],
           )
          ),
          const SizedBox(height:15),
          Container(
            padding:const EdgeInsets.all(1),
            child:Image.network(
              widget.snap['postUrl'].toString(),
              width:double.infinity,
              height:400,
            
              ),
          ),
          const SizedBox(height:5),
          Container(
            margin:const EdgeInsets.symmetric(horizontal:10),
            child:Row(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
              children: [
                  IconButton(
                    onPressed:liked,
                    icon:const Icon(Icons.favorite_border_outlined,
                    size:30,
                  )),
                  const SizedBox(width:10),
                  IconButton(
                    onPressed:(){}, 
                    icon:const Icon(Icons.comment_bank_outlined,
                    size:30,
                  )),
                   const SizedBox(width:10),
                  IconButton(
                    onPressed:(){}, 
                    icon:const Icon(Icons.share_rounded,
                    size:30,
                  )),
                  const SizedBox(height:10,),
                  Flexible(
                    flex:2,
                    child:Container()
                  ),
                  IconButton(
                    onPressed:(){}, 
                    icon:const Icon(Icons.add_to_photos)
                  ),
              ]),
          ),
          const SizedBox(height:5),
          Container(
            margin:const EdgeInsets.symmetric(horizontal:15),
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                const Text('5,161 likes'),
                const SizedBox(height:5),
                Text('${widget.snap['username']}  ${widget.snap['description']}',style:const TextStyle(
                  fontSize:18,
                )),         
                const SizedBox(height:10),
                Text( 
                  DateFormat.yMMMMd().format(widget.snap['datePublished'].toDate()),
                  ),
                const SizedBox(height:10),
                GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>CommentsScreen(postId:uid, username: username)));
                    },
                    child:const Text(
                      'View all 4 comments',style:TextStyle(
                      color:Colors.grey,fontSize:18)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}