import 'package:flutter/material.dart';
import 'colors.dart';
import 'style.dart';

// ignore_for_file: must_be_immutable
class Registration2Screen extends StatefulWidget {
  @override
  State<Registration2Screen> createState() => _Registration2ScreenState();
}

class _Registration2ScreenState extends State<Registration2Screen> {
  TextEditingController nameController = TextEditingController();
  final items = ['One', 'Two', 'Three', 'Four'];
  String selectedValue = 'Four';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appBackgroundColor,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 21, top: 30, right: 21, bottom: 30,),
                child: Wrap(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(),
                      Container(
                          // width: 200,
                          margin: const EdgeInsets.only(left: 3,),
                          child: Text("How active are you?",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: Style.txtSFProSemibold28
                              )
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 38),
                          child: Text("How often do you work out?",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              // style: AppStyle.txtRobotoRegular16
                            )
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.white, side: const BorderSide(
                              width: 1, // the thickness
                              color: Colors.black // the color of the border
                          )),
                          onPressed: (){}, 
                          child: 
                            DropdownButton<String>(
                              value: selectedValue,
                              onChanged: (value) => selectedValue,
                              items: items
                                    .map<DropdownMenuItem<String>>(
                                        (String value) => DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 42,
                              underline: SizedBox(),   
                            ),
                        )]),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 38),
                          child: Text("What type of workouts do you prefer?",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              // style: AppStyle.txtRobotoRegular16
                            )
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.white, side: const BorderSide(
                              width: 1, // the thickness
                              color: Colors.black // the color of the border
                          )),
                          onPressed: (){}, 
                          child: 
                            DropdownButton<String>(
                              value: selectedValue,
                              onChanged: (value) => selectedValue,
                              items: items
                                    .map<DropdownMenuItem<String>>(
                                        (String value) => DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 42,
                              underline: SizedBox(),   
                            ),
                        ),]),
                
                         Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              
                              OutlinedButton(
                                onPressed: (){}, 
                                child: Text("Next")),
                              OutlinedButton(
                                onPressed: (){}, 
                                child: Text("Skip")),
                            ],)]),
                      
                    ]))));
  }

  onTapNext(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.iphone14FourOneScreen);
  }

  onTapTxtSkip(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.iphone14FourOneScreen);
  }
}
