import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'calendar.dart';
import 'package:calender_picker/calender_picker.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);
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
    return ListView(
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
            )
          ],
      )
      ],

    );
  }
}