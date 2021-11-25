import '../modules/clinics.dart';
import '../modules/more.dart';
import '../modules/my_time.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeLayout extends StatefulWidget {
  final int selectedIndex;

  const HomeLayout({Key key, this.selectedIndex}) : super(key: key);
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.selectedIndex == null ? 0 : widget.selectedIndex;
    super.initState();
  }

  List<Widget> screens = [
    Clinics(),
    MyTime(),
    More(),
  ];
  List<Widget> led = [
    Image(
      image: AssetImage('assets/images/bar1.png'),
    ),
    Image(
      image: AssetImage('assets/images/bar2.png'),
    ),
    Image(
      image: AssetImage('assets/images/bar4.png'),
    ),
  ];

  List<Widget> tit = [
    Text(
      'اختار العيادة',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    Text(
      'مواعيدي',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    Text(
      'المزيد',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: led[currentIndex],
        title: tit[currentIndex],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: HexColor("#051DA4"),
        items: [
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/bar1.png'),
                height: 35,
              ),
              label: 'اختار العيادة'),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/bar2.png'),
                height: 35,
              ),
              label: 'مواعيدي'),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/bar4.png'),
                height: 35,
              ),
              label: 'المزيد'),
        ],
      ),
    );
  }
}
