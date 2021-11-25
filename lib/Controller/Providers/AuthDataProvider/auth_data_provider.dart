import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Database/app_database.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../Models/UserAuthModel/user_auth_model.dart';

class AuthDataProvider with ChangeNotifier {
  // AuthData
  UserAuthModel currentUser;

  bool checkResetDate() {
    if (currentUser.resetDate == null) {
      return false;
    } else if (currentUser.resetDate.isBefore(DateTime.now())) {
      return false;
    } else {
      return true;
    }
  }

  bool checkIfSignedIn() {
    if (currentUser.uid == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> fetchAndSetTable() async {
    List<Map<String, dynamic>> outputData;

    outputData = await AppDB.getData("AuthData");
    print(outputData);

    if (outputData.length == 0) {
      await setAuthDataTable();
    } else if (outputData.length > 1) {
      // re-install the app
    } else {
      currentUser = UserAuthModel.fromAppDatabase(
        map: outputData[0],
      );
    }
  }

  Future<void> setAuthDataTable() async {
    //
    currentUser = UserAuthModel.getEmptyUserAuthModel();

    await AppDB.insert(
      "AuthData",
      currentUser.toAppDatabase(),
    );
  }

  Future<void> updateAuthDataTable({
    UserAuthModel userAuthModelInp,
  }) async {
    await AppDB.update(
      table: "AuthData",
      data: userAuthModelInp.toAppDatabase(),
      whereStatement: null,
      whereValue: null,
    );
    currentUser = userAuthModelInp;
  }

  Future<void> updatePhoneNumberInAuthDataTable({
    String phoneNumberInp,
  }) async {
    await AppDB.update(
      table: "AuthData",
      data: {
        "phoneNumber": phoneNumberInp,
      },
      whereStatement: null,
      whereValue: null,
    );
    await fetchAndSetTable();
    notifyListeners();
  }

  Future<void> updateNameInAuthDataTable({
    String nameInp,
  }) async {
    await AppDB.update(
      table: "AuthData",
      data: {
        "name": nameInp,
      },
      whereStatement: null,
      whereValue: null,
    );
    await fetchAndSetTable();
    notifyListeners();
  }

  Future<void> clearAuthDataTable() async {
    currentUser = UserAuthModel.getEmptyUserAuthModel();
    await AppDB.update(
      table: "AuthData",
      data: currentUser.toAppDatabase(),
      whereStatement: null,
      whereValue: null,
    );
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

  ////////////////////////
  /// Functions for register a new account

  Future<String> signUpWithEmailAndPassword({
    BuildContext context,
    UserAuthModel userAuthModel,
  }) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "لا يوجد لديك اتصال بالانترنت";
    }

    try {
      // Intialize firebase
      await startFireBase();

      // sign up user
      FirebaseAuth fA;
      fA = FirebaseAuth.instance;
      UserCredential userCredential;
      User userAuthFirebase;

      // sign up the user
      userCredential = await fA.createUserWithEmailAndPassword(
        email: userAuthModel.email,
        password: userAuthModel.password,
      );

      // Here will be code for ev

      userAuthFirebase = userCredential.user;

      //  Create the user in
      bool check = await createUserInCloudFirestore(
        userAuthModel: userAuthModel,
        userAuthFirebase: userAuthFirebase,
      );

      if (!check) {
        return 'لقد حدث خطأ اثناء تسجيل المستخدم في قاعدة البيانات';
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "البريد الالكتروني الذي ادخلته موجود بالفعل";
      } else if (e.code == "invalid-email") {
        return "البريد الالكتروني الذي ادخلته غير صحيح";
      } else if (e.code == "weak-password") {
        return "كلمة المرور التي ادخلتها ضعيفة";
      } else {
        return e.code;
      }
    } on SocketException catch (_) {
      return "لا يوجد لديك اتصال بالانترنت";
    } catch (e) {
      return "لقد حدث خطأ";
    }
  }

  Future<bool> createUserInCloudFirestore(
      {User userAuthFirebase, UserAuthModel userAuthModel}) async {
    try {
      FirebaseFirestore fCF;

      fCF = FirebaseFirestore.instance;
      String countryName = await getCountryName();

      // Complete the auth data before storeing them in firestore
      userAuthModel.resetDate = null;
      userAuthModel.countryName = countryName;
      userAuthModel.uid = userAuthFirebase.uid;

      await fCF
          .collection("Users")
          .doc(userAuthFirebase.uid)
          .collection("UserData")
          .doc("AuthData")
          .set(
            userAuthModel.toFirebase(),
          );

      return true;
    } catch (error) {
      print(error);
      // validate sign up process
      return false;
    }
  }

  Future<String> getCountryName() async {
    String countryName = '';
    try {
      String url = 'http://ip-api.com/json';
      Uri uri = Uri.parse(url);
      http.Response data = await http.get(uri);
      Map out = jsonDecode(data.body);
      countryName = out['country'];
    } catch (_) {
      try {
        // This fucntion will get country code
        countryName = await FlutterSimCountryCode.simCountryCode;
      } catch (_) {
        // No thing to do
      }
    }
    return countryName;
  }

  //////////////////////////////////////////
  /// Functions for Login
  /// Using email and password
  Future<String> loginWithEmailAndPassword({
    BuildContext context,
    UserAuthModel userAuthModel,
  }) async {
    // Check internet connection
    bool check = await checkInternetConnection();

    if (!check) {
      return "لا يوجد لديك اتصال بالانترنت";
    }

    try {
      // Intialize firebase
      await startFireBase();

      // login user
      FirebaseAuth fA;
      fA = FirebaseAuth.instance;

      UserCredential userCredential;
      User userAuthFirebase;

      // sign in the user
      userCredential = await fA.signInWithEmailAndPassword(
        email: userAuthModel.email,
        password: userAuthModel.password,
      );
      userAuthFirebase = userCredential.user;

      // Here will be code for ev

      String output = await storeAuthDataAfterLoginWithEmailAndPassword(
        context: context,
        userAuthModel: userAuthModel,
        userAuthFirebase: userAuthFirebase,
      );

      return output;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "البريد الالكتروني الذي ادخلته غير صحيح";
      } else if (e.code == "user-disabled") {
        return "تم ايفاف هذا المستخدم";
      } else if (e.code == "user-not-found") {
        return "هذا المستخدم غير موجود";
      } else if (e.code == "wrong-password") {
        return "كلمة المرور التي ادخلتها غير صحيحه";
      } else {
        print(e);
        return e.code;
      }
    } on SocketException catch (_) {
      return "لا يوجد لديك اتصال بالانترنت";
    } catch (e) {
      return 'لقد حدث خطأ';
    }
  }

  Future<String> storeAuthDataAfterLoginWithEmailAndPassword({
    BuildContext context,
    User userAuthFirebase,
    UserAuthModel userAuthModel,
  }) async {
    try {
      FirebaseFirestore fCF;
      fCF = FirebaseFirestore.instance;

      // I do that, because the password maybe has been changed in reset password process over the web not the app,
      // So i update password everytime the user login to the app
      await fCF
          .collection("Users")
          .doc(userAuthFirebase.uid)
          .collection("UserData")
          .doc("AuthData")
          .update(
        {
          "password": userAuthModel.password,
        },
      );

      //  Get user's auth data from firebase firestore
      DocumentSnapshot documentSnapshot = await fCF
          .collection("Users")
          .doc(userAuthFirebase.uid)
          .collection("UserData")
          .doc("AuthData")
          .get();

      Map outputData = documentSnapshot.data();

      userAuthModel = UserAuthModel.fromFirebase(
        map: outputData,
      );

      //  Store user's auth data in app database
      await updateAuthDataTable(
        userAuthModelInp: userAuthModel,
      );

      return null;
    } catch (e) {
      print(e);
      return 'لقد حدث خطأ';
    }
  }

  // Reset password function
  Future<String> resetPasswordFn({String email}) async {
    try {
      // Check internet connection
      bool check = await checkInternetConnection();

      if (!check) {
        return "لا يوجد لديك اتصال بالانترنت";
      }

      // Intialize firebase
      await startFireBase();

      FirebaseAuth fA;
      fA = FirebaseAuth.instance;
      //
      await fA.sendPasswordResetEmail(
        email: email,
      );

      //
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "البريد الالكتروني الذي ادخلته غير صحيح";
      } else if (e.code == "user-disabled") {
        return "تم ايفاف هذا المستخدم";
      } else if (e.code == "user-not-found") {
        return "هذا المستخدم غير موجود";
      } else if (e.code == "wrong-password") {
        return "كلمة المرور التي ادخلتها غير صحيحه";
      } else {
        print(e);
        return e.code;
      }
    } catch (e) {
      print(e);
      return "لقد حدث خطأ";
    }
  }

  ////////////////////////////
  // Login with google functions
  Future<String> signInWithGoogle({
    BuildContext context,
  }) async {
    try {
      // Check internet connection
      bool check = await checkInternetConnection();

      if (!check) {
        return "لا يوجد لديك اتصال بالانترنت";
      }
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print('---------- User credential ----------');
      print(userCredential);

      User userAuthFirebase = userCredential.user;

      String output = await storeAuthDataAfterLoginWithGoogleOrFacebook(
        context: context,
        userAuthFirebase: userAuthFirebase,
      );
      return output;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "البريد الالكتروني الذي ادخلته غير صحيح";
      } else if (e.code == "user-disabled") {
        return "تم ايفاف هذا المستخدم";
      } else if (e.code == "user-not-found") {
        return "هذا المستخدم غير موجود";
      } else if (e.code == "wrong-password") {
        return "كلمة المرور التي ادخلتها غير صحيحه";
      } else {
        print(e);
        return e.code;
      }
    } on SocketException catch (_) {
      return "لا يوجد لديك اتصال بالانترنت";
    } catch (e) {
      return 'لقد حدث خطأ';
    }
  }

  Future<String> storeAuthDataAfterLoginWithGoogleOrFacebook({
    BuildContext context,
    User userAuthFirebase,
  }) async {
    try {
      FirebaseFirestore fCF;
      fCF = FirebaseFirestore.instance;
      UserAuthModel userAuthModel;
      UserAuthModel tempUserAuthModel;

      String countryName = await getCountryName();

      //  Get user's auth data from firebase firestore
      DocumentSnapshot documentSnapshot = await fCF
          .collection("Users")
          .doc(userAuthFirebase.uid)
          .collection("UserData")
          .doc("AuthData")
          .get();

      Map outputData = documentSnapshot.data();

      if (outputData != null) {
        //  This is the case if the user has modified his data from his profile
        // So i need to know this data to avoid overwrite on it, then merge them the login's auth data
        tempUserAuthModel = UserAuthModel.fromFirebase(
          map: outputData,
        );
        userAuthModel = UserAuthModel(
          email: userAuthFirebase.email,
          uid: userAuthFirebase.uid,
          profilePhoto: userAuthFirebase.photoURL,
          countryName: countryName,
          password: null,
          resetDate: null,
          birthDate: tempUserAuthModel.birthDate,
          gender: tempUserAuthModel.gender,
          name: tempUserAuthModel.name,
          phoneNumber: tempUserAuthModel.phoneNumber,
        );
      } else {
        // This is the case if user sign in for first time
        userAuthModel = UserAuthModel(
          email: userAuthFirebase.email,
          name: userAuthFirebase.displayName,
          uid: userAuthFirebase.uid,
          phoneNumber: userAuthFirebase.phoneNumber,
          profilePhoto: userAuthFirebase.photoURL,
          countryName: countryName,
          gender: 'Male',
          password: null,
          resetDate: null,
          birthDate: null,
        );
      }

      // Set the user's auth data in firestore after login with google
      await fCF
          .collection("Users")
          .doc(userAuthFirebase.uid)
          .collection("UserData")
          .doc("AuthData")
          .set(
            userAuthModel.toFirebase(),
          );

      //  Store user's auth data in app database
      await updateAuthDataTable(
        userAuthModelInp: userAuthModel,
      );

      return null;
    } catch (e) {
      print(e);
      return 'لقد حدث خطأ';
    }
  }

  //////////////////////////////////////////////
  // Login with facebook functions
  Future<String> signInWithFacebook({
    BuildContext context,
  }) async {
    try {
      // Check internet connection
      bool check = await checkInternetConnection();

      if (!check) {
        return "لا يوجد لديك اتصال بالانترنت";
      }

      // Trigger the sign-in flow
      final facebookAuth = FacebookAuth.instance;
      final LoginResult loginResult = await facebookAuth.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);

      // Once signed in, return the UserCredential

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      print('---------- User credential ----------');
      print(userCredential);

      User userAuthFirebase = userCredential.user;

      String output = await storeAuthDataAfterLoginWithGoogleOrFacebook(
        context: context,
        userAuthFirebase: userAuthFirebase,
      );
      return output;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "البريد الالكتروني الذي ادخلته غير صحيح";
      } else if (e.code == "user-disabled") {
        return "تم ايفاف هذا المستخدم";
      } else if (e.code == "user-not-found") {
        return "هذا المستخدم غير موجود";
      } else if (e.code == "wrong-password") {
        return "كلمة المرور التي ادخلتها غير صحيحه";
      } else {
        print(e);
        return e.code;
      }
    } on SocketException catch (_) {
      return "لا يوجد لديك اتصال بالانترنت";
    } catch (e) {
      return 'لقد حدث خطأ';
    }
  }

  /////////////////////////////////////////////
  /// Modify and update user's Auth data
  Future<String> modifyAndUpdateUserAuthData({
    BuildContext context,
    UserAuthModel userAuthModel,
  }) async {
    try {
      // Check internet connection
      bool check = await checkInternetConnection();

      if (!check) {
        return "لا يوجد لديك اتصال بالانترنت";
      }
      FirebaseFirestore fCF;
      fCF = FirebaseFirestore.instance;

      //  Get user's auth data from firebase firestore
      await fCF
          .collection("Users")
          .doc(userAuthModel.uid)
          .collection("UserData")
          .doc("AuthData")
          .update(
        {
          "name": userAuthModel.name,
          "phoneNumber": userAuthModel.phoneNumber,
          "gender": userAuthModel.gender,
          "birthDate": userAuthModel.birthDate == null
              ? null
              : Timestamp.fromDate(userAuthModel.birthDate),
        },
      );

      // Update user's auth data in firestore

      //  Update user's auth data in app database
      await updateAuthDataTable(
        userAuthModelInp: userAuthModel,
      );

      return null;
    } on SocketException catch (_) {
      return "لا يوجد لديك اتصال بالانترنت";
    } catch (e) {
      return 'لقد حدث خطأ';
    }
  }
}
