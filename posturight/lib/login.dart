import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'style.dart';
import 'text_field.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appBackgroundColor,
            extendBodyBehindAppBar: true,
            appBar: AppBar (
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Log in",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      loginTextField("Enter username", false, _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      loginTextField("Enter password", false, _passwordTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          // Navigator.push(context,
                          //   MaterialPageRoute(builder: (context) => HomePage(title: 'Home')));
                          // setState(() => currentWidget = HomePage(title: 'Home'));
                        }, 
                        child: Text("Log in")
                      )
                    ],
                  )
                )
              ),
            )
          )
        );
  }
}