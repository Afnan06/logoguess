import 'package:flutter/material.dart';
import 'package:guesslogo/Score.dart';
import 'package:guesslogo/appbar.dart';
import 'package:guesslogo/drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class ThankYou extends StatefulWidget {
  final Score arguments;

  ThankYou(this.arguments);

  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  String txt = 'a';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  appbar(),
             drawer: drawer(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/pattern-1.png"), fit: BoxFit.cover)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                        (int.parse(widget.arguments.obt) > (int.parse(widget.arguments.tot)-1)/2
                            ? "You Played Well !"
                            : "Take Another Chance"),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 16,
                            fontWeight: FontWeight.bold)),
                  )),
                  SizedBox(height: MediaQuery.of(context).size.width / 14,),
                  CircularPercentIndicator(
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: double.parse(widget.arguments.obt) /
                        double.parse(widget.arguments.tot)-1,
                    animation: true,
                    animateFromLastPercent: true,
                    radius: MediaQuery.of(context).size.width / 5,
                    lineWidth: MediaQuery.of(context).size.width / 68,
                    progressColor: Colors.amber,
                    center: Text(
                      widget.arguments.obt.toString() +
                          '/' +
                          widget.arguments.tot.toString(),
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width/22,
                                  fontWeight: FontWeight.bold, color: Colors.green)),
                  ),
                 SizedBox(height: MediaQuery.of(context).size.width / 16,),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: MediaQuery.of(context).size.height / 16,
                      margin: EdgeInsets.symmetric(vertical: 3.0),
                      child: SizedBox.expand(
                          child: OutlineButton(
                              child: Text('Continue',
                                  style:TextStyle(fontSize: MediaQuery.of(context).size.width/22,
                                  fontWeight: FontWeight.bold, color: Colors.green)),
                              borderSide: BorderSide(
                                color: Colors.amber,
                                style: BorderStyle.solid,
                                width: MediaQuery.of(context).size.width / 80,
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, "/home");
                              }))),
               
                ])));
  }
}

//  decoration: BoxDecoration(
//           gradient:LinearGradient(colors: [Color(0xff1542bf),Color(0xff51a8ff)],
//           begin: FractionalOffset(0.5,1))),
