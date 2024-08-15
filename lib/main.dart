import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifespark_test/core/router/router.dart';
import 'package:lifespark_test/core/services/local_service.dart';
import 'package:lifespark_test/core/styles/app_colors.dart';
import 'package:toastification/toastification.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService().initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ToastificationWrapper(
        child: MaterialApp.router(
          routerConfig: router,
          title: 'Lifespark Test',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.charcoalBlack,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
