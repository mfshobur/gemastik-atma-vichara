import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:flutter/material.dart';

class PrimaryElevatedButton extends StatelessWidget {
  const PrimaryElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.dense = false,
    this.disabled = false,
    this.style,
    this.fontSize,
  });

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final bool dense;
  final bool disabled;
  final ButtonStyle? style;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            // remove splash effect
            splashFactory: disabled ? NoSplash.splashFactory : InkRipple.splashFactory,
            backgroundColor: disabled ? kDisable : color.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: width != null
                ? Size(width!, 56.0)
                : dense
                    ? null
                    : const Size(double.infinity, 56.0),
          ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.w500,
          color: disabled ? color.secondary : null,
        ),
      ),
    );
  }
}
