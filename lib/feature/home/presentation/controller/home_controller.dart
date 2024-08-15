import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifespark_test/core/services/local_service.dart';
import 'package:lifespark_test/core/utils/app_toast.dart';

class HomeController extends StateNotifier<AsyncValue<bool>>{
  HomeController(this._preferenceService):super(const AsyncData(false));
final SharedPreferenceService _preferenceService;

  /// Stores email to local storage
  Future<void> storeEmail(String email)async{

   await _preferenceService.storeEmail(email);
   showToast(title: "Your email is safe with us");
  }

  /// showToastOfEmail shows email in pop up when app starts
  void showToastOfEmail() {
    final email = _preferenceService.getEmail();
    if(email != null){
      showToast(title: "Here is your saved email '$email'");
    }
  }
}