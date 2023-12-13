import 'package:flutter/material.dart';

import '../../config/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.width,
    this.height,
    this.isOk = true,
    this.isOutline = false,
    this.borderRadius,
    this.textStyle,
    required this.onTap,
  });

  final String text;
  final Color? color;
  final double? width;
  final double? height;
  final bool isOk;
  final bool isOutline;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final GestureTapCallback onTap;

  CustomButton.small({
    Key? key,
    required String text,
    bool isOk = true,
    bool isOutline = false,
    Color? color,
    required GestureTapCallback onTap,
  }) : this(
          key: key,
          width: 82 * sizeUnit,
          height: 32 * sizeUnit,
          text: text,
          isOk: isOk,
          isOutline: isOutline,
          color: color,
          onTap: onTap,
          textStyle: $style.text.headline14,
        );

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = this.textStyle ?? $style.text.headline16;
    final Color backColor = isOutline
        ? Colors.white
        : isOk
            ? color ?? $style.colors.primary
            : $style.colors.grey;
    final Color borderColor = isOutline
        ? isOk
            ? color ?? $style.colors.primary
            : $style.colors.grey
        : backColor;

    return TextButton(
      onPressed: isOk ? onTap : null,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular($style.corners.$24),
            side: BorderSide(color: borderColor),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backColor),
        minimumSize: MaterialStateProperty.all(Size(width ?? double.infinity, height ?? 44 * sizeUnit)),
        fixedSize: MaterialStateProperty.all(Size(width ?? double.infinity, height ?? 44 * sizeUnit)),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: $style.insets.$8)),
        alignment: Alignment.center,
      ),
      child: Text(
        text,
        style: textStyle.copyWith(
          color: isOutline
              ? isOk
                  ? color ?? $style.colors.primary
                  : $style.colors.grey
              : Colors.white,
        ),
      ),
    );
  }
}
