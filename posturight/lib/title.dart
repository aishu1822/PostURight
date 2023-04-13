import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:posturight/create_account.dart';
import 'colors.dart';
import 'login.dart';
import 'style.dart';
import 'registration_button.dart';

class TitleScreen extends StatelessWidget {

  // Function(Widget) callback;
  // TitleScreen({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appBackgroundColor,
            body: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Text("PostURight",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: Style.txtPalanquinDarkRegular42)),
                      const SizedBox(height: 15,),
                      Container(
                          alignment: Alignment.bottomCenter,
                          child: const Text("Helping you fix your posture...",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 18),
                          )),
                      const Padding(padding: EdgeInsets.only(top: 150)),
                      registrationButton("Get Started", context, "register"),
                      const SizedBox(height: 15,),
                      registrationButton("Already have an account? Log in", context, "login"),
                    ]
                  )
                )
              )
            );
  }
}