import '../Controller/1MainHelper/Snacks/snackbar.dart';
import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import 'login.dart';
import 'personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Setting());
}

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image(
          image: AssetImage('assets/images/m1.png'),
        ),
        title: Text(
          'الأعدادات',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              SvgPicture.asset(
                ('assets/images/Doc9.svg'),
                height: 200,
                width: double.infinity,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: HexColor("#e6e8f5"),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Image(
                    image: AssetImage('assets/images/m6.png'),
                    height: 35,
                  ),
                  title: Text(
                    'تعديل بياناتي',
                    style: TextStyle(
                        color: HexColor("#051DA4"),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    bool checkIfSignedIn =
                        Provider.of<AuthDataProvider>(context, listen: false)
                            .checkIfSignedIn();
                    if (checkIfSignedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalInfo(),
                        ),
                      );
                    } else {
                      showTopSnackBar(
                        title: 'تنبيه',
                        body: 'من فضلك قم بتسجيل الدخول اولا',
                        context: context,
                      );
                      await Future.delayed(
                        Duration(seconds: 2),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
