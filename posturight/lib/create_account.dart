import 'package:flutter/material.dart';
import 'package:posturight/login.dart';
import 'home.dart';
import 'text_field.dart';
import 'colors.dart';
import 'app_root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_model.dart';
import 'registration3.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar (
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:Color.fromARGB(255, 23, 114, 109),),
        ),
      ),
      body: Container (
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
                loginTextField("Enter username", false, _usernameTextController),
                const SizedBox(
                  height: 20,
                ),
                loginTextField("Enter email", false, _emailTextController),
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
                    .createUserWithEmailAndPassword(email: _emailTextController.text,
                                                    password: _passwordTextController.text).then((value) {
                                                      print("Created new account");
                                                      createUser(FirebaseAuth.instance.currentUser!.uid, _usernameTextController.text, _emailTextController.text, 0);
                                                      Navigator.pushAndRemoveUntil(context,
                                                        MaterialPageRoute(builder: (context) => Registration3Screen()),
                                                        (Route<dynamic> route) => false,
                                                      );
                                                    }).onError((error, stackTrace) {
                                                      print("Error: ${error.toString()}");
                                                  });
                  }, 
                  child: Text("Create Account"),
                  style: ElevatedButton.styleFrom(
                          shadowColor:Color.fromARGB(255, 9, 57, 54),
                          minimumSize: Size(MediaQuery.of(context).size.width-10, 55),
                          primary: Color.fromARGB(255, 23, 114, 109),
                          side: BorderSide(color: Color.fromARGB(255, 23, 114, 109),),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                          ),
                )
              ],
            )
          ) 
        ),
      ),
    );
  }
}