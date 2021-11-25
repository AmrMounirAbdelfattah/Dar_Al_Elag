import '../Controller/1MainHelper/Snacks/snackbar.dart';
import '../Controller/Functions/validate_inputs.dart';
import '../Controller/Models/UserAuthModel/user_auth_model.dart';
import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import '../Widgets/progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool isHidePasswordConfirm = true;
  bool isHidePassword = true;

  String gender = 'Male';

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        ('assets/images/log2.svg'),
                        height: 200,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'تسجل مستخدم جديد',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexColor("#051DA4"),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'إسم المستخدم',
                          prefixIcon: Icon(Icons.assignment_ind),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'البريد الألكتروني',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'رقم الموبايل',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: birthdayController,
                        decoration: InputDecoration(
                            labelText: 'تاريخ الميلاد',
                            prefixIcon: IconButton(
                              icon: Icon(Icons.date_range),
                              onPressed: () async {
                                DateTime birthDate;
                                birthDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1920, 1, 1),
                                      lastDate: DateTime.now(),
                                    ) ??
                                    DateTime.now();
                                birthdayController.text =
                                    intl.DateFormat('dd/MM/yyyy')
                                        .format(birthDate);
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'النوع',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#051DA4")),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            height: gender == 'Male' ? 40 : 30,
                            minWidth: gender == 'Male' ? 90 : 80,
                            child: Text(
                              'ذكر',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: HexColor("#004f94"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 15,
                            onPressed: () {
                              setState(() {
                                gender = 'Male';
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          MaterialButton(
                            height: gender == 'Female' ? 40 : 35,
                            minWidth: gender == 'Female' ? 90 : 70,
                            child: Text(
                              'أنثي',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: HexColor("#f98fed"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 15,
                            onPressed: () {
                              setState(() {
                                gender = 'Female';
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isHidePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'كلمة السر',
                            prefixIcon: Icon(Icons.lock_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                              ),
                              onPressed: () {
                                setState(() {
                                  isHidePassword = !isHidePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isHidePasswordConfirm,
                        controller: passwordConfirmController,
                        decoration: InputDecoration(
                          labelText: 'تأكيد كلمة السر',
                          prefixIcon: Icon(Icons.lock_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                            ),
                            onPressed: () {
                              setState(() {
                                isHidePasswordConfirm = !isHidePasswordConfirm;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        child: Text(
                          'سجل',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: HexColor("#051DA4"),
                        minWidth: 250,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 15,
                        onPressed: () async {
                          // Validate all inputs
                          if (nameController.text.isEmpty ||
                              birthdayController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              passwordConfirmController.text.isEmpty) {
                            showTopSnackBar(
                              title: 'تنبيه',
                              body: 'الرجاء إدخال البيانات كاملةً.',
                              context: context,
                            );
                            return;
                          }
                          String validateInputsResult =
                              validateInputsForRegistration(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phoneNumber: phoneController.text,
                          );

                          if (validateInputsResult != null) {
                            showTopSnackBar(
                              title: 'تنبيه',
                              body: validateInputsResult,
                              context: context,
                            );
                            return;
                          }
                          // Check if valid birthdate
                          try {
                            intl.DateFormat('dd/MM/yyyy')
                                .parse(birthdayController.text);
                          } catch (_) {
                            showTopSnackBar(
                              title: 'تنبيه',
                              body: 'الرجاء إدخال صيغة تاريخ صحيحة',
                              context: context,
                            );
                            return;
                          }
                          // Check if passwords match
                          if (passwordController.text !=
                              passwordConfirmController.text) {
                            showTopSnackBar(
                              title: 'تنبيه',
                              body: 'كلمتا المرور غير متطابقتين',
                              context: context,
                            );
                            return;
                          }
                          setState(() {
                            showSpinner = true;
                          });
                          UserAuthModel userAuthModel = UserAuthModel(
                            birthDate: intl.DateFormat('dd/MM/yyyy')
                                .parse(birthdayController.text),
                            email: emailController.text.trim(),
                            password: passwordController.text,
                            phoneNumber: phoneController.text.trim(),
                            gender: gender,
                            name: nameController.text.trim(),
                            profilePhoto: '',
                          );
                          String output = await Provider.of<AuthDataProvider>(
                                  context,
                                  listen: false)
                              .signUpWithEmailAndPassword(
                            userAuthModel: userAuthModel,
                            context: context,
                          );
                          setState(() {
                            showSpinner = false;
                          });

                          if (output != null) {
                            print('Registartion result == Failed');

                            showTopSnackBar(
                              title: 'تنبيه',
                              body: output,
                              context: context,
                            );
                            return;
                          } else {
                            print('Registartion result == Successful');

                            showTopSnackBar(
                              title: 'مبروك',
                              body: 'لقد تم انشاء الحساب بنجاح',
                              context: context,
                            );
                            await Future.delayed(
                              Duration(
                                seconds: 2,
                              ),
                            );
                            // Return to the login page
                            Navigator.pop(
                              context,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
      inAsyncCall: showSpinner,
    );
  }
}
