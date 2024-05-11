import 'package:atma_vichara_gemastik/const/resource.dart';
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(R.ASSETS_ICONS_ICON_PNG, height: 65),
              const SizedBox(height: 53),
              const Text(
                'Selamat Datang di\nAtma Vichara',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 294),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryElevatedButton(
                    text: 'Masuk',
                    onPressed: () {},
                    dense: true,
                    width: 167,
                    fontSize: 18,
                  ),
                  const SizedBox(width: 16),
                  PrimaryElevatedButton(
                    text: 'Daftar',
                    onPressed: () {},
                    disabled: true,
                    dense: true,
                    width: 167,
                    fontSize: 18,
                  ),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
