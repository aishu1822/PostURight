import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:posturight/progess_card.dart';
import 'colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profilepicture.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              'shashi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'shashi@example.com',
              style: TextStyle(fontSize: 16),
            ),
            /*const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.emoji_events, color: Colors.brown),
                SizedBox(width: 8),
                Icon(Icons.emoji_events, color: Colors.grey),
                SizedBox(width: 8),
                Icon(Icons.emoji_events, color: Colors.yellow),
              ],
            ),*/
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Edit Profile'),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 13.93),
                      width: double.infinity,
                      child: const Text(
                        'Achievements',
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(11, 0, 114, 23),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                          width: 36,
                          height: 37,
                          child: Image.asset(
                            'assets/bronze_badge.png',
                            width: 36,
                            height: 37,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.12, 1, 0.12, 0.12),
                          child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(11, 0.1, 13.67, 8.53),
                    padding: const EdgeInsets.fromLTRB(0.1, 0.1, 100.33, 0.1),
                    width: double.infinity,
                    height: 49.47,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                          width: 36,
                          height: 36,
                          child: Image.asset(
                            'assets/silver_badge.jpg',
                            width: 36,
                            height: 36,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 4, 0.1, 0.1),
                          child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(11, 0.1, 114, 0.1),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                          width: 36,
                          height: 37,
                          child: Image.asset(
                            'assets/gold_badge.png',
                            width: 36,
                            height: 37,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 1, 0.1, 0.1),
                          child: const Text(
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




                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 13.93),
                      width: double.infinity,
                      child: const Text(
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(11, 0, 114, 23),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                          width: 36,
                          height: 37,
                          child: Image.asset(
                            'assets/bronze_badge.png',
                            width: 36,
                            height: 37,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.12, 1, 0.12, 0.12),
                          child: const Text(
                            'shashi',
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
                    margin: const EdgeInsets.fromLTRB(11, 0.1, 13.67, 8.53),
                    padding: const EdgeInsets.fromLTRB(0.1, 0.1, 100.33, 0.1),
                    width: double.infinity,
                    height: 49.47,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                          width: 36,
                          height: 36,
                          child: Image.asset(
                            'assets/silver_badge.jpg',
                            width: 36,
                            height: 36,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 4, 0.1, 0.1),
                          child: const Text(
                            'jhon',
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
                    margin: const EdgeInsets.fromLTRB(11, 0.1, 114, 0.1),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 0.1, 26, 0.1),
                          width: 36,
                          height: 37,
                          child: Image.asset(
                            'assets/gold_badge.png',
                            width: 36,
                            height: 37,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.1, 1, 0.1, 0.1),
                          child: const Text(
                            'joe',
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
                ],
              ),
            ),
          ],
        ),)
      ),
    );
  }
}


