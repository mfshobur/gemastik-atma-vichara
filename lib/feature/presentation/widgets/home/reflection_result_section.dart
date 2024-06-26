import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/feature/domain/entities/reflection_result.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/reflection_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/home/reflection_result_card.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/primary_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ReflectionResultSection extends StatefulWidget {
  const ReflectionResultSection({super.key});

  @override
  State<ReflectionResultSection> createState() => _ReflectionResultSectionState();
}

class _ReflectionResultSectionState extends State<ReflectionResultSection> {
  List<ReflectionResult> reflectionResults = [];

  @override
  void initState() {
    final pastAnswers = Provider.of<UserNotifier>(context, listen: false).user!.pastAnswers;
    final presentAnswers = Provider.of<UserNotifier>(context, listen: false).user!.presentAnswers;
    final futureAnswers = Provider.of<UserNotifier>(context, listen: false).user!.futureAnswers;
    List<ReflectionResult> pastResult = [];
    List<ReflectionResult> presentResult = [];
    List<ReflectionResult> futureResult = [];

    for (var question in pastQuestions) {
      final answer = pastAnswers![pastQuestions.indexOf(question)];
      pastResult.add(
        ReflectionResult(
          question: question,
          answer: answer,
        ),
      );
      reflectionResults.add(
        ReflectionResult(
          question: question,
          answer: answer,
        ),
      );
    }

    for (var question in presentQuestions) {
      final answer = presentAnswers![presentQuestions.indexOf(question)];
      presentResult.add(
        ReflectionResult(
          question: question,
          answer: answer,
        ),
      );
      reflectionResults.add(
        ReflectionResult(
          question: question,
          answer: answer,
        ),
      );
    }

    for (var question in futureQuestions) {
      final answer = futureAnswers![futureQuestions.indexOf(question)];
      futureResult.add(
        ReflectionResult(
          question: question,
          answer: answer,
        ),
      );
      reflectionResults.add(
        ReflectionResult(
          question: question,
          answer: answer,
        ),
      );
    }
    if (Provider.of<UserNotifier>(context, listen: false).user!.reflectionResponse == null) {
      Future.microtask(() => Provider.of<ReflectionNotifier>(context, listen: false)
          .getReflectionResponse(Provider.of<UserNotifier>(context, listen: false).user!.id,
              pastResult, presentResult, futureResult));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReflectionNotifier>(
      builder: (context, value, child) {
        final state = value.generateReflectionResponseState;
        if (state.stateLoading()) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.stateSuccess()) {
          Future.microtask(() => Provider.of<UserNotifier>(context, listen: false)
              .updateReflectionResponse(value.generateReflectionResponseState.value!));
        }

        final reflectionResponse =
            Provider.of<UserNotifier>(context, listen: false).user!.reflectionResponse ??
                state.value;

        return Padding(
          padding: const EdgeInsets.fromLTRB(kDefaultPadding, kDefaultPadding, kDefaultPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reflect',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: kFontweightSemiBold,
                ),
              ),
              const SizedBox(height: 12),
              reflectionResponse != null
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'See what we thought about your reflection',
                              style: TextStyle(
                                fontWeight: kFontweightSemiBold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          PrimaryElevatedButton(
                            text: 'Look',
                            dense: true,
                            onPressed: () {
                              context.go('/home/response', extra: reflectionResponse);
                            },
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: kDefaultPadding),
                  itemCount: reflectionResults.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 24,
                  ),
                  itemBuilder: (context, index) {
                    final reflectionResult = reflectionResults[index];
                    return ReflectionResultCard(reflectionResult: reflectionResult);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
