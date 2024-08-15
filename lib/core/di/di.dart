import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifespark_test/core/services/local_service.dart';
import 'package:lifespark_test/feature/auth/data/auth_repository.dart';
import 'package:lifespark_test/feature/auth/data/auth_service.dart';
import 'package:lifespark_test/feature/auth/domain/auth_repository_impl.dart';
import 'package:lifespark_test/feature/auth/domain/auth_usecase.dart';
import 'package:lifespark_test/feature/auth/presentation/controller/login_controller.dart';
import 'package:lifespark_test/feature/home/presentation/controller/home_controller.dart';
import 'package:riverpod/riverpod.dart';

final authService = Provider<AuthService>(
    (ref) => AuthService(firebaseAuth: FirebaseAuth.instance));
final authRepository = Provider<AuthRepository>(
    (ref) => AuthRepositoryImpl(authService: ref.read(authService)));
final authUsecase = Provider<AuthUsecase>(
    (ref) => AuthUsecase(authRepository: ref.read(authRepository)));
final loginController =
    StateNotifierProvider<LoginController, AsyncValue<bool>>((ref) =>
        LoginController(ref.read(authUsecase), SharedPreferenceService()));

// HOME CONTROLLER
final homeController =
    StateNotifierProvider((ref) => HomeController(SharedPreferenceService()));
