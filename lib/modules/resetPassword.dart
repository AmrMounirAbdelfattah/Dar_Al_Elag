import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ('assets/images/log3.svg'),
                      height: 200,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('غير كلمة السر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexColor("#051DA4"),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'كلمة السر الجديدة',
                          prefixIcon: Icon(Icons.lock_rounded),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'تأكيد كلمة السر الجديدة',
                          prefixIcon: Icon(Icons.lock_rounded),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      child: Text(
                        'تغير',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: HexColor("#051DA4"),
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      elevation: 15,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
