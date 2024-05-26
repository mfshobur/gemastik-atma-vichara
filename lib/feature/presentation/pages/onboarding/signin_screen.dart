import 'package:atma_vichara_gemastik/const/resource.dart';
import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/primary_elevated_button.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/text_input_column.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Center(child: Image.asset(R.ASSETS_ICONS_ICON_PNG, height: 65)),
                  const SizedBox(height: 53),
                  const Text(
                    'Selamat Datang\nKembali!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: kFontweightSemiBold,
                    ),
                  ),
                  const SizedBox(height: 20),
                TextInputColumn(
                  text: 'Email',
                  controller: emailController,
                ),
                TextInputColumn(
                  text: 'Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 80),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Doesn\'t have an account? ',
                          style: TextStyle(color: kTextGreyColor),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go('/onboarding/signup');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryElevatedButton(
                  text: 'Sign In',
                  onPressed: () => context.go('/home'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
