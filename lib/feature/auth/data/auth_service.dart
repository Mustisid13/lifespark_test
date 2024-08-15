import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  final FirebaseAuth _firebaseAuth;

  /// sendOtpOnPhoneNumber takes phone number as parameter and sends otp using firebase to the provided phone number
  Future<Either<FirebaseAuthException, String>> sendOtpOnPhoneNumber(
      String phone) async {
    Completer<dynamic> result = Completer();
    // sending otp
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (creds) {},
        verificationFailed: (exception) {
          // when error is thrown
          result.complete(exception);
        },
        codeSent: (vId, _) {
          // when code is sent successfully the return verification id
          result.complete(vId);
        },
        codeAutoRetrievalTimeout: (err) {});
    final finalResult = await result.future;
    if (finalResult is String) {
      return Right(finalResult);
    } else {
      return Left(finalResult);
    }
  }
  // verifyOtpOnPhone takes otp and verification id as input that is returned by sendOtpOnPhoneNumber
  Future<Either<FirebaseAuthException, User?>> verifyOtpOnPhone(
      String otp, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final userCreds = await _firebaseAuth.signInWithCredential(credential);

      return Right(userCreds.user);
    } on FirebaseAuthException catch (err) {
      log("", error: err, name: "Phone otp verification error");
      // if(err.code == "invalid-verification-code"){
      return Left(err);
      // }
    }
  }
}
