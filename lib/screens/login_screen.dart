import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/utils/globla_variables.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/text_type_input.dart';

class LogInScreen extends StatefulWidget{
 const LogInScreen({super.key});
  static const routeName ='/loginscreen';
   @override 
     LogInScreenState createState()=> LogInScreenState();
}

class LogInScreenState extends State<LogInScreen>{
  final TextEditingController logEmailController = TextEditingController();
  final TextEditingController logPasswordController = TextEditingController();
  bool isLoading =false;
  @override 
    void dispose(){
       super.dispose();
       logEmailController.dispose();
       logPasswordController.dispose();
    }

 void logUser()async{
    setState(() {
      isLoading = true;
    });

    // ignore: unused_local_variable
    String result = await AuthMethods().signInUser(email:logEmailController.text,password:logPasswordController.text);
    if(result =='success'){
      setState(() {
        isLoading=false;
      });
    }else{
      setState(() {
        isLoading=false;
      });

      // ignore: use_build_context_synchronously
      showSnackBar(context,result.toString());
    }
  }

 void signUpPage(){
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       Navigator.pushReplacementNamed(context,SignUpScreen.routeName);
     });
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
       padding:MediaQuery.of(context).size.width > webScreenSize ? EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width /2.8):  EdgeInsets.symmetric(horizontal:32),
       margin:const EdgeInsets.only(top:10,bottom:10),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Flexible(
              flex:2,
              child:Container()
            ),
            Container(
             padding:MediaQuery.of(context).size.width > webScreenSize ? EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width / 18): const EdgeInsets.symmetric(horizontal:32),
              child:Image.asset(
                'lib/assets/instagram-text.png',
                color:Colors.white,
              )
            ),
            const SizedBox(height:24),
            TextTypeInput(
              controller:logEmailController, 
              hintText:'Enter your email',
              textInputType:TextInputType.emailAddress,
              isPass:false
            ),
            const SizedBox(height:24,),
            TextTypeInput(
              controller:logPasswordController, 
              hintText:'Enter your password', 
              textInputType:TextInputType.text, 
              isPass:true
              ),
            const SizedBox(height:32,),
            GestureDetector(
              onTap:logUser,
              child:Container(
                width:double.infinity,
                alignment:Alignment.center,
                height:48,
                decoration:const ShapeDecoration(
                  color:Colors.blue,
                  shape:RoundedRectangleBorder(
                    borderRadius:BorderRadius.all(Radius.circular(4)),
                  )
                  
                ),
                child:!isLoading ?const Text('Log In',style:TextStyle(
                  fontSize:24
                )): const CircularProgressIndicator(color:Colors.white),
              ),
            ),
            const SizedBox(height:24),
            Flexible(
              flex:2,
              child:Container()
            ),
            const SizedBox(height:24,),
            Row(
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                const Text('I have not any account ? ',style:TextStyle(
                  fontSize:20,
                )),
                InkWell(
                  onTap:signUpPage,
                  child:const Text('Sign Up',style:TextStyle(
                    fontSize:24,
                    color:Colors.blue,
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}