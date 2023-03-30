import 'package:flutter/material.dart';
import 'colors.dart';
import 'style.dart';

// ignore_for_file: must_be_immutable
class Registration1Screen extends StatefulWidget {
  @override
  State<Registration1Screen> createState() => _Registration1ScreenState();
}

class _Registration1ScreenState extends State<Registration1Screen> {
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
                          child: Text("Tell us more about yourself",
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: Style.txtSFProSemibold28
                              )
                          ),
                      Padding(
                          padding: const EdgeInsets.only(top:32),
                
                          child: Text("What is your name?",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: Style.txtRobotoRegular16
                              )
                          ),
                      TextFormField(
                          focusNode: FocusNode(),
                          controller: nameController,
                          // initialValue: "Jane Doe",
                          // margin: getMargin(top: 4),
                          // variant: TextFormFieldVariant.OutlineBluegray600_1,
                          // fontStyle:TextFormFieldFontStyle.RobotoRegular16Black90001,
                          textInputAction: TextInputAction.done),
                      Padding(
                          padding: const EdgeInsets.only(top: 38),
                          child: Text("What is your birth date?",
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
                        ),
                      Padding(
                          padding: const EdgeInsets.only(top: 38),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("Height",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      // style: AppStyle.txtRobotoRegular16
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
                                    ),
                                  ]
                                ),
                                Column(
                                    children: [
                                    Text("Weight",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      // style: AppStyle.txtRobotoRegular16
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(primary: Colors.white,
                                      side: const BorderSide(
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
                                    ),
                                  ],
                                ),
                                
                              ])),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              
                              OutlinedButton(
                                onPressed: (){}, 
                                child: Text("Next")),
                              OutlinedButton(
                                onPressed: (){}, 
                                child: Text("Skip")),
                            ],)
                      
                    ]))));
  }

  onTapNext(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.iphone14FourOneScreen);
  }

  onTapTxtSkip(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.iphone14FourOneScreen);
  }
}
