import 'package:flutter/material.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: searchViewWidget,
          )
        : searchViewWidget;
  }

  Widget get searchViewWidget => SizedBox(
        width: width ?? (double.maxFinite) - 20,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode ?? null,
          autofocus: autofocus!,
          style: textStyle ?? const TextStyle(fontSize: 15),
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          onChanged: (String value) {
            onChanged!.call(value);
          },
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ??
            const TextStyle(
                color: Color.fromARGB(255, 126, 126, 126),
                fontWeight: FontWeight.normal,
                fontFamily: "poppins",
                fontSize: 17),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(
            08,
          ),
        ),
        prefixIconConstraints: prefixConstraints ??
            const BoxConstraints(
              maxHeight: 30,
            ),
        suffixIcon: suffix ??
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 23,
              ),
            ),
        suffixIconConstraints: suffixConstraints ??
            const BoxConstraints(
              maxHeight: 30,
            ),
        isDense: true,
        contentPadding: contentPadding ??
            const EdgeInsets.only(
              left: 8,
              top: 5,
              bottom: 5,
            ),
        fillColor: fillColor ?? Colors.white,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
      );
}

/// Extension on [CustomSearchView] to facilitate inclusion of all types of border style etc
extension SearchViewStyleHelper on CustomSearchView {
  static OutlineInputBorder get outlineBlackTL19 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1,
        ),
      );
}
