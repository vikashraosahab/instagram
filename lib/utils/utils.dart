import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

 imagePicker(ImageSource image) async{
  final ImagePicker imagePicker = ImagePicker();

  XFile ? file =await imagePicker.pickImage(source:image);

  if(file !=null){
     return file.readAsBytes();
  }else{
    print('No image pick');
  }
}


