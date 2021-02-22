import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:guesslogo/appbar.dart';
import 'package:guesslogo/home.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
class IDownload extends StatefulWidget {
  @override
  _IDownloadState createState() => _IDownloadState();
}

class _IDownloadState extends State<IDownload> {

   bool _downloading;
  String _dir;
  List<String> _images, _tempImages;
  //String _zipPath = 'https://firebasestorage.googleapis.com/v0/b/logo-quiz-b57b5.appspot.com/o/logoImages.zip?alt=media&token=a21df551-3213-465c-b1c7-a8ae5be4ae2c';
  String _localZipFileName = 'logoImages.zip';
  String _zipPath ='';
  bool clicked =false;
  List data=[];
 bool c_vis=true;
 List images=[];

  @override
  void initState() {
    super.initState();
    _images = List();
    _tempImages = List();
    _downloading = false;
    _initDir();
   
  }
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

  _initDir() async {
    if (null == _dir) {
      _dir = (await getApplicationDocumentsDirectory()).path;
    }
  }
   
 
  Future<File> _downloadFile(String url, String fileName) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = File('$_dir/$fileName');
    return file.writeAsBytes(req.bodyBytes);
  }
 
  Future<void> _downloadZip() async {
    setState(() {
      _downloading = true;
    });
 
    _images.clear();
    _tempImages.clear();
 
    var zippedFile = await _downloadFile(_zipPath, _localZipFileName);
    await unarchiveAndSave(zippedFile);
 
    setState(() {
      _images.addAll(_tempImages);
      _downloading = false;
    });
  }
 
  unarchiveAndSave(var zippedFile) async {
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileName = '$_dir/${file.name}';
      images.add(fileName);
      var s = json.encode(images);
      final prefs=await SharedPreferences.getInstance();
    await prefs.setString("names", s);
     
      if (file.isFile) {
        var outFile = File(fileName);
        //print('File:: ' + outFile.path);
        _tempImages.add(outFile.path);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }
 
  buildList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _images.length,
        itemBuilder: (BuildContext context, int index) {
         
          return Image.file(
            File(_images[index]),
            fit: BoxFit.fitWidth,
          );
        },
      ),
    );
  }
 
  progress() {
  return Container(
          padding: EdgeInsets.all(16.0),
          child:CircularProgressIndicator() ,
        );
  }

   
 
  @override
  Widget build(BuildContext context) {
       return Scaffold(
       appBar: appbar(),
           
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
                      !clicked ?
                        "Click Continue to set up things for you": "This will take few seconds...",
                       // (Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage())) ),
                        //"This will take few seconds...",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.bold)),
                  )),
                   SizedBox(height:30),
                    Center(
                      child:
           _downloading ? progress() :  
                      Visibility(
                        visible : !c_vis,
                                              child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          height: MediaQuery.of(context).size.height / 16,
                          margin: EdgeInsets.symmetric(vertical: 3.0),
                          child: SizedBox.expand(
                              child: OutlineButton(
                                  child: Text("Next",
                                      style:TextStyle(fontSize: MediaQuery.of(context).size.width/22,
                                      fontWeight: FontWeight.bold, color: Colors.green)),
                                  borderSide: BorderSide(
                                    color: Colors.amber,
                                    style: BorderStyle.solid,
                                    width: MediaQuery.of(context).size.width / 80,
                                  ),
                                  onPressed: () async  {
                                     final prefs=await SharedPreferences.getInstance();
                                     await prefs.setInt("check",1);
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage())) ;
                                   
                                    
                                    
                                  
                                  }))),
                      ) ,  //option(st="Next");
           ),

           
                   
                    Visibility(
                      visible: c_vis,
                                          child: Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: MediaQuery.of(context).size.height / 16,
                        margin: EdgeInsets.symmetric(vertical: 3.0),
                        child: SizedBox.expand(
                            child: OutlineButton(
                                child: Text("Continue",
                                    style:TextStyle(fontSize: MediaQuery.of(context).size.width/22,
                                    fontWeight: FontWeight.bold, color: Colors.green)),
                                borderSide: BorderSide(
                                  color: Colors.amber,
                                  style: BorderStyle.solid,
                                  width: MediaQuery.of(context).size.width / 80,
                                ),
                                onPressed: ()  {
                                  
                                   retrieveurl();
                                 _downloadZip();
                                  setState(() {
                                        clicked=!clicked;
                                        c_vis=!c_vis;
                                       
                                        
                                        
                                        
                                    });
                                   
                                  
                                  
                                
                                }))),
                    ),


                     

                 
                ])));
  }
}