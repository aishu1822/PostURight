import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'style.dart';
import 'text_field.dart';
import 'home.dart';
import 'app_root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_model.dart';

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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 23, 114, 109),),
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
                          FirebaseAuth.instance
                          .signInWithEmailAndPassword(email: _emailTextController.text, 
                                                      password: _passwordTextController.text).then((value) {
                                                        Navigator.pushAndRemoveUntil(context,
                                                          MaterialPageRoute(builder: (context) => AppRoot()),
                                                          (Route<dynamic> route) => false,
                                                        );
                                                      }).onError((error, stackTrace) {
                                                        // TODO: tell user the error
                                                        print("Error: ${error.toString()}");
                                                      });
                        }, 
                        child: Text("Log in"),
                        style: ElevatedButton.styleFrom(
                          shadowColor:Color.fromARGB(255, 9, 57, 54),
                          minimumSize: Size(MediaQuery.of(context).size.width-10, 55),
                          primary: Color.fromARGB(255, 23, 114, 109),
                          side: BorderSide(color: Color.fromARGB(255, 23, 114, 109),),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                          )
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