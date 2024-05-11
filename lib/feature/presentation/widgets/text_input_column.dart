import 'package:atma_vichara_gemastik/feature/presentation/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class TextInputColumn extends StatelessWidget {
  const TextInputColumn({
    super.key,
    required this.text,
    required this.controller,
    this.prefixIcon,
    this.email = false,
    this.number = false,
    this.isPassword = false,
    this.isLastInput = false,
    this.onComplete,
    this.validator,
    this.validatorText = 'Field must be filled',
  });

  final String text;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool email;
  final bool number;
  final bool isPassword;
  final bool isLastInput;
  final Future<void> Function()? onComplete;
  final bool Function(String value)? validator;
  final String validatorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        PrimaryTextField(
          controller: controller,
          hintText: '',
          prefixIcon: prefixIcon,
          email: email,
          number: number,
          isPassword: isPassword,
          isLastInput: isLastInput,
          onComplete: onComplete,
          validator: validator,
          validatorText: validatorText,
        ),
      ],
    );
  }
}
