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
 
  @override
  Widget build(BuildContext context) {

    return MaterialApp (
      // TODO: if user logged in, then app_root.dart, else, title.dart
      home: TitleScreen()
    );
  }
}