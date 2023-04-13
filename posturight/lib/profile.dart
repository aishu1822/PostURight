import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:posturight/progess_card.dart';
import 'colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    style: TextStyle(fontFamily: 'lato', fontSize: 17.0, fontWeight: FontWeight.w600, height: 1.171879, color: Color(0xff263238))
            
                  ),
                  const Text(
                    "Level 12 | 2 day streak",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'lato', fontSize: 17.0, fontWeight: FontWeight.w600, height: 1.171879, color: Color(0xff263238))
                  ),]
              ),
              Container(margin: EdgeInsets.fromLTRB(25, 0, 24, 0), 
                        padding: EdgeInsets.fromLTRB(10, 9, 10, 23.07), 
                        width: double.infinity, 
                        decoration: BoxDecoration(border: Border.all(color: Color(0xffdadada)), color: Color(0xffffffff),borderRadius: BorderRadius.circular(6)),
              //MyCard(),
              //Card(
                // clipBehavior is necessary because, without it, the InkWell's animation
                // will extend beyond the rounded edges of the [Card] (see https://github.com/flutter/flutter/issues/109776)
                // This comes with a small performance cost, and you should not set [clipBehavior]
                // unless you need it.
                //clipBehavior: Clip.hardEdge,
                //child: InkWell(
                  //splashColor: Colors.blue.withAlpha(30),
                  //onTap: () {
                    //debugPrint('Card tapped.');
                  //},
                  
                  child: 
                    Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: 
                                   Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 13.93),
                                    width: double.infinity,
                                    child: 
                                      Text(
                                        'Achievements',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                          color: Color(0xff898a8d),
                                        ),
                                      )),
                                    ),
                                   Container(
                                    margin: EdgeInsets.fromLTRB(11, 0, 114, 23),
                                    width: double.infinity,
                                    child:
                                     Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:  EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                                          width: 36,
                                          height: 37,
                                          child: 
                                          Image.network(
                                            'assets/Frame4.png',
                                           //['image_1.png'],
                                           width: 36,
                                           height: 37,
                                          ),
                                        ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0.12, 1, 0.12, 0.12),
                                        child:
                                         Text(
                                          'Bronze League',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5,
                                            color: Color(0xff1f1f1f),
                                          ),
                                          ),

                                      ),
                                      ],
                                     ),
                                   ),
                                   Container(
                                    margin: EdgeInsets.fromLTRB(11, 0.1, 13.67, 8.53),
                                    padding: EdgeInsets.fromLTRB(0.1, 0.1, 100.33, 0.1),
                                    width: double.infinity,
                                    height: 49.47,
                                    child:
                                     Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                                          width: 36,
                                          height: 36,
                                          child:
                                          Image.network(
                                            'assets/Frame4.png',
                                            //[image_2.png],
                                            width: 36,
                                            height: 36,

                                          ),

                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0.1, 4, 0.1, 0.1),
                                          child:
                                          Text(
                                            'Silver League',
                                             style: TextStyle(
                                             fontSize: 14,
                                             fontWeight: FontWeight.w500,
                                             height: 1.5,
                                             color: Color(0xff1f1f1f),

                                             ),
                                          ),
                                        ),

                                      ],
                                     ),
                                   ),
                                   Container(
                                    margin: EdgeInsets.fromLTRB(11, 0.1, 114, 0.1),
                                    width: double.infinity,
                                    child:
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                         margin: EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                                         width: 36,
                                         height: 37,
                                         child:
                                         Image.network(
                                          'assets/Frame4.png',
                                          //['image_3.png'],
                                          width: 36,
                                          height: 37,
                                         ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0.1, 1, 0.1, 0.1),
                                          child: 
                                          Text(
                                            'Gold League',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5,
                                              color: Color(0xff1f1f1f),
                                            ),

                                          ),
                                        ),
                                      ],
                                    ),

                                   ),

              Container(
                width: double.infinity,
                height: 228,
                child: 
                  Stack(
                    children: [
                      Positioned(
                        left: 24,
                        top: 0.1,
                        child:
                         Align(
                          child: 
                           SizedBox(
                            width: 341,
                            height: 222,
                            child: 
                             Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Color(0xffdadada)),
                                color:  Color(0xffffffff),

                              ),
                             ),
                           ),
                         ),
                      ),
                      Positioned(
                        left: 35,
                        top: 9,
                        child:
                         Center(
                          child:
                           Align(
                            child:
                              SizedBox(
                                width: 108,
                                height: 21,
                                child:
                                 Text(
                                  'Leaderboard',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    color: Color(0xff898a8d),
                                  ),
                                ),
                           ), 
                         ),
                        ),
                      ),
                      Positioned(
                        left: 46,
                        top: 43.929,
                        child: 
                        Align(
                          child:
                          SizedBox(
                            width: 36,
                            height: 37,
                            child:
                             Image.network(
                              'assets/Frame4.png',
                              //['url'],
                              width: 36,
                              height: 37,

                             ),
                          ),
                        ),

                      ),
                      Positioned(
                        left: 46,
                        top: 103.929,
                        child:
                        Align(
                          child:
                          SizedBox(
                            width: 36,
                            height: 36,
                            child:
                             Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Color(0xffcecece),
                              ),
                             ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 46,
                        top: 161.929,
                        child: 
                         Align(
                          child:
                          SizedBox(
                            width:36,
                            height: 37,
                            child:
                             Image.network(
                              'assets/Frame4.png',
                              //['Url2'],
                              width: 36,
                              height: 37,
                             ),
                          ),
                         ),
                      ),
                      Positioned(
                        left: 108,
                        top:48.929,
                        child:
                         Align(
                          child:
                          SizedBox(
                            width:134,
                            height: 28,
                             child: 
                             Text(
                              'John',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Color(0xff1f1f1f),
                              ),
                             ),
                          ),
                         ),
                      ),
                      Positioned(
                        left: 108,
                        top: 107.929,
                        child: 
                        Align(
                          child:
                          SizedBox(
                            width: 134,
                            height: 28,
                            child:
                            Text(
                              'Jane',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Color(0xff1f1f1f),
                              ),
                            ),
                    
                          ),

                        ),
                      ),
                      Positioned(
                        left: 160,
                        top: 53,
                        child:
                        Container(
                          width: 41,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Color(0xff6a6a6a),
                            borderRadius:  BorderRadius.circular(50),

                          ),
                          child: 
                          Center(
                            child: 
                             Text(
                              'You',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Color(0xffffffff),
                              ),
                             ),
                          ),


                        ),
                        
                        
                      ),
                      Positioned(
                        left: 0.01,
                        top: 169,
                        child: 
                        Container(
                          width: 390,
                          height: 59,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                          ),
                          child:
                          Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top:-3,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width: 390,
                                    height: 62,
                                    child: 
                                    Container(
                                      decoration: BoxDecoration(color: Color(0xffe1e1e1),),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 312,
                                top: 16,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child:
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.only(top: 0.1, left:0.13),
                                      ),
                                      child: 
                                       Image.network(
                                        'assets/Frame4.png',
                                       // ['icon1'],
                                        width: 30,
                                        height: 30,
                                       ),

                                     ),
                                  ),),
                              ),
                              Positioned(
                                left: 48,
                                top:16,
                                child:
                                Align(
                                  child: 
                                  SizedBox(
                                    width: 30,
                                    height:30,
                                    child:
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.only(top: 0.1, left:0.13),
                                      ),
                                      child:
                                      Image.network(
                                        'assets/Frame4.png',
                                        //['icon2'],
                                        width: 30,
                                        height: 30,
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 142.68115,
                                top: 18.499,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width: 17.05,
                                    height: 24.76,
                                    child:
                                    Image.network(
                                      'assets/Frame4.png',
                                      //['icon3'],
                                      width: 17.05,
                                      height: 24.76,
                                    ),

                                  ),
                                ),
                              ),
                              Positioned(
                                left: 224,
                                top:16,
                                child:
                                Container(
                                  width: 30,
                                  height:30,
                                  child:
                                  Center(
                                    child:
                                    SizedBox(
                                      width: 30,
                                      height:30,
                                      child:
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.only(top: 0.1, left:0.13),



                                        ),
                                        child: 
                                        Image.network(
                                          'assets/Frame4.png',
                                          //['icon4'],
                                          fit: BoxFit.cover,
                                        )

                                      
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              

                            ],
                          ),

                        ),
                      ),

                    ],
                  ),
                    

              ),                  


                                //  Text("Leaderboard",
                                //       overflow: TextOverflow.ellipsis,
                                //       textAlign: TextAlign.center,
                                //       /*style: AppStyle.txtSFProRegular12*/),
                                // Padding(
                                //     padding:const EdgeInsets.only(top: 14,),
                                //     child: Row(children: [
                                //       ClipOval(
                                //         child: SizedBox.fromSize(
                                //           size: const Size.fromRadius(23), // Image radius
                                //           child: Image.asset(
                                //                           'assets/Frame4.png',
                                //                         ),
                                //         ),
                                //       ),
                                //       Padding(
                                //           padding: const EdgeInsets.only(top: 8, left: 13,),
                                //           child:Text("John",
                                //               overflow: TextOverflow.ellipsis,
                                //               textAlign: TextAlign.left,
                                //               /*style:AppStyle.txtPoppinsMedium14*/),),
                                //     ])),
                                // Padding(
                                //     padding: const EdgeInsets.only(top: 23,),
                                //     child: Row(children: [
                                //       ClipOval(
                                //         child: SizedBox.fromSize(
                                //           size: const Size.fromRadius(23), // Image radius
                                //           child: Image.asset(
                                //                           'assets/Frame4.png',
                                //                         ),
                                //         ),
                                //       ),
                                //       Padding(
                                //           padding: const EdgeInsets.only(top: 8, left: 13,),
                                //           child: Text("Jane",
                                //               overflow: TextOverflow.ellipsis,
                                //               textAlign: TextAlign.left,
                                //               /*style:AppStyle.txtPoppinsMedium14*/))
                                //     ])),
                                // Padding(
                                //     padding: const EdgeInsets.only(top: 21, bottom:10),
                                //     child: Row(children: [
                                //       ClipOval(
                                //         child: SizedBox.fromSize(
                                //           size: const Size.fromRadius(23), // Image radius
                                //           child: Image.asset(
                                //                           'assets/Frame4.png',
                                //                         ),
                                //         ),
                                //       ),
                                //       Padding(
                                //           padding: const EdgeInsets.only(top: 8, left: 13,),
                                //           child: Text("Jane",
                                //               overflow: TextOverflow.ellipsis,
                                //               textAlign: TextAlign.left,
                                //               /*style:AppStyle.txtPoppinsMedium14*/))
                                //     ])),
                                  ]
                  ),
                ),
              
            ],
          ),
        ),
      ),
     );
  }
}