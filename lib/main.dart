import 'modules/splah_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import 'Controller/Providers/ReservationsProvider/reservations_provider.dart';
import 'modules/doctor_page.dart';
import 'modules/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth data
        ChangeNotifierProvider(
          create: (_) => AuthDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReservationsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Tajawal',
          primaryColor: HexColor("#051DA4"),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
                fontFamily: 'Tajawal',
                color: HexColor("#051DA4"),
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: HexColor("#051DA4")),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        locale: Locale('ar', 'AE'),
        routes: {
          Login.routeName: (ctx) => Login(),
          DoctorPage.routeName: (ctx) => DoctorPage(),
        },
        home: SplashPage(),
      ),
    );
  }
}
