import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;

String demo_uid = "Gsm90VhQr0boPKxLUitlbtuIe3n2";

void createUser(String uid, String username, String email, int postureDurationGoal) {
  final userData = {
    'username' : username,
    'email' : email,
    'duration_goal' : postureDurationGoal,
    'best_duration_held' : {},
    'daily_total_duration' : {},
  };

  final db_ref = FirebaseDatabase.instance.ref();
  final profileRef = db_ref.child("/profiles/$uid");
  profileRef.set(userData).catchError((error) {
    print("failed to save data, Error: ${error.toString()}");
  });
}


bool updateUserDurationGoal(String uid, int hours, int minutes) {
  final db_ref = FirebaseDatabase.instance.ref();
  final profileRef = db_ref.child("/profiles/$uid");
  int goal = hours*3600 + minutes*60;
  profileRef.update({'duration_goal' : goal.toString()}).catchError((error) {
    print("failed to update user duration goal, Error: ${error.toString()}");
    return false;
  });
  return true;
}

Future<int> getUserPostureDurationGoal(String uid) async {
  final db_ref = FirebaseDatabase.instance.ref();
  final userData = await db_ref.child('profiles/$uid/duration_goal').get();
  if (userData.exists) {
    print(userData.toString());
    return int.parse(userData.value as String);
  } 
  print("failed to retrieve data");  
  return -1;
}

Future<int> getUserBestDuration(String uid) async {
  final db_ref = FirebaseDatabase.instance.ref();
  final date = DateTime.now().toIso8601String().substring(0,10);
  final data = await db_ref.child('profiles/$uid/best_duration_held/$date').get();
  if (data.exists) {
    // print("getting best duration");
    // print(data.value);
    return data.value as int;
  }     
  print("getUserBestDuration error");
  return 0; 
  
}

void updateDailyTotal(String uid, String date, int duration) {
  
  final db_ref = FirebaseDatabase.instance.ref().child("/profiles/$uid/daily_total_duration");
  db_ref.set({
    date : duration.toString()
  });
}

Future<bool> updateUserBestDuration(String uid, int new_duration) async {
  
  int current_best_duration = await getUserBestDuration(uid);

  if (new_duration <= current_best_duration) return true;

  final db_ref = FirebaseDatabase.instance.ref();
  final date = DateTime.now().toIso8601String().substring(0,10);
  final profileRef = db_ref.child("/profiles/$uid/best_duration_held");
  profileRef.update({date : new_duration}).catchError((error) {
    print("failed to update user best duration for today, Error: ${error.toString()}");
    return false;
  });
  return true;
}

// void loadFakeDailyData(String uid) {
//   final db_ref = FirebaseDatabase.instance.ref();
//   final profileRef = db_ref.child("/profiles/$demo_uid");

//   final data = {
//       'username' : 'fake',
//       'email' : 'fake',
//       'duration_goal' : 0,
//       'best_duration_held' : {
//         '2023-04-05' : 200,
//         '2023-04-06' : 200,
//         '2023-04-07' : 200,
//         '2023-04-08' : 200,
//       },
//       'daily_total_duration' : {
//         '2023-04-03' : 3600,
//         '2023-04-04' : 7200,
//         '2023-04-05' : 18000,
//         '2023-04-06' : 21600,
//         '2023-04-07' : 14400,
//         '2023-04-08' : 18000,
//       },
//   };

//   profileRef.set(data).catchError((error) {
//     print("failed to save fake daily data, Error: ${error.toString()}");
//   });
// }

Future<Map> getUserChartData(String uid) async {
  print("entered getUserChartData");
  final db_ref = FirebaseDatabase.instance.ref();
  final data = await db_ref.child('profiles/$uid/daily_total_duration').get();
  
  if (data.exists) {
    print("getting chart data");
    print(data.value);
    return data.value as Map;
  }     
  print("getUserChartData error");
  return {}; 
}