
class Post{
   final String uid;
   final String name;
   final String email;
   final String description;
   final DateTime datePublished;
   final String username;
   final String postId;
   final String postUrl;
   final List likes;
   final String profileImage;

    Post({
       required this.uid,
       required this.name,
       required this.email,
       required this.description,
       required this.datePublished,
       required this.username,
       //required this.likes,
       required this.postId,
       required this.postUrl,
       required this.likes,
       required this.profileImage,
    });
    

  Map<String,dynamic> toJson()=>{
   'userId':uid,
    'name':name,
    'email':email,
    'description':description,
    'username':username,
    'postId':postId,
    'postUrl':postUrl,
     'likes':likes,
    'profileImg':profileImage,
    'datePublished':datePublished,
  };

}