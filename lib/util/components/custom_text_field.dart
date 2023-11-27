import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.errorText,
    this.focusNode,
    this.textInputType,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
    this.style,
    this.hintStyle,
    this.fillColor,
    this.borderColor,
    this.focusBorderColor,
    this.borderRadius,
    this.inputFormatters,
    this.width,
    this.counterText,
    this.isActive = true,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool obscureText;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final int? maxLength;
  final int maxLines;
  final int minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final BorderRadius? borderRadius;
  final List<TextInputFormatter>? inputFormatters;
  final double? width;
  final String? counterText;
  final bool isActive;
  final TextAlign textAlign;

  final TextStyle defaultTextStyle = $style.text.body14;

  final BorderRadius defaultBorderRadius = BorderRadius.circular($style.corners.$8);

  OutlineInputBorder outlinedInputBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1 * sizeUnit),
        borderRadius: borderRadius ?? defaultBorderRadius,
      );

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: $style.colors.primary,
          keyboardType: textInputType,
          textAlignVertical: TextAlignVertical.center,
          textAlign: textAlign,
          style: style ?? defaultTextStyle,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle ?? (style ?? defaultTextStyle).copyWith(color: $style.colors.grey),
            border: outlinedInputBorder(borderColor ?? $style.colors.grey),
            enabledBorder: outlinedInputBorder(borderColor ?? $style.colors.grey),
            focusedBorder: outlinedInputBorder(focusBorderColor ?? $style.colors.primary),
            errorBorder: outlinedInputBorder($style.colors.red),
            contentPadding: EdgeInsets.all(15 * sizeUnit),
            errorText: errorText,
            errorMaxLines: 2,
            errorStyle: $style.text.body12.copyWith(color: $style.colors.red),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            counterStyle: $style.text.body12.copyWith(color: $style.colors.grey),
            filled: true,
            fillColor: fillColor ?? Colors.white,
            isCollapsed: true,
            counterText: counterText,
          ),
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          autofocus: autofocus,
          obscureText: obscureText,
          onSubmitted: onSubmitted,
          onChanged: onChanged,
        ),
      );
    } else {
      final bool haveText = controller != null && controller!.text.isNotEmpty;

      return Container(
        padding: EdgeInsets.all($style.insets.$16),
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? defaultBorderRadius,
          color: $style.colors.grey,
        ),
        child: Text(
          haveText ? controller!.text : hintText ?? '',
          style: hintStyle ?? defaultTextStyle.copyWith(color: haveText ? null : $style.colors.grey),
          textAlign: textAlign,
        ),
      );
    }
  }
}
