import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool isLastInput;
  final bool email;
  final bool number;
  final Future<void> Function()? onComplete;
  final IconData? prefixIcon;
  final bool Function(String value)? validator;
  final String validatorText;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.email = false,
    this.number = false,
    this.isPassword = false,
    this.isLastInput = false,
    this.onComplete,
    this.prefixIcon,
    this.validator,
    this.validatorText = 'Field must be filled',
  });

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  late FocusNode _focusNode;
  late bool _isObscure;
  late Widget? _suffixIcon;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isObscure = widget.isPassword;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    _suffixIcon = _getSuffix();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        cursorColor: color.secondary,
        focusNode: _focusNode,
        validator: widget.validator != null
            ? (value) {
                if (widget.validator!(value!)) {
                  return widget.validatorText;
                }
                return null;
              }
            : null,
        onEditingComplete: () async {
          if (widget.onComplete != null) {
            _focusNode.unfocus();
            await widget.onComplete!();
          } else {
            _focusNode.nextFocus();
          }
        },
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: _isObscure,
        keyboardType: widget.email
            ? TextInputType.emailAddress
            : widget.number
                ? TextInputType.number
                : widget.isPassword
                    ? TextInputType.visiblePassword
                    : TextInputType.text,
        inputFormatters: widget.number ? [FilteringTextInputFormatter.digitsOnly] : null,
        textInputAction: widget.isLastInput ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(10),
          fillColor: color.background,
          filled: true,
          labelText: widget.hintText,
          labelStyle: TextStyle(
            fontSize: 16,
            color: color.onBackground,
          ),
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color.onBackground,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: kInputBorderColor,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: color.secondary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: color.secondary,
            ),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: color.onBackground,
                  size: 24,
                )
              : null,
          suffixIcon: _suffixIcon,
        ),
      ),
    );
  }

  Widget? _getSuffix() {
    if (widget.isPassword) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
        child: Icon(
          _isObscure ? Icons.visibility : Icons.visibility_off,
          color: kDarkGrey,
        ),
      );
    }
    return null;
  }
}
