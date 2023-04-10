import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({Key ? key}):super(key:key);
   @override
  SearchScreenState createState()=> SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>{
  final TextEditingController searchController = TextEditingController();
   bool isSearching = false;
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:mobileBackgroundColor,
        title:Container(
          padding:const EdgeInsets.all(5),
        child:Form(child: TextFormField(
          controller:searchController,
          decoration:const InputDecoration(labelText:'Search username'),
          onFieldSubmitted: (String _){
            setState(() {
               isSearching = true;
            });
          },
        )),
        ),
      ),
      body:isSearching ? FutureBuilder(
        future:FirebaseFirestore.instance.collection('user').where('username',isGreaterThanOrEqualTo:searchController.text).get(), 
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {  
           if(!snapshot.hasData){
            return const CircularProgressIndicator();
           }
           return ListView.builder(
             itemCount:(snapshot.data! as dynamic).docs.length,
             itemBuilder:((context, index) {
               return GestureDetector(
                 onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=> ProfileScreen(uid:(snapshot.data! as dynamic).docs[index]['uid'])));
                 },
                 child: Container(
                  padding:const EdgeInsets.symmetric(vertical:5,horizontal:5),
                  child:Row(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      Container(
                        margin:const EdgeInsets.all(5),
                        padding:const EdgeInsets.symmetric(vertical:5,horizontal:15),
                        child:CircleAvatar(
                          radius:30,
                          backgroundImage:NetworkImage((snapshot.data! as dynamic).docs[index]['photoUrl']),
                        ),
                      ),
                      Container(
                        child:Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            Text(
                              (snapshot.data! as dynamic).docs[index]['username'],
                              style:const TextStyle(
                                fontSize:21
                              )),
                            Text(
                              (snapshot.data! as dynamic).docs[index]['name'],
                              style:const TextStyle(
                                fontSize:19,color:Colors.grey
                              ))
                          ],
                        ),
                      )
                  ])
                 ),
               );
             }),
           );
        },
      ) : FutureBuilder(
        future:FirebaseFirestore.instance.collection(
          'posts'
          ).orderBy('datePublished').get(),
        builder:(context,snapshot){
           if(!snapshot.hasData){
             return const CircularProgressIndicator(color:Colors.white);
           }
           return  GridView.custom(
  gridDelegate: SliverQuiltedGridDelegate(
    crossAxisCount:4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,

    repeatPattern: QuiltedGridRepeatPattern.inverted,
    pattern:const [
      QuiltedGridTile(2, 2),
      QuiltedGridTile(1, 1),
      QuiltedGridTile(1, 1),
      QuiltedGridTile(1, 2),
    ],
  ),
  childrenDelegate: SliverChildBuilderDelegate(
    (context, index) => 
    Container(
      margin:const EdgeInsets.symmetric(vertical:10),
      child:Image.network((snapshot.data! as dynamic).docs[index]['postUrl'])),
      childCount:(snapshot.data! as dynamic).docs.length,
        ),
         );
      }
    ));
  }
}