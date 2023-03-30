import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'style.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appBackgroundColor,//ColorConstant.gray50,
            body: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 24,right: 24,),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 94,//getVerticalSize(94),
                          width: 265,//getHorizontalSize(265),
                          margin: const EdgeInsets.only(top: 29,),//getMargin(top: 29),
                          child: 
                            Wrap(
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text("Welcome!",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: Style.txtPalanquinDarkRegular42)
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 32,),
                                  child: Text("Email",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      /*style: AppStyle.txtRobotoRegular16*/)
                                ),
                                TextFormField(
                                    controller: TextEditingController(text: ''),
                                    // initialValue: "TODO: email validation",
                                    // variant: TextFormFieldVariant.OutlineBluegray600_1,
                                    // fontStyle:TextFormFieldFontStyle.RobotoRegular16Black90001,
                                    // textInputAction: TextInputAction.done
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 32,),
                                  child: Text("Password",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      /*style: AppStyle.txtRobotoRegular16*/)
                                ),
                                TextFormField(
                                    controller: TextEditingController(text: ''),
                                    // initialValue: "TODO: pw validation",
                                    // variant: TextFormFieldVariant.OutlineBluegray600_1,
                                    // fontStyle:TextFormFieldFontStyle.RobotoRegular16Black90001,
                                    // textInputAction: TextInputAction.done
                                ),
                              ])),
                      const Spacer(),
                      SizedBox(
                        height: 56,
                        child: OutlinedButton(
                            // height: 56,//getVerticalSize(56),
                            // variant: ButtonVariant.FillTeal700,
                            // fontStyle: ButtonFontStyle.SFProBold20,
                            // onTap: () => onTapGetstarted(context), onPressed: () {  },
                            onPressed: () {  },
                            child: const Text("Sign In"),
                        ),
                      ),
                    ])
                    )
                  )
                );
  }

  onTapGetstarted(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.iphone14ThreeScreen);
  }
}