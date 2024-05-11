import 'package:atma_vichara_gemastik/feature/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/onboarding/signin_screen.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/onboarding/signup_screen.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
      routes: [
        GoRoute(
          path: 'signin',
          builder: (context, state) => const SigninScreen(),
        ),
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignupScreen(),
        ),
      ],
    ),
  ],
);
