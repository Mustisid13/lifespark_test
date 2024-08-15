class AppValidators {

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return "Please enter your phone number";
    }
    if(value.length <10){
      return "Not a valid phone number";
    }
    return null;
  }
}