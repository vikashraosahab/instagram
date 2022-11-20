import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/responsive/mobile_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/main_screen.dart';
import 'package:instagram/widgets/text_type_input.dart';

import '../responsive/web_layout.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});
  static const routeName ='/signupscreen';
   @override 
    SignUpScreenState createState()=> SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen>{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading =false;
  

  @override
  void dispose(){
     super.dispose();
     nameController.dispose();
     emailController.dispose();
     usernameController.dispose();
     passwordController.dispose();
  }

   Future<void> signUp() async{
         setState(() {
           isLoading =true;
         });
      String result =await AuthMethods().signUpUser(
        name:nameController.text, 
        email:emailController.text, 
        username: usernameController.text, 
        password: passwordController.text
      );

      if(result =='success'){
         setState(() {
           isLoading =false;
         });

          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(context,MaterialPageRoute(builder:((context) => const ResponsiveLayout(
              webLayout:WebLayout(), 
              mobileLayout:MobileLayout()
            ))));
          });
      }else{
         setState(() {
           isLoading =false;
         });

         print(result.toString());
      }
    }
  @override
  Widget build(BuildContext context)=>Scaffold(
    body:Container(
       margin:const EdgeInsets.only(top:10,bottom:10),
       padding:const EdgeInsets.symmetric(horizontal:32),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.center,
        children:[
          Flexible(flex:2,child:Container()),
          Container(
            padding:const EdgeInsets.symmetric(horizontal:32),
            child:Image.asset(
              'lib/assets/instagram-text.png',
              color:Colors.white,
            ),
          ),
          const SizedBox(height:64,),
          Stack(
            children: const[
               CircleAvatar(
                radius:64,
                backgroundColor:Colors.white,
               ),
            ],
          ),
          const SizedBox(height:24),
          TextTypeInput(
            controller:nameController, 
            hintText:'Enter your full name', 
            textInputType:TextInputType.text, 
            isPass:false
          ),
          const SizedBox(height:24,),
          TextTypeInput(
            controller:emailController, 
            hintText:'Enter your email', 
            textInputType:TextInputType.emailAddress, 
            isPass:false
          ),
          const SizedBox(height:24),
          TextTypeInput(
           controller:usernameController, 
           hintText:'Enter your username', 
           textInputType:TextInputType.text, 
           isPass:false
          ),
          const SizedBox(height:24,),
          TextTypeInput(
          controller:passwordController, 
          hintText:'Enter your password', 
          textInputType:TextInputType.text, 
          isPass:true
          ),
          const SizedBox(height:32),
          GestureDetector(
            onTap:signUp,
            child:Container(
             width:double.infinity,
             height:48,
             decoration:const ShapeDecoration(
              color: Colors.blue,
              shape:RoundedRectangleBorder(
                borderRadius:BorderRadius.all(Radius.circular(8)),
              )
             ),
              alignment:Alignment.center,
              child:!isLoading ?const Text('Sign Up',style:TextStyle(
                fontSize:24, 
                letterSpacing:1,
              )) :const CircularProgressIndicator(color:Colors.white),
            ),
          ),
          const SizedBox(height:24,),
          Flexible(flex:4,child:Container()),
          Row(
            crossAxisAlignment:CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              const Text('I already have a account ? ',style:TextStyle(fontSize:20),),
              GestureDetector(
                onTap:()=> Navigator.pushReplacementNamed(context,LogInScreen.routeName),
                child:const Text('Log In',style:TextStyle(fontSize: 22,color:Colors.blue),),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
