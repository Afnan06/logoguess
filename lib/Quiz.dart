import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guesslogo/appbar.dart';
import 'package:guesslogo/drawer.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:guesslogo/Score.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quiz extends StatefulWidget {
  Quiz({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  DefaultCacheManager manager = new DefaultCacheManager();
  String start = "Start";
  List data = [];
  String title;
  List images = [];
  List title_r = [];
  List image_r = [];
  FirebaseDatabase firebaseDatabase;
  DatabaseReference reference;
  bool _visible = true;
  bool timer_visible = false;
  bool loaded = false;
  Function eq = const ListEquality().equals;
  var text = [];
  int total_score = 0;
  final random = Random();
  var r;
  var j = [];
  var r1 = [];
  var r2 = [];
  var r3 = [];
  var correct = [];
  var randomalphabets = [];

  String firstpic = 'quiz.jpg';
  int pic_count = 0;
  int loop_count = 0;
  int count = 0;
  int sub = 1;
  int obt_score = -1;

  int timeinmin = 30;
  Timer _timer;
  double percent = 1.0;
  bool end = false;
  List repeat = [];

  Future<List> getIm() async {
    images = [];
    final prefs = await SharedPreferences.getInstance();
    final name = await prefs.getString("names");

    images = json.decode(name);

    total_score = images.length;
    return images;
  }

  // Future<List> retrieve() async {
  //   print("retrieveeeee");
  //   DataSnapshot dataSnapshot =
  //       await FirebaseDatabase.instance.reference().child("Data").once();

  //   if (dataSnapshot.value != null) {
  //     data.add(dataSnapshot.value);

  //     print("true");
  //     for (int i = 1; i < data[1].length; i++) {///////CHANGE REQUIREDDDDD FIREBASE DATA
  //       title_r.add(data[1][i]['title']);
  //       image_r.add(data[1][i]['image']);
  //     }
  //     title = title_r;
  //     images = image_r;
  //     print(title);
  //     print(images);
  //     title_r = [];
  //     image_r = [];
  //     total_score = images.length;
  //     print('images.length');
  //     print(images);
  //     print(title);

  //     // dataSnapshot.value.forEach((key,value){
  //     //   print("h4");

  //     //   print(value);
  //     //   print(key);

  //     // });
  //   }
  //   return images;
  // }

  void getstart() {
    if (mounted) {
    setState(() {
      timeinmin = 30;

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            if (timeinmin > 0) {
              percent = ((timeinmin - 1) * 3.3333) / 100;

              timeinmin = timeinmin - 1;
            } else {
              loaded = false;
              task();

              timeinmin = 30;
            }
          });
        }
        setState(() {
          if (end == true) {
            _timer.cancel();
            Navigator.pushReplacementNamed(context, "/thanks",
                arguments: Score(
                    obt: obt_score.toString(), tot: total_score.toString()));
          }
        });
      });
    });}
  }

  void task() {
    sub = 1;

    percent = 1.0;

    _visible = false;

    text = [];

    r1 = [];
    r2 = [];
    r3 = [];
    j = [];
    correct = [];
    randomalphabets = [];

    pic_count = random.nextInt(images.length);
    while (repeat.contains(pic_count)) {
      pic_count = random.nextInt(images.length);
    }
    repeat.add(pic_count);

    if (loop_count < images.length-1) {
      count = count + 1;
      firstpic = images[pic_count];
      title = StringUtils.reverse(firstpic);
      int id = title.indexOf('/');
      title = title.substring(4, id);

      title = StringUtils.reverse(title);
      // print(title);
      // print(images.length);
      // print(loop_count);

      for (int x = 0; x < (title.length); x++) {
        if (title[x] == '-') {
          break;
        }
        randomalphabets.add(title[x].toUpperCase());

        text.add('');
        correct.add(title[x].toUpperCase());
      }

      r = randomAlpha(15 - randomalphabets.length);
      for (int y = 0; y < r.toString().length; y++) {
        randomalphabets.add(r[y].toUpperCase());
      }

      randomalphabets.shuffle();

      for (int y = 0; y < randomalphabets.length; y++) {
        if (y < 5) {
          r1.add(randomalphabets[y]);
        }
        if (y >= 5 && y < 10) {
          r2.add(randomalphabets[y]);
        }
        if (y >= 10 && y < 15) {
          r3.add(randomalphabets[y]);
        }
      }

      loop_count = loop_count + 1;
    } 
    else {
      
      end = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    //retrieve();
  }

  @override
  Widget build(BuildContext context) {
    //images = Condition(title: widget.title).condition();
    //images=image;

    return Scaffold(
         appBar: appbar(),
             drawer: drawer(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/pattern-1.png"),
                    fit: BoxFit.cover)),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 13),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 4,
                    child: start != "Start"
                        ? Image.file(
                            File(firstpic),
                          )
                        : Image.asset(
                            'images/quiz.png',
                            fit: BoxFit.cover,
                          )),
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                Container(
                    child: Text("Guess The Logo",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 16,
                            fontWeight: FontWeight.bold))),
                Visibility(
                  visible: !_visible,
                  child: Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < text.length; i++)
                        Card(
                          color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width / 12,
                                width: MediaQuery.of(context).size.width / 12,
                                child: Center(
                                  child: Text(text[i],
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if (start == "Start" || count <= images.length - 1)
                    Visibility(
                      visible: _visible,
                      child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 16,
                          margin: EdgeInsets.symmetric(vertical: 3.0),
                          child: SizedBox.expand(
                              child: OutlineButton(
                                  child: Text(start,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                  borderSide: BorderSide(
                                    color: Colors.amber,
                                    style: BorderStyle.solid,
                                    width:
                                        MediaQuery.of(context).size.width / 120,
                                  ),
                                  onPressed: () async {
                                    if (start == "Start") {
                                      manager.emptyCache();

                                      await getIm();
                                    }
                                    setState(() {
                                      if (start == "Next") {
                                        _timer.cancel();
                                      }

                                      start = "Next";
                                      loaded = false;

                                      timer_visible = true;
                                      obt_score = obt_score + 1;

                                      getstart();

                                      task();
                                    });
                                  }))),
                    ),
                
                  if (count == images.length && images.length != 0)
                    Visibility(
                      visible: _visible,
                      child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 16,
                          margin: EdgeInsets.symmetric(vertical: 3.0),
                          child: SizedBox.expand(
                              child: OutlineButton(
                                  child: Text("Done",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                  borderSide: BorderSide(
                                    color: Colors.amber,
                                    style: BorderStyle.solid,
                                    width:
                                        MediaQuery.of(context).size.width / 120,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obt_score = obt_score + 1;

                                      Navigator.pushReplacementNamed(
                                          context, "/thanks",
                                          arguments: Score(
                                              obt: obt_score.toString(),
                                              tot: total_score.toString()));
                                      _timer.cancel();
                                    });
                                  }))),
                    ),
                ]),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < r1.length; i++)
                      Card(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    j = [];
                                    if (correct.contains(r1[i])) {
                                      for (int x = 0; x < correct.length; x++) {
                                        if (correct[x] == r1[i]) {
                                          j.add(x);
                                        }
                                      }

                                      //  index= correct.indexWhere((note) => note.startsWith(r3[i]) );
                                      for (int t = 0; t < j.length; t++) {
                                        text[j[t]] = r1[i];
                                      }

                                      r1.remove(r1[i]);
                                    }
                                    if (eq(correct, text)) {
                                      _visible = true;
                                      _timer.cancel();
                                      start = "Next";
                                      loaded = false;

                                      timer_visible = true;
                                      obt_score = obt_score + 1;

                                      getstart();

                                      task();
                                    } else {
                                      //print('wrong');
                                    }
                                  });
                                }, // Handle your callback
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width / 11,
                                  width: MediaQuery.of(context).size.width / 11,
                                  child: Center(
                                    child: Text(r1[i],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                )),
                          ],
                        ),
                      ),
                  ],
                )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < r2.length; i++)
                      Card(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    j = [];
                                    if (correct.contains(r2[i])) {
                                      for (int x = 0; x < correct.length; x++) {
                                        if (correct[x] == r2[i]) {
                                          j.add(x);
                                        }
                                      }

                                      //  index= correct.indexWhere((note) => note.startsWith(r3[i]) );
                                      for (int t = 0; t < j.length; t++) {
                                        text[j[t]] = r2[i];
                                      }

                                      r2.remove(r2[i]);
                                      if (eq(correct, text)) {
                                        _visible = true;
                                        _timer.cancel();
                                        start = "Next";
                                        loaded = false;

                                        timer_visible = true;
                                        obt_score = obt_score + 1;

                                        getstart();

                                        task();
                                      }
                                    } else {
                                      //print('wrong');
                                    }
                                  });
                                }, // Handle your callback
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width / 11,
                                  width: MediaQuery.of(context).size.width / 11,
                                  child: Center(
                                    child: Text(r2[i],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                )),
                          ],
                        ),
                      ),
                  ],
                )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < r3.length; i++)
                      Card(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    j = [];
                                    if (correct.contains(r3[i])) {
                                      for (int x = 0; x < correct.length; x++) {
                                        if (correct[x] == r3[i]) {
                                          j.add(x);
                                        }
                                      }

                                      //  index= correct.indexWhere((note) => note.startsWith(r3[i]) );
                                      for (int t = 0; t < j.length; t++) {
                                        text[j[t]] = r3[i];
                                      }

                                      r3.remove(r3[i]);
                                      if (eq(correct, text)) {
                                        _visible = true;
                                        _timer.cancel();
                                        start = "Next";
                                        loaded = false;

                                        timer_visible = true;
                                        obt_score = obt_score + 1;

                                        getstart();

                                        task();
                                      }
                                    } else {
                                      //print('wrong');
                                    }
                                  });
                                }, // Handle your callback

                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width / 11,
                                  width: MediaQuery.of(context).size.width / 11,
                                  child: Center(
                                    child: Text(r3[i],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                )),
                          ],
                        ),
                      ),
                  ],
                )),
                Container(
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 8),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: CircularPercentIndicator(
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: percent,
                      animation: true,
                      animateFromLastPercent: true,
                      radius: MediaQuery.of(context).size.width / 5,
                      lineWidth: MediaQuery.of(context).size.width / 68,
                      progressColor: Colors.amber,
                      center: Text("$timeinmin",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    )),
                    // RaisedButton(onPressed: (){
                    //   print(loop_count);
                    // },
                    // child:Text("Hello"))
              ],
            ))));
  }
}
//  Container (
//                      color: Colors.amber,
//                      child:ElevatedButton(

//                       onPressed: () {
// setState(() {
//   start="Next";
//   timer_visible = true;
//   obt_score=obt_score +1;
//    getstart();

//   task();
// });
//                       },
//                       child: Container(
//                         height: 50,
//                         width: 60,

//                         padding: const EdgeInsets.all(10.0),
//                         child: Center(
//                           child:  Text(start,
//                               style: TextStyle(fontSize: 15)),
//                         ),
//                       )),
//                 ),
