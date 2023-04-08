import 'package:flutter/material.dart';
import 'package:posturight/app_root.dart';
import 'colors.dart';
import 'style.dart';
import 'time.dart';

// ignore_for_file: must_be_immutable
class Registration3Screen extends StatefulWidget {
  @override
  State<Registration3Screen> createState() => _Registration3ScreenState();
}

class _Registration3ScreenState extends State<Registration3Screen> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
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
                                controller: _controller,
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
