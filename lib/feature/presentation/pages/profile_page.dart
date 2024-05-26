import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/core/utils/custom_snackbar.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserNotifier>(context, listen: false).user;
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: kFontweightBold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE1E8FF),
                  ),
                  child: Text(
                    user!.name[0],
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: kFontweightSemiBold,
                      color: color.primary,
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: kFontweightBold,
                        color: kLightGrey,
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: kFontweightRegular,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: kFontweightBold,
                        color: kLightGrey,
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: kFontweightRegular,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                Consumer<UserNotifier>(
                  builder: (context, value, child) {
                    if (value.signOutState.stateLoading()) {
                      return const CircularProgressIndicator();
                    } else if (value.signOutState.stateSuccess()) {
                      Future.microtask(() => context.go('/onboarding'));
                    } else if (value.signOutState.stateError()) {
                      CustomSnackbar.alert(context, value.signOutState.failure!.message);
                    }
                    return GestureDetector(
                      onTap: () {
                        value.signOut();
                      },
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: kFontweightSemiBold,
                          color: kRedColor,
                        ),
                      ),
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
