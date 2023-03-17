// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:direct_select/direct_select.dart';


void main() {
  runApp(MyApp());
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
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
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
        backgroundColor: Color.fromARGB(255, 198, 214, 186).withOpacity(.94),
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
              Wrap(children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('S'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('M'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('T'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('W'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('T'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('F'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('S'),
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
                  DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndexHours!,
                    child: MySelectionItem(
                      isForList: false,
                      title: hours[selectedIndexHours!],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndexHours = index;
                      });
                    },
                    mode: DirectSelectMode.tap,
                    items: _buildItemsHours()
              ),
              DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndexMinutes!,
                    child: MySelectionItem(
                      isForList: false,
                      title: minutes[selectedIndexMinutes!],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndexMinutes = index;
                      });
                    },
                    mode: DirectSelectMode.tap,
                    items: _buildItemsMinutes()
              ),
              DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndexAMPM!,
                    child: MySelectionItem(
                      isForList: false,
                      title: ampm[selectedIndexAMPM!],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndexAMPM = index;
                      });
                    },
                    mode: DirectSelectMode.tap,
                    items: _buildItemsAMPM()
              ),
              ]),
              // DirectSelect(
              //       itemExtent: 35.0,
              //       selectedIndex: selectedIndexHours!,
              //       child: MySelectionItem(
              //         isForList: false,
              //         title: hours[selectedIndexHours!],
              //       ),
              //       onSelectedItemChanged: (index) {
              //         setState(() {
              //           selectedIndexHours = index;
              //         });
              //       },
              //       mode: DirectSelectMode.tap,
              //       items: _buildItemsHours()
              // ),
              // DirectSelect(
              //       itemExtent: 35.0,
              //       selectedIndex: selectedIndexMinutes!,
              //       child: MySelectionItem(
              //         isForList: false,
              //         title: minutes[selectedIndexMinutes!],
              //       ),
              //       onSelectedItemChanged: (index) {
              //         setState(() {
              //           selectedIndexMinutes = index;
              //         });
              //       },
              //       mode: DirectSelectMode.tap,
              //       items: _buildItemsMinutes()
              // ),
              // DirectSelect(
              //       itemExtent: 35.0,
              //       selectedIndex: selectedIndexAMPM!,
              //       child: MySelectionItem(
              //         isForList: false,
              //         title: ampm[selectedIndexAMPM!],
              //       ),
              //       onSelectedItemChanged: (index) {
              //         setState(() {
              //           selectedIndexAMPM = index;
              //         });
              //       },
              //       mode: DirectSelectMode.tap,
              //       items: _buildItemsAMPM()
              // ),
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