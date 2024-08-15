import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifespark_test/core/router/route_names.dart';
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

  /// sendOtp send otp to entered phone number
  Future<bool> sendOtp(String phone) async {
    state = const AsyncLoading();
    Completer<bool> sent = Completer();
    // sending otp
    final result = await _authUsecase.sendOtpOnPhoneNumber(phone);
    result.fold((err) {
      // When faced any error
      log("", error: err.message, name: "Error");
      showToast(
          title:
              "We are nnable to send OTP on your number at the moment, please try again later",
          isError: true);
      state = const AsyncData(false);
      sent.complete(false);
    }, (succes) {
      // when code successfully sent
      showToast(
        title: "We have sent OTP on your number.",
      );
      _verificationId = succes;
      state = const AsyncData(true);
      sent.complete(true);
    });
    return await sent.future;
  }

  /// VerifyOTP method verifies the otp sent to user
  Future<bool> verifyOtp(String otp, BuildContext context) async {
    Completer<bool> verified = Completer();
    final result = await _authUsecase.verifyOtpOnPhone(otp, _verificationId);
    result.fold((err) {
      showToast(title: "Unauthorized login!", isError: true);
      verified.complete(false);
    }, (user) async {
      if (user != null) {
        verified.complete(true);
        await _sharedPreferenceService.storeUser(user);
        if (context.mounted) {
          context.go(RouteNames.home);
        }
      } else {
        showToast(
            title:
                "We are facing some problem in authenticating, please try again after some time",
            isError: true);
        verified.complete(false);
      }
    });
    return await verified.future;
  }

  void logOut(BuildContext context) {
    _sharedPreferenceService.clearAll();
    context.go(RouteNames.login);
  }
}
