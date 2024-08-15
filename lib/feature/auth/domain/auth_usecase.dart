import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifespark_test/feature/auth/data/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase({required this.authRepository});

  Future<Either<FirebaseAuthException, User?>> verifyOtpOnPhone(String otp, String verificationId) {
    return authRepository.verifyOtpOnPhone(otp, verificationId);
  }

  Future<Either<FirebaseAuthException, String>> sendOtpOnPhoneNumber(
      String phone) {
    return authRepository.sendOtpOnPhoneNumber(phone);
  }
}
