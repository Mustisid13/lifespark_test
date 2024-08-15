import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifespark_test/feature/auth/presentation/login_page.dart';
import 'package:lifespark_test/feature/home/presentation/home_page.dart';

import '../services/local_service.dart';
import 'route_names.dart';

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    _getRoute(RouteNames.home, const HomePage(),guarded: true),
    _getRoute(RouteNames.login, const LoginPage()),
    // auth screens

  ],
);

GoRoute _getRoute(String path, Widget page, {bool guarded = false}) => GoRoute(
      path: path,
      name: path,
      redirect: guarded ? _checkAuthentication : null,
      builder: (BuildContext context, GoRouterState state) {
        return page;
      },
    );

String? _checkAuthentication(context, state) {
  final token = SharedPreferenceService().getUser();
  bool isAuthenticated = token != null;
  if (!isAuthenticated) {
    return "/login";
  }
  return null;
}
