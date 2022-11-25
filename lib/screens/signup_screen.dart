import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/responsive/mobile_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/main_screen.dart';
import 'package:instagram/utils/globla_variables.dart';
import 'package:instagram/utils/utils.dart';
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
  Uint8List? image;

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
        password: passwordController.text,
        file:image!
      );

      if(result =='success'){
         setState(() {
           isLoading =false;
         });

          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushReplacement(context,MaterialPageRoute(builder:((context) =>const ResponsiveLayout(
              webLayout:WebLayout(), 
              mobileLayout:MobileLayout(),
            ))));
          });
      }else{
         setState(() {
           isLoading =false;
         });

      // ignore: use_build_context_synchronously
      showSnackBar(context,result.toString());

      }
    }
    
    void selectImage() async{
       Uint8List imgUrl = await imagePick(ImageSource.gallery);

       setState(() {
          image=imgUrl;
       });
    }
    
  @override
  Widget build(BuildContext context)=>Scaffold(
    body:Container(
       padding:MediaQuery.of(context).size.width > webScreenSize ? EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width /3): const EdgeInsets.symmetric(horizontal:32),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.center,
        children:[
          Flexible(flex:2,child:Container()),
          Container(
           padding:MediaQuery.of(context).size.width > webScreenSize ? EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width /3): const EdgeInsets.symmetric(horizontal:32),
            child:Image.asset(
              'lib/assets/instagram-text.png',
              color:Colors.white,
            ),
          ),
          const SizedBox(height:64,),
          Stack(
            children:[
               image !=null ? CircleAvatar(
                radius:45,
                backgroundColor:Colors.white,
                backgroundImage:MemoryImage(image!),
               ) : const CircleAvatar(
                  radius:45,
                  backgroundColor:Colors.white,
                  backgroundImage:NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
               ),
               Positioned(
                right:2,
                bottom:1,
                child:IconButton(
                  onPressed:selectImage,
                  icon:const Icon(Icons.add_a_photo_outlined,color:Colors.grey,size:30,)
                ),
               )
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
