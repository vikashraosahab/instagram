import 'package:flutter/material.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/custom_textfield.dart';

class SignInScreen extends StatefulWidget{
  static const routeName = '/signInScreen';
  const SignInScreen({super.key});
  @override 
   SignInScreenState createState()=> SignInScreenState();
}

class SignInScreenState extends State<SignInScreen>{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
   @override
  Widget build(BuildContext context) {
     return Scaffold(
      body:Container(
        padding:const EdgeInsets.symmetric(horizontal:32,vertical:32),
          child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                mainAxisAlignment:MainAxisAlignment.start,
                 children: [
                   Container(
                    padding:const EdgeInsets.symmetric(horizontal:32,vertical:32),
                    child:Image.asset(
                      'lib/assets/instagram.png',
                     color:Colors.white,  
                    ),
                   ),
                   const SizedBox(height:64),
                   CustomTextField(
                    textEditingController:emailController, 
                    hintText:'Enter your email', 
                    ispass:false,
                    textInputType:TextInputType.emailAddress,
                    ),
                   const SizedBox(height:24),
                   CustomTextField(
                    textEditingController:passController, 
                    hintText:'Enter your Password', 
                    ispass: true,
                    textInputType:TextInputType.text,
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
                      onTap:(){},
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
                   Flexible(
                    flex:4,
                    child:Container()
                  ),
                   Container(
                    margin:const EdgeInsets.only(top:100),
                    child:Row(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        const Text("I haven't any account ? ",style:TextStyle(
                          color:primaryColor,
                          fontSize: 20
                        )),
                        GestureDetector(
                           onTap:(){
                             Navigator.pushNamed(context,SignUpScreen.routeName);
                           },
                            child:const Text('Sign Up', style:TextStyle(
                              color:blueColor,
                              fontSize:21,
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