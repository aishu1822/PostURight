import 'package:flutter/material.dart';
import 'alert_settings.dart';
import 'exercises.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PostURight',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:const App(),
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
  Widget _currentWidget = Container();

  void _loadScreen() {
    switch(_currentIndex) {
      case 0: return setState(() => _currentWidget = App());
      case 1: return setState(() => _currentWidget = ProfilePage(title: 'Profile'));
      case 2: return setState(() => _currentWidget = ExercisesPage(title: 'Exercises'));
      case 3: return setState(() => _currentWidget = AlertSettingsPage(title: 'Alert Settings',));    
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 198, 214, 186).withOpacity(.94),
        // appBar: AppBar(
        //   title: const Text(
        //     "PostURight",
        //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: _buildBody(),
        
        // bottomNavigationBar: BottomNavigation (
        //   currentTab: _currentTab, 
        //   onSelectTab: _selectTab,
        // ),

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
  Widget _buildBody() {
    return _currentWidget;
  }

}