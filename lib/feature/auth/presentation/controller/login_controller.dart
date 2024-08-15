import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifespark_test/core/router/route_names.dart';
import 'package:lifespark_test/core/router/router.dart';
import 'package:lifespark_test/core/services/local_service.dart';
import 'package:lifespark_test/core/utils/app_toast.dart';
import 'package:lifespark_test/feature/auth/domain/auth_usecase.dart';
import 'package:riverpod/riverpod.dart';

class LoginController extends StateNotifier<AsyncValue<bool>> {
  LoginController(this._authUsecase, this._sharedPreferenceService)
      : super(const AsyncData(false));
  final AuthUsecase _authUsecase;
  final SharedPreferenceService _sharedPreferenceService;

  late String _verificationId;
  Future<bool> sendOtp(String phone) async {
    Completer<bool> sent = Completer();
    final result = await _authUsecase.sendOtpOnPhoneNumber(phone);
    result.fold((err) {
      showToast(
          title:
              "We are nnable to send OTP on your number at the moment, please try again later",
          isError: true);
          sent.complete(false);
    }, (succes) {
      showToast(
        title: "We have sent OTP on your number.",
      );
      sent.complete(true);
    });
    return await sent.future;
  }

  Future<void> verifyOtp(String otp, BuildContext context) async {
    final result = await _authUsecase.verifyOtpOnPhone(otp, _verificationId);
    result.fold((err) {
      showToast(title: "Unauthorized login!", isError: true);
    }, (user) {
      if (user != null) {
        showToast(
            title:
                "We are facing some problem in authenticating, please try again after some time");
        _sharedPreferenceService.storeUser(user);
        context.go(RouteNames.home);
      }
    });
  }
}
