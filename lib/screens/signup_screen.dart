import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/signin_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget{
  static const routeName = '/signUpScreen';
  const SignUpScreen({super.key});
  @override 
   SignUpScreenState createState()=> SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen>{
  final TextEditingController signUpNameController = TextEditingController();
  final TextEditingController signUpEmailContorller = TextEditingController();
  final TextEditingController signUpPasswordContter = TextEditingController();
  final TextEditingController signUpUsernameController = TextEditingController();
  bool isLoading = false;
  Uint8List? image;

  @override 
    void  dispose(){
      super.dispose();
      signUpEmailContorller.dispose();
      signUpNameController.dispose();
      signUpPasswordContter.dispose();
      
    }

    signedUpUser()async {
      setState(() {
        isLoading =true;
      });
     String result = await AuthMethods().signUpUser(
      name:signUpNameController.text, 
      email:signUpEmailContorller.text, 
      password:signUpPasswordContter.text, 
      username:signUpUsernameController.text, 
      photoUrl:image!, 
      follower:[], 
      following:[]
      );
      if(result =='Success'){
         setState(() {
            isLoading = false;
         });
      }else{
        isLoading =false;
      }
    }
    showPostLocation() async{
      return showDialog(
        context: context,
         builder:(BuildContext context) {
           return AlertDialog(
              alignment:Alignment.center,
                actions: [
                  const SizedBox(height:30),
                  Container(
                    alignment:Alignment.center,
                    padding:const EdgeInsets.all(2),
                    child:InkWell(
                      onTap:()async{
                       Uint8List? camer = await imagePicker(ImageSource.camera);

                       setState(() {
                         image=camer;
                         Navigator.pop(context);
                       });
                      },
                      child:Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children:const [
                        Icon(Icons.camera_alt_rounded),
                       SizedBox(width:12,),
                        Text('Camer'),
                      ],
                    )),
                  ),
                  const SizedBox(height:24),
                   Container(
                    alignment:Alignment.center,
                    padding:const EdgeInsets.all(2),
                    child:InkWell(
                      onTap:()async{
                        Uint8List? gallery = await imagePicker(ImageSource.gallery);

                         setState(() {
                            image = gallery;
                            Navigator.pop(context);
                         });
                      },
                      child:Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children:const [
                        Icon(Icons.image_rounded),
                        SizedBox(width:12,),
                        Text('Gallery'),
                      ],
                  ))),
                  const SizedBox(height:30),
                ],
           );
         });
    }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body:SingleChildScrollView(
        child:Container(
        padding:MediaQuery.of(context).size.width > webScreen ? 
        EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width /3.2)
        : const EdgeInsets.symmetric(horizontal:32,vertical:32),
                child:Column(
                 children: [
                   Container(
                    padding:const EdgeInsets.symmetric(horizontal:32),
                    child:Image.asset(
                      'lib/assets/instagram.png',
                     color:Colors.white,  
                    ),
                   ),
                   const SizedBox(height:10),
                    Stack(
                      children: [
                        image !=null ?
                          CircleAvatar(
                            radius:60,
                            backgroundImage:MemoryImage(image!),
                          )
                         :const CircleAvatar(
                          radius:60,
                          backgroundColor:Colors.grey,
                         ),
                        Positioned(
                          left:80,
                          bottom:2,
                          child:GestureDetector(
                            onTap:showPostLocation,
                            child:const Icon(Icons.add_a_photo_outlined,color:Colors.white,size:30)
                      
                        ))
                      ],
                    ),
                   const SizedBox(height:24),
                    CustomTextField(
                    textEditingController:signUpNameController, 
                    hintText:'Enter your name', 
                    ispass: false, 
                    textInputType:TextInputType.text
                  ),
                  const SizedBox(height:20),
                    CustomTextField(
                      textEditingController:signUpEmailContorller, 
                      hintText:'Enter your email', 
                      ispass: false, 
                      textInputType:TextInputType.emailAddress
                  ),
                  const SizedBox(height:20,),
                   CustomTextField(
                    textEditingController:signUpUsernameController, 
                    hintText:'Enter your username',
                    ispass:false, 
                    textInputType:TextInputType.text,
                  ),
                  const SizedBox(height:20),
                   CustomTextField(
                    textEditingController:signUpPasswordContter, 
                    hintText:'Enter your password', 
                    ispass:true, 
                    textInputType:TextInputType.text
                    ),
                  const SizedBox(height:20),
                   Container(
                    width:double.infinity,
                    height:55,
                    decoration:const BoxDecoration(
                      color:blueColor,
                      borderRadius:BorderRadius.all(
                        Radius.circular(4)
                     ),
                    ),
                    child:GestureDetector(
                      onTap:signedUpUser,
                      child:Container(
                        alignment:Alignment.center,
                        child:!isLoading ? const Text('Sign In',style:TextStyle(
                          color:primaryColor,
                          fontSize:25,
                        )):const Center(
                          child:CircularProgressIndicator(color:Colors.white)
                        ),
                      ),
                    ),
                   ),
                   const SizedBox(height:20),
                   Container(
                    alignment:Alignment.bottomCenter,
                    padding:const EdgeInsets.all(5),
                    child:Row(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        const Text("I have account already ? ",style:TextStyle(
                          color:primaryColor,
                          fontSize:19.3
                        )),
                        GestureDetector(
                          onTap:(){
                            Navigator.pushNamed(context,SignInScreen.routeName);
                          },
                            child:const Text('Sign In', style:TextStyle(
                              color:blueColor,
                              fontSize:20,
                            )),
                          ),
                      ],
                    ),
                   ),
                   const SizedBox(height:20,),
                 ],
              ),
     )));
  }
}