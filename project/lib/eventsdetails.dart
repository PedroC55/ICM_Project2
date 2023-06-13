import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:homework/Models/progressmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'eventsdetails.dart';

class EventsDetails extends StatefulWidget {
  const EventsDetails({Key? key, required this.index}) : super(key: key);
  final String index;
  @override
  EventsDetailsPage createState() => EventsDetailsPage();
}

class EventsDetailsPage extends State<EventsDetails>{
  Map<String, String> spotsId = {}; 
  Map<String, String> spotsCrackcode = {};
  Map<String, String> nameTime = {};
  Map<String, String> userTime = {}; 
  List<String> times = [];
  List<String> persons = [];
  String hint1 = "";
  String hint2 = "";
  String hint3 = "";
  String hint4 = "";
  String code1 = "";
  String code2 = "";
  String code3 = "";
  String code4 = "";
  String name = "";
  String peddypaperID = "";
  String userID = "";
  String start_time = "";
  String end_time = "";
  String time = "";
  String user = "";
  String nameScore = "";
  int numberHint = 0;
  late final Future<void> _future;
  CameraController? _cameraController;
  bool _isPermissionGranted = false;
  final _textRecognizer = TextRecognizer();
  final db = FirebaseFirestore.instance;
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getPeddyPapers();
    });
    super.initState();
    _future = requestCameraPermission();
  }

  Future<void> requestCameraPermission() async{
    final status = Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void didChangeAppLifecycleState(AppLifecycleState state){
    if(_cameraController==null || !_cameraController!.value.isInitialized){
      return;
    }
    if(state == AppLifecycleState.inactive){
      stopCamera();
    }
    else if(state == AppLifecycleState.resumed && _cameraController!=null && _cameraController!.value.isInitialized){
      startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    db.settings = const Settings(persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,);
    return Scaffold(
      appBar: AppBar(title: Text("MovingCampus")),
      body: FutureBuilder(
        future: getPeddyPapers(),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: _future,
            builder: (context, snapshot){
              return Stack(
                children: [                    
                  Column(
                    children:[
                      Container(     
                        alignment: Alignment.center,
                        height: 80.0,
                        color: Color.fromARGB(255, 192, 186, 186),
                        child: Text(name, style: TextStyle(fontSize: 30.0),),
                      ),
                      if(numberHint == 1)
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 1:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint1, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              )
                            ,

                          ), 
                        )
                      else if(numberHint == 2) ...[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 1:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint1, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              )
                            ,

                          ), 
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 2:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint2, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              )
                            ,

                          ), 
                        )
                      ]   
                      else if(numberHint == 3) ... [
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 1:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint1, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              )
                            ,

                          ), 
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 2:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint2, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              )
                            ,

                          ), 
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 3:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint3, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              )
                            ,

                          ), 
                        )
                      ]
                      else if(numberHint == 4) ... [
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 1:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint1, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              )
                            ,

                          ), 
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 2:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint2, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              )
                            ,

                          ), 
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 3:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint3, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              ),
                          ), 
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          alignment: Alignment.center,
                          height: 120.0,
                          child: new RichText(text:
                              new TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(text: "Hint 4:\n", style: TextStyle(fontSize: 20.0, color: Colors.lime)),
                                  new TextSpan(text: hint4, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                ],
                              ),
                          ), 
                        )
                      ],  
                      if(numberHint == 0)
                        ElevatedButton.icon(
                        onPressed: () => _scanImage(),
                        icon: Icon(Icons.not_started_outlined, size: 24,),
                        label: Text("Start", style: TextStyle(fontSize: 18),)
                      )
                      else if(numberHint == 5) ... [
                        SizedBox(height: 100.0,),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Text("You have completed this peddypaper!!!", style: TextStyle(fontSize: 25.0),),
                        ),
                        SizedBox(height: 30.0,),
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.green,
                            child: Icon(
                              Icons.check,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        Text("Your time was " + DateTime.parse(end_time).difference(DateTime.parse(start_time)).toString().split(".")[0] , style: TextStyle(fontSize: 25.0),),
                        SizedBox(height: 30.0,),
                        Text("Score Board", style: TextStyle(fontSize: 25.0)),
                        SizedBox(height: 10.0,),
                        Table(
                          children: [
                            if (nameTime.length==1) ...[
                              TableRow( 
                                children: [
                                  
                                  Container(
                                  alignment: Alignment.center,
                                  child: new RichText(text:
                                        new TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(text: persons[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                            new TextSpan(text: times[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          ],
                                        ),
                                    ),
                                  ),
                                  ]
                                ),
                            ],
                            if (nameTime.length==2) ...[
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[1], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[1], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                            ],
                            if (nameTime.length==3) ... [
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[1], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[1], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[2], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[2], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                            ],
                            if (nameTime.length==4) ...[
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[1], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[1], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[2], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[2], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[3], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[3], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                            ],
                            if (nameTime.length==5) ... [
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[0], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[1], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[1], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[2], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[2], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[3], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[3], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                              TableRow( 
                              children: [ Container(
                                alignment: Alignment.center,
                                child: new RichText(text:
                                      new TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(text: persons[4], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                          new TextSpan(text: times[4], style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                        ],
                                      ),
                                  ),
                                ),
                                ]
                              ), 
                            ]
                              
                          ],
                        )
                      ]

                      else
                        ElevatedButton.icon(
                        onPressed: () => _scanImage(),
                        icon: Icon(Icons.photo_camera, size: 24,),
                        label: Text("Shoot My Guess", style: TextStyle(fontSize: 18),)
                        ),
                    ],    
                  ),
                ],
              );
            },);
          
          
          
        }
      ),
    );     
  }

  

  getPeddyPapers() async {
    final spots = await db.collection("spots").get().then((value){
      value.docs.forEach((element) async {
        spotsId[element.id] = element['hint'];
        spotsCrackcode[element.id] = element['crackcode'];
      });
    });
    final _userName = ((await FirebaseAuth.instance.currentUser()).email);
    final userrr = await db.collection("users").get().then((value){
      value.docs.forEach((element) async {
        if (_userName == element['email']){
          userID = element.id;
        }
        });
      });
    int i =0;
    final userDoc = await db.collection("peddypaper").get().then((value){
      value.docs.forEach((element) async {
        if(element.id.contains(widget.index)){
          peddypaperID = element.id;
          name = element['name'];
          for(String spot in spotsId.keys){
          if (spot.contains(element['spot1'].id)){
            hint1 = spotsId.values.elementAt(i);
            code1 = spotsCrackcode.values.elementAt(i);
          }
          if (spot.contains(element['spot2'].id)){
            hint2 = spotsId.values.elementAt(i);
            code2 = spotsCrackcode.values.elementAt(i);
          }
          if (spot.contains(element['spot3'].id)){
            hint3 = spotsId.values.elementAt(i);
            code3 = spotsCrackcode.values.elementAt(i);
          }
          if (spot.contains(element['spot4'].id)){
            hint4 = spotsId.values.elementAt(i);
            code4 = spotsCrackcode.values.elementAt(i);
          }
          i++;
        };
        }
        
        });
      }
    );
    final progressforscores = await db.collection("progress").get().then((value){
      value.docs.forEach((element) async {
        if(element.id.contains(peddypaperID)){
          if(element['level'] == 5){
            start_time = element['start_time'];
            end_time = element['end_time'];
            time = DateTime.parse(end_time).difference(DateTime.parse(start_time)).toString().split(".")[0];
            user = element['user'];
            userTime[user] = time;
            if(!times.contains(time)){
              times.add(time);
            } 
          }
        }
        });
      });
    int help = 0;
    final namesScores = await db.collection("users").get().then((value){
      value.docs.forEach((element) async {
        for(String u in userTime.keys){
          if(u.contains(element.id)){
            nameScore = element['name'];
            if(!nameTime.keys.contains(nameScore)){
              nameTime[nameScore] = userTime.values.elementAt(help);
              help++;
            }
          }
        }
        });
      });    
    final progress = await db.collection("progress").get().then((value){
      value.docs.forEach((element) async {
        if ((userID+peddypaperID).toString().contains(element.id)){
          numberHint = element['level'];
          start_time = element['start_time'];
          end_time = element['end_time'];
        }
        });
      });
      print(nameTime.length);
      times.sort();
      int p = 0;
      for(String a in times){
        p = 0;
        for(String b in nameTime.values){
          if(a.contains(b)){
            print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAIIIIIIIIIIIIIIIIIIIIIIAAAAAAAAAAa");
            if(!persons.contains(nameTime.keys.elementAt(p))){
              persons.add(nameTime.keys.elementAt(p));
            }
          }
          p++;
        }
      }
      print(times);
      print(persons);
      
  }

  void startCamera(){
    if(_cameraController!=null){
      _cameraSelected(_cameraController!.description);
    }
  }

  void stopCamera(){
    if(_cameraController!=null){
      _cameraController?.dispose();
    }
  }

  @override
  void dispose(){
    _textRecognizer.close();
  }

  void initCameraController(List<CameraDescription> cameras){
    if(_cameraController!=null){
      return;
    }
    CameraDescription? camera;
    for(var i = 0; i<cameras.length;i++){
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back){
        camera = current;
        break;
      }
    }
    if (camera != null){
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async{
    _cameraController = CameraController(camera, ResolutionPreset.max, enableAudio: false);
    await _cameraController?.initialize();
    if (!mounted){
      return;
    }
    setState(() {});
  }

  Future<void> _scanImage() async{

    try {
      if (numberHint == 0){
        start_time = DateTime.now().toString();
        ProgressModel pm = ProgressModel(start_time, "", userID, 1, peddypaperID);
        await db.collection("progress").doc(userID+peddypaperID).set(pm.toJson());
        setState(() {});
      }
      else{
        final pictureFile = await ImagePicker.pickImage(source: ImageSource.camera);
        final file = File(pictureFile.path);
        final inputImage = InputImage.fromFile(file);
        final recognizedText = await _textRecognizer.processImage(inputImage);
        if(code1 != "passed" && recognizedText.text.contains(code1)){
          code1 == "passed";
          ProgressModel pm = ProgressModel(start_time, "", userID, 2, peddypaperID);
          await db.collection("progress").doc(userID+peddypaperID).set(pm.toJson());
          setState(() {});
        }
        else if(code2 != "passed" && recognizedText.text.contains(code2)){
          code2 == "passed";
          ProgressModel pm = ProgressModel(start_time, "", userID, 3, peddypaperID);
          await db.collection("progress").doc(userID+peddypaperID).set(pm.toJson());
          setState(() {});
        }
        else if(code3 != "passed" && recognizedText.text.contains(code3)){
          code3 == "passed";
          ProgressModel pm = ProgressModel(start_time, "", userID, 4, peddypaperID);
          await db.collection("progress").doc(userID+peddypaperID).set(pm.toJson());
          setState(() {});
        }
        else if(code4 != "passed" && recognizedText.text.contains(code4)){
          code4 == "passed";
          ProgressModel pm = ProgressModel(start_time, DateTime.now().toString(), userID, 5, peddypaperID);
          await db.collection("progress").doc(userID+peddypaperID).set(pm.toJson());
          setState(() {});
        }
        else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TryAgainDialog();
            },
          );
        }
      }  
    } catch (e) {
      
    }
  }

  

}
class TryAgainDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Wrong!'),
      content: Text('This is not the correct department. Please try again!'),
      actions: [
        TextButton(
          child: Text('Try Again'),
          onPressed: () {
            // Perform the action when "Try Again" is pressed
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
