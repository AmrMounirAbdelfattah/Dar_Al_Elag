import '../Controller/1MainHelper/Snacks/snackbar.dart';
import '../Controller/Models/DoctorModel/doctor_model.dart';
import '../Controller/Models/ReservationModel/reservation_model.dart';
import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import '../Controller/Providers/ReservationsProvider/reservations_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import 'login.dart';

class MyTime extends StatefulWidget {
  const MyTime({
    Key key,
  }) : super(key: key);

  @override
  _MyTimeState createState() => _MyTimeState();
}

class _MyTimeState extends State<MyTime> {
  List<ReservationModel> reservations = [];

  List<DoctorModel> reservationsDoctors = [];
  String userUid;
  bool _isFetched = false;
  bool _isLoading = false;
  @override
  void initState() {
    userUid =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser.uid;
    super.initState();
  }

  Future<void> fetchReservations() async {
    if (_isFetched) {
      reservations = Provider.of<ReservationsProvider>(context, listen: false)
          .getReservations;

      reservationsDoctors =
          Provider.of<ReservationsProvider>(context, listen: false)
              .getReservationsDoctors;
      return;
    }

    //
    await Provider.of<ReservationsProvider>(context, listen: false)
        .fetchAndSetFromFirebase(
      context: context,
      userUid: userUid,
    );

    reservations = Provider.of<ReservationsProvider>(context, listen: false)
        .getReservations;

    reservationsDoctors =
        Provider.of<ReservationsProvider>(context, listen: false)
            .getReservationsDoctors;

    _isFetched = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SvgPicture.asset(
              ('assets/images/Doc7.svg'),
              height: 200,
              width: double.infinity,
            ),
            SizedBox(
              height: 15,
            ),
            // Check if the user is signed in or not
            userUid == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لو عايز تعرف مواعيدك',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Text(
                            'سجل الدخول لحسابك',
                            style: TextStyle(
                              color: HexColor("#D00404"),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : FutureBuilder(
                    future: fetchReservations(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return reservations.length == 0
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'لايوجد لديك اي حجوزات',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: reservations
                                    .map(
                                      (reservation) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: HexColor("#e6e8f5"),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'التاريخ : ${intl.DateFormat('dd/MM/yyyy').format(reservation.dateOfReservation)}'
                                                  '\n'
                                                  'الوقت : ${reservation.timeOfReservation}',
                                                  style: TextStyle(
                                                    color: HexColor("#051DA4"),
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      reservationsDoctors
                                                          .firstWhere(
                                                              (element) =>
                                                                  element.uid ==
                                                                  reservation
                                                                      .doctorUid)
                                                          .name,
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#051DA4"),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      reservationsDoctors
                                                          .firstWhere(
                                                              (element) =>
                                                                  element.uid ==
                                                                  reservation
                                                                      .doctorUid)
                                                          .specialization,
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#051DA4"),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                reservation.status == 'canceled'
                                                    ? Text(
                                                        'تم إلغاء الحجز',
                                                        style: TextStyle(
                                                          color: HexColor(
                                                              "#D00404"),
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                    : Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'تم الحجز',
                                                            style: TextStyle(
                                                              color: HexColor(
                                                                  "#051DA4"),
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              if (_isLoading) {
                                                                return;
                                                              }

                                                              // Code for cancle reservation
                                                              _isLoading = true;
                                                              String output = await Provider.of<
                                                                          ReservationsProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .canceleReservation(
                                                                context:
                                                                    context,
                                                                reservationModel:
                                                                    reservation,
                                                              );

                                                              _isLoading =
                                                                  false;

                                                              if (output !=
                                                                  null) {
                                                                showTopSnackBar(
                                                                  title:
                                                                      'تنبيه',
                                                                  body: output,
                                                                  context:
                                                                      context,
                                                                );
                                                              } else {
                                                                showTopSnackBar(
                                                                  title: 'رائع',
                                                                  body:
                                                                      'تم الغاء الحجز بنجاح',
                                                                  context:
                                                                      context,
                                                                );
                                                                setState(() {
                                                                  // To update the ui after cancele a reservation
                                                                });
                                                              }
                                                            },
                                                            child: Text(
                                                              'إلغاء الحجز',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
