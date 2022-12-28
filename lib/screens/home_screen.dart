import 'package:flutter/material.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  static const routeName ='./home';
   @override 
   HomeScreenState createState()=> HomeScreenState();
}


class HomeScreenState extends State<HomeScreen>{
 
   @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return  Scaffold(
      body:Center(
        child:Text(userProvider.getUser.uid.toString()),
      ),
    );
  }
}