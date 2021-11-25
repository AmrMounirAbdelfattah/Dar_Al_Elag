import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';

class AddDoctorInfo extends StatefulWidget {
  @override
  _AddDoctorInfo createState() => _AddDoctorInfo();
}

class _AddDoctorInfo extends State<AddDoctorInfo> {
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'ادخل بيانات الدكتور',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: HexColor("#051DA4"),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'اسم الدكتور',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'التخصص',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'العيادة',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'النوع',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HexColor("#051DA4")),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  height: gender == 'Male' ? 40 : 30,
                  minWidth: gender == 'Male' ? 90 : 80,
                  child: Text(
                    'ذكر',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: HexColor("#004f94"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 15,
                  onPressed: () {
                    setState(() {
                      gender = 'Male';
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  height: gender == 'Female' ? 40 : 35,
                  minWidth: gender == 'Female' ? 90 : 70,
                  child: Text(
                    'أنثي',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: HexColor("#f98fed"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 15,
                  onPressed: () {
                    setState(() {
                      gender = 'Female';
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
                child: Text(
                  'اضافة',
                  style: TextStyle(color: Colors.white),
                ),
                color: HexColor("#051DA4"),
                minWidth: 250,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 15,
                onPressed: () async {}),
          ],
        ),
      ),
    );
  }
}
