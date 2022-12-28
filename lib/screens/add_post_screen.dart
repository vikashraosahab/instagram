import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:instagram/screens/home_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget{
  const AddPostScreen({super.key});
   @override 
    AddPostScreenState createState()=> AddPostScreenState();
}

class AddPostScreenState extends State<AddPostScreen>{
  Uint8List? file;
  bool isloading =false;
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  
    selectImage(BuildContext parentContext){
     return showDialog(
      context:parentContext, 
      builder:(BuildContext context){
        return SimpleDialog(
          title:const Text('Create a Post'),
          children: [
            SimpleDialogOption(
               child:const Text('Choose from gallery'),
               onPressed:()async{
                 Uint8List galleryImage = await imagePick(ImageSource.gallery);
                  setState(() {
                    file=galleryImage;
                    Navigator.pop(context);
                  });
               },
            ),
            SimpleDialogOption(
              child:const Text('Choose from Cammer'),
              onPressed:()async{
                Uint8List cammerImage = await imagePick(ImageSource.camera);

                 setState(() {
                    file=cammerImage;
                    Navigator.pop(context);
                 });
              },
            ),
            Container(
              color:Colors.yellow,
              
              alignment:Alignment.bottomCenter,
              child:SimpleDialogOption(
              child:const Text('Cancel'),
              onPressed:(){
                Navigator.pop(context);
              },
            ))
          ],
        );
      });
   }

  Future<void> posted()async{
    setState(() {
       isloading=true;
    });
      String result = await FireStoreMethods().uploadPost(
        'posts',
         file!, 
         firebaseauth.currentUser!.uid, 
         'hello world',
         'zero tone'
      );

      if(result =='success'){
         setState(() {
            isloading=false;
         });

         Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }else{
        setState(() {
          isloading=false;
        });

        showSnackBar(context, result.toString());
      }
   }

   @override
  Widget build(BuildContext context){
   final UserProvider User =Provider.of<UserProvider>(context);
   return file == null ?  Center(
    child:IconButton(
      onPressed:(){
         selectImage(context);
      },
      icon:const Icon(
        Icons.arrow_upward_rounded,
        size:30,
      ),
    )
   ):Scaffold(
    appBar:AppBar(
      backgroundColor:mobileBackgroundColor,
     leading:IconButton(
      icon:const Icon(Icons.arrow_back),
      onPressed:(){},
     ),
     title:const Text(
      'Post to'
     ),
     centerTitle:false,
     actions: [
      TextButton(
        onPressed:posted,
        child:!isloading ? const Text(
          'Post',style:TextStyle(fontSize:24),
       ): 
       const CircularProgressIndicator(color:Colors.red),
    )]
    ),
    body:Container(
      child:Row(
        children: [
          Container(
            child:Image.network(FirebaseAuth.instance.currentUser!.photoURL.toString()),
          ),
          Divider(),
          Container(
            height:300,
            width:300,
            padding:const EdgeInsets.all(10),
            child:Image.memory(file!),
          ),
          const Divider(),
          
        ],
      ),
    ),
   );
  }
}