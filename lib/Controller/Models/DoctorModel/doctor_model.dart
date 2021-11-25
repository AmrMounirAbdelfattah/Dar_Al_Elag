import 'package:cloud_firestore/cloud_firestore.dart';

// We need to add a photo url
class DoctorModel {
  String uid;
  String name;
  String clinicId;
  String specialization;
  String gender;
  DateTime birthDate;

  DoctorModel({
    this.name,
    this.clinicId,
    this.specialization,
    this.uid,
    this.birthDate,
    this.gender,
  });

  factory DoctorModel.getEmptyDoctorModel() {
    return DoctorModel(
      name: null,
      clinicId: null,
      specialization: null,
      uid: null,
      birthDate: null,
      gender: null,
    );
  }
  Map<String, dynamic> toAppDatabase() {
    return {
      "name": name,
      "clinicId": clinicId,
      "uid": uid,
      "specialization": specialization,
      "gender": gender,
      "birthDate": birthDate == null ? null : birthDate.toIso8601String(),
    };
  }

  factory DoctorModel.fromAppDatabase({Map<String, dynamic> map}) {
    return DoctorModel(
      name: map["name"],
      clinicId: map["clinicId"],
      uid: map["uid"],
      specialization: map["specialization"],
      gender: map["gender"],
      birthDate: map["birthDate"] == null
          ? null
          : DateTime.parse(
              map["birthDate"],
            ),
    );
  }
  factory DoctorModel.fromFirebase({Map<String, dynamic> map}) {
    Timestamp firebaseDate2 = map["birthDate"];
    return DoctorModel(
      name: map["name"],
      clinicId: map["clinicId"],
      uid: map["uid"],
      specialization: map["specialization"],
      gender: map["gender"],
      birthDate: firebaseDate2 == null ? null : firebaseDate2.toDate(),
    );
  }
  Map<String, dynamic> toFirebase({Map<String, dynamic> map}) {
    return {
      "name": name,
      "clinicId": clinicId,
      "uid": uid,
      "specialization": specialization,
      "gender": gender,
      "birthDate": birthDate == null ? null : Timestamp.fromDate(birthDate),
    };
  }
}
