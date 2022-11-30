import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/globla_variables.dart';

class WebLayout extends StatefulWidget{
  const WebLayout({super.key});
   @override 
    WebLayoutState createState()=> WebLayoutState();
}

class WebLayoutState extends State<WebLayout>{
  int page=0;
  late PageController pageController;
  @override
   void initState(){
     super.initState();
     pageController = PageController();
   }

   
   @override 
     void dispose(){
      super.dispose();
       pageController.dispose();
     }

     void navigateTo(int value){
      pageController.jumpToPage(page);
      setState(() {
         page=value;
      });
     }
     
     onPageChanged(int index){
      setState(() {
         page=index;
      });
     }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:mobileBackgroundColor,
        automaticallyImplyLeading:false,
        title:Image.asset(
          'lib/assets/instagram-text.png',
          height:40,
          color: primaryColor,
       ),
        actions:<IconButton>[
          IconButton(
            onPressed:()=>navigateTo(0),
            icon:const Icon(
              Icons.home,
            ),
           ),
           IconButton(
            onPressed:()=>navigateTo(1),
            icon:Icon(
              Icons.search,
              color:page == 1 ? primaryColor : secondaryColor,
            ),
           ),
           IconButton(
            onPressed:()=>navigateTo(2),
            icon:const Icon(
              Icons.add_circle,
            ),
           ),
           IconButton(
            onPressed:()=>navigateTo(3),
            icon:const Icon(
              Icons.favorite,
            ),
           ),
           IconButton(
            onPressed:()=>navigateTo(4),
            icon:const Icon(
              Icons.person,
            ),
           )
        ],
      ),
      body:PageView(
        physics:const NeverScrollableScrollPhysics(),
        controller:pageController,
        onPageChanged:onPageChanged,
        children:applicationPages,
      ),
    );
  }
}