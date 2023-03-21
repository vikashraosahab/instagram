import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';

class MobileLayout extends StatefulWidget{
   @override 

    MobileLayoutState createState()=> MobileLayoutState();
}

class MobileLayoutState extends State<MobileLayout>{
  int page = 0;
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
    onPageChanged(int val){
         setState(() {
            page = val;
         });
    }

   void navigationTapped(int page){
     pageController.jumpToPage(page);
   }
   @override
  Widget build(BuildContext context) {
     return Scaffold(
        body:Container(
          child:PageView(
            //physics:const NeverScrollableScrollPhysics(),
            physics:const NeverScrollableScrollPhysics(),
            onPageChanged:(int val){
              setState(() {
                page == val;
              });
            },
            controller:pageController,
            children:homeItems,
          )
        ),
        bottomNavigationBar:BottomAppBar(
          color:mobileBackgroundColor,
          child:Row(
            crossAxisAlignment:CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children: [
            Container(
              padding:const EdgeInsets.all(5),
              child:IconButton(
                onPressed:(){
                  setState(() {
                    page = 0;
                    navigationTapped(0);
                  });
                }, 
                icon:Icon(
                  Icons.home,
                  size:26,
                  color:(page == 0) ? primaryColor : secondaryColor, 
              )
             ),
            ),
             Container(
              padding:const EdgeInsets.all(5),
              child:IconButton(
                onPressed:(){
                 setState(() {
                    page = 1;

                  navigationTapped(1);
                 });
                }, 
                icon:Icon(
                  Icons.search_rounded,
                  size:26,
                   color:page == 1 ? primaryColor : secondaryColor
              )
             ),
            ),
             Container(
              padding:const EdgeInsets.all(5),
              child:IconButton(
                onPressed:(){
                  setState(() {
                    page = 2;
                    navigationTapped(2);
                  });
                }, 
                icon:Icon(
                  Icons.add_box_outlined,
                  size:26,
                  color:(page == 2) ? primaryColor : secondaryColor,
                )
             ),
            ),
             Container(
              padding:const EdgeInsets.all(5),
              child:IconButton(
                onPressed:(){
                  setState(() {
                    page=3;
                    navigationTapped(3);
                  });
                }, 
                icon:Icon(
                  Icons.favorite_border_outlined,
                  size:26,
                  color:(page == 3) ? primaryColor : secondaryColor,
              )
             ),
            ),
             Container(
              padding:const EdgeInsets.all(5),
              child:IconButton(
                onPressed:(){
                  setState(() {
                    page = 4;
                    navigationTapped(4);
                  });
                }, 
                icon:Icon(
                  Icons.settings_display,
                  size:26,
                  color:(page == 4)  ? primaryColor :secondaryColor,
              )
             ),
            ),
          ]
        ),
       ),
     );
  }
}