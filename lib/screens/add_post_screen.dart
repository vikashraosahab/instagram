import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/resources/firebase_firestore.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:instagram/screens/signin_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/custom_textfield.dart';

class AddPostScreen extends StatefulWidget{
  const AddPostScreen({super.key});
  @override
   AddPostScreenState createState()=> AddPostScreenState();
}

class AddPostScreenState extends State<AddPostScreen>{
 final TextEditingController commentController = TextEditingController();
 Uint8List? image;
 bool isLoading =false;
 String name ='';
 String username ='';
 String email ='';
 String userId ='';
 String profile ='';
 String postId ='';
 
 @override
  void initState(){
    super.initState();
    getData();
  }

 Future<void> getData() async{
     DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();

     setState(() {
        username = (snapshot.data()!as Map<String,dynamic>)['username'];
        name = (snapshot.data()!as Map<String,dynamic>)['name'];
        email = (snapshot.data()!as Map<String,dynamic>)['email'];
        userId = (snapshot.data()!as Map<String,dynamic>)['uid'];
        profile = (snapshot.data()!as Map<String,dynamic>)['photoUrl'];
     });
  }
   
  @override 
    void dispose(){
      super.dispose();
      commentController.dispose();
    }
   galleryImagePost() async{
    Uint8List galleryImage =  await imagePicker(ImageSource.gallery);
       setState(() {
          image =galleryImage;
       });
   }

   // if you want post image from camer

   cameraImagePost() async{
    Uint8List? camImage = await imagePicker(ImageSource.camera);
     setState(() {
        image = camImage;
     });
   }

   posted() async{
      setState(() {
         isLoading =true;
      });

     String postUrl= await StorageMethods().uploadImage('postImage', image!,true);  
     String result = await FirestoreMethods().uploadPost(
      uid:FirebaseAuth.instance.currentUser!.uid, 
      name:name,
      email:email,
      description:commentController.text, 
      username:username, 
      photoUrl:postUrl, 
      profile:profile,
      );
     if(result =='Success'){
       setState(() {
          isLoading =false;
       });
       print(username);
       print(profile);
       
     }else{
      setState(() {
        isLoading =false;
      });
      print(email);
     }
   }
   @override 
     Widget build(BuildContext context) {
     return image == null ?
            Scaffold(body:Container(
              alignment:Alignment.bottomCenter,
              child:AlertDialog(
                alignment:Alignment.center,
                backgroundColor:const Color.fromARGB(255, 24, 23, 23),
                actions: [
                 Container(
                  padding:const EdgeInsets.symmetric(horizontal:12,vertical:12),
                  alignment:Alignment.center,
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:cameraImagePost,
                        child:Row(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: const[
                          Icon(
                            Icons.camera_alt_outlined,
                            size:25,
                          ),
                           SizedBox(width:20),
                          Text(
                            'Camera',
                            style:TextStyle(
                              fontSize:19,
                            )
                          )
                        ],)
                      ),
                      const SizedBox(height:20),
                      GestureDetector(
                        onTap:galleryImagePost,
                        child:Row(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.photo_camera_back,
                             size:26,  
                            ),
                            SizedBox(width:20),
                            Text(
                              'gallery',
                              style:TextStyle(
                                fontSize:19,
                              ),
                            ),
                          ],
                        )
                      ),
                      
                    ]
                  )
                 ),
                ],
              ))
             ): Scaffold(
             appBar:AppBar(
              backgroundColor:mobileBackgroundColor,
              
              centerTitle:false,
              leading:IconButton(
                onPressed:(){
                  setState(() {
                     image = null;
                  });
                },
                icon:const Icon(Icons.arrow_back_ios_new_outlined)
              ),
              title:const Text('Post'),
              actions: [
                 Container(
                  margin:const EdgeInsets.only(top:10,right:40),
                  padding:const EdgeInsets.only(left:5,right:5),
                  child:GestureDetector(
                  onTap:posted,
                  child:!isLoading ? const Icon(Icons.arrow_forward_rounded):
                    Container(
                      alignment:Alignment.center,
                      child:const CircularProgressIndicator(color:Colors.blue)
                    ),
                 ),
                 ),
              ],
             ),
            body:SingleChildScrollView(
              
              child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.center,
                children: [
                   Container(
                    padding:const EdgeInsets.symmetric(horizontal:20),
                    width:400,
                    height:400,
                    child:Image.memory(image!),
                   ),
                   const SizedBox(height:12),
                   CustomTextField(
                    textEditingController:commentController, 
                    hintText:"description", 
                    ispass:false, 
                    textInputType:TextInputType.text,
                  ),
                ],
             ),
            ),
        );
  }
}