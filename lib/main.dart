import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/core/router.dart';
import 'package:atma_vichara_gemastik/core/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: kAppName,
      theme: AppTheme().theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
