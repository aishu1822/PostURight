import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:firebase_core/firebase_core.dart';

class Streak {
  final DateTime startDate;
  final DateTime endDate;

  Streak(this.startDate, this.endDate);
}

class ExerciseCalendar extends StatefulWidget {
  @override
  _ExerciseCalendarState createState() => _ExerciseCalendarState();
}

class _ExerciseCalendarState extends State<ExerciseCalendar> {
  DateTime minD = DateTime.now().subtract(Duration(days: 30));
  DateTime maxD = DateTime.now().add(Duration(days: 30));
  late final calendarController;// = CleanCalendarController(minDate: minD,maxDate: maxD);
  

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((value) => _updateCalendarController());
    calendarController = CleanCalendarController(minDate: DateTime.now(),maxDate:  DateTime.now().add(const Duration(days: 365)));
    
  }

  Future<void> _updateCalendarController() async {
    // print("entered updateCalendarController");
    String current_uuid = FirebaseAuth.instance.currentUser!.uid;
    final dailyData = await FirebaseDatabase.instance.ref().child('profiles/$current_uuid/best_duration_held').get();
    
    // if (!dailyData.exists) return;
    // if (dailyData.value == null) return;
    print("daily data = ${dailyData.toString()}");
    print("daily data type= ${dailyData.value.runtimeType}");
    Map streaks = dailyData.value as Map;

    // final streaks = streakData.map((doc) => Streak(doc['startDate'].toDate(), doc['endDate'].toDate())).toList();
    // print("streaks = $streaks");
    if (streaks.isNotEmpty) {
      //final mostRecentStreak = streaks.last;
      //calendarController.initialDateSelected = mostRecentStreak.startDate;
      for (final dateKey in streaks.keys) {
        //calendarController.selectRange(streak.startDate, streak.endDate);
        // DateTime d = DateTime.parse(dateKey);
        // print("dateKey = $dateKey");
        // calendarController.selectRange(d, d);
        // calendarController.selectRange(DateTime.now(), DateTime.now().add(const Duration(days: 365)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color.fromARGB(255, 0, 150, 136),
          primaryContainer: Color.fromARGB(255, 0, 150, 136),
          secondary: Color(0xFFD32F2F),
          secondaryContainer: Color(0xFF9A0007),
          surface: Color(0xFFDEE2E6),
          background: Color(0xFFF8F9FA),
          error: Color(0xFF96031A),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar Streak'),
          actions: [
            IconButton(
              onPressed: () {
                calendarController.clearSelectedDates();
              },
              icon: const Icon(Icons.clear),
            )
          ],
        ),
        body: Column(
          children: [
            FutureBuilder<DataSnapshot>(
              future: FirebaseDatabase.instance.ref().child("profiles/${FirebaseAuth.instance.currentUser!.uid}/best_duration_held").get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) return const CircularProgressIndicator();
                  if (!snapshot.data!.exists) return const CircularProgressIndicator();
                  // print("${snapshot.data}");
                  Map snapshot_map = snapshot.data!.value as Map;
                  // final streakCount = snapshot_map?['streakCount'] ?? 0;
                  // final totalDaysUsed = snapshot_map?['totalDaysUsed'] ?? 0;
                  // final streakCount = snapshot_map['streakCount'];
                  // final totalDaysUsed = snapshot_map['totalDaysUsed'];

                  final duration_data = snapshot_map;
                  print("duration data type: ${duration_data.toString()}");
                  int streakCount = 0;
                  int totalDaysUsed = duration_data.length;

                  for (final date in duration_data.keys) {
                    print("duration data type: ${duration_data[date].runtimeType}");
                    if (duration_data[date] > 3600) {
                      streakCount++;
                    }
                  }

                  return Column(
                    children: [
                      Text('Current streak: $streakCount days'),
                      Text('Total days used: $totalDaysUsed'),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Expanded(
              child: ScrollableCleanCalendar(
                calendarController: calendarController,
                layout: Layout.BEAUTY,
                calendarCrossAxisSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
