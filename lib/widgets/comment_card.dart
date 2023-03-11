import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget{
  final dynamic snap;
  const CommentCard({Key ? key, required this.snap}):super(key:key);
   @override
   CommentCardState createState()=> CommentCardState();
}

class CommentCardState extends State<CommentCard>{
   @override
  Widget build(BuildContext context) {
    return Container(
      color:const Color.fromARGB(255, 24, 23, 23),
      padding:const EdgeInsets.all(10),
      margin:const EdgeInsets.only(bottom:5,top:5,left:3,right:3),
      child:Row(
        children: [
          Container(
            child:CircleAvatar(
              radius:30,
              backgroundImage:NetworkImage(widget.snap['profilePic']),
            ),
          ),
          Container(
            margin:const EdgeInsets.only(left:12),
            padding:const EdgeInsets.all(5),
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
              Text(widget.snap['name']),
              const SizedBox(height:5),
              Container(
                width:180,
                child:Text(
                  widget.snap['text'],
                  softWrap:true,
                  maxLines:10,
                  overflow:TextOverflow.ellipsis,
                  style:const TextStyle(
                    color:Colors.grey,
                  )
                  ,),
              ),
              const SizedBox(height:7),
            ]),
          ),
          Flexible(flex:3,child:Container()),
          IconButton(
              onPressed:(){},
               icon:const Icon(Icons.favorite_border_outlined))
        
        ],
      ),
    );
  }
}