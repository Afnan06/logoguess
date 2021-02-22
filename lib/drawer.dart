import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Drawer(
            child: Column(children: [
          Container(child: Image.asset("images/quiz.png")),
          RaisedButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  "/home",
                );
              },
              child: Row(children: [
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.amber,
                      size: MediaQuery.of(context).size.width / 12,
                    ),
                    onPressed: () {}),
                Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
              ])),
          RaisedButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  "/help",
                );
              },
              child: Row(children: [
                IconButton(
                  icon: Icon(
                    Icons.help,
                    color: Colors.amber,
                    size: MediaQuery.of(context).size.width / 12,
                  ),
                  onPressed: () {},
                ),
                Text(
                  "Help",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
              ])),
          RaisedButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  "/about",
                );
              },
              child: Row(children: [
                IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.amber,
                    size: MediaQuery.of(context).size.width / 12,
                  ),
                  onPressed: () {},
                ),
                Text(
                  "About",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
              ])),
          RaisedButton(
              color: Colors.white,
              onPressed: () {
                Share.share("Please Visit https://www.google.com to learn about us");
                // Navigator.pushReplacementNamed(
                //   context,
                //   "/share",
                // );
              },
              child: Row(children: [
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.amber,
                    size: MediaQuery.of(context).size.width / 12,
                  ),
                  onPressed: () {},
                ),
                Text(
                  "Share",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
              ])),
          RaisedButton(
              color: Colors.white,
              onPressed: () {
                exit(0);
              },
              child: Row(children: [
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.amber,
                    size: MediaQuery.of(context).size.width / 12,
                  ),
                  onPressed: () {},
                ),
                Text(
                  "Quit",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
              ])),
        ])));
  }
}
