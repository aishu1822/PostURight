import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:posturight/progess_card.dart';
import 'colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.title, Key? key}) : super(key: key);
  final String? title;
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentStep = 10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
     return MaterialApp(
      home: Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // // user card
              // SimpleUserCard(
              //   userName: "Nom de l'utilisateur",
              //   userProfilePic: AssetImage("assets\\Frame4.png"),
              // ),
              Column (
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                      child: Image.asset(
                                      'assets/Frame4.png',
                                      width: 100,
                                      height: 100,
                                    ),
                    ),
                  ),
                  const Text(
                    "Jane Doe",
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "15 Friends",
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Level 12 | 2 day streak",
                    textAlign: TextAlign.center,
                  ),]
              ),
              MyCard(),
              Card(
                // clipBehavior is necessary because, without it, the InkWell's animation
                // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
                // This comes with a small performance cost, and you should not set [clipBehavior]
                // unless you need it.
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: 
                    Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Text("Friend Leaderboard",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      /*style: AppStyle.txtSFProRegular12*/),
                                Padding(
                                    padding:const EdgeInsets.only(top: 14,),
                                    child: Row(children: [
                                      ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(23), // Image radius
                                          child: Image.asset(
                                                          'assets/Frame4.png',
                                                        ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 8, left: 13,),
                                          child:Text("John",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              /*style:AppStyle.txtPoppinsMedium14*/),),
                                    ])),
                                Padding(
                                    padding: const EdgeInsets.only(top: 23,),
                                    child: Row(children: [
                                      ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(23), // Image radius
                                          child: Image.asset(
                                                          'assets/Frame4.png',
                                                        ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 8, left: 13,),
                                          child: Text("Jane",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              /*style:AppStyle.txtPoppinsMedium14*/))
                                    ])),
                                Padding(
                                    padding: const EdgeInsets.only(top: 21, bottom:10),
                                    child: Row(children: [
                                      ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(23), // Image radius
                                          child: Image.asset(
                                                          'assets/Frame4.png',
                                                        ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 8, left: 13,),
                                          child: Text("Jane",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              /*style:AppStyle.txtPoppinsMedium14*/))
                                    ])),
                                  ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
     );
  }
}