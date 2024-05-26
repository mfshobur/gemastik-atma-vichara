import 'package:atma_vichara_gemastik/const/resource.dart';
import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/core/router.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/primary_elevated_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                R.ASSETS_IMAGES_ONBOARDING_PNG,
                width: 303,
              ),
              const SizedBox(height: 53),
              const Text(
                'Selamat Datang\ndi Atma Vichara!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: kFontweightBold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Bersiaplah untuk memulai perjalanan\ndigital Anda dengan kami. Mari kita\njelajahi fitur-fitur menarik yang kami\ntawarkan untuk membuat hidup\nAnda lebih mudah.',
                style: TextStyle(
                  fontSize: 16,
                  color: kLightGrey,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryElevatedButton(
                    text: 'Masuk',
                    onPressed: () => router.go('/onboarding/signin'),
                    dense: true,
                    width: 167,
                    fontSize: 18,
                  ),
                  const SizedBox(width: 16),
                  PrimaryElevatedButton(
                    text: 'Daftar',
                    onPressed: () => router.go('/onboarding/signup'),
                    disabled: true,
                    dense: true,
                    width: 167,
                    fontSize: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
