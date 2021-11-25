import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void showTopSnackBar({BuildContext context, String title, String body}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: HexColor("#e6e8f5"),
    boxShadows: [
      BoxShadow(
          color: HexColor("#cfd4ec"), offset: Offset(0.0, 2.0), blurRadius: 3.0)
    ],
    isDismissible: false,
    duration: Duration(seconds: 2),
    icon: Icon(
      Icons.check,
      color: HexColor("#051DA4"),
    ),
    progressIndicatorBackgroundColor: Colors.white,
    titleText: Text(
      title,
      textScaleFactor: 1,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: HexColor("#D00404"),
      ),
      //fontFamily: "ShadowsIntoLightTwo"
    ),
    messageText: Text(
      body,
      textScaleFactor: 1,
      style: TextStyle(
        fontSize: 18.0,
        color: HexColor("#051DA4"),
      ),
    ),
  )..show(context);
}

void showBottomSnackBar({BuildContext context, String title, String body}) {
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: HexColor("#e6e8f5"),
    boxShadows: [
      BoxShadow(
          color: HexColor("#cfd4ec"), offset: Offset(0.0, 2.0), blurRadius: 3.0)
    ],
    isDismissible: false,
    duration: Duration(seconds: 2),
    icon: Icon(
      Icons.check,
      color: HexColor("#051DA4"),
    ),
    progressIndicatorBackgroundColor: Colors.white,
    titleText: Text(
      title,
      textScaleFactor: 1,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: HexColor("#D00404"),
      ),
      //fontFamily: "ShadowsIntoLightTwo"
    ),
    messageText: Text(
      body,
      textScaleFactor: 1,
      style: TextStyle(
        fontSize: 18.0,
        color: HexColor("#051DA4"),
      ),
    ),
  )..show(context);
}
