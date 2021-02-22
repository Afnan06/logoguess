import 'package:flutter/material.dart';
import 'package:guesslogo/appbar.dart';
import 'package:guesslogo/drawer.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:   appbar(),
             drawer: drawer(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/pattern-1.png"),
                    fit: BoxFit.cover)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Container(
                            child: Text("Help",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 16,
                                    fontWeight: FontWeight.bold))),
                      
                        Padding(padding: EdgeInsets.all( MediaQuery.of(context).size.width / 20),child:Container(
                            child: Text(
                                "Guess logos in picture and enter the name by clicking on options alphabets. For each logo, time limit is 30 seconds after that a new logo will appear",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                ))),),
                        
                      
                        Container(
                            child: Text(
                                "Now boost your brain and enjoy the game",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                ))),
                      ])),
                  
                ])));
  }
}
