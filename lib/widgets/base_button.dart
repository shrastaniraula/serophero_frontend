import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  BaseButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.buttonStyle,
      this.buttonTextStyle,
      this.isDisabled,
      this.height,
      this.width,
      this.margin,
      this.alignment,
      this.isloading,
      this.color})
      : super(
          key: key,
        );

  final String text;
  final bool? isloading;

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
    return SizedBox.shrink();
  }
}
