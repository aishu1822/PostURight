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
import 'colors.dart';
import 'package:flutter/services.dart';
import 'exercise_calender.dart';
import 'package:vibration/vibration.dart';


// TODO: put in firebase and make API call to read

Map guids = {};

// final Guid accX_uuid = Guid("00002101-0000-1000-8000-00805f9b34fb");
// final Guid accY_uuid = Guid("00002102-0000-1000-8000-00805f9b34fb");
// final Guid accZ_uuid = Guid("00002103-0000-1000-8000-00805f9b34fb");
// final Guid gyrX_uuid = Guid("00002104-0000-1000-8000-00805f9b34fb");
// final Guid gyrY_uuid = Guid("00002105-0000-1000-8000-00805f9b34fb");
// final Guid gyrZ_uuid = Guid("00002106-0000-1000-8000-00805f9b34fb");
// final Guid angle_uuid = Guid("00002107-0000-1000-8000-00805f9b34fb");

Guid accX_uuid  = Guid("0");
Guid accY_uuid  = Guid("0");
Guid accZ_uuid  = Guid("0");
Guid gyrX_uuid  = Guid("0");
Guid gyrY_uuid  = Guid("0");
Guid gyrZ_uuid  = Guid("0");
Guid angle_uuid = Guid("0");

Timer? postureNotifTimer;
String currentPosture = "nothing yet";
int seconds_straight = 0;
BluetoothDevice? _connectedDevice = null;
DateTime startTime = DateTime.now();

final Map<Guid, List<int>> readValues = Map<Guid, List<int>>();

void populateUuids() async {
  var uuid_data = await FirebaseDatabase.instance.ref().child('uuid').get();
  if (!uuid_data.exists) {
    print("failed to retrieve guid data for ble connection");  
    return;
  } 

  print(uuid_data.toString());
  guids = uuid_data.value as Map;
  accX_uuid = Guid(guids["accX_uuid"]);
  accY_uuid = Guid(guids["accY_uuid"]);
  accZ_uuid = Guid(guids["accZ_uuid"]);
  gyrX_uuid = Guid(guids["gyrX_uuid"]);
  gyrY_uuid = Guid(guids["gyrY_uuid"]);
  gyrZ_uuid = Guid(guids["gyrZ_uuid"]);
  angle_uuid = Guid(guids["angle_uuid"]);
}

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

    if (currentPosture == "straight") {
      DateTime endTime = DateTime.now();
      int new_duration = (endTime.difference(startTime)).inSeconds;
      bool updated = await updateUserBestDuration(FirebaseAuth.instance.currentUser!.uid, new_duration);
      if (!updated) {
        print("failed to update best duration");
      }
      // HapticFeedback.heavyImpact();//lightImpact();
      Vibration.vibrate( intensities: [1000]

        // pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500],
        //           intensities: [0, 128, 0, 255, 0, 64, 0, 255],

      );
      print("new_duration: $new_duration");
    }

    // reset
    startTime = DateTime.now();
    currentPosture = "slouching";

  } else {      
    currentPosture = "straight";
  }
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
  final cron = Cron();
  double targetValue = 200.0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  

  // ble connection animation variables
  double _animateHeight = 80.0;
  double _animateWidth = 80.0;
  bool _resized = false;

  @override
  void initState() {
    super.initState();
    populateUuids();
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
      // final db_ref = FirebaseDatabase.instance.ref().child("/profiles/$current_uid/daily_total_duration");
      // db_ref.set({
      //   date : seconds_straight.toString()
      // });
      updateDailyTotal(current_uid, date, seconds_straight);
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
      case 1: return setState(() => _currentWidget = ProfilePage());
      case 2: return setState(() => _currentWidget = ExercisesPage());
      case 3: return setState(() => _currentWidget = AlertSettingsPage());    
    }
  }  

  _addDeviceTolist(final BluetoothDevice device) {
   if (!devicesList.contains(device)) {
     setState(() {
       devicesList.add(device);
     });
   }
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

 BluetoothDevice? getDevice() {
  for (BluetoothDevice device in devicesList) {
    //  print(device.id);
    //  print(device.name);
     if (/*device.id.toString() != "78:21:84:AA:36:56" ||*/ device.name.toString() != "PostURight Sensor") continue;
     return device;
  }
  return null;
 }


 ListView _buildListViewOfDevices() {
   List<Container> containers = <Container>[];
   BluetoothDevice? device = getDevice();

   containers.add(Container(child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.15, 20, 0),),));
   if (device == null) {
    containers.add(Container(child:Text("No device detected", textAlign: TextAlign.center,)));
   }
   else {
  //  for (BluetoothDevice device in devicesList) {
    //  print(device.id);
    //  print(device.name);
    //  if (device.id.toString() != "78:21:84:AA:36:56" || device.name.toString() != "PostURight Sensor") continue;
     containers.add(
       Container(
        //  height: 50,
         child: Row(
           children: <Widget>[
             Expanded(
               child: Column(
                 children: <Widget>[
                  Text("${device.name == '' ? '(unknown device)' : device.name} detected"),
                  //  Text(device.id.toString()),
                 ],
               ),
             ),
           ],
         ),
       ),
     );
   }

   Widget detectingAnimation() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetValue),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double size, Widget? child) {
        return IconButton(
          iconSize: size,
          icon: child!,
          style: IconButton.styleFrom(shape: const CircleBorder(),),
          onPressed: () async {
            if (device == null) return;
            Timer.periodic(const Duration(seconds:1), (timer) {
              setState(() {
                targetValue = targetValue == 200.0 ? 300.0 : 200.0;
              });
            });   
                List<BluetoothService> newServices;
                List<BluetoothCharacteristic> bclist;
                flutterBlue.stopScan();
                  try {
                    if (device != null) {
                      await device.connect();
                    }

                  } catch (e) {
                    // if (e.code != 'already_connected') {
                    //   throw e;
                    // }
                    print(e);
                  } finally {
                    if (device == null) return;
                    newServices = await device!.discoverServices();
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
                  }                           
          },
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: const [          
          ImageIcon(AssetImage('assets/images/connect_button.png',), color: Color.fromARGB(255,89,195,178),),
          Text("Tap to connect to\ndevice once detected...\n\nMake sure to\nenable bluetooth", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: 'SF Pro'),),
        ])
    );           
   }
 
   return ListView(
     padding: const EdgeInsets.all(8),
     children: <Widget>[
       ...containers,

      Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.15, 20, 0),),
      detectingAnimation(),
      
     ],
   );
 }

 Widget appRootWidget() {
  return MaterialApp (
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 182, 224, 207).withOpacity(1),
        body: _currentWidget,

        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black,
          // selectedItemColor: Color.fromARGB(255, 193, 6, 207).withOpacity(.94),
          unselectedItemColor: Colors.black,
          items: const[
            BottomNavigationBarItem(
              icon : ImageIcon(AssetImage('assets/images/home.png',)),
              label : 'Home',
            ),
            BottomNavigationBarItem(
              icon : ImageIcon(AssetImage('assets/images/profile.png',)),
              label : 'Profile',
            ),
            BottomNavigationBarItem(
              icon : ImageIcon(AssetImage('assets/images/exercise.png',)),
              label : 'Exercise',
            ),
            BottomNavigationBarItem(
              icon : ImageIcon(AssetImage('assets/images/alert_settings.png',)),
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
      //  appBar: AppBar(
        //  title: Text("Detecting bluetooth devices"),
      //  ),
       backgroundColor: appBackgroundColor,
       body:
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/dashed_1.png'),
                  // fit: BoxFit.fitHeight,
                ),
              ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dashed_2.png'),
                // fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/dashed_3.png'),
                // fit: BoxFit.fitHeight,
              ),
            ),
          ),
            _buildListViewOfDevices(),
          ],
        ),
      );
 }


  @override
  Widget build(BuildContext context) {
    return _buildView();    
  }
}