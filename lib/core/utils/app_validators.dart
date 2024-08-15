import 'package:lifespark_test/core/utils/extensions/strings_extension.dart';

class AppValidators {
// phone number validation for TextFormField
  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return "Please enter your phone number";
    }
    if(value.length <10){
      return "Not a valid phone number";
    }
    return null;
  }

  // email validation for TextFormField
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an email!";
    }
    if (!value.isValidEmail) {
      return "Not a valid email!";
    }
    return null;
  }
}