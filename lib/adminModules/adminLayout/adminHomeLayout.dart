import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../add_doctor_info.dart';
import '../admin_more.dart';
import '../edit_doctor_info.dart';
import '../reservation_notifications.dart';

class AdminHomeLayout extends StatefulWidget {
  final int selectedIndex;

  const AdminHomeLayout({Key key, this.selectedIndex}) : super(key: key);
  @override
  _AdminHomeLayoutState createState() => _AdminHomeLayoutState();
}

class _AdminHomeLayoutState extends State<AdminHomeLayout> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.selectedIndex == null ? 0 : widget.selectedIndex;
    super.initState();
  }

  List<Widget> screens = [
    AddDoctorInfo(),
    EditDoctorInfo(),
    ReservationNotifications(),
    AdminMore(),
  ];
  List<Widget> led = [
    Image(
      image: AssetImage('assets/images/bar7.png'),
    ),
    Image(
      image: AssetImage('assets/images/bar8.png'),
    ),
    Image(
      image: AssetImage('assets/images/bar9.png'),
    ),
    Image(
      image: AssetImage('assets/images/bar3.png'),
    ),
  ];

  List<Widget> tit = [
    Text(
      'اضافة دكتور',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    Text(
      'تعديل بيانات دكتور',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    Text(
      'عرض الحجوزات',
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
                image: AssetImage('assets/images/bar7.png'),
                height: 35,
              ),
              label: 'اضافة دكتور'),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/bar8.png'),
                height: 35,
              ),
              label: 'تعديل بيانات'),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/bar9.png'),
                height: 35,
              ),
              label: 'عرض الحجوزات'),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/bar3.png'),
                height: 35,
              ),
              label: 'المزيد'),
        ],
      ),
    );
  }
}
