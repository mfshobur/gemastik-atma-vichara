import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:flutter/material.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reflect',
          style: TextStyle(
            fontSize: 36,
            fontWeight: kFontweightSemiBold,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Embrace the Journey',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Life is a series of moments - the past, the present, and the yet-to-be. Take a moment to pause, breathe, and reflect.',
          style: TextStyle(
            fontSize: 16,
            color: kSemiGrayColor,
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
