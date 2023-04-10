import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:posturight/profile_model.dart';
import 'title.dart';
import 'alert_settings.dart';
import 'exercises.dart';
import 'profile.dart';
import 'home.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:cron/cron.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

final Guid accX_uuid = Guid("00002101-0000-1000-8000-00805f9b34fb");
final Guid accY_uuid = Guid("00002102-0000-1000-8000-00805f9b34fb");
final Guid accZ_uuid = Guid("00002103-0000-1000-8000-00805f9b34fb");
final Guid gyrX_uuid = Guid("00002104-0000-1000-8000-00805f9b34fb");
final Guid gyrY_uuid = Guid("00002105-0000-1000-8000-00805f9b34fb");
final Guid gyrZ_uuid = Guid("00002106-0000-1000-8000-00805f9b34fb");
final Guid angle_uuid = Guid("00002107-0000-1000-8000-00805f9b34fb");

Timer? postureNotifTimer;
String currentPosture = "nothing yet";
int seconds_straight = 0;
final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

@pragma('vm:entry-point')
void countDailyTotal(String arg) { 
  Timer.periodic(Duration(seconds:1), (timer) {
    double a = interpretValue(readValues[angle_uuid]!);
    if (a <= 75.0 || a >= 105.0) {
      return;
    }
    seconds_straight++;
  });  
}

double interpretValue(List<int> data) {
  if (data.length < 4) return 0.0;
  final bytes = Uint8List.fromList(data);
  final byteData = ByteData.sublistView(bytes);
  double value = byteData.getFloat32(0,Endian.little);
  // print(value); 
  return value;
}

class AppRoot extends StatefulWidget {
  AppRoot({Key? key}) : super(key: key);
  
  // final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  @override
  State<AppRoot> createState() => AppRootState();
}

class AppRootState extends State<AppRoot> with TickerProviderStateMixin {

  // int selectedBottomBarIndex = 0;
  int _currentIndex = 0;
  late Widget _currentWidget;//Registration1Screen();
  //WelcomeScreen();//TitleScreen();//Container();

  List<int> accXchar=[], accYchar=[], accZchar=[], gyrXchar=[], gyrYchar=[], gyrZchar=[];
  List<BluetoothService> _services = <BluetoothService>[];
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  BluetoothDevice? _connectedDevice = null;
  final cron = Cron();
  DateTime startTime = DateTime.now();
  double _animateHeight = 80.0;
  double _animateWidth = 80.0;
  bool _resized = false;

  @override
  void initState() {
    super.initState();
    
    compute(countDailyTotal, "arg");
    scheduleUpdateDailyTotalDB();

    flutterBlue.setLogLevel(LogLevel.info);
    Widget titleScreen = HomePage(title: 'Home');//TitleScreen(callback: refresh);
    _currentWidget = titleScreen;

    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan();

    postureNotifTimer = Timer.periodic(const Duration(seconds:1),(arg) {
      checkPosture();
    });
  }

  void scheduleUpdateDailyTotalDB() async {
    cron.schedule(Schedule.parse('59 23 * * *'), () async {
      // print("This code runs at 11:59pm everyday");
      String current_uid = FirebaseAuth.instance.currentUser!.uid;
      String date = (DateTime.now().toIso8601String()).substring(5,10);
      final db_ref = FirebaseDatabase.instance.ref().child("/profiles/$current_uid/daily_total_duration");
      db_ref.set({
        '$date' : '$seconds_straight'
      });
      seconds_straight = 0;
      // reset ongoing time so it doesn't carry over from previous day
      startTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    super.dispose();
    postureNotifTimer!.cancel();
  }

  void refresh(Widget widget) {
    setState(() {
      _currentWidget = widget;
    });
  }

  void _loadScreen() {
    switch(_currentIndex) {
      case 0: return setState(() => _currentWidget = HomePage(title: 'Home'));
      case 1: return setState(() => _currentWidget = ProfilePage(title: 'Profile'));
      case 2: return setState(() => _currentWidget = ExercisesPage(title: 'Exercises'));
      case 3: return setState(() => _currentWidget = AlertSettingsPage(title: 'Alert Settings'));    
    }
  }  
  
  Future<void> checkPosture() async {
    if (_connectedDevice == null) return;

    // BluetoothService serv = _services[2]; // assuming 3 services and IMU service is the third one
    // assert(serv.uuid.toString().split('-')[0] == '00001101');
    
    // print("timer thread");
    
    double accX = interpretValue(readValues[accX_uuid]!);
    double accY = interpretValue(readValues[accY_uuid]!);
    double accZ = interpretValue(readValues[accZ_uuid]!);
    double gyrX = interpretValue(readValues[gyrX_uuid]!);
    double gyrY = interpretValue(readValues[gyrX_uuid]!);
    double gyrZ = interpretValue(readValues[gyrX_uuid]!);
    double angle = interpretValue(readValues[angle_uuid]!);

    // print("Accelerometer: accX = $accX, accY = $accY, accZ = $accZ");
    // print("Gyroscope: gyrX = $gyrX, gyrY = $gyrY, gyrZ = $gyrZ");
    print("Angle: $angle");

    if (angle <= 75.0 || angle >= 105.0) {
      startTime = DateTime.now();
      currentPosture = "slouching";

    } else {
      if (currentPosture == "straight") {
        DateTime endTime = DateTime.now();
        int new_duration = (endTime.difference(startTime)).inSeconds;
        // username should be FirebaseAuth.instance.currentUser.uid
        bool updated = await updateUserBestDuration(FirebaseAuth.instance.currentUser!.uid, new_duration);
        if (!updated) {
          print("failed to update best duration");
        }
        print("new_duration: $new_duration");
      }
      currentPosture = "straight";
    }
  }

  _addDeviceTolist(final BluetoothDevice device) {
   if (!devicesList.contains(device)) {
     setState(() {
       devicesList.add(device);
     });
   }
 }

 List<ButtonTheme> _buildReadWriteNotifyButton(BluetoothCharacteristic characteristic) {
   List<ButtonTheme> buttons = <ButtonTheme>[];
 
   if (characteristic.properties.read) {
     buttons.add(
       ButtonTheme(
         minWidth: 10,
         height: 20,
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 4),
           child: ElevatedButton(
             child: Text('READ', style: TextStyle(color: Colors.white)),
             onPressed: () async {
               var sub = characteristic.value.listen((value) {
                 setState(() {
                   readValues[characteristic.uuid] = value;
                 });
               });
               await characteristic.read();
               sub.cancel();
             },
           ),
         ),
       ),
     );
   }

   if (characteristic.properties.notify) {
     buttons.add(
       ButtonTheme(
         minWidth: 10,
         height: 20,
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 4),
           child: ElevatedButton(
             child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
             onPressed: () async {
              characteristic.value.listen((value) {
                readValues[characteristic.uuid] = value;
              });
              await characteristic.setNotifyValue(true);
             },
           ),
         ),
       ),
     );
   }
 
   return buttons;
 }

 ListView _buildConnectDeviceView() {
  List<Container> containers = <Container>[];
 
   for (BluetoothService service in _services) {
     List<Widget> characteristicsWidget = <Widget>[];
     for (BluetoothCharacteristic characteristic in service.characteristics) {
       characteristicsWidget.add(
         Align(
           alignment: Alignment.centerLeft,
           child: Column(
             children: <Widget>[
               Row(
                 children: <Widget>[
                   Text(characteristic.uuid.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                 ],
               ),
              //  Row(
              //    children: <Widget>[
              //      ..._buildReadWriteNotifyButton(characteristic),
              //    ],
              //  ),
             ],
           ),
         ),
       );
     }
     containers.add(
       Container(
         child: ExpansionTile(
             title: Text(service.uuid.toString()),
             children: characteristicsWidget),
       ),
     );
   }
 
   return ListView(
     padding: const EdgeInsets.all(8),
     children: <Widget>[
       ...containers,
     ],
   );
 }

 ListView _buildListViewOfDevices() {
   List<Container> containers = <Container>[];
   for (BluetoothDevice device in devicesList) {
    //  print(device.id);
    //  print(device.name);
     if (device.id.toString() != "78:21:84:AA:36:56" || device.name.toString() != "PostURight Sensor") continue;
     containers.add(
       Container(
         height: 50,
         child: Row(
           children: <Widget>[
             Expanded(
               child: Column(
                 children: <Widget>[
                   Text(device.name == '' ? '(unknown device)' : device.name),
                   Text(device.id.toString()),
                 ],
               ),
             ),
             ElevatedButton(
               child: Text(
                 'Connect',
                 style: TextStyle(color: Colors.white),
               ),
               onPressed: () async {
                List<BluetoothService> newServices;
                List<BluetoothCharacteristic> bclist;
                flutterBlue.stopScan();
                  try {
                    await device.connect();

                  } catch (e) {
                    // if (e.code != 'already_connected') {
                    //   throw e;
                    // }
                    print(e);
                  } finally {
                    newServices = await device.discoverServices();
                    // TODO: remove idx hard coding
                    bclist = newServices[2].characteristics; 
                    for (BluetoothCharacteristic c in bclist) {
                      c.value.listen((value) {
                        readValues[c.uuid] = value;
                      });                      
                      await c.setNotifyValue(true);
                    }
                    setState(() {
                      _services = newServices;
                      _connectedDevice = device; 
                    });

                    // Navigator.pushAndRemoveUntil(context,
                    //   MaterialPageRoute(builder: (context) => AppRoot()),
                    //   (Route<dynamic> route) => false,
                    // );
                  }
                  
               },
             ),
           ],
         ),
       ),
     );
   }

   Timer.periodic(Duration(seconds: 8), (timer) { 
    setState(() {
                    if (_resized) {
                      _resized = false;
                      _animateHeight = 200.0;
                      _animateWidth = 200.0;
                    } else {
                      _resized = true;
                      _animateHeight = 300.0;
                      _animateWidth = 300.0;
                    }
                  });
   });
 
   return ListView(
     padding: const EdgeInsets.all(8),
     children: <Widget>[
       ...containers,

       Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),),
       AnimatedContainer(
              duration: const Duration(seconds:3),
              // vsync: this,
              curve: Curves.bounceInOut,
              // child: Container(
              // alignment: Alignment(3,3),
              width: _animateWidth,
              height:_animateHeight,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.teal.shade400,),
                    // ),
              child: Text("Detecting devices...",),
              
        ),
             
     ],
   );
 }

 Widget appRootWidget() {
  return MaterialApp (
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 182, 224, 207).withOpacity(1),
        body: _currentWidget,

        bottomNavigationBar: BottomNavigationBar(
          // fixedColor: Color.fromARGB(255, 193, 6, 207).withOpacity(.94),
          selectedItemColor: Color.fromARGB(255, 193, 6, 207).withOpacity(.94),
          unselectedItemColor: Color.fromARGB(255, 37, 5, 220).withOpacity(.94),
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
          ],
          onTap: (index) {
            setState(() => _currentIndex = index);
            _loadScreen();
          },
        ),
      )
    );
 }

 Widget _buildView() {
   if (_connectedDevice != null) {
     return appRootWidget();//_buildConnectDeviceView();
   }
   return Scaffold(
       appBar: AppBar(
         title: Text("Detecting bluetooth devices"),
       ),
       body:_buildListViewOfDevices(),
      );
 }


  @override
  Widget build(BuildContext context) {
    return _buildView();    
  }
}