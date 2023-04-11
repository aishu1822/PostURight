// import 'imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';
import 'package:flutter/painting.dart';

class Style {

static BoxDecoration get outlineBluegray600 => BoxDecoration(
  border: Border.all(
    color: c2,
    width: 2,//getHorizontalSize(2,),
    // strokeAlign: StrokeAlign.outside,
  ),
);

static TextStyle txtPalanquinDarkRegular42 = TextStyle(
    color: c3,//ColorConstant.teal300,
    fontSize: 42,//getFontSize(42,),
    fontFamily: 'Palanquin Dark',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtSFProRegular22 = TextStyle(
    color: black,
    fontSize: 22,//getFontSize(22,),
    fontFamily: 'SF Pro',
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtSFProSemibold28 = TextStyle(
    color: black,
    fontSize: 28,//getFontSize(22,),
    fontFamily: 'SF Pro',
    fontWeight: FontWeight.w400,
  );
  
  
  static TextStyle txtSFProRegular12 = TextStyle(
    color: black,
    fontSize: 12,//getFontSize(22,),
    fontFamily: 'SF Pro',
    fontWeight: FontWeight.w400,
  );

 static TextStyle txtRobotoRegular16 = TextStyle(
    color: black,
    fontSize: 16,
    fontFamily: 'RobotoRegular16Black90001',
    fontWeight: FontWeight.w400,
  );

 static TextStyle txtRobotoRomanMedium28Teal900 = TextStyle(
    color: Colors.teal,
    fontSize: 28,
    fontFamily: 'RobotoRomanMedium28Teal900',
    fontWeight: FontWeight.w400,
  );
  

}