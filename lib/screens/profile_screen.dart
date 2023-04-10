import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/profile_button.dart';

class ProfileScreen extends StatefulWidget{
  final dynamic uid;
  const ProfileScreen({
  Key ? key,
  required this.uid
  }):super(key:key);
   @override 
     ProfileScreenState createState()=> ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>{
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  dynamic userData = [];
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
     @override 
       void initState(){
         super.initState();
         getUserData();
       }

        getUserData() async{
           setState(() {
              isLoading = true;
           });
           try{
             var userSnap = await firebaseFirestore.collection('user').doc(widget.uid).get();

            var postSnap = await firebaseFirestore.collection('posts').where('uid',isEqualTo:FirebaseAuth.instance.currentUser!.uid).get();
             
             postLength = postSnap.docs.length;
              userData = userSnap.data()!;
              followers = userSnap.data()!['followers'].length;
              following = userSnap.data()!['following'].lenth;
              isFollowing = userSnap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
             setState(() {

             });
           }catch(e){print(e.toString());}
          setState(() {
            isLoading = false;
          });
        }
     @override 
      Widget build(BuildContext context) {   
          return isLoading ? const Center(
             child:CircularProgressIndicator(),
          ) : Scaffold(
              appBar:AppBar(
                title:Text(userData['username'],style:const TextStyle(
                  fontSize:21,
                  letterSpacing:1.1,
                  fontFamily:'verdana',
                  fontWeight:FontWeight.w500
                )),
                backgroundColor:mobileBackgroundColor
              ),
              body:ListView(
                children:[
                Padding(
                padding:const EdgeInsets.all(16),
                child:Column(
                children: [
                   Row(
                      children:[
                        CircleAvatar(
                          radius:48,
                          backgroundImage:NetworkImage(
                            userData['photoUrl']
                          ),
                          backgroundColor:Colors.white,
                        ),
                        const SizedBox(width:5),
                        Expanded(
                          flex:1,
                          child:Column(
                          children: [
                            Row(
                          mainAxisSize:MainAxisSize.max,
                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                            children: [
                             buildStateColumn(postLength,'Posts'),
                             buildStateColumn(40, 'Followers'),
                             buildStateColumn(91, 'Following'),
                          ]),
                          const SizedBox(height:12),
                           Row(
                            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                           children:[
                             firebaseAuth.currentUser!.uid == widget.uid ? 
                               ProfileButton(
                                textValue:'Edit Profile', 
                                backgroundColor:Colors.blue, 
                                borderColor:Colors.white, 
                                textColor:Colors.white,
                                function:(){})
                              : isFollowing ? const ProfileButton(
                                textValue:'Follow', 
                                backgroundColor:Colors.blue, 
                                borderColor:Colors.white, 
                                textColor:Colors.white) : const ProfileButton(
                                textValue:'Unfollow', 
                                backgroundColor:Colors.white, 
                                borderColor:Colors.blue, 
                                textColor:Colors.blue) ,
                           ])
                         ]
                        ),  
                       )],
                     ),
                     // there is button of probilescreen
                ],
              ),
          ),
          Container(
             alignment:Alignment.centerLeft,
             padding:const EdgeInsets.symmetric(horizontal:12),
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(userData['name'],style:const TextStyle(
                  fontSize:20,
                )),
                const SizedBox(height:5),
                const Text('Biography',style:TextStyle(
                  fontSize:18,
                ))
              ],
            ),
          ),
        const Divider(),
        FutureBuilder(
          future:firebaseFirestore.collection('posts').where('uid',isEqualTo:widget.uid).get(),
          builder:(context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child:CircularProgressIndicator());
            }
            return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
          }
        )
      ]));
  }

  Column buildStateColumn(int value,String label){
    return Column(
      children: [
        Text(
          value.toString(),
          style:const TextStyle(
          color:Colors.white,
          fontSize:21,
        )),
        const SizedBox(height:12),
       Text(
         label,
         style:const TextStyle(
          color:Colors.white,
          fontSize:18,
         )
        ),
      ],
    );
  }
}