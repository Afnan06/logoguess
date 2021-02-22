import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:guesslogo/Thankyou.dart';
import 'package:guesslogo/about.dart';
import 'package:guesslogo/help.dart';
import 'package:guesslogo/home.dart';
import 'package:guesslogo/imagedownload.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApplication());
  // runApp( MaterialApp (home: DevicePreview(
  //   // enabled: !kReleaseMode,
  //   builder: (context) => MyApplication(), // Wrap your app
  // )
  // ),);
}
class MyApplication extends StatefulWidget {
  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  int count;
  int check;
  Future<int> get_counttimes() async {
    final prefs=await SharedPreferences.getInstance();
    final number= prefs.getInt("number");
    if (number==null){
      return 0;

    }
    return number;
   
  }
  Future<void> reset_counttimes() async {
    final prefs=await SharedPreferences.getInstance();
    await prefs.setInt("number",0);
   
  }
  Future<void> increment_counttimes() async {
    final prefs=await SharedPreferences.getInstance();
    int lastnumber=await get_counttimes();
     int currentnumber= lastnumber +1;
    
   
    await prefs.setInt("number", currentnumber);
    

    
    
    setState(() {
       count=currentnumber;
       
    });
    if (count ==1 ){
        await prefs.setInt("check",0);
        

       }
       final checking= prefs.getInt("check");

       setState(() {
         check=checking;
       });
      
   
  
   
  }
  @override
  void initState() {
    // TODO: implement initState
     increment_counttimes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //MyHomePage(title: 'Flutter Demo Home Page'),
        primarySwatch: Colors.blue,
      ),
      routes: {
         
         "/home": (_) => new MyHomePage(),
         "/help":(_) => new Help(),
         "/about":(_) => new About(),
        // "/share":(_) => new Sharing(),
        
     
         
        "/thanks": (context) =>
        ThankYou(ModalRoute.of(context).settings.arguments),
      },
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder, // Add the builder here
      home:
      Container(
       
        decoration: BoxDecoration(
          gradient:LinearGradient(colors: [Color(0xff1542bf),Color(0xff51a8ff)],
          begin: FractionalOffset(0.5,1))),
          child:  AnimatedSplashScreen(
        
        splash:   
        Container(child:Image.asset('images/quiz.png',fit: BoxFit.cover,),width:400,height:400),
        
        
        
       
        
        
        
       
        nextScreen: (check == 0 ||  count == 1 )  ? IDownload(): MyHomePage(),
        splashTransition:  SplashTransition.sizeTransition,
        
      
        duration: 4000,
      ),),
    );
  }
}
