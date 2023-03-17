import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'time.dart';

class AlertSettingsPage extends StatefulWidget {
  const AlertSettingsPage({required this.title, Key? key}) : super(key: key);
  final String? title;
  
  @override
  _AlertSettingsPageState createState() => _AlertSettingsPageState();
}

class _AlertSettingsPageState extends State<AlertSettingsPage> {
  late FixedExtentScrollController _controller;
  final double buttonDayHeightWidth = 30;
  bool _vibrationOn = false;

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
      backgroundColor: Color.fromARGB(255, 189, 211, 182),
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
                Row(children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () { },
                    child: const Text('Start'),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () { },
                    child: const Text('End'),
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