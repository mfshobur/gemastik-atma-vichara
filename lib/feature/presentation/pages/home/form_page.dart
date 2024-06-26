import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/core/enum.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/reflection_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/primary_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  const FormPage({
    super.key,
    required this.type,
    required this.description,
  });

  final ReflectionType type;
  final String description;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late String title;
  late TextEditingController answerController;
  late List<String> questions;
  late String question;
  late List<String> answers;
  bool canNext = false;
  bool canPrev = false;
  int currentQuestionIndex = 0;
  String nextButtonText = 'Next';
  bool canPop = false;

  @override
  void initState() {
    Provider.of<ReflectionNotifier>(context, listen: false).initState();
    title = widget.type == ReflectionType.past
        ? 'PAST'
        : widget.type == ReflectionType.present
            ? 'PRESENT'
            : 'FUTURE';
    answerController = TextEditingController();
    questions = widget.type == ReflectionType.past
        ? pastQuestions
        : widget.type == ReflectionType.present
            ? presentQuestions
            : futureQuestions;
    question = questions[currentQuestionIndex];
    answers = [];
    for (var _ in questions) {
      answers.add('');
    }
    super.initState();
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void updateAnswer() {
    if (answerController.text.isEmpty) {
      setState(() {
        canNext = false;
      });
    } else if (answerController.text.length == 1) {
      setState(() {
        canNext = true;
      });
    }
  }

  void nextQuestion() {
    // save answer
    answers[currentQuestionIndex] = answerController.text;
    // go to next question
    currentQuestionIndex++;
    if (answers[currentQuestionIndex].isNotEmpty) {
      answerController.text = answers[currentQuestionIndex];
      canNext = true;
    } else {
      answerController.clear();
      canNext = false;
    }
    if (currentQuestionIndex == questions.length - 1) {
      nextButtonText = 'Done';
      canNext = false;
    }
    canPrev = true;
    question = questions[currentQuestionIndex];
    setState(() {});
  }

  void prevQuestion() {
    // save answer
    answers[currentQuestionIndex] = answerController.text;
    // go to prev question
    currentQuestionIndex--;
    if (answers[currentQuestionIndex].isNotEmpty) {
      answerController.text = answers[currentQuestionIndex];
      canNext = true;
    } else {
      answerController.clear();
    }
    if (currentQuestionIndex == 0) {
      canPrev = false;
    }
    question = questions[currentQuestionIndex];
    setState(() {});
  }

  void submit(BuildContext context) {
    // save answer
    answers[currentQuestionIndex] = answerController.text;
    // submit reflection
    final userId = Provider.of<UserNotifier>(context, listen: false).user!.id;
    Provider.of<ReflectionNotifier>(context, listen: false).submitReflection(
      widget.type,
      answers,
      userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        if (didPop) return;
        // show dialog to confirm
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Exit Reflection?',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.white,
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('You will lose all your progress.'),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: kFontweightSemiBold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.pop();
                  },
                  child: const Text(
                    'Exit',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: kFontweightSemiBold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: kFontweightSemiBold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 12,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: color.onSecondary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.5,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: color.secondary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.5,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Center(
                            child: Text(
                              question,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: kFontweightSemiBold,
                                color: color.onSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24, bottom: 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${currentQuestionIndex + 1}/${questions.length}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: kFontweightSemiBold,
                              color: color.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // multi line text field with grey border
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kSemiGrayColor),
                  ),
                  child: TextField(
                    controller: answerController,
                    minLines: 5,
                    maxLines: null,
                    onChanged: (value) => updateAnswer(),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'answer here...',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    PrimaryElevatedButton(
                      text: 'Prev',
                      onPressed: () {
                        if (canPrev) {
                          prevQuestion();
                        }
                      },
                      disabled: !canPrev,
                      dense: true,
                    ),
                    const Spacer(),
                    Consumer<ReflectionNotifier>(
                      builder: (context, value, child) {
                        final state = value.submitReflectionState;
                        if (state.stateLoading()) {
                          return const CircularProgressIndicator();
                        } else if (state.stateError()) {
                          Fluttertoast.showToast(
                            msg: 'Failed to submit reflection',
                          );
                        } else if (state.stateSuccess()) {
                          Fluttertoast.showToast(
                            msg: 'Reflection submitted successfully',
                          );
                          final userNotifier = Provider.of<UserNotifier>(context, listen: false);
                          Future.microtask(
                            () => userNotifier
                                .updateLocalReflection(
                              widget.type,
                              answers,
                            ),
                          );
                          
                          canPop = true;
                          Future.microtask(() => context.go('/home'));
                        }
                        return PrimaryElevatedButton(
                          text: nextButtonText,
                          onPressed: () {
                            if (nextButtonText == 'Done') {
                              submit(context);
                            } else if (canNext) {
                              nextQuestion();
                            }
                          },
                          disabled: !canNext,
                          dense: true,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
