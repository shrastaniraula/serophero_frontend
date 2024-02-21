import 'package:flutter/material.dart';

class BaseTextFormField extends StatelessWidget {
  BaseTextFormField({
    required this.initialValue,
    this.onPressed,
    this.buttonStyle,
    this.buttonTextStyle,
    this.isDisabled,
    this.height,
    this.width,
    this.margin,
    this.alignment,
    this.color,
  });

  final String initialValue;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? buttonTextStyle;
  final bool? isDisabled;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}
