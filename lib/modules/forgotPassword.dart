import '../Controller/1MainHelper/Snacks/snackbar.dart';
import '../Controller/Functions/validate_inputs.dart';
import '../Controller/Providers/AuthDataProvider/auth_data_provider.dart';
import '../Utils/AppDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ('assets/images/log3.svg'),
                      height: 200,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('نسيت كلمة السر مفيش مشكله',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexColor("#051DA4"),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text('دخل بريدك الألكتروني و إحنا هنساعدك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
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
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              HexColor("#051DA4"),
                            ),
                          )
                        : MaterialButton(
                            child: Text(
                              'أضغط هنا',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: HexColor("#051DA4"),
                            minWidth: 250,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 15,
                            onPressed: () async {
                              String validateEmailResult = validateEmail(
                                email: emailController.text,
                              );
                              if (validateEmailResult != null) {
                                showTopSnackBar(
                                  title: 'تنبيه',
                                  body: validateEmailResult,
                                  context: context,
                                );
                                return;
                              }
                              setState(() {
                                _isLoading = true;
                              });
                              String output =
                                  await Provider.of<AuthDataProvider>(context,
                                          listen: false)
                                      .resetPasswordFn(
                                email: emailController.text.trim(),
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
                                return;
                              } else {
                                showTopSnackBar(
                                  title: 'تحقق من بريدك الالكتروني',
                                  body:
                                      'لقد تم ارسال رابط لتغير كلمة المرور الى بريدك الالكتروني',
                                  context: context,
                                );
                                await Future.delayed(
                                  Duration(
                                    seconds: 2,
                                  ),
                                );
                                // Return to the login page
                                Navigator.of(context).pop();
                              }
                            }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
