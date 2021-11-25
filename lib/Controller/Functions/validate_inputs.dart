import 'package:string_validator/string_validator.dart';

String validateInputsForLogin({String email, String password}) {
  if (email == null || email.trim().isEmpty) {
    return "من فضلك ادخل البريد الالكتروني";
  } else if (!isEmail(email)) {
    return "البريد الالكتروني الذي ادخلته غير صحيح";
  } else if (password == null || password.isEmpty) {
    return "من فضلك ادخل كلمة المرور";
  } else {
    return null;
  }
}

String validateEmail({String email}) {
  if (email == null || email.trim().isEmpty) {
    return "pleaseProvideEmail";
  } else if (!isEmail(email)) {
    return "invalidEmail";
  } else {
    return null;
  }
}

String validateInputsForRegistration(
    {String name, String email, String password, String phoneNumber}) {
  if (name == null || name.trim().isEmpty) {
    return "من فضلك ادخل اسم المستخدم";
  } else if (name.length < 4) {
    return "اسم المستخدم الذي ادخلته قصير";
  } else if (email == null || email.trim().isEmpty) {
    return "من فضلك ادخل البريد الالكتروني";
  } else if (!isEmail(email)) {
    return "البريد الالكتروني الذي ادخلته غير صحيح";
  } else if (password == null || password.isEmpty) {
    return "من فضلك ادخل كلمة المرور";
  } else if (password.length < 6) {
    return "كلمة المرور التي ادخلتها قصيره";
  } else if (isAlpha(password)) {
    return "كلمة المرور يجب أن تحتوي على احرف وارقام";
  } else if (isNumeric(password)) {
    return "كلمة المرور يجب أن تحتوي على احرف وارقام";
  } else if (phoneNumber == null || phoneNumber.trim().isEmpty) {
    return 'من فضلك ادخل رقم الهاتف';
  } else if (phoneNumber.length < 8) {
    return "رقم الهاتف الذي ادخلته قصير";
  } else {
    return null;
  }
}

String validateInputsAfterEditing(
    {String name, String phoneNumber}) {
  if (name == null || name.trim().isEmpty) {
    return "من فضلك ادخل اسم المستخدم";
  } else if (name.length < 4) {
    return "اسم المستخدم الذي ادخلته قصير";
  }  else if (phoneNumber == null || phoneNumber.trim().isEmpty) {
    return 'من فضلك ادخل رقم الهاتف';
  } else if (phoneNumber.length < 8) {
    return "رقم الهاتف الذي ادخلته قصير";
  } else {
    return null;
  }
}
