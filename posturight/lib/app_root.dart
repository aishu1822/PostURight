import 'dart:ffi';
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

final Guid accX_uuid = Guid("00002101-0000-1000-8000-00805f9b34fb");
final Guid accY_uuid = Guid("00002102-0000-1000-8000-00805f9b34fb");
final Guid accZ_uuid = Guid("00002103-0000-1000-8000-00805f9b34fb");
final Guid gyrX_uuid = Guid("00002104-0000-1000-8000-00805f9b34fb");
final Guid gyrY_uuid = Guid("00002105-0000-1000-8000-00805f9b34fb");
final Guid gyrZ_uuid = Guid("00002106-0000-1000-8000-00805f9b34fb");
final Guid angle_uuid = Guid("00002107-0000-1000-8000-00805f9b34fb");

Timer? postureNotifTimer;
String currentPosture = "nothing yet";

final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

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

class AppRootState extends State<AppRoot> {

  // int selectedBottomBarIndex = 0;
  int _currentIndex = 0;
  late Widget _currentWidget;//Registration1Screen();
  //WelcomeScreen();//TitleScreen();//Container();

  List<int> accXchar=[], accYchar=[], accZchar=[], gyrXchar=[], gyrYchar=[], gyrZchar=[];
  List<BluetoothService> _services = <BluetoothService>[];
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  BluetoothDevice? _connectedDevice = null;

  DateTime startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
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

    // if (accZ > 0.3) {
    //   currentPosture = "slouching!";
    // } else {
    //   if (currentPosture == "slouching!" || currentPosture == "nothing yet") {
    //     currentPosture = "straight!";
    //   }
    // }    

    if (angle <= 75.0 || angle >= 105.0) {
      if (startTime != null && currentPosture == "straight") {
        DateTime endTime = DateTime.now();
        int new_duration = (endTime.difference(startTime)).inSeconds;
        // username should be FirebaseAuth.instance.currentUser.uid
        bool updated = await updateUserBestDuration(FirebaseAuth.instance.currentUser!.uid, new_duration);
        if (!updated) {
          print("failed to update best duration");
        }
        print("new_duration: $new_duration");
      }
      currentPosture = "slouching";
    } else {
      if (startTime == null || currentPosture != "straight") {
        startTime = DateTime.now();
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
                   Text(characteristic.uuid.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                 ],
               ),
               Row(
                 children: <Widget>[
                   ..._buildReadWriteNotifyButton(characteristic),
                 ],
               ),
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
 
   return ListView(
     padding: const EdgeInsets.all(8),
     children: <Widget>[
       ...containers,
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