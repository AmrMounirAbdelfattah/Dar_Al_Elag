import 'package:cloud_firestore/cloud_firestore.dart';

class UserAuthModel {
  String name;
  String email;
  String phoneNumber;
  String password;
  String uid;
  String countryName;
  DateTime resetDate;
  String profilePhoto;
  DateTime birthDate;
  String gender;

  UserAuthModel({
    this.name,
    this.email,
    this.countryName,
    this.password,
    this.phoneNumber,
    this.resetDate,
    this.uid,
    this.profilePhoto,
    this.birthDate,
    this.gender,
  });

  factory UserAuthModel.getEmptyUserAuthModel() {
    return UserAuthModel(
      countryName: null,
      name: null,
      profilePhoto: null,
      email: null,
      password: null,
      phoneNumber: null,
      resetDate: null,
      uid: null,
      birthDate: null,
      gender: null,
    );
  }
  Map<String, dynamic> toAppDatabase() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "password": password,
      "phoneNumber": phoneNumber,
      "countryName": countryName,
      "profilePhoto": profilePhoto,
      "gender": gender,
      "birthDate": birthDate == null ? null : birthDate.toIso8601String(),
      "resetDate": resetDate == null ? null : resetDate.toIso8601String(),
    };
  }

  factory UserAuthModel.fromAppDatabase({Map<String, dynamic> map}) {
    return UserAuthModel(
      name: map["name"],
      email: map["email"],
      uid: map["uid"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      countryName: map["countryName"],
      profilePhoto: map["profilePhoto"],
      gender: map["gender"],
      birthDate: map["birthDate"] == null
          ? null
          : DateTime.parse(
              map["birthDate"],
            ),
      resetDate: map["resetDate"] == null
          ? null
          : DateTime.parse(
              map["resetDate"],
            ),
    );
  }
  factory UserAuthModel.fromFirebase({Map<String, dynamic> map}) {
    Timestamp firebaseDate = map["resetDate"];
    Timestamp firebaseDate2 = map["birthDate"];
    return UserAuthModel(
      name: map["name"],
      email: map["email"],
      uid: map["uid"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      countryName: map["countryName"],
      profilePhoto: map["profilePhoto"],
      gender: map["gender"],
      birthDate: firebaseDate2 == null ? null : firebaseDate2.toDate(),
      resetDate: firebaseDate == null ? null : firebaseDate.toDate(),
    );
  }
  Map<String, dynamic> toFirebase({Map<String, dynamic> map}) {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "password": password,
      "phoneNumber": phoneNumber,
      "countryName": countryName,
      "profilePhoto": profilePhoto,
      "gender": gender,
      "birthDate": birthDate == null ? null : Timestamp.fromDate(birthDate),
      "resetDate": resetDate == null ? null : Timestamp.fromDate(resetDate),
    };
  }
}
