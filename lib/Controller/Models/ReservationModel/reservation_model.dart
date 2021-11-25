import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  String id;
  String doctorUid;
  String clientUid;
  String timeOfReservation;
  String status;
  // Take there options
  // canceled or done or running
  DateTime dateOfReservation;
  DateTime createdDate;

  ReservationModel({
    this.id,
    this.doctorUid,
    this.clientUid,
    this.timeOfReservation,
    this.status,
    this.dateOfReservation,
    this.createdDate,
  });

  factory ReservationModel.getEmptyReservationModel() {
    return ReservationModel(
      id: null,
      doctorUid: null,
      clientUid: null,
      timeOfReservation: null,
      status: null,
      dateOfReservation: null,
      createdDate: null,
    );
  }
  Map<String, dynamic> toAppDatabase() {
    return {
      "id": id,
      "doctorUid": doctorUid,
      "clientUid": clientUid,
      "timeOfReservation": timeOfReservation,
      "status": status,
      "createdDate": createdDate == null ? null : createdDate.toIso8601String(),
      "dateOfReservation": dateOfReservation == null
          ? null
          : dateOfReservation.toIso8601String(),
    };
  }

  factory ReservationModel.fromAppDatabase({Map<String, dynamic> map}) {
    return ReservationModel(
      id: map['id'],
      doctorUid: map["doctorUid"],
      clientUid: map["clientUid"],
      timeOfReservation: map["timeOfReservation"],
      status: map["status"],
      createdDate: map["createdDate"] == null
          ? null
          : DateTime.parse(map["createdDate"]),
      dateOfReservation: map["dateOfReservation"] == null
          ? null
          : DateTime.parse(
              map["dateOfReservation"],
            ),
    );
  }
  factory ReservationModel.fromFirebase({Map<String, dynamic> map}) {
    Timestamp firebaseDate = map["dateOfReservation"];
    Timestamp firebaseDate2 = map["createdDate"];

    return ReservationModel(
      id: map['id'],
      doctorUid: map["doctorUid"],
      clientUid: map["clientUid"],
      timeOfReservation: map["timeOfReservation"],
      status: map["status"],
      createdDate: firebaseDate2 == null ? null : firebaseDate2.toDate(),
      dateOfReservation: firebaseDate == null ? null : firebaseDate.toDate(),
    );
  }
  Map<String, dynamic> toFirebase({Map<String, dynamic> map}) {
    return {
      "id": id,
      "doctorUid": doctorUid,
      "clientUid": clientUid,
      "timeOfReservation": timeOfReservation,
      "status": status,
      "createdDate":
          createdDate == null ? null : Timestamp.fromDate(createdDate),
      "dateOfReservation": dateOfReservation == null
          ? null
          : Timestamp.fromDate(dateOfReservation),
    };
  }
}
