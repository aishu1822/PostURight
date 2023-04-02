import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:posturight/login.dart';
import 'calendar.dart';
import 'package:calender_picker/calender_picker.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'colors.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key, Function? refresh}) : super(key: key);
  final String? title;
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double buttonDayHeightWidth = 40;
  var _selectedValue = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileRef = database.child("/profile");
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
                    SimpleCircularProgressBar(
                        mergeMode: true,
                        onGetText: (double value) {
                            return Text('${value.toInt()}%');
                        },
                    ),
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
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => LoginScreen()));
                
              }, 
              child: Text("Logout"),
            ),
          ],
      )
      ],

    ))
    );
  }
}