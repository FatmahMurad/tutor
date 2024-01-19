import 'package:flutter/foundation.dart';

class AuthValidators {
  final String _passwordErrMsg = "Password must have at least 6 characters.";

  String? emailValidator(String? val) {
    debugPrint("emailValidator $val");
    if (val != null) {
      final bool emailValid = RegExp(
              r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$')
          .hasMatch(val);
      if (emailValid) {
        return null;
      }
    }
    return "Emial is Not Valid";
  }

  String? passwordVlidator(String? val) {
    final String password = val as String;

    if (password.isEmpty || password.length <= 5) return _passwordErrMsg;

    return null;
  }

  String? userNameValidator(String? val) {
    if (val != null && val.length > 3) {
      return null;
    } else {
      return "User Name must be more than 3 charecters";
    }
  }
}
