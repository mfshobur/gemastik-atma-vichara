import 'package:atma_vichara_gemastik/feature/presentation/pages/home/home_page.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/home/scaffold_with_navbar.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/note_page.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/onboarding/signin_screen.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/onboarding/signup_screen.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/profile_page.dart';
import 'package:atma_vichara_gemastik/feature/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // main page will have navbar
        if (state.fullPath == '/home' ||
            state.fullPath == '/note' ||
            // state.fullPath == '/goal' ||
            state.fullPath == '/profile') {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        }
        // other page will not have navbar
        return Scaffold(
          body: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 480,
              ),
              child: navigationShell,
            ),
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: [
            GoRoute(
              name: 'home',
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'note',
              path: '/note',
              builder: (context, state) => const NotePage(),
            ),
          ],
        ),
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       name: 'goal',
        //       path: '/goal',
        //       builder: (context, state) => const GoalPage(),
        //     ),
        //   ],
        // ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'profile',
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
