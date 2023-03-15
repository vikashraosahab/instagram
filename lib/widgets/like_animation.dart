import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget{
  final Widget child;
  final bool animation;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
   
    const LikeAnimation({
      Key?key, 
      required this.child,
      required this.animation,
      required this.duration,
      required this.onEnd,
      required this.smallLike,
      }):super(key:key);
   @override 
     
     LikeAnimationState createState()=> LikeAnimationState();
}

class LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin{
   late AnimationController animationController;
   late Animation<double> scale;

    @override 
       void initState(){
         super.initState();
          animationController = AnimationController(
            vsync:this,
            duration:Duration(milliseconds:widget.duration.inMilliseconds ~/2),
          );
         scale = Tween<double>(begin:1,end: 1.2).animate(animationController);
       }

    @override 
      void didUpdateWidget(covariant LikeAnimation oldWidget){
         super.didUpdateWidget(oldWidget);
          if(widget.animation != oldWidget.animation){
             startAnimation();
          }
      }

      startAnimation() async{
         if(widget.animation || widget.smallLike){
            await animationController.forward();
            await animationController.reverse();

            await Future.delayed(
              const Duration(milliseconds:2000)
            );
         }

         if(widget.animation !=null){
            widget.onEnd!();
         }
      }


    @override 
       void dispose(){
        super.dispose();
         animationController.dispose();
       }
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return ScaleTransition(
    scale:scale,
    child:widget.child
   );
  }
}