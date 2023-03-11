import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/custom_textfield.dart';

import '../utils/global_variables.dart';

class SignInScreen extends StatefulWidget{
  static const routeName = '/signInScreen';
  const SignInScreen({super.key});
  @override 
   SignInScreenState createState()=> SignInScreenState();
}

class SignInScreenState extends State<SignInScreen>{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;

    void dispose(){
       super.dispose();
       emailController.text;
       passController.text;
    }

    Future<void>signInUser() async{
       setState(() {
         isLoading = true;
       });
      String result = await AuthMethods().signInUser(
        email:emailController.text,
        password:passController.text
      );

      if(result =='Success'){
         setState(() {
           isLoading = false;
         });
      }else{
        setState(() {
          isLoading =false;
        });
      }
    }
   @override
  Widget build(BuildContext context) {
     return Scaffold(
      body:Container(
        padding:MediaQuery.of(context).size.width > webScreen ? 
        EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width /3, vertical:MediaQuery.of(context).size.height /9)
        : const EdgeInsets.symmetric(horizontal:32,vertical:32),
          child:Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                mainAxisAlignment:MainAxisAlignment.start,
                 children: [
                   Container(
                    padding:const EdgeInsets.symmetric(horizontal:30),
                    child:Image.asset(
                      'lib/assets/instagram.png',
                     color:Colors.white,  
                    ),
                   ),
                   const SizedBox(height:28),
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
                      onTap:signInUser,
                      child:Container(
                        alignment:Alignment.center,
                        child:!isLoading ? const Text('Sign In',style:TextStyle(
                          color:primaryColor,
                          fontSize:25,
                        )):const Center(
                          child:CircularProgressIndicator(color:Colors.white),
                        )
                      ),
                    ),
                   ),
                   const SizedBox(height:20),
                   Container(
                    padding:const EdgeInsets.only(top:5),
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