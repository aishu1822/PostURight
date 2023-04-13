import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:posturight/app_root.dart';
import 'colors.dart';
import 'style.dart';
import 'time.dart';
import 'profile_model.dart';

// ignore_for_file: must_be_immutable
class Registration3Screen extends StatefulWidget {
  @override
  State<Registration3Screen> createState() => _Registration3ScreenState();
}

class _Registration3ScreenState extends State<Registration3Screen> {
  late FixedExtentScrollController _hoursController;
  late FixedExtentScrollController _minutesController;

  @override
  void initState() {
    super.initState();
    _hoursController = FixedExtentScrollController();
    _minutesController = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appBackgroundColor,
            resizeToAvoidBottomInset: false,
            body: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: 
                  [
                    Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),),
                    const Text("Set your daily goal", textAlign: TextAlign.left, style: TextStyle(fontSize: 28, fontFamily: "SF Pro", color: Color.fromARGB(255, 23, 114, 109), fontWeight: FontWeight.w500),),
                    Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.1, 20, 0),),
                    Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        const Text("I want to maintain proper posture for"),
                        Row(       
                          mainAxisAlignment: MainAxisAlignment.center,                    
                          children: [
                            Container(
                              width: 70,
                              height: 80,
                              child: ListWheelScrollView.useDelegate(
                                controller: _hoursController,
                                itemExtent: 50,
                                perspective: 0.005,
                                diameterRatio: 1.2,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 13,
                                  builder: (context, index) {
                                    return MyHours(
                                      hours: index,
                                    );
                                  },
                                ),
                              ),
                            ),

                            // minutes wheel
                            Container(
                              width: 70,
                              height: 80,
                              child: ListWheelScrollView.useDelegate(
                                controller: _minutesController,
                                itemExtent: 50,
                                perspective: 0.005,
                                diameterRatio: 1.2,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 60,
                                  builder: (context, index) {
                                    return MyMinutes(
                                      mins: index,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),),
                        OutlinedButton(
                                onPressed: (){
                                  print("hours: ${_hoursController.selectedItem}");
                                  print("mins: ${_minutesController.selectedItem}");
                                  updateUserDurationGoal(FirebaseAuth.instance.currentUser!.uid, _hoursController.selectedItem, _minutesController.selectedItem);
                                  Navigator.pushAndRemoveUntil(context,
                                                        MaterialPageRoute(builder: (context) => AppRoot()),
                                                        (Route<dynamic> route) => false,
                                                      );
                                }, 
                                child: Text("Next", style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                        shadowColor:Color.fromARGB(255, 9, 57, 54),
                                        minimumSize: Size(MediaQuery.of(context).size.width-250, 40),
                                        primary: Color.fromARGB(255, 23, 114, 109),
                                        side: BorderSide(color: Color.fromARGB(255, 23, 114, 109),),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          )
                                        )
                        ),
                    ],
                  ),
                ]
              ),
          ));
  }
}
