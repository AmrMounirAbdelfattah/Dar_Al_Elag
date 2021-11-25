import 'package:flutter/material.dart';

import 'Models/DoctorModel/doctor_model.dart';

List<DoctorModel> doctors = [
  DoctorModel(
    name: 'محمد احمد',
    clinicId: '1',
    gender: 'Male',
    specialization: 'اخصائي اوعية',
    uid: '100',
    birthDate: DateTime.now(),
  ),
  DoctorModel(
    name: 'نور محمد',
    clinicId: '1',
    gender: 'Male',
    specialization: 'اخصائي اوعية',
    uid: '101',
    birthDate: DateTime.now(),
  ),
  DoctorModel(
    name: 'اسراء عادل',
    clinicId: '1',
    gender: 'Female',
    specialization: 'اخصائي اوعية',
    uid: '102',
    birthDate: DateTime.now(),
  ),
  DoctorModel(
    name: 'عمرو مجدي',
    clinicId: '2',
    gender: 'Male',
    specialization: 'اخصائي اورام',
    uid: '103',
    birthDate: DateTime.now(),
  ),
  DoctorModel(
    name: 'مروة علي',
    clinicId: '3',
    gender: 'Female',
    specialization: 'اخصائي اطفال',
    uid: '104',
    birthDate: DateTime.now(),
  ),
  DoctorModel(
    name: 'علي ابراهيم',
    clinicId: '3',
    gender: 'Male',
    specialization: 'اخصائي اطفال',
    uid: '105',
    birthDate: DateTime.now(),
  ),
];

final List<Map<String, dynamic>> allClinics = [
  {
    "id": "1",
    "name": "الأوعية الدموية",
    "age": AssetImage('assets/images/c1.png')
  },
  {
    "id": "2",
    "name": "الأورام",
    "age": AssetImage('assets/images/c2.png'),
  },
  {
    "id": "3",
    "name": "الأطفال",
    "age": AssetImage('assets/images/c3.png'),
  },
  {
    "id": "4",
    "name": "الباطنة",
    "age": AssetImage('assets/images/c4.png'),
  },
  {
    "id": "5",
    "name": "التجميل",
    "age": AssetImage('assets/images/c5.png'),
  },
  {
    "id": "6",
    "name": "التغذية والنحافة",
    "age": AssetImage('assets/images/c6.png')
  },
  {
    "id": "7",
    "name": "الجراحة العامة",
    "age": AssetImage('assets/images/c7.png')
  },
  {
    "id": "8",
    "name": "الجلدية",
    "age": AssetImage('assets/images/c8.png'),
  },
  {
    "id": "9",
    "name": "العظام",
    "age": AssetImage('assets/images/c9.png'),
  },
  {
    "id": "10",
    "name": "القلب",
    "age": AssetImage('assets/images/c10.png'),
  },
  {
    "id": "11",
    "name": "المسالك البولية",
    "age": AssetImage('assets/images/c11.png')
  },
  {
    "id": "12",
    "name": "النساء والتوليد",
    "age": AssetImage('assets/images/c12.png')
  },
  {
    "id": "13",
    "name": "نفسية و عصبية",
    "age": AssetImage('assets/images/c13.png')
  },
  {
    "id": "14",
    "name": "السلوكية",
    "age": AssetImage('assets/images/c14.png'),
  },
  {
    "id": "15",
    "name": "انف واذن وحنجرة",
    "age": AssetImage('assets/images/c15.png')
  },
  {
    "id": "16",
    "name": "الأسنان",
    "age": AssetImage('assets/images/c16.png'),
  },
  {
    "id": "17",
    "name": "الرمد",
    "age": AssetImage('assets/images/c17.png'),
  },
  {
    "id": "18",
    "name": "علاج الألم",
    "age": AssetImage('assets/images/c18.png'),
  },
  {
    "id": "19",
    "name": "الأمراض الصدرية",
    "age": AssetImage('assets/images/c19.png')
  },
  {
    "id": "20",
    "name": "جراحة الأطفال",
    "age": AssetImage('assets/images/c7.png')
  },
  {
    "id": "21",
    "name": "المخ و الاعصاب",
    "age": AssetImage('assets/images/c20.png')
  },
];
