import 'package:flutter/material.dart';

BottomNavigationBar? bottomNavigationBar(Function onTap, bool hide) {
  if (hide) return null;
  return BottomNavigationBar(
          // fixedColor: Color.fromARGB(255, 193, 6, 207).withOpacity(.94),
          selectedItemColor: Color.fromARGB(255, 193, 6, 207).withOpacity(.94),
          unselectedItemColor: Color.fromARGB(255, 37, 5, 220).withOpacity(.94),
          items: const[
            BottomNavigationBarItem(
              icon : Icon(Icons.home),
              label : 'Home',
            ),
            BottomNavigationBarItem(
              icon : Icon(Icons.home),
              label : 'Profile',
            ),
            BottomNavigationBarItem(
              icon : Icon(Icons.business),
              label : 'Exercise',
            ),
            BottomNavigationBarItem(
              icon : Icon(Icons.school),
              label : 'Alerts',
            ),
          ],
          onTap: (index) {
            // setState(() => _currentIndex = index);
            // _loadScreen();
            onTap();
          },
        );
}