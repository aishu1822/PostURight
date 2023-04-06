import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:posturight/login.dart';
import 'calendar.dart';
import 'package:calender_picker/calender_picker.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'colors.dart';
import 'main.dart';
import 'title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:typed_data';
import 'app_root.dart';

final Guid accX_uuid = new Guid("00002101-0000-1000-8000-00805f9b34fb");
final Guid accY_uuid = new Guid("00002102-0000-1000-8000-00805f9b34fb");
final Guid accZ_uuid = new Guid("00002103-0000-1000-8000-00805f9b34fb");
final Guid gyrX_uuid = new Guid("00002104-0000-1000-8000-00805f9b34fb");
final Guid gyrY_uuid = new Guid("00002105-0000-1000-8000-00805f9b34fb");
final Guid gyrZ_uuid = new Guid("00002106-0000-1000-8000-00805f9b34fb");

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
              height: 200,
              width: 300,
              child: Card(
                  child: 
                    Text("Posture status: " + _displayPostureStatus),
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