import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import 'contact_us.dart';
import 'setting.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class More extends StatefulWidget {
  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    bool checkIfSignedIn =
        Provider.of<AuthDataProvider>(context, listen: false).checkIfSignedIn();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          SvgPicture.asset(
            ('assets/images/Doc8.svg'),
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
                image: AssetImage('assets/images/m1.png'),
                height: 35,
              ),
              title: Text(
                'الأعدادات',
                style: TextStyle(
                    color: HexColor("#051DA4"),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                );
              },
            ),
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
                image: AssetImage('assets/images/m2.png'),
                height: 35,
              ),
              title: Text(
                'اتصل بنا',
                style: TextStyle(
                    color: HexColor("#051DA4"),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Contact()),
                );
              },
            ),
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
                image: AssetImage('assets/images/m3.png'),
                height: 35,
              ),
              title: Text(
                checkIfSignedIn ? 'تسجيل الخروج' : 'تسجيل الدخول',
                style: TextStyle(
                    color: HexColor("#051DA4"),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                if (checkIfSignedIn) {
                  await Provider.of<AuthDataProvider>(context, listen: false)
                      .clearAuthDataTable();
                  setState(() {
                    // To update the page
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
