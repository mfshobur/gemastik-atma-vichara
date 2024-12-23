import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/core/router.dart';
import 'package:atma_vichara_gemastik/core/theme.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/note_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/reflection_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserNotifier()),
        ChangeNotifierProvider(create: (_) => 
        ReflectionNotifier()),
        ChangeNotifierProvider(create: (_) => 
        NoteNotifier()),
      ],
      child: MaterialApp.router(
        title: kAppName,
        theme: AppTheme().theme,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
