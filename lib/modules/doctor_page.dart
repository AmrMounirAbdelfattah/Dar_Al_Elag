import 'package:chips_choice_null_safety/chips_choice.dart';
import '../Controller/1MainHelper/Snacks/snackbar.dart';
import '../Controller/Models/DoctorModel/doctor_model.dart';
import '../Controller/Models/ReservationModel/reservation_model.dart';
import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import '../Controller/Providers/ReservationsProvider/reservations_provider.dart';
import '../Controller/static_data.dart';

import '../Utils/lib/date_picker_timeline.dart';
import '../layout/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;
import 'package:date_utils/date_utils.dart' as utils;

import 'login.dart';

class DoctorPage extends StatefulWidget {
  static const routeName = "/doctor_screen";
  final DoctorModel doctorModel;

  const DoctorPage({
    Key key,
    this.doctorModel,
  }) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  ValueNotifier<DateTime> selectedDate;
  String selectedTime = '';
  bool _isLoading = false;

  int tag = 1;
  List<String> options = [
    '09:00 AM',
    '11:00 AM',
    '01:00 PM',
    '03:00 PM',
    '05:00 PM',
  ];
  String userUid;
  @override
  void initState() {
    intl.Intl.defaultLocale = 'ar';
    selectedDate = ValueNotifier(DateTime.now());
    userUid =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage('assets/images/bar1.png'),
        ),
        title: Text(
          'احجز العيادة',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 150,
                          minWidth: 110,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffc0caf7).withOpacity(0.82),
                                    HexColor("#051DA4"),
                                  ],
                                  end: Alignment.topRight,
                                  begin: Alignment.bottomLeft,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned(
                              bottom:
                                  widget.doctorModel.gender == 'Male' ? 0 : -9,
                              child: widget.doctorModel.gender == 'Male'
                                  ? Image.asset(
                                      'assets/images/male_doctor.png',
                                      width: 130,
                                      height: 220,
                                      fit: BoxFit.fitHeight,
                                    )
                                  : Image.asset(
                                      'assets/images/female_doctor.png',
                                      width: 140,
                                      height: 250,
                                      fit: BoxFit.fitHeight,
                                    ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctorModel.name,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: HexColor("#051DA4"),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              allClinics.firstWhere((element) =>
                                  element['id'] ==
                                  widget.doctorModel.clinicId)['name'],
                              style: TextStyle(
                                fontSize: 25,
                                color: HexColor("#051DA4"),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                launch(
                                  'tel://15074',
                                );
                              },
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                elevation:
                                    MaterialStateProperty.all<double>(15),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 88.0, minHeight: 36.0),
                                // min sizes for Material buttons
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffc0caf7),
                                      HexColor("#051DA4"),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'احجز الآن عن طريق الموبايل',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35.0),
                      child: Text(
                        widget.doctorModel.specialization,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#051DA4"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showMonthPicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 1, 5),
                        lastDate: DateTime(DateTime.now().year + 1, 9),
                        initialDate: selectedDate.value,
                        locale: Locale("ar"),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            selectedDate.value = date;
                          });
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          intl.DateFormat('yyyy MMMM').format(
                            selectedDate.value,
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            color: HexColor("#051DA4"),
                          ),
                        ),
                        Icon(Icons.expand_more,
                            size: 26, color: HexColor("#051DA4")),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: selectedDate,
                      builder: (context, val, child) {
                        return DatePicker(
                          DateTime(
                              selectedDate.value.year,
                              selectedDate.value.month,
                              utils.DateUtils.firstDayOfMonth(
                                      selectedDate.value)
                                  .day),
                          initialSelectedDate: selectedDate.value,
                          selectionColor: HexColor("#051DA4"),
                          daysCount:
                              utils.DateUtils.lastDayOfMonth(selectedDate.value)
                                  .day,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            selectedDate.value = date;
                          },
                        );
                      }),
                  Align(
                    alignment: Alignment.center,
                    child: ChipsChoice<int>.single(
                      value: tag,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      onChanged: (val) {
                        selectedTime = options[val];
                        setState(() => tag = val);
                      },
                      wrapped: true,
                      choiceStyle: C2ChoiceStyle(
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      choiceActiveStyle: C2ChoiceStyle(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                          brightness: Brightness.dark,
                          showCheckmark: false),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        activeStyle: (i, v) => C2ChoiceStyle(
                          color: HexColor("#051DA4"),
                        ),
                        label: (i, v) => v,
                      ),
                    ),
                  ),
                  _isLoading
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Make sure the user is signed in
                              if (userUid == null) {
                                showTopSnackBar(
                                  title: 'تنبيه',
                                  body: 'من فضلك قم بتسجيل الدخول اولا',
                                  context: context,
                                );
                                await Future.delayed(
                                  Duration(
                                    seconds: 2,
                                  ),
                                );
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (ctx) => Login(
                                      action: 'returnToReserveDoctorScreen',
                                    ),
                                  ),
                                )
                                    .then((value) {
                                  userUid = Provider.of<AuthDataProvider>(
                                          context,
                                          listen: false)
                                      .currentUser
                                      .uid;
                                });
                                return;
                              }

                              if (selectedTime == '') {
                                selectedTime = options[1];
                              }
                              setState(() {
                                _isLoading = true;
                              });

                              ReservationModel reservationModel =
                                  ReservationModel(
                                id: null,
                                doctorUid: widget.doctorModel.uid,
                                clientUid: userUid,
                                createdDate: DateTime.now(),
                                dateOfReservation: selectedDate.value,
                                timeOfReservation: selectedTime,
                                status: 'running',
                              );
                              String output =
                                  await Provider.of<ReservationsProvider>(
                                          context,
                                          listen: false)
                                      .createReservation(
                                context: context,
                                reservationModel: reservationModel,
                              );
                              setState(() {
                                _isLoading = false;
                              });

                              if (output != null) {
                                showTopSnackBar(
                                  title: 'تنبيه',
                                  body: output,
                                  context: context,
                                );
                              } else {
                                showTopSnackBar(
                                  title: 'مبروك',
                                  body: 'تم الحجز بنجاح',
                                  context: context,
                                );
                                await Future.delayed(
                                  Duration(
                                    seconds: 2,
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeLayout(
                                      selectedIndex: 1,
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              elevation: MaterialStateProperty.all<double>(15),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                            ),
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                color: HexColor("#051DA4"),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  'تأكيد الحجز',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
