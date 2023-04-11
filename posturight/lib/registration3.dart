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
            body: Container(
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                        Wrap( 
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

                            SizedBox(
                              width: 10,
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
                                child: Text("Next")
                        ),
                    ],
                  ),
              ),
          ));
  }
}
