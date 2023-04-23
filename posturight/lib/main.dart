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
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  // int selectedBottomBarIndex = 0;
  int _currentIndex = 0;
  Widget _currentWidget = Registration2Screen();//Registration1Screen();
  //WelcomeScreen();//TitleScreen();//Container();

  void _loadScreen() {
    switch(_currentIndex) {
      case 0: return setState(() => _currentWidget = HomePage(title: 'Home'));
      case 1: return setState(() => _currentWidget = ProfilePage());
      case 2: return setState(() => _currentWidget = ExercisesPage());
      case 3: return setState(() => _currentWidget = AlertSettingsPage());    
    }
  }
 
  @override
  Widget build(BuildContext context) {

    return MaterialApp (
      // TODO: if user logged in, then app_root.dart, else, title.dart
      home: TitleScreen()
    );
  }
}