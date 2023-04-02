import 'package:flutter/material.dart';
import 'package:posturight/login.dart';
import 'home.dart';
import 'text_field.dart';
import 'colors.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                loginTextField("Enter username", false, _emailTextController),
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
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage(title: 'Home')));
                  }, 
                  child: Text("Create Account")
                )
              ],
            )
          ) 
        ),
      ),
    );
  }
}