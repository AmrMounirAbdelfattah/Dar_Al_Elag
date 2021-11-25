import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';

void main() {
  runApp(Contact());
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('ar', 'AE')],
      locale: Locale('ar', 'AE'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ('assets/images/Doc11.svg'),
                  height: 200,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'مستشفي دار العلاج',
                  style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 40.0,
                      color: HexColor("#051DA4"),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.0,
                  width: 150.0,
                  child: Divider(
                    color: HexColor("#051DA4"),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: HexColor("#e6e8f5"),
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/m2.png'),
                      height: 35,
                    ),
                    title: GestureDetector(
                      onTap: () {
                        launch('tel://15074');
                      },
                      child: Text(
                        '15074',
                        style: TextStyle(
                            color: HexColor("#051DA4"),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: HexColor("#e6e8f5"),
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage('assets/images/m7.png'),
                      height: 35,
                    ),
                    title: GestureDetector(
                      onTap: () {
                        launch(
                            'https://www.facebook.com/DarAlElagClinics/');
                      },
                      child: Text(
                        'اتواصل معانا علي فيس بوك',
                        style: TextStyle(
                            color: HexColor("#051DA4"),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Contact()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
