import 'package:daralelag/Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import 'package:daralelag/modules/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class AdminMore extends StatefulWidget {
  @override
  State<AdminMore> createState() => _AdminMoreState();
}

class _AdminMoreState extends State<AdminMore> {
  @override
  Widget build(BuildContext context) {
    bool checkIfSignedIn =
    Provider.of<AuthDataProvider>(context, listen: false).checkIfSignedIn();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
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
      ),
    );
  }
}
