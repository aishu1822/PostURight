import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

void createUser(String firstname, String lastname, String username, String email, int postureDurationGoal) {
  final userData = {
    'email' : email,
    'firstname' : firstname,
    'lastname' : lastname,    
    'duration_goal' : postureDurationGoal,
    'best_duration_held' : 0,
  };

  final db_ref = FirebaseDatabase.instance.ref();
  final profileRef = db_ref.child("/profiles/$username");
  profileRef.set(userData).catchError((error) {
    print("failed to save data, Error: ${error.toString()}");
  });
}

Future<Map> getUserPostureDurationGoal(String username) async {
  final db_ref = FirebaseDatabase.instance.ref();
  final userData = await db_ref.child('profiles/$username/duration_goal').get();
  if (userData.exists) {
    print(userData.toString());
  } else {
    print("failed to retrieve data");
  }
  return {};
}

Future<int> getUserBestDuration(String username) async {
  final db_ref = FirebaseDatabase.instance.ref();
  final profileRef = db_ref.child("/profiles/$username");
  final date = DateTime.now().toIso8601String().substring(0,10);
  final data = await db_ref.child('profiles/$username/best_duration_held/$date').get();
  if (data.exists) {
    // print("getting best duration");
    // print(data.value);
    return data.value as int;
  }     
  print("getUserBestDuration error");
  return 0; 
  
}

Future<bool> updateUserBestDuration(String username, int new_duration) async {
  int current_best_duration = await getUserBestDuration(username);

  if (new_duration <= current_best_duration) return true;

  final db_ref = FirebaseDatabase.instance.ref();
  final date = DateTime.now().toIso8601String().substring(0,10);
  final profileRef = db_ref.child("/profiles/$username");
  profileRef.update({'best_duration_held/$date' : new_duration}).catchError((error) {
    print("failed to update user best duration, Error: ${error.toString()}");
    return false;
  });
  return true;
}