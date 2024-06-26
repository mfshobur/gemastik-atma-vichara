// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/core/enum.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/reflection_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/home/home_header_section.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/home/reflect_form_card.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/home/reflection_result_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<ReflectionNotifier>(context, listen: false).initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserNotifier>(context, listen: false).user!;
    final alreadyAnswerAll =
        user.alreadyReflectPast && user.alreadyReflectPresent && user.alreadyReflectFuture;

    return Scaffold(
      body: SafeArea(
        child: alreadyAnswerAll
            ? const ReflectionResultSection()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Consumer<UserNotifier>(
                  builder: (context, userNotifier, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeaderSection(),
                        ReflectFormCard(type: ReflectionType.past),
                        ReflectFormCard(type: ReflectionType.present),
                        ReflectFormCard(type: ReflectionType.future),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
