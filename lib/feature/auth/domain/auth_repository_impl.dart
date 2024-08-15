import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifespark_test/feature/auth/data/auth_repository.dart';
import 'package:lifespark_test/feature/auth/data/auth_service.dart';

class AuthRepositoryImpl  implements AuthRepository{
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService}) : _authService = authService;
  @override
  Future<Either<FirebaseAuthException, String>> sendOtpOnPhoneNumber(String phone) {
    return _authService.sendOtpOnPhoneNumber(phone);
  }

  @override
  Future<Either<FirebaseAuthException, User?>> verifyOtpOnPhone(String otp, String verificationId) async{
    return _authService.verifyOtpOnPhone(otp, verificationId);
  }
}