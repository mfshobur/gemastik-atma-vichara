import 'package:atma_vichara_gemastik/const/resource.dart';
import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:atma_vichara_gemastik/core/enum.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/reflection_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/provider/user_notifier.dart';
import 'package:atma_vichara_gemastik/feature/presentation/widgets/primary_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ReflectFormCard extends StatefulWidget {
  const ReflectFormCard({
    super.key,
    required this.type,
  });

  final ReflectionType type;

  @override
  State<ReflectFormCard> createState() => _ReflectFormCardState();
}

class _ReflectFormCardState extends State<ReflectFormCard> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserNotifier>(context, listen: false).user!;
    bool alreadyAnswered = widget.type == ReflectionType.past
        ? user.alreadyReflectPast
        : widget.type == ReflectionType.present
            ? user.alreadyReflectPresent
            : user.alreadyReflectFuture;

    String? alreadyAnsweredText = !alreadyAnswered
        ? null
        : widget.type == ReflectionType.past
            ? 'You already reflect your past'
            : widget.type == ReflectionType.present
                ? 'You already reflect your present'
                : 'You already reflect your future';

    final titleText = widget.type == ReflectionType.past
        ? 'Past Reflection'
        : widget.type == ReflectionType.present
            ? 'Present Reflection'
            : 'Future Reflection';

    final subtitleText = widget.type == ReflectionType.past
        ? 'Remember the steps you\'ve taken, the challenges you\'ve overcome, and the joys you\'ve experienced. They\'ve shaped who you are today.'
        : widget.type == ReflectionType.present
            ? 'Embrace this moment. Feel the warmth of the sun, the gentle breeze, and the beating of your heart. You are here, now.'
            : 'Look ahead with hope and anticipation. Dream big, set goals, and believe in the magic of what\'s to come. Your journey continues, filled with infinite possibilities.';

    final image = widget.type == ReflectionType.past
        ? R.ASSETS_IMAGES_PAST_CARD_IMAGE_PNG
        : widget.type == ReflectionType.present
            ? R.ASSETS_IMAGES_PRESENT_CARD_IMAGE_PNG
            : R.ASSETS_IMAGES_FUTURE_CARD_IMAGE_PNG;

    return alreadyAnswered
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
                Expanded(
                  child: Text(
                    alreadyAnsweredText!,
                    style: const TextStyle(
                      fontWeight: kFontweightSemiBold,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Consumer<ReflectionNotifier>(
                  builder: (context, reflectionNotifier, child) {
                    final state = reflectionNotifier.resetReflectionState;
                    if (state.stateLoading()) {
                      return const CircularProgressIndicator();
                    } else if (state.stateError()) {
                      Fluttertoast.showToast(
                        msg: 'Failed to reset reflection',
                      );
                    } else if (state.stateSuccess()) {
                      Future.microtask(() => Provider.of<UserNotifier>(context, listen: false)
                          .resetLocalReflection(widget.type));
                      Fluttertoast.showToast(
                        msg: 'Reflection reset successfully',
                      );
                    }
                    return PrimaryElevatedButton(
                      text: 'Restart',
                      dense: true,
                      onPressed: () {
                        // show dialog to confirm
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Reset Reflection?',
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
                                    reflectionNotifier.resetReflection(widget.type, user.id);

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Restart',
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
                    );
                  },
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: () => context.go('/home/form', extra: {
              'type': widget.type,
              'description': subtitleText,
            }),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleText,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: kFontweightSemiBold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subtitleText,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    image,
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
          );
  }
}
