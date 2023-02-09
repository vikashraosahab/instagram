import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/signin_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/custom_textfield.dart';
import './resources/auth_methods.dart';

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
        photoUrl:image,
      );

      if(result =='Success'){
         setState(() {
            isLoading = false;
         });
      }else{
        isLoading =false;
      }
    }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body:Container(
        padding:const EdgeInsets.symmetric(horizontal:32),
              child:Column(
                 children: [
                   Container(
                    padding:const EdgeInsets.symmetric(horizontal:32,vertical:32),
                    child:Image.asset(
                      'lib/assets/instagram.png',
                     color:Colors.white,  
                    ),
                   ),
                   const SizedBox(height:24),
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius:65,
                          backgroundColor:Colors.red,
                        ),
                        Positioned(child:
                         GestureDetector(
                            onTap:(){},
                            child:const Icon(Icons.add_a_photo_outlined)
                      
                        ))
                      ],
                    ),
                   const SizedBox(height:64),
                    CustomTextField(
                    textEditingController:signUpNameController, 
                    hintText:'Enter your name', 
                    ispass: false, 
                    textInputType:TextInputType.text
                  ),
                  const SizedBox(height:24),
                    CustomTextField(
                      textEditingController:signUpEmailContorller, 
                      hintText:'Enter your email', 
                      ispass: false, 
                      textInputType:TextInputType.emailAddress
                  ),
                  const SizedBox(height:24,),
                   CustomTextField(
                    textEditingController:signUpUsernameController, 
                    hintText:'Enter your username',
                    ispass:false, 
                    textInputType:TextInputType.text,
                  ),
                  const SizedBox(height:24),
                   CustomTextField(
                    textEditingController:signUpPasswordContter, 
                    hintText:'Enter your password', 
                    ispass:true, 
                    textInputType:TextInputType.text
                    ),
                  const SizedBox(height:24),
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
                        child:const Text('Sign In',style:TextStyle(
                          color:primaryColor,
                          fontSize:25,
                        )),
                      ),
                    ),
                   ),
                   const SizedBox(height:24),
                   Flexible(flex:3,child:Container()),
                   Container(
                    padding:const EdgeInsets.all(5),
                    child:Row(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        const Text(" I have account already ? ",style:TextStyle(
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
                   const SizedBox(height:24,)
                 ],
              ),
          ),
     );
  }
}