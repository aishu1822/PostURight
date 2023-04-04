import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:posturight/login.dart';
import 'calendar.dart';
import 'package:calender_picker/calender_picker.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'colors.dart';
import 'main.dart';
import 'title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:typed_data';
import 'app_root.dart';

final Guid accX_uuid = new Guid("00002101-0000-1000-8000-00805f9b34fb");
final Guid accY_uuid = new Guid("00002102-0000-1000-8000-00805f9b34fb");
final Guid accZ_uuid = new Guid("00002103-0000-1000-8000-00805f9b34fb");
final Guid gyrX_uuid = new Guid("00002104-0000-1000-8000-00805f9b34fb");
final Guid gyrY_uuid = new Guid("00002105-0000-1000-8000-00805f9b34fb");
final Guid gyrZ_uuid = new Guid("00002106-0000-1000-8000-00805f9b34fb");

class HomePage extends StatefulWidget {
  HomePage({required this.title, Key? key, Function? refresh}) : super(key: key);
  final String? title;
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final profileRef = database.child("/profile");
  double buttonDayHeightWidth = 40;
  var _selectedValue = DateTime.now();

  List<int> accXchar=[], accYchar=[], accZchar=[], gyrXchar=[], gyrYchar=[], gyrZchar=[];
  String _current_posture = "nothing yet";
  List<BluetoothService> _services = <BluetoothService>[];
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  BluetoothDevice? _connectedDevice = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    var period = const Duration(seconds:1);
    Timer.periodic(period,(arg){
      checkPosture();
    });
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
      setState(() {
        _current_posture = "slouching!";
      });
    } else {
      if (_current_posture == "slouching!" || _current_posture == "nothing yet") {
        setState(() {
        _current_posture = "straight!";
      });
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
                List<BluetoothService> new_services;
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
                    new_services = await device.discoverServices();
                    // TODO: remove idx hard coding
                    bclist = new_services[2].characteristics; 
                    for (BluetoothCharacteristic c in bclist) {
                      c.value.listen((value) {
                        widget.readValues[c.uuid] = value;
                      });                      
                      await c.setNotifyValue(true);
                    }
                    setState(() {
                      _services = new_services;
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

  Widget homeWidget() {
    return MaterialApp( 
      
      home: Scaffold (
      backgroundColor: appBackgroundColor,
      body:ListView(
      children: [
        Padding(padding: const EdgeInsets.all(10),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CalenderPicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedValue = date;
                });
              },
            ),

            ElevatedButton (
              onPressed: () {
                profileRef.set({'firstname': 'Jane', 'lastname': 'Doe'});
              },
              child: Text("Test set db"),
            ),


            Container(
              height: 200,
              width: 300,
              child: Card(
                  child: 
                    Text("Posture status: " + _current_posture),
                ),
            ),
            Wrap(
              children: [
                Card(
                  child: 
                    SimpleCircularProgressBar(
                        mergeMode: true,
                        onGetText: (double value) {
                            return Text('${value.toInt()}%');
                        },
                    ),
                ),
                Card(
                  child: 
                    SimpleCircularProgressBar(
                        mergeMode: true,
                        onGetText: (double value) {
                            return Text('${value.toInt()}%');
                        },
                    ),
                ),
              ]
            ),

            ElevatedButton(
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed out");
                  Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => TitleScreen()),
                            (Route<dynamic> route) => false,
                          );
                });
              }, 
              child: Text("Logout"),
            ),
          ],
      )
      ],

    ))
    );
  }

  Widget _buildView() {
   if (_connectedDevice != null) {
     return homeWidget();//_buildConnectDeviceView();
   }
   return Scaffold(
       appBar: AppBar(
         title: Text("Posture status: " + _current_posture),//Text(widget.title),
       ),
       body:_buildListViewOfDevices()
      );
 }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}