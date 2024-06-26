import 'package:atma_vichara_gemastik/feature/domain/entities/reflection_result.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class ReflectionResultCard extends StatefulWidget {
  const ReflectionResultCard({
    super.key,
    required this.reflectionResult,
  });

  final ReflectionResult reflectionResult;

  @override
  State<ReflectionResultCard> createState() => _ReflectionResultCardState();
}

class _ReflectionResultCardState extends State<ReflectionResultCard> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return FlipCard(
      front: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.onSecondary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Text(
              widget.reflectionResult.question,
              style: TextStyle(
                fontSize: 18,
                color: color.secondary,
              ),
            ),
          ),
        ),
      ),
      back: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.onSecondary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Text(
              widget.reflectionResult.answer,
              style: TextStyle(
                fontSize: 16,
                color: color.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
