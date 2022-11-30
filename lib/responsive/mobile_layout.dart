import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/globla_variables.dart';


class MobileLayout extends StatefulWidget{
  const MobileLayout({super.key});
   @override
    MobileLayoutState createState()=> MobileLayoutState();
}

class MobileLayoutState extends State<MobileLayout>{
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
   
   void pageNavigation(int page){
    pageController.jumpToPage(page);
   }

   void onPageChanged(int index){
    setState(() {
      page=index;
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        physics:const NeverScrollableScrollPhysics(),
        controller:pageController,
        onPageChanged:onPageChanged,
        children:applicationPages,
      ),
      bottomNavigationBar:CupertinoTabBar(
        backgroundColor:mobileBackgroundColor,
        items:<BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon:Icon(
              Icons.home,
              color:page ==0 ? primaryColor : secondaryColor,
            ),
            label:'',
            backgroundColor:primaryColor,
          ),
          BottomNavigationBarItem(
            icon:Icon(
              Icons.search,
              color:page == 1 ? primaryColor : secondaryColor,
            ),
            label:'',
            backgroundColor:primaryColor,
          ),  
         BottomNavigationBarItem(
            icon:Icon(
              Icons.add_circle,
              color:page == 2 ? primaryColor : secondaryColor,
            ),
            label:'',
            backgroundColor:primaryColor,
          ),
        BottomNavigationBarItem(
            icon:Icon(
              Icons.favorite,
            color:page == 3 ? primaryColor : secondaryColor
            ),
            label:'',
            backgroundColor:primaryColor,
          ),
        BottomNavigationBarItem(
            icon:Icon(
              Icons.person,
               color:page == 4 ? primaryColor : secondaryColor
            ),
            label:'',
            backgroundColor:primaryColor,
          ),
        ],
        currentIndex: page,
        onTap:pageNavigation,
      ),
    );
  }
}