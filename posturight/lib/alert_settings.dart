import 'dart:async';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profile.dart';
import 'package:vibration/vibration.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'time.dart';

class AlertSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskTimer()
    );
  }
}

class TaskTimer extends StatefulWidget {
  @override
  _TaskTimerState createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> {


  bool selectedDaysSunday = false;
  bool selectedDaysMonday = false;
  bool selectedDaysTuesday = false;
  bool selectedDaysWednesday = false;
  bool selectedDaysThursday = false;
  bool selectedDaysFriday = false;
  bool selectedDaysSaturday = false;
  void _toggleSelectedDaysSunday() {
    setState(() {
      selectedDaysSunday = !selectedDaysSunday;
    });
  }
  void _toggleSelectedDaysMonday() {
    setState(() {
      selectedDaysMonday = !selectedDaysMonday;
    });
  }
  void _toggleSelectedDaysTuesday() {
    setState(() {
      selectedDaysTuesday = !selectedDaysTuesday;
    });
  }
  void _toggleSelectedDaysWednesday() {
    setState(() {
      selectedDaysWednesday = !selectedDaysWednesday;
    });
  }
  void _toggleSelectedDaysThursday() {
    setState(() {
      selectedDaysThursday = !selectedDaysThursday;
    });
  }
  void _toggleSelectedDaysFriday() {
    setState(() {
      selectedDaysFriday = !selectedDaysFriday;
    });
  }
  void _toggleSelectedDaysSaturday() {
    setState(() {
      selectedDaysSaturday = !selectedDaysSaturday;
    });
  }
  bool _vibrationOn = false;
  double buttonDayHeightWidth = 35;
  String _startDate = '';
  String _startTime = '';
  String _endDate = '';
  String _endTime = '';
  late DateTime _startDateTime;
  late DateTime _endDateTime;
  bool _timerStarted = false;
  int _secondsRemaining = 0;
  late Timer _timer;
  _TaskTimerState() {
    _startDateTime = DateTime.now();
  }
  String _message = '';
  List<Task> _tasks = [];
  void _startTimer() {
    _secondsRemaining = _endDateTime.difference(DateTime.now()).inSeconds;
    _timerStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining--;
      });
      if (_secondsRemaining <= 0) {
        Vibration.vibrate(duration: 1000);
        _timer.cancel();
        _timerStarted = false;
        _addTaskToList();
      }
    });
  }
  void _stopTimer() {
    _timer.cancel();
    _timerStarted = false;
  }
  void _addTaskToList() {
    Task task = Task(
      startDate: _startDate,
      startTime: _startTime,
      endDate: _endDate,
      endTime: _endTime,
      message: _message,
    );
    setState(() {
      _tasks.add(task);
    });
  }
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }
  void _navigateToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            // IconButton(
            //   icon: const Icon(Icons.person),
            //   onPressed: () {
            //     _navigateToProfilePage(context);
            //   },
            // ),
            Expanded(
              child: Center(
                child: Text('Task Timer'),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 16.0),
           
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    setState(() {_vibrationOn = true;});
                  },
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Vibration Alert',
                  subtitle: "On",
                  trailing: Switch.adaptive(
                    value: _vibrationOn,
                    onChanged: (value) {},
                  ),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Vibration Type',
                  subtitle: "Default",
                ),
              ],
            ),
            // const SizedBox(height: 16.0),
            const Text('Start Date and Time'),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              initialValue: '',
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              timeLabelText: 'Time',
              onChanged: (val) {
                _startDateTime = DateTime.parse(val);
                setState(() {
                  _startDate = _startDateTime.toString().split(' ')[0];
                  _startTime = _startDateTime.toString().split(' ')[1];
                });
              },
            ),
            // const SizedBox(height: 16.0),
            const Text('End Date and Time'),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              initialValue: '',
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              timeLabelText: 'Time',
              onChanged: (val) {
                _endDateTime = DateTime.parse(val);
                setState(() {
                  _endDate = _endDateTime.toString().split(' ')[0];
                  _endTime = _endDateTime.toString().split(' ')[1];
                });
              },
            ),
           
            // const SizedBox(height: 16.0),
            const Text('Days'),
            // const SizedBox(height: 16.0),
            Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: [
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { _toggleSelectedDaysSunday();},
                      child: const Text('S'),
                    ),
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { _toggleSelectedDaysMonday();},
                      child: const Text('M'),
                    ),
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: const Text('T'),
                    ),
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: const Text('W'),
                    ),
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: const Text('T'),
                    ),
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: const Text('F'),
                    ),
                  ),
                  SizedBox(
                    height: buttonDayHeightWidth,
                    width: buttonDayHeightWidth,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () { },
                      child: const Text('S'),
                    ),
                  ),
                ],),
            // const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _timerStarted ? null : _startTimer,
                  child: const Text('Start Timer'),
                ),
                ElevatedButton(
                  onPressed: _timerStarted ? _stopTimer : null,
                  child: const Text('Stop Timer'),
                ),
              ],
            ),
            // const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  Task task = _tasks[index];
                  return ListTile(
                    title: Text(task.message),
                    subtitle: Text(
                        '${task.startDate} ${task.startTime} - ${task.endDate} ${task.endTime}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteTask(index);
                      },
                    ),
                  );
                },
              ),
            ),
            // const SizedBox(height: 16.0),
            Center(
              child: Text(
                _timerStarted
                    ? 'Time Remaining: $_secondsRemaining seconds'
                    : '',
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Task {
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final String message;
  Task({
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.message,
  });
}