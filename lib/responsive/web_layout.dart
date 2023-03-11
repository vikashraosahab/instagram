import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';

class WebLayout extends StatefulWidget{
  const WebLayout({super.key});
  @override 
   WebLayoutState createState()=> WebLayoutState();
}
class WebLayoutState extends State<WebLayout>{
   int page = 0;
   int value=0;
   late PageController pageController;

    @override 
      void initState(){
        super.initState();
        pageController = PageController();
      }

      @override 
       void dispose(){
         super.dispose();
         pageController = PageController();
       }

       onPageChanged(int val){
         setState(() {
           page == val;
           value +=550;
         });
       }

       // onPageJumped is used for navigate pageview 

       onNavigatePage(int page){
        setState(() {
           pageController.jumpToPage(page);
        });
       }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding:const EdgeInsets.all(5),
        child:Row(
          crossAxisAlignment:CrossAxisAlignment.start,
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
         children: [
          Flexible(flex:2,
          child:Container(
            color:Colors.green,
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:(){
                    setState(() {
                       page == 0;
                       onNavigatePage(0);
                    });
                  },
                  icon:Icon(
                    Icons.home,
                    color:page == 0 ? primaryColor : secondaryColor,
                    ),
                ),
                const SizedBox(height:12),
                IconButton(
                  onPressed:(){
                    setState(() {
                       page == 1;
                       onNavigatePage(1);
                    });
                  }, 
                  icon:Icon(Icons.search,
                  color:page ==0 ? primaryColor : secondaryColor,
                )),
                const SizedBox(height:12,),
                IconButton(
                  onPressed:(){
                    setState(() {
                      page ==2;
                      onNavigatePage(2);
                    });
                  }, 
                  icon:const Icon(Icons.add_box_outlined)),
                const SizedBox(height:12,),
                IconButton(
                  onPressed:(){
                    setState(() {
                      page ==3;
                      onNavigatePage(3);
                    });
                  }, 
                  icon:const Icon(Icons.video_call_sharp
                )),
                const SizedBox(height:12),
                IconButton(
                  onPressed:(){
                    setState(() {
                      page ==4;
                      onNavigatePage(4);
                    });
                  }, 
                  icon:const Icon(Icons.settings,
                ))

              ],
            ),
          )),
          Flexible(
            flex:6,
            child:Container(
            color:Colors.red,
            child:Container(
              child:PageView(
                controller:pageController,
                onPageChanged:onPageChanged,
                children:homeItems,
              ),
            ),
          )),
          Flexible(
            flex:2,
            child:Container(
            color:Colors.blue,
          ))
         ],

        ),
      ),
    );
  }
}