import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:direct_select/direct_select.dart';


void main() {
  runApp(const MyApp());
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String? title;
  final bool isForList;

  const MySelectionItem({Key? key, this.title, this.isForList = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildItem(context),
            )
          : Card(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: FittedBox(
          child: Text(
        title!,
      )),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _vibrationOn = false;
  final double buttonDayHeightWidth = 45;
  final hours = [
    "1",
    "2",
    "3",
  ];
  final minutes = [
    "1",
    "2",
    "3",
  ];
  final ampm = [
    "AM",
    "PM",
  ];
  int? selectedIndexHours = 0, selectedIndexMinutes = 0, selectedIndexAMPM = 0;

  List<Widget> _buildItemsHours() {
    return hours
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  List<Widget> _buildItemsMinutes() {
    return minutes
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  List<Widget> _buildItemsAMPM() {
    return ampm
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

    void _invertVibrationOn() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _vibrationOn = true;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 198, 214, 186).withOpacity(.94),
        appBar: AppBar(
          title: const Text(
            "Alert Settings",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      _invertVibrationOn();
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
                  child: TextButton(
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
                  child: TextButton(
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
                  child: TextButton(
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
                  child: TextButton(
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
                  child: TextButton(
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
                  child: TextButton(
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
                  child: TextButton(
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
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('Start'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('End'),
                ),
              ]),
              Wrap(children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child:
                  DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndexHours!,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndexHours = index;
                      });
                    },
                    mode: DirectSelectMode.tap,
                    items: _buildItemsHours(),
                    child: MySelectionItem(
                      isForList: false,
                      title: hours[selectedIndexHours!],
                    )
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child:
                    DirectSelect(
                          itemExtent: 35.0,
                          selectedIndex: selectedIndexMinutes!,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedIndexMinutes = index;
                            });
                          },
                          mode: DirectSelectMode.tap,
                          items: _buildItemsMinutes(),
                          child: MySelectionItem(
                            isForList: false,
                            title: minutes[selectedIndexMinutes!],
                          )
                    ),
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child:
                    DirectSelect(
                          itemExtent: 35.0,
                          selectedIndex: selectedIndexAMPM!,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedIndexAMPM = index;
                            });
                          },
                          mode: DirectSelectMode.tap,
                          items: _buildItemsAMPM(),
                          child: MySelectionItem(
                            isForList: false,
                            title: ampm[selectedIndexAMPM!],
                          )
                    ),
                ),
              ]),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const[
            BottomNavigationBarItem(
              icon : Icon(Icons.home),
              label : 'Home',
            ),
            BottomNavigationBarItem(
              icon : Icon(Icons.home),
              label : 'Profile',
            ),
            BottomNavigationBarItem(
              icon : Icon(Icons.business),
              label : 'Exercise',
            ),
            BottomNavigationBarItem(
              icon : Icon(Icons.school),
              label : 'Alerts',
            ),
          ]
        ),
      ),
    );
  }
}