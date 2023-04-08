import 'package:flutter/material.dart';
import 'package:calender_picker/calender_picker.dart';
import 'package:posturight/profile_model.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'colors.dart';
import 'main.dart';
import 'title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'app_root.dart';
import 'dart:core';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

class _ChartData {
  _ChartData(this.x, this.y);
 
  final String x;
  final double y;
}

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
  int _best_duration_today = 0;
  bool _showGoodPostureImage = false;

  @override
  void initState() {
    super.initState();
    updatePostureStatusTimer = Timer.periodic(const Duration(seconds:1),(arg) {

      // TODO: do only a single set state
      if (_displayPostureStatus != currentPosture) {
        setState(() {
          _displayPostureStatus = currentPosture;
          if (currentPosture != "straight") {
            _showGoodPostureImage = false;
            updateDisplayUserBestDuration();
          } else {
            _showGoodPostureImage = true;
          } 
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

  Future<void> updateDisplayUserBestDuration() async {
    int best_duration = await getUserBestDuration(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      _best_duration_today = (best_duration / 60).toInt();
    });
  }

  Widget chartWidget() {
    List<_ChartData> data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    charts.TooltipBehavior _tooltip = charts.TooltipBehavior(enable: true);
    return charts.SfCartesianChart(
            primaryXAxis: charts.CategoryAxis(),
            primaryYAxis: charts.NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <charts.ChartSeries<_ChartData, String>>[
              charts.AreaSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: const Color.fromRGBO(8, 142, 255, 1),
              ),
            ],
          );           
  }

  Widget homeWidget() {
    return MaterialApp( 
      
      home: Scaffold (
      backgroundColor: appBackgroundColor,
      body:ListView(
      children: [
        const Padding(padding: EdgeInsets.all(10),),
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

            // ElevatedButton (
            //   onPressed: () {
            //     profileRef.set({'firstname': 'Jane', 'lastname': 'Doe'});
            //   },
            //   child: Text("Test set db"),
            // ),


            Container(
              // height: 200,
              // width: 300,
              margin: const EdgeInsets.all(0),
              constraints: const BoxConstraints(minWidth: 300.0, maxHeight: 200.0),
              child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(0),
                  child: 
                  Column(  
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                      padding: const EdgeInsets.only(top:0, bottom: 0),
                      constraints: const BoxConstraints(maxWidth: 280.0),
                      child:
                        SfLinearGauge(
                          minimum: -90,
                          maximum: 90,
                          showLabels: false,
                          showTicks: false,
                          ranges: [
                            LinearGaugeRange(
                              startValue: -90,
                              endValue: 90,
                              position: LinearElementPosition.cross,
                              edgeStyle: LinearEdgeStyle.bothCurve,
                              midWidth: 15,
                              endWidth: 15,
                              startWidth: 15,
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: <Color>[
                                    Color.fromARGB(255, 239, 139, 8),
                                    Color.fromARGB(255, 204, 191, 43),
                                    Color.fromARGB(255, 104, 217, 92),
                                    Color.fromARGB(255, 204, 191, 43),
                                    Color.fromARGB(255, 239, 139, 8),
                                  ],
                                  stops: <double>[0.0, 0.4, 0.5, 0.6, 1.0],
                                ).createShader(bounds),
                            )
                          ],
                          markerPointers: [
                            LinearWidgetPointer(
                              value: _angle,
                              enableAnimation: true,
                              child: Container(
                                height: 25,
                                width: 10,
                                decoration: BoxDecoration(color: Colors.white, 
                                                          border: Border(bottom: BorderSide(color: Colors.grey.shade400), 
                                                                          top: BorderSide(color: Colors.grey.shade400), 
                                                                          left: BorderSide(color: Colors.grey.shade400), 
                                                                          right: BorderSide(color: Colors.grey.shade400)
                                                                        ),
                                                          borderRadius: const BorderRadius.all(Radius.circular(20),),
                                                          boxShadow: [BoxShadow(color: Colors.black)],
                                                          )
                              ), 
                            )
                          ],                            
                          ),
                        ),
                    AnimatedCrossFade(
                      crossFadeState: _showGoodPostureImage ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 500),
                      firstChild: Container(
                        child: const Text("Your back is straight. Good job!", style: TextStyle(color: Colors.green)),
                      ),
                      secondChild: Container(
                        child: Text("You are slouching by ${_angle.toInt().abs().toString()} degrees", style: const TextStyle(color: Color.fromARGB(255, 245, 115, 9)),),
                      ),                    
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    AnimatedCrossFade(
                      crossFadeState: _showGoodPostureImage ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 500),
                      firstChild: Container(
                        child: Image.asset(
                          'assets/images/good_posture.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      secondChild: Container(
                        child: Image.asset(
                          'assets/images/bad_posture.png',
                          width: 100,
                          height: 100,
                        ),
                      ),                    
                    ),
                  ],
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(minWidth: 150.0),
                  child:Card(
                    elevation: 2,
                    child:Column(children:[
                      const Text("Goal: 1hr. 30min.", textAlign: TextAlign.center,),
                      const Padding(padding: EdgeInsets.only(top:10, left:15, right:15)),
                      SizedBox(
                        height: 80.0,
                        width: 80.0,
                        child: 
                          SfRadialGauge(
                              axes: [
                                RadialAxis(
                                  axisLineStyle: const AxisLineStyle(
                                    thickness: 5
                                  ),
                                  showTicks: false,
                                  showLabels: false,
                                  startAngle: 0,
                                  endAngle: 0,
                                  ranges: [
                                    GaugeRange(startValue: 0, endValue: _best_duration_today.toDouble()),
                                  ],
                                  annotations: [
                                    GaugeAnnotation(widget: Text("$_best_duration_today min."))
                                  ],
                                ),
                              ],
                            ),
                      ),
                      const Padding(padding: EdgeInsets.only(top:10, left:15, right:15)),
                  ]),)
                ),
                 Container(
                  constraints: const BoxConstraints(minWidth: 150.0),
                  child:Card(
                    elevation: 2,
                    child:Column(children:[
                      const Text("Ratio of good to bad\nposture (last 3 days)", textAlign: TextAlign.center,),
                      const Padding(padding: EdgeInsets.only(top:10, left:15, right:15)),
                      SizedBox(
                        height: 80.0,
                        width: 80.0,
                        child: 
                          SfRadialGauge(
                            axes: [
                              RadialAxis(
                                axisLineStyle: const AxisLineStyle(
                                  thickness: 5
                                ),
                                showTicks: false,
                                showLabels: false,
                                startAngle: 0,
                                endAngle: 0,
                              )
                            ],
                          ),
                      ),
                      const Padding(padding: EdgeInsets.only(top:10, left:15, right:15)),
                    ])
                  ),)
              ]
            ),

            Container(
              constraints: const BoxConstraints(maxHeight: 100),
              child:chartWidget(),
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
              child: const Text("Logout"),
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