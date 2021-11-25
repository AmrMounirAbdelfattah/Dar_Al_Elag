import 'dart:async';

import 'package:daralelag/adminModules/adminLayout/adminHomeLayout.dart';

import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
//import '../layout/home_layout.dart';
import 'on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer timer;

  Future<void> initSharedPreferences() async {
    // Fetch and set sqlite data
    await Provider.of<AuthDataProvider>(context, listen: false)
        .fetchAndSetTable();

    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    if (prefs.getBool('showBoardingPage') ?? true) {
      prefs.setBool('showBoardingPage', false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminHomeLayout()));
    }
  }

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
