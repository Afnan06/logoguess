import 'package:flutter/material.dart';
Widget appbar(){
  return AppBar(
    title:  Text("Guess Logo",style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            centerTitle: true,
            brightness: Brightness.dark,
            elevation: 50,
            shape:   RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),),
            iconTheme: IconThemeData(color: Colors.blue),
    
  );
}