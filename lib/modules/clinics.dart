import '../Controller/static_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'doctors.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner

      home: Clinics(),
    );
  }
}

class Clinics extends StatelessWidget {
  List imgList = [
    'assets/images/im1.png',
    'assets/images/im2.jpg',
    'assets/images/im3.jpg',
    'assets/images/im4.jpg',
    'assets/images/im5.jpg',
    'assets/images/im6.png',
    'assets/images/im7.png',
    'assets/images/im8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          CarouselSlider(
              items: imgList.map((imageUrl) {
                return Container(
                  width: double.infinity,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              )),
          SizedBox(
            height: 25,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: allClinics.length,
              itemBuilder: (BuildContext ctx, index) {
                return new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Doctors(
                          clinic: allClinics[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Center(
                        child: Image(
                          image: (allClinics[index]["age"]),
                          height: 65,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        allClinics[index]["name"],
                        style: TextStyle(
                            color: HexColor("#051DA4"),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    decoration: BoxDecoration(
                        color: HexColor("#e6e8f5"),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                );
              })
        ]),
      ),
    );
  }
}
