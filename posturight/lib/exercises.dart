// import 'package:flutter/material.dart';
// import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

// class ExercisesPage extends StatefulWidget {
//   const ExercisesPage({required this.title, Key? key}) : super(key: key);
//   final String? title;
  
//   @override
//   _ExercisesPageState createState() => _ExercisesPageState();
// }

// class _ExercisesPageState extends State<ExercisesPage> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:flutter/material.dart';
class Exercises extends StatelessWidget {
  const Exercises({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: ExercisesPage(),
    );
  }
}
class ExercisesPage extends StatefulWidget {
  const ExercisesPage({required this.title, Key? key}) : super(key: key);
  final String title;
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}
class _ExercisesPageState extends State<ExercisesPage> {
  final List<Map<String, dynamic>> _allUsers = [    {"id": 1, "Exercise": "Downward dog"},    {"id": 2, "Exercise": "Plank"},    {"id": 3, "Exercise": "Child's Pose"},    {"id": 4, "Exercise": "Flexibility"},    {"id": 5, "Exercise": "Wall Slides"},    {"id": 6, "Exercise": "Single leg extension"},    {"id": 7, "Exercise": "Shoulder stretch"},    {"id": 8, "Exercise": "Renegade Rows"},    {"id": 9, "Exercise": "Superman"},    {"id": 10, "Exercise": "Side plank"},  ];
  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  void initState() {
    _foundUsers = _allUsers;
    super.initState();
  }
  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["Exercise"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: 
            // _foundUsers.isNotEmpty,
                  ListView.builder(
                    itemCount: _foundUsers.length,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(_foundUsers[index]["id"]),
                      color: Color.fromARGB(255, 187, 229, 230),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Text(_foundUsers[index]["id"].toString()),
                        title: Text(_foundUsers[index]["Exercise"]),
                      ),
                    ),
                  // _allUsers()
                ),
          ),
       ],
        ),
      ),
    );
  }
}