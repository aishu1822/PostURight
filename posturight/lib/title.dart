import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'style.dart';

class TitleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: c1,//ColorConstant.gray50,
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
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text("PostURight",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: Style.txtPalanquinDarkRegular42)),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("Lorem Ipsum sit dolor amet",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: Style.txtSFProRegular22))
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
                            child: const Text("Get Started"),
                        ),
                      ),
                      Container(
                          width: double.maxFinite,
                          child: Container(
                              margin: const EdgeInsets.only(top: 19,),//getMargin(top: 19),
                              padding: const EdgeInsets.only(top: 29,),//getPadding(all: 13),
                              decoration: Style.outlineBluegray600.copyWith(borderRadius: BorderRadius.circular(4,)),//BorderRadiusStyle.roundedBorder4),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(top: 5,),//getPadding(top: 5),
                                        child: RichText(
                                            text: const TextSpan(children: [
                                              TextSpan(
                                                  text:"Already have an account?",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 0x2b, 0x79, 0x74),//ColorConstant.blueGray600,
                                                      fontSize: 20,//getFontSize(20),
                                                      fontFamily: 'Helvetica Neue',
                                                      fontWeight:FontWeight.w500,
                                                      letterSpacing: 0.4,//getHorizontalSize(0.4)
                                                  )
                                              ),
                                              TextSpan(
                                                  text: " ",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 0x2b, 0x79, 0x74),
                                                      fontSize: 20,//getFontSize(20),
                                                      fontFamily:'Helvetica Neue',
                                                      fontWeight:FontWeight.w400,
                                                      letterSpacing:0.4)),//getHorizontalSize(0.4))),
                                              TextSpan(
                                                  text: "Log in",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 0x2b, 0x79, 0x74),
                                                      fontSize: 20,//getFontSize(20),
                                                      fontFamily:'Helvetica Neue',
                                                      fontWeight:FontWeight.w700,
                                                      letterSpacing:0.4,))//getHorizontalSize(0.4)))
                                            ]),
                                            textAlign: TextAlign.left))
                                  ])))
                    ]))));
  }

  onTapGetstarted(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.iphone14ThreeScreen);
  }
}