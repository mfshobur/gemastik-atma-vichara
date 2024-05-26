import 'package:atma_vichara_gemastik/const/resource.dart';
import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/core/utils/custom_snackbar.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/primary_elevated_button.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/text_input_column.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (passwordController.text != confirmPasswordController.text) {
      CustomSnackbar.alert(context, 'Password tidak sama');
    } else {
      Provider.of<UserNotifier>(context, listen: false).signUp(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(kDefaultPadding, 40, kDefaultPadding, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(R.ASSETS_ICONS_ICON_PNG, height: 65)),
                const SizedBox(height: 32),
                const Text(
                  'Let\'s Get Started!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: kFontweightSemiBold,
                  ),
                ),
                const Text(
                  'Create an account to Atma Vichara',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),
                TextInputColumn(
                  text: 'Username',
                  controller: usernameController,
                ),
                TextInputColumn(
                  text: 'Email',
                  controller: emailController,
                ),
                TextInputColumn(
                  text: 'Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                TextInputColumn(
                  text: 'Confirm Password',
                  controller: confirmPasswordController,
                  isPassword: true,
                ),
                const SizedBox(height: 14),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(color: kTextGreyColor),
                        ),
                        TextSpan(
                          text: 'Sign in here',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go('/onboarding/signin');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<UserNotifier>(
                  builder: (context, value, child) {
                    if (value.signUpState.stateLoading()) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (value.signUpState.stateError()) {
                      // scaffold error message
                      Future.microtask(
                          () => CustomSnackbar.alert(context, value.signUpState.failure!.message));
                    } else if (value.signUpState.stateSuccess()) {
                      // go to home
                      Future.microtask(() => context.go('/home'));
                    }
                    return PrimaryElevatedButton(
                      text: 'Register',
                      onPressed: onSubmit,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
