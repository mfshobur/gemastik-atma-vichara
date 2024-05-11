import 'package:atma_vichara_gemastik/const/resource.dart';
import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      context.go('/onboarding');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                R.ASSETS_ICONS_ICON_PNG,
                width: 150,
              ),
              const SizedBox(height: 24),
              Text(
                kAppName,
                style: TextStyle(
                  color: color.primary,
                  fontSize: 26,
                  fontWeight: kFontweightSemiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
