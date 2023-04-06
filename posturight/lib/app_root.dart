import 'package:flutter/material.dart';
import 'title.dart';
import 'alert_settings.dart';
import 'exercises.dart';
import 'profile.dart';
import 'home.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:typed_data';

Timer? postureNotifTimer;
String currentPosture = "nothing yet";

class AppRoot extends StatefulWidget {
  AppRoot({Key? key}) : super(key: key);
  
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
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

  double interpretValue(List<int> data) {
    if (data.length < 4) return 0;
    final bytes = Uint8List.fromList(data);
    final byteData = ByteData.sublistView(bytes);
    double value = byteData.getFloat32(0,Endian.little);
    print(value); 
    return value;
  }

  void checkPosture() {
    if (_connectedDevice == null) return;

    // BluetoothService serv = _services[2]; // assuming 3 services and IMU service is the third one
    // assert(serv.uuid.toString().split('-')[0] == '00001101');
    
    print("timer thread");
    
    double accX = interpretValue(widget.readValues[accX_uuid]!);
    double accY = interpretValue(widget.readValues[accY_uuid]!);
    double accZ = interpretValue(widget.readValues[accZ_uuid]!);
    double gyrX = interpretValue(widget.readValues[gyrX_uuid]!);
    double gyrY = interpretValue(widget.readValues[gyrX_uuid]!);
    double gyrZ = interpretValue(widget.readValues[gyrX_uuid]!);

    print("Accelerometer: accX = $accX, accY = $accY, accZ = $accZ");
    print("Gyroscope: gyrX = $gyrX, gyrY = $gyrY, gyrZ = $gyrZ");

    if (accZ > 0.3) {
      currentPosture = "slouching!";
    } else {
      if (currentPosture == "slouching!" || currentPosture == "nothing yet") {
        currentPosture = "straight!";
      }
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
                   widget.readValues[characteristic.uuid] = value;
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
                widget.readValues[characteristic.uuid] = value;
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
                        widget.readValues[c.uuid] = value;
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
         title: Text("Detecting bluetooth devices"),//Text(widget.title),
       ),
       body:_buildListViewOfDevices(),
      );
 }


  @override
  Widget build(BuildContext context) {
    return _buildView();    
  }
}