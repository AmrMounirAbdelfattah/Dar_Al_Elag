import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/DoctorModel/doctor_model.dart';
import '../../static_data.dart';
import '../../Models/ReservationModel/reservation_model.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ReservationsProvider with ChangeNotifier {
  // AuthData
  List<ReservationModel> reservations = [];
  List<DoctorModel> reservationsDoctors = [];

  List<ReservationModel> get getReservations {
    return [...reservations];
  }

  List<DoctorModel> get getReservationsDoctors {
    return [...reservationsDoctors];
  }

  bool checkIfThereAreReservations() {
    if (reservations.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> startFireBase() async {
    print("Starting firebase .......");
    await Firebase.initializeApp();
  }

  Future<bool> checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
      //Nothing to do --> continue in code
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  Future<String> fetchAndSetFromFirebase({
    @required BuildContext context,
    @required String userUid,
  }) async {
    try {
      bool check = await checkInternetConnection();

      if (!check) {
        return "لا يوجد لديك اتصال بالانترنت";
      }

      // Intialize firebase
      await startFireBase();

      FirebaseFirestore fCF;
      fCF = FirebaseFirestore.instance;

      //  Get user's reservations data from firebase firestore
      QuerySnapshot querySnapshot = await fCF
          .collection("Reservations")
          .where('clientUid', isEqualTo: userUid)
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      // Clear the list of reservations
      reservations.clear();
      // Clear the list of reservations' doctors
      reservationsDoctors.clear();

      // Store the reservations in a list
      docs.forEach((element) async {
        Map outputData = element.data();
        ReservationModel tempReservationModel = ReservationModel.fromFirebase(
          map: outputData,
        );
        reservations.add(
          tempReservationModel,
        );

        /*  // This part to fetch the doctors' data of the current reservations
        QuerySnapshot querySnapshot = await fCF
            .collection("Doctors")
            .where('doctorUid', isEqualTo: tempReservationModel.doctorUid)
            .get();
        // The length of the this list must be 1
        // Because every doctor has unique uid
        // so docs has only one element of that contains the doctor's data of the these reservations
        List<QueryDocumentSnapshot> docs = querySnapshot.docs;
        Map outputData2 = docs[0].data();
        DoctorModel tempDoctorModel = DoctorModel.fromFirebase(
          map: outputData2,
        ); */

        // Remove this line when you make doctors database in firebase
        DoctorModel tempDoctorModel = doctors.firstWhere(
            (element) => element.uid == tempReservationModel.doctorUid);

        reservationsDoctors.add(
          tempDoctorModel,
        );
      });

      return null;
    } catch (e) {
      print(e);
      return 'لقد حدث خطأ';
    }
  }

  Future<String> createReservation({
    @required BuildContext context,
    @required ReservationModel reservationModel,
  }) async {
    try {
      bool check = await checkInternetConnection();

      if (!check) {
        return "لا يوجد لديك اتصال بالانترنت";
      }

      // Intialize firebase
      await startFireBase();

      FirebaseFirestore fCF;
      fCF = FirebaseFirestore.instance;

      // Create reservation in firestore
      DocumentReference documentReference =
          await fCF.collection("Reservations").add(
                reservationModel.toFirebase(),
              );

      print(documentReference);

      if (documentReference == null) {
        return 'لقد حدث خطأ في الحجز';
      } else {
        // Add the id of the reservation in reservation's data
        await fCF.collection("Reservations").doc(documentReference.id).update(
          {
            'id': documentReference.id,
          },
        );
      }

      return null;
    } catch (e) {
      print(e);
      return 'لقد حدث خطأ';
    }
  }

  Future<String> canceleReservation({
    @required BuildContext context,
    @required ReservationModel reservationModel,
  }) async {
    try {
      bool check = await checkInternetConnection();

      if (!check) {
        return "لا يوجد لديك اتصال بالانترنت";
      }

      // Intialize firebase
      await startFireBase();

      FirebaseFirestore fCF;
      fCF = FirebaseFirestore.instance;

      // Create reservation in firestore
      await fCF.collection("Reservations").doc(reservationModel.id).update(
        {
          'status': 'canceled',
        },
      );

      int index = reservations
          .indexWhere((element) => element.id == reservationModel.id);

      reservations[index].status = 'canceled';

      return null;
    } catch (e) {
      print(e);
      return 'لقد حدث خطأ';
    }
  }
}
