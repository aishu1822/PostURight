import 'package:flutter/material.dart';
import 'package:calender_picker/calender_picker.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'colors.dart';
import 'main.dart';
import 'title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'app_root.dart';
import 'dart:core';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.title, Key? key, Function? refresh}) : super(key: key);
  final String? title;
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final profileRef = database.child("/profile");
  double buttonDayHeightWidth = 40;
  String _displayPostureStatus = "nothing yet";
  late Timer updatePostureStatusTimer;
  var _selectedValue = DateTime.now();
  double _angle = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatePostureStatusTimer = Timer.periodic(const Duration(seconds:1),(arg) {
      if (_displayPostureStatus != currentPosture) {
        setState(() {
          _displayPostureStatus = currentPosture;
        });
      }
      if (readValues.containsKey(angle_uuid)) {
        double new_angle = interpretValue(readValues[angle_uuid]!) - 90.0;
        if ((new_angle - _angle).abs() > 5) {
          setState(() {
            _angle = new_angle;
          });
        }
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    updatePostureStatusTimer.cancel();
  }

  Widget homeWidget() {
    return MaterialApp( 
      
      home: Scaffold (
      backgroundColor: appBackgroundColor,
      body:ListView(
      children: [
        Padding(padding: const EdgeInsets.all(10),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CalenderPicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                });
              },
            ),

            ElevatedButton (
              onPressed: () {
                profileRef.set({'firstname': 'Jane', 'lastname': 'Doe'});
              },
              child: Text("Test set db"),
            ),


            Container(
              // height: 200,
              // width: 300,
              child: Card(
                  child: 
                  Column(children: [
                    Text("Posture status: " + _displayPostureStatus),
                    // angleSlider(getDisplayAngle()),
                    SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: -45,
                            maximum: 45,
                            canScaleToFit: false,
                            showLabels: true,
                            showTicks: true,
                            radiusFactor: 0.6,
                            showFirstLabel: true,
                            showLastLabel: true,
                            startAngle: 190,
                            endAngle: 350,
                            axisLineStyle: const AxisLineStyle(
                                cornerStyle: CornerStyle.bothFlat,
                                thickness: 25,
                                gradient: SweepGradient(
                                      colors: <Color>[
                                        Color.fromARGB(255, 239, 70, 8),
                                        Color.fromARGB(255, 204, 153, 43),
                                        Color.fromARGB(255, 104, 217, 92),
                                        Color.fromARGB(255, 204, 153, 43),
                                        Color.fromARGB(255, 239, 70, 8),
                                      ],
                                      stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
                                  )),
                            pointers: <GaugePointer>[
                              MarkerPointer(
                                  value: _angle,
                                  enableDragging: true,
                                  enableAnimation: true,
                                  markerHeight: 15,
                                  markerWidth: 45,
                                  markerType: MarkerType.rectangle,
                                  color: Colors.white,
                                  elevation: 3,),
                            ],
                        )
                      ]
                    ),
                  ],)
                ),
            ),
            Wrap(
              children: [
                Card(
                  child: 
                    SimpleCircularProgressBar(
                        mergeMode: true,
                        onGetText: (double value) {
                            return Text('${value.toInt()}%');
                        },
                    ),
                ),
                Card(
                  child: 
                    SimpleCircularProgressBar(
                        mergeMode: true,
                        onGetText: (double value) {
                            return Text('${value.toInt()}%');
                        },
                    ),
                ),
              ]
            ),

            ElevatedButton(
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed out");
                  Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => TitleScreen()),
                            (Route<dynamic> route) => false,
                          );
                });
              }, 
              child: Text("Logout"),
            ),
          ],
      )
      ],

    ))
    );
  }
 

  @override
  Widget build(BuildContext context) {
    return homeWidget();
  }
}