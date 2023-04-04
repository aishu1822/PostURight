
import 'package:flutter/material.dart';
import 'create_account.dart';
import 'login.dart';

Widget registrationButton(String text, BuildContext context, String nextPage) {
  Widget nextPageWidget = Container(child: Text("need to assign next page"));
  if (nextPage == "register") {
    nextPageWidget = CreateAccountScreen();
  } else if (nextPage == "login") {
    nextPageWidget = LoginScreen();
  }
  return ElevatedButton(
    onPressed: () {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => nextPageWidget));
    }, 
    child: Text(text,
                style: TextStyle(color: Colors.white, 
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16),),
    
    style: ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width-10, 55),
      primary: Color.fromARGB(255, 23, 114, 109),
      side: BorderSide(color: Color.fromARGB(255, 23, 114, 109),),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )
      )
    );
}