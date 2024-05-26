import 'package:atma_vichara_gemastik/const/resource.dart';
import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Provider.of<UserNotifier>(context, listen: false).getCurrentUser();
      // context.go('/onboarding');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserNotifier>(
          builder: (context, userNotifier, _) {
            if (userNotifier.getCurrentUserState.stateError()) {
              Future.microtask(() => context.go('/onboarding'));
            } else if (userNotifier.getCurrentUserState.stateSuccess()) {
              Future.microtask(() => context.go('/home'));
            }
            return Center(
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
            );
          },
        ),
      ),
    );
  }
}
