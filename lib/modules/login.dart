import '../Controller/1MainHelper/Snacks/snackbar.dart';
import '../Controller/Functions/validate_inputs.dart';
import '../Controller/Models/UserAuthModel/user_auth_model.dart';
import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import '../Widgets/progress_hud.dart';
import '../layout/home_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'forgotPassword.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'doctor_page.dart';

class Login extends StatefulWidget {
  static const routeName = "/login_screen";
  final String action;
  const Login({Key key, this.action}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHidePassword = true;

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
                          ('assets/images/log1.svg'),
                          height: 200,
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('تسجيل الدخول',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: HexColor("#051DA4"),
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            )),
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
                        MaterialButton(
                          child: Text(
                            'دخول',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: HexColor("#051DA4"),
                          minWidth: 250,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          elevation: 15,
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            setState(() {
                              showSpinner = true;
                            });
                            // Validate all inputs
                            String validateInputsResult =
                                validateInputsForLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            if (validateInputsResult != null) {
                              showTopSnackBar(
                                title: 'تنبيه',
                                body: validateInputsResult,
                                context: context,
                              );
                              return;
                            }
                            // Login the user
                            UserAuthModel userAuthModel = UserAuthModel(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            String output = await Provider.of<AuthDataProvider>(
                                    context,
                                    listen: false)
                                .loginWithEmailAndPassword(
                              userAuthModel: userAuthModel,
                              context: context,
                            );
                            setState(() {
                              showSpinner = false;
                            });

                            if (output != null) {
                              print('Login result == failed');

                              showTopSnackBar(
                                title: 'تنبيه',
                                body: output,
                                context: context,
                              );
                              return;
                            } else {
                              print('Login result == Successful');
                              showTopSnackBar(
                                title: 'رائع',
                                body: 'لقد تم تسجيل الدخول بنجاح',
                                context: context,
                              );
                              await Future.delayed(
                                Duration(
                                  seconds: 2,
                                ),
                              );

                              // Return to doctor page to continue reservating a doctor process
                              if (widget.action ==
                                  'returnToReserveDoctorScreen') {
                                Navigator.of(context).pop();

                                return;
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeLayout(),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'أو سجل دخول بأستخدام',
                          textAlign: TextAlign.right,
                          style: TextStyle(
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
                              child: Text(
                                'فيس بوك',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: HexColor("#3b5998"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              elevation: 15,
                              onPressed: () async {
                                String output;
                                setState(() {
                                  showSpinner = true;
                                });
                                //
                                output = await Provider.of<AuthDataProvider>(
                                        context,
                                        listen: false)
                                    .signInWithFacebook(
                                  context: context,
                                );
                                setState(() {
                                  showSpinner = false;
                                });

                                if (output != null) {
                                  print('Login result == failed');
                                  showTopSnackBar(
                                    title: 'تنبيه',
                                    body: output,
                                    context: context,
                                  );
                                  return;
                                } else {
                                  print('Login result == Successful');
                                  showTopSnackBar(
                                    title: 'مبروك',
                                    body: 'لقد تم تسجيل الدخول بنجاح',
                                    context: context,
                                  );
                                  await Future.delayed(
                                    Duration(
                                      seconds: 2,
                                    ),
                                  );
                                  // Return to doctor page to continue reservating a doctor process
                                  if (widget.action ==
                                      'returnToReserveDoctorScreen') {
                                    Navigator.of(context).pop();

                                    return;
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeLayout(),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            MaterialButton(
                              child: Text(
                                'جوجل',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: HexColor("#D44638"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              elevation: 15,
                              onPressed: () async {
                                String output;
                                setState(() {
                                  showSpinner = true;
                                });
                                //
                                output = await Provider.of<AuthDataProvider>(
                                        context,
                                        listen: false)
                                    .signInWithGoogle(
                                  context: context,
                                );
                                setState(() {
                                  showSpinner = false;
                                });

                                if (output != null) {
                                  print('Login result == failed');
                                  showTopSnackBar(
                                    title: 'تنبيه',
                                    body: output,
                                    context: context,
                                  );
                                  return;
                                } else {
                                  print('Login result == Successful');

                                  showTopSnackBar(
                                    title: 'مبروك',
                                    body: 'لقد تم تسجيل الدخول بنجاح',
                                    context: context,
                                  );
                                  await Future.delayed(
                                    Duration(
                                      seconds: 2,
                                    ),
                                  );

                                  // Return to doctor page to continue reservating a doctor process
                                  if (widget.action ==
                                      'returnToReserveDoctorScreen') {
                                    Navigator.of(context).pop();
                                    return;
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeLayout(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('معندكش حساب ؟'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ),
                                );
                              },
                              child: Text(
                                'يلا سجل دلوقتي',
                                style: TextStyle(color: HexColor("#051DA4")),
                              ),
                            )
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()),
                              );
                            },
                            child: Text(
                              'نسيت كلمة السر !',
                              style: TextStyle(color: HexColor("#D00404")),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
        inAsyncCall: showSpinner);
  }
}
