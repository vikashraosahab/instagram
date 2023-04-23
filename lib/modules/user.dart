
class User{
  final String uid;
  final String name;
  final String email;
  final String password;
  final String username;
  final String image;
  final List follower;
  final List following;

   User({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    required this.image,
    required this.follower,
    required this.following,
   });

  Map <String,dynamic> toJson()=>{
     "uid":uid,
     "name":name,
     "email":email,
     "password":password,
     'username':username,
     'photoUrl':image,
     'follower':follower,
     'following':following,
  };
  
}