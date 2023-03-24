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
  final imgIconWidthHeight = 40.0;
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
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 11, left:24),
                  child: Text("Routines",
                      overflow:TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      /*style: AppStyle.txtRobotoRomanMedium28Teal900*/))),
          Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Text("Personalized Routine",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  /*style: AppStyle.txtSFProRegular12*/),
                              Text("Based on you activity level and preferences",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  /*style: AppStyle.txtSFProRegular12*/),
                            Padding(
                                padding:const EdgeInsets.only(top: 14,),
                                child: Wrap(children: [
                                  // CustomImageView(
                                  //     imagePath: ImageConstant.imgEllipse8,
                                  //     height: getVerticalSize(37),
                                  //     width: getHorizontalSize(36),
                                  //     radius: BorderRadius.circular(
                                  //         getHorizontalSize(18))),
                                ]
                              )
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 10,
                              children: [ SizedBox(
                                            height: imgIconWidthHeight,
                                            width: imgIconWidthHeight,
                                            child: OutlinedButton(
                                                    style: ButtonStyle(
                                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                                                    ),
                                                    onPressed: () { },
                                                    child: const Text('img'),
                                                  ),
                                            
                                            ),
                                            SizedBox(
                                            height: imgIconWidthHeight,
                                            width: imgIconWidthHeight,
                                            child: OutlinedButton(
                                                    style: ButtonStyle(
                                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                                                    ),
                                                    onPressed: () { },
                                                    child: const Text('img'),
                                                  ),
                                            
                                            ),
                                        ],
                            ),
                      ]
              ),
            ),
          ),

              Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Text("Personalized Routine",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  /*style: AppStyle.txtSFProRegular12*/),
                              Text("Based on you activity level and preferences",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  /*style: AppStyle.txtSFProRegular12*/),
                            Padding(
                                padding:const EdgeInsets.only(top: 14,),
                                child: Wrap(children: [
                                  // CustomImageView(
                                  //     imagePath: ImageConstant.imgEllipse8,
                                  //     height: getVerticalSize(37),
                                  //     width: getHorizontalSize(36),
                                  //     radius: BorderRadius.circular(
                                  //         getHorizontalSize(18))),
                                ]
                              )
                            ),
                          ]
                  ),
                ),
              ),


           Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 11, left:24),
                  child: Text("Exercises",
                      overflow:TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      /*style: AppStyle.txtRobotoRomanMedium28Teal900*/))),
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