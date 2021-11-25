import '../Controller/1MainHelper/Snacks/snackbar.dart';
import '../Controller/Functions/validate_inputs.dart';
import '../Controller/Models/UserAuthModel/user_auth_model.dart';
import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import '../Widgets/progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class PersonalInfo extends StatefulWidget {
  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController birthdayController = TextEditingController();

  String gender;
  UserAuthModel currentUser;

  @override
  void initState() {
    currentUser =
        Provider.of<AuthDataProvider>(context, listen: false).currentUser;
    nameController.text = currentUser.name;
    phoneController.text = currentUser.phoneNumber;
    gender = currentUser.gender;

    DateTime birthDate = currentUser.birthDate;
    birthdayController.text = birthDate == null
        ? null
        : intl.DateFormat('dd/MM/yyyy').format(birthDate);
    super.initState();
  }

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Image(
            image: AssetImage('assets/images/m6.png'),
          ),
          title: Text(
            'تعديل بياناتي',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ('assets/images/Doc10.svg'),
                      height: 200,
                      width: double.infinity,
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
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue:
                          currentUser.email == null ? '' : currentUser.email,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'البريد الألكتروني',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'رقم الموبيل',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
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
                      height: 30,
                    ),
                    MaterialButton(
                      child: Text(
                        'حفظ التعديلات',
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
                            phoneController.text.isEmpty ||
                            birthdayController.text.isEmpty) {
                          showTopSnackBar(
                            title: 'تنبيه',
                            body: 'الرجاء إدخال البيانات كاملةً.',
                            context: context,
                          );
                          return;
                        }
                        String validateInputsResult =
                            validateInputsAfterEditing(
                          name: nameController.text,
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

                        setState(() {
                          showSpinner = true;
                        });
                        UserAuthModel userAuthModel = UserAuthModel(
                          birthDate: intl.DateFormat('dd/MM/yyyy')
                              .parse(birthdayController.text),
                          phoneNumber: phoneController.text.trim(),
                          name: nameController.text.trim(),
                          gender: gender,
                          password: currentUser.password,
                          email: currentUser.email,
                          profilePhoto: currentUser.profilePhoto,
                          countryName: currentUser.countryName,
                          uid: currentUser.uid,
                          resetDate: currentUser.resetDate,
                        );

                        String output = await Provider.of<AuthDataProvider>(
                                context,
                                listen: false)
                            .modifyAndUpdateUserAuthData(
                          context: context,
                          userAuthModel: userAuthModel,
                        );

                        setState(() {
                          showSpinner = false;
                        });

                        if (output != null) {
                          print('Update result == Failed');

                          showTopSnackBar(
                            title: 'تنبيه',
                            body: output,
                            context: context,
                          );
                          return;
                        } else {
                          print('Update result == Successful');

                          showTopSnackBar(
                            title: 'رائع',
                            body: 'لقد تم تحديث البيانات بنجاح',
                            context: context,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      inAsyncCall: showSpinner,
    );
  }
}
