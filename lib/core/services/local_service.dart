import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifespark_test/core/models/logged_in_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService._internal();

  static final _service = SharedPreferenceService._internal();

  factory SharedPreferenceService() {
    return _service;
  }

  // params
  SharedPreferences? _preferences;

  Future<void> initialize() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> storeEmail(String token) async {
    await _preferences?.setString("email", token);
  }

  String? getEmail() {
    return _preferences?.getString("email");
  }

  Future<void> clearAll() async {
    await _preferences?.clear();
  }

  Future<void> storeUser(User user) async {
    await _preferences?.setString(
        "user",
        jsonEncode(LoggedInUserModel(
                email: user.email,
                name: user.displayName,
                phone: user.phoneNumber,
                id: user.uid)
            .toJson()));
  }

LoggedInUserModel? getUser()  {
    final data = _preferences?.getString("user");
    if (data != null) {
      return LoggedInUserModel.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }
}
