import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppDialog {
  static void customFlushBar({BuildContext context, String message}) {
    Flushbar(
      backgroundGradient: LinearGradient(
        colors: [
          Color(0xffc0caf7).withOpacity(0.82),
          HexColor("#051DA4").withOpacity(0.82),
        ],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      ),
      message: message,
      duration: Duration(seconds: 3),
    ).show(context);
  }
}
