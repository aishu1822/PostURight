import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:posturight/home.dart';
import 'time.dart';
import 'colors.dart';
import 'dart:async';

class AlertSettingsPage extends StatefulWidget {
  const AlertSettingsPage({required this.title, Key? key}) : super(key: key);
  final String? title;
  
  @override
  _AlertSettingsPageState createState() => _AlertSettingsPageState();
}

class _AlertSettingsPageState extends State<AlertSettingsPage> {
  late FixedExtentScrollController _controller;
  double buttonDayHeightWidth = 40;
  bool _vibrationOn = false;
  DateTime _startDate = DateTime.now(); // Variable to store start date
  DateTime _endDate = DateTime.now(); //Variable to store end end
  TimeOfDay _startTime = TimeOfDay.now(); // Variable to store start time
  TimeOfDay _endTime = TimeOfDay.now(); // Variable to store end time
  

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: _startDate, firstDate: new DateTime(1970, 10), lastDate: new DateTime(2101));
    if (picked != null) _startDate = picked; // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> _HomePageState(_startDate)));
  }
  
  Future<void> _selectEndDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(context: context, initialDate: _endDate, firstDate: new DateTime(1970, 10), lastDate: new DateTime(2101));
    if (picked != null) _endDate = picked;
  }
  
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: _startTime);
    if (picked != null) _startTime = picked ;
  }
  
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: _endTime);
    if (picked != null) _endTime = picked ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView( 
          children: [

            SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {
                        setState(() {_vibrationOn = true;});
                      },
                      icons: Icons.dark_mode_rounded,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.red,
                      ),
                      title: 'Vibration Alert',
                      subtitle: "On",
                      trailing: Switch.adaptive(
                        value: _vibrationOn,
                        onChanged: (value) {},
                      ),
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.fingerprint,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.red,
                      ),
                      title: 'Vibration Type',
                      subtitle: "Default",
                    ),
                  ],
                ),
                const Text("Choose the days you want"),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: [
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                            ),
                            onPressed: () { },
                            child: const Text('S'),
                          ),
                    
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                            ),
                            onPressed: () { },
                            child: const Text('M'),
                          ),
                    
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                            ),
                            onPressed: () { },
                            child: const Text('T'),
                          ),
                    
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                            ),
                            onPressed: () { },
                            child: const Text('W'),
                          ),
                    
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                            ),
                            onPressed: () { },
                            child: const Text('T'),
                          ),
                    
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                            ),
                            onPressed: () { },
                            child: const Text('F'),
                          ),
                    
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                            ),
                            onPressed: () { },
                            child: const Text('S'),
                          ),
                    
                  ),
                ]),

                const Text("Set Time"),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: <Widget>[
                    Text('Start Date: ${_startDate.toString()}',),
                    Text('Start Time: ${_startTime.toString()}',),
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      _selectStartDate(context);
                      _selectStartTime(context);
                     },
                    child: const Text('Start Date'),
                  ),
                  Text('End Date: ${_endDate.toString()}',),
                  Text('End Time: ${_endTime.toString()}',),
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () { 
                      _selectEndDate(context);
                      _selectEndTime(context);
                      },
                    child: const Text('End Date'),
                  ),
                ]),  
                                
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  // hours wheel
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

                  SizedBox(
                    width: 15,
                  ),

                  // am or pm
                  Container(
                    width: 70,
                    height: 80,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 50,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 2,
                        builder: (context, index) {
                          if (index == 0) {
                            return AmPm(
                              isItAm: true,
                            );
                          } else {
                            return AmPm(
                              isItAm: false,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
                 
            ],
          ),
        ),
      ),
    );
  }
}