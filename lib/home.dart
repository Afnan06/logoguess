
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:guesslogo/Quiz.dart';
import 'package:guesslogo/appbar.dart';
import 'package:guesslogo/drawer.dart';
import 'package:guesslogo/help.dart';

import 'package:shared_preferences/shared_preferences.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool ic = true;
  List data=[];
  String _zipPath="";
  Future<String> retrieveurl() async {
    
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.reference().child("Data").once();

    if (dataSnapshot.value != null) {
      data.add(dataSnapshot.value);

      
     setState(() {
        _zipPath =data[1][1]['url'];
       
       
     });
      
     
  
     
     
    }
   
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
     
        child: Scaffold(
         
            backgroundColor: Colors.transparent,
            appBar: appbar(),
             drawer: drawer(),
            body: Container(
               height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/pattern-1.png"), fit: BoxFit.cover)),
    
                child: Center(
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,children: [

              Container(
                  width:MediaQuery.of(context).size.width/1.5,
                  height:MediaQuery.of(context).size.height/2.66,
                  child: Image.asset('images/quiz.png',fit: BoxFit.cover,)),
              SizedBox(height: MediaQuery.of(context).size.height/40,),
              Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/16,
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: SizedBox.expand(
                      child: OutlineButton(
                          child: Text('Play',
                              style:
                                  TextStyle(fontSize: MediaQuery.of(context).size.width/22,
                                  fontWeight: FontWeight.bold, color: Colors.green)),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            style: BorderStyle.solid,
                            width: MediaQuery.of(context).size.width/110,
                          ),
                          onPressed: () {
                           
                           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Quiz(title: "Cars")),
  );
                          }))),
                             SizedBox(height: MediaQuery.of(context).size.height/80,),
               Container(
                   width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/16,
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: SizedBox.expand(
                      child: OutlineButton(
                          child: Text('Help',
                              style:
                                   TextStyle(fontSize: MediaQuery.of(context).size.width/22,
                                  fontWeight: FontWeight.bold, color: Colors.green)),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            style: BorderStyle.solid,
                            width: MediaQuery.of(context).size.width/120,
                          ),
                          onPressed: () async  {
                             final prefs=await SharedPreferences.getInstance();
                             
    await prefs.setInt("number",0);
    prefs.setString("names", "");

                            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Help()),
  );
                           
                           
                          }))),
              SizedBox(height: MediaQuery.of(context).size.height/80,),
              Container(
                    width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height/16,
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: SizedBox.expand(
                      child: OutlineButton(
                          child: Text('Quit',
                              style:
                                 TextStyle(fontSize: MediaQuery.of(context).size.width/22,
                                  fontWeight: FontWeight.bold, color: Colors.green)),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            style: BorderStyle.solid,
                            width:MediaQuery.of(context).size.width/120,
                          ),
                          onPressed: () {
                            // print(MediaQuery.of(context).size.width);
                            // print(MediaQuery.of(context).size.height);
                             
                           
                            exit(0);
                          }))),
              SizedBox(height: MediaQuery.of(context).size.height/80,),
              // Center(
              //     child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
                
              //   children: <Widget>[
              //     IconButton(
              //       icon: Icon(
              //         ic ? Icons.volume_up : Icons.volume_off,
              //         color: Colors.amber,
              //         size: MediaQuery.of(context).size.width/15,
              //       ),
              //       onPressed: () {
              //         setState(() {
              //           ic = !ic;
              //         });
              //       },
              //     ),
              //     SizedBox(width: MediaQuery.of(context).size.width/38,),
              //     IconButton(
              //       icon: Icon(
              //         Icons.settings,
              //         color: Colors.amber,
              //         size: MediaQuery.of(context).size.width/15,
              //       ),
              //       onPressed: () {
              //         setState(() {});
              //       },
              //     ),
              //      SizedBox(width: MediaQuery.of(context).size.width/38,),
              //     IconButton(
              //       icon: Icon(
              //         Icons.favorite,
              //         color: Colors.amber,
              //         size: MediaQuery.of(context).size.width/15,
              //       ),
              //       onPressed: () {
              //         setState(() {});
              //       },
              //     ),
              //   ],
              // ))
            ])))));
  }
}


