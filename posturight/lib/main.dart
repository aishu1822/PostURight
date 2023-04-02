import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:posturight/registration1.dart';
import 'package:posturight/registration2.dart';
import 'package:posturight/registration3.dart';
import 'package:posturight/login.dart';
import 'alert_settings.dart';
import 'exercises.dart';
import 'profile.dart';
import 'home.dart';
import 'title.dart';

// import 'globals.dart';

final database = FirebaseDatabase.instance.ref();
// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PostURight',
      home:App(),
    );
  }

  // @override
  // State<MyApp> createState() => _MyAppState();
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {

  // int selectedBottomBarIndex = 0;
  int _currentIndex = 0;
  late Widget _currentWidget;//Registration1Screen();
  //WelcomeScreen();//TitleScreen();//Container();


  @override
  void initState() {
    super.initState();
    Widget titleScreen = TitleScreen(callback: refresh);
    _currentWidget = titleScreen;
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

  
 
  @override
  Widget build(BuildContext context) {

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

  // return a widget representing a page
  // Widget _buildBody() {
  //   return currentWidget;
  // }

}