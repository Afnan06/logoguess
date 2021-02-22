import 'package:flutter/material.dart';
import 'package:guesslogo/appbar.dart';
import 'package:guesslogo/drawer.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
                            child: Text("About",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 16,
                                    fontWeight: FontWeight.bold))),
                      
                        Padding(padding: EdgeInsets.all( MediaQuery.of(context).size.width / 20),child:Container(
                            child: Text(
                               "Guess Logo is an quiz logo game which tests your brain skills and helps you to boost your brain and guess the visible brands logos.We hope you enjoy the game and don't forgot to give it a share",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                ))),),
                                Padding(padding: EdgeInsets.all( MediaQuery.of(context).size.width / 20),child: Container(
                            child: Text(
                                "Contact us: www.zilliondesigns.com",
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