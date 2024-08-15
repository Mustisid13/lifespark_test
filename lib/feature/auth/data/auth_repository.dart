import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<FirebaseAuthException, User?>> verifyOtpOnPhone(String otp, String verificationId);
  Future<Either<FirebaseAuthException, String>> sendOtpOnPhoneNumber(
      String phone);
}
