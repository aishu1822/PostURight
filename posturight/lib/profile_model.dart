import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

void createUser(String uid, String username, String email, int postureDurationGoal) {
  final userData = {
    'username' : username,
    'email' : email,
    'duration_goal' : postureDurationGoal,
    'best_duration_held' : 0,
  };

  final db_ref = FirebaseDatabase.instance.ref();
  final profileRef = db_ref.child("/profiles/$uid");
  profileRef.set(userData).catchError((error) {
    print("failed to save data, Error: ${error.toString()}");
  });
}

Future<Map> getUserPostureDurationGoal(String uid) async {
  final db_ref = FirebaseDatabase.instance.ref();
  final userData = await db_ref.child('profiles/$uid/duration_goal').get();
  if (userData.exists) {
    print(userData.toString());
  } else {
    print("failed to retrieve data");
  }
  return {};
}

Future<int> getUserBestDuration(String uid) async {
  final db_ref = FirebaseDatabase.instance.ref();
  final profileRef = db_ref.child("/profiles/$uid");
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