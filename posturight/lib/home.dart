import 'dart:math';
import 'package:flutter/material.dart';
import 'package:calender_picker/calender_picker.dart';
import 'package:posturight/exercise_calender.dart';
import 'package:posturight/profile_model.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
  final int y;
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
  late Timer updateUserBestDurationTimer;
  var _selectedValue = DateTime.now();
  double _angle = 0.0;
  int _best_duration_today = 0;
  bool _showGoodPostureImage = false;
  int _posture_goal_hours = 0;
  int _posture_goal_mins = 0;
  // Map data_map = {};
  List<_ChartData> chart_data = [];
  int last_three_days_total = 0;
  bool _isShow = false;

  @override
  void initState() {
    super.initState();
    setPostureGoalDisplay();
    
    loadFakeDailyData(FirebaseAuth.instance.currentUser!.uid);
    populateChartData();
    
    updateUserBestDurationTimer = Timer.periodic(const Duration(minutes: 1), (timer) { 
      print("=============================================================================> updating best duration");
      updateDisplayUserBestDuration();
    });
    
    updatePostureStatusTimer = Timer.periodic(const Duration(seconds:1),(arg) {

      // TODO: do only a single set state
      if (_displayPostureStatus != currentPosture) {
        setState(() {
          _displayPostureStatus = currentPosture;
          if (currentPosture != "straight") {
            _showGoodPostureImage = false;
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
    updateUserBestDurationTimer.cancel();
  }

  Future<void> setPostureGoalDisplay() async {
    int posture_goal_seconds = await getUserPostureDurationGoal(FirebaseAuth.instance.currentUser!.uid);
    int total_mins = posture_goal_seconds ~/ 60;
    int best_duration = await getUserBestDuration(FirebaseAuth.instance.currentUser!.uid);
    print("total_mins = $total_mins");
    setState(() {
      _posture_goal_hours = total_mins ~/ 60;
      _posture_goal_mins = total_mins % 60;
      _best_duration_today = (best_duration~/60);
    });

    // call so it initializes once without waiting 1 minute
    updateDisplayUserBestDuration();
  }

  void updateDisplayUserBestDuration() {
    // int best_duration = await getUserBestDuration(FirebaseAuth.instance.currentUser!.uid);
    // print("best_duratino = $best_duration");
    int duration = (DateTime.now().difference(startTime)).inSeconds;
    if (duration > _best_duration_today) {
      setState(() {
        _best_duration_today = (duration / 60).toInt();
      });
    }    
  }

  void populateChartData() async {
    Map loaded_data_map = await getUserChartData(FirebaseAuth.instance.currentUser!.uid);
    final keys_list = loaded_data_map.keys.toList();
    final values_list = loaded_data_map.values.toList();
    final last_week = keys_list.getRange(max(0, loaded_data_map.length-7), loaded_data_map.length);
    final last_three_days = values_list.getRange(max(0, values_list.length-4), max(0, values_list.length-1));

    int total = 0;
    last_three_days.forEach((element) {
      total += element as int;
    });
    // ratio /= (3*12*3600);
    // print("ratio = $ratio");

    List<_ChartData> new_state_list = [];
    last_week.forEach((element) {
      new_state_list.add(_ChartData(element.substring(5,10), loaded_data_map[element]~/3600));
    });
    
    setState(() {
      chart_data = new_state_list;
      last_three_days_total = total;
    });
  }

  Widget chartWidget() {
    // List<_ChartData> data = [];
    // print("data_map is here");
    // print(data_map);
    // data_map.keys.forEach((element) {
      // print("element");
      // print(element.runtimeType);

      // print(data_map[element].runtimeType);
      // data.add(_ChartData(element.substring(5,10), data_map[element]));
    // });
    print("data is here");
    print(chart_data);

    charts.TooltipBehavior _tooltip = charts.TooltipBehavior(enable: true);
    return charts.SfCartesianChart( 
            primaryXAxis: charts.CategoryAxis(axisLine: AxisLine(width: 0), majorGridLines: MajorGridLines(width: 0),),
            primaryYAxis: charts.NumericAxis(minimum: 0, maximum: 12, interval: 1, axisLine: AxisLine(width: 0), majorGridLines: MajorGridLines(width: 0),),
            tooltipBehavior: _tooltip,
            plotAreaBorderWidth: 0,
            series: <charts.ChartSeries<_ChartData, String>>[
              charts.AreaSeries<_ChartData, String>(
                  dataSource: chart_data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  color: Color.fromARGB(255, 13, 144, 162),
              ),
            ],
          );           
  }

  Widget homeWidget() {
    return MaterialApp( 
      
      home: Scaffold (
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              constraints: BoxConstraints(minWidth: 120, minHeight: 60),
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseCalendar()));
              }, 
            
              icon: ImageIcon(AssetImage('assets/images/cal_button.png',), color: Colors.black, size: 100.0),
            ),
          ],
        ),
      backgroundColor: appBackgroundColor,
      body:ListView(
      children: [
        const Padding(padding: EdgeInsets.fromLTRB(10,0,10,10),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CalenderPicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Color.fromARGB(255,89,195,178),
              selectedTextColor: Colors.white,

              // width: 40,
              // height: 60,

              dateTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              dayTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                });
              },
            ),

            Container(
              // height: 200,
              // width: 300,
              margin: const EdgeInsets.fromLTRB(0,10,0,0),
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
                        child: const Text("Your back is straight. Good job!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                      ),
                      secondChild: Container(
                        child: RichText(text: TextSpan(children: [WidgetSpan(child: ImageIcon(AssetImage('assets/images/Layer_1.png',), color: Colors.orange.shade800),), 
                                                                  TextSpan(
                                                                    text: "You are slouching by ${_angle.toInt().abs().toString()}\u00B0",
                                                                    style: const TextStyle(color: Color.fromARGB(255, 245, 115, 9), fontWeight: FontWeight.w600),
                                                                  )])) 
                        //Text("You are slouching by ${_angle.toInt().abs().toString()}\u00B0", style: const TextStyle(color: Color.fromARGB(255, 245, 115, 9), fontWeight: FontWeight.w600),),
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
                  padding: EdgeInsets.only(top:10),
                  constraints: const BoxConstraints(minWidth: 150.0),
                  child:Card(
                    elevation: 2,
                    child:Column(children:[
                      Text("Goal: $_posture_goal_hours hr $_posture_goal_mins min", textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 23, 114, 109), 
                                                                                                                                  fontFamily: "Roboto",
                                                                                                                                  fontWeight: FontWeight.w600),),
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
                                  minimum: 0,
                                  maximum: max(1, (_posture_goal_hours*60 + _posture_goal_mins)).toDouble(),
                                  ranges: [
                                    GaugeRange(startValue: 0, endValue: _best_duration_today.toDouble()),
                                  ],
                                  annotations: [
                                    GaugeAnnotation(widget: Text("$_best_duration_today min"))
                                  ],
                                ),
                              ],
                            ),
                      ),
                      const Padding(padding: EdgeInsets.only(top:10, left:15, right:15)),
                  ]),)
                ),
                 Container(
                  padding: EdgeInsets.only(top:10),
                  constraints: const BoxConstraints(minWidth: 150.0),
                  child:Card(
                    elevation: 2,
                    child:Column(children:[
                      const Text("Ratio (last 3 days)", textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 23, 114, 109), 
                                                                                                      fontFamily: "Roboto",
                                                                                                      fontWeight: FontWeight.w600),),
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
                                minimum: 0,
                                maximum: 36*3600,
                                ranges: [
                                  GaugeRange(startValue: 0, endValue: last_three_days_total.toDouble())
                                ],
                                annotations: [
                                  GaugeAnnotation(widget: Text("${double.parse(((last_three_days_total/(36*3600)*100)).toStringAsFixed(2))}%"))
                                ],
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
              // constraints: const BoxConstraints(maxHeight: 100),
              child:
                Column(
                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Visibility(
                      visible: _isShow,
                      child: chartWidget(),
                    ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Row(
                      children:[
                    Padding(
                      padding: EdgeInsets.only(left:30),
                      child:ElevatedButton(
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 23, 114, 109),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            _isShow = !_isShow;
                          },
                        );
                      },
                      child: Text(
                        _isShow ? 'Hide' : 'Show daily summary',
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                    )])
                  ],
                ),
              // chartWidget(),
            ),

            ElevatedButton(
              onPressed: (){

                checkPosture();
                updateDailyTotal(FirebaseAuth.instance.currentUser!.uid, (DateTime.now().toIso8601String()).substring(5,10), seconds_straight);
                updateUserBestDuration(FirebaseAuth.instance.currentUser!.uid, (DateTime.now().difference(startTime)).inSeconds);
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