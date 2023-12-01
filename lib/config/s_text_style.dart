import 'package:flutter/material.dart';

import 'constants.dart';

// headline: w700, subTitle: w500, body: w400
// 맨 뒤 숫자가 폰트 사이즈
@immutable
class STextStyle {
  STextStyle(this.scale);
  final double scale;

  late final Color fontColor = $style.colors.black;
  final double height = 1.3;

  late final TextStyle headline40 = TextStyle(
    fontSize: 40 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle headline32 = TextStyle(
    fontSize: 32 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle headline28 = TextStyle(
    fontSize: 28 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle headline24 = TextStyle(
    fontSize: 24 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle headline20 = TextStyle(
    fontSize: 20 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle headline18 = TextStyle(
    fontSize: 18 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle headline16 = TextStyle(
    fontSize: 16 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle headline14 = TextStyle(
    fontSize: 14 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle headline12 = TextStyle(
    fontSize: 12 * scale,
    fontWeight: FontWeight.bold,
    height: height,
    color: fontColor,
  );

  late final TextStyle subTitle20 = TextStyle(
    fontSize: 20 * scale,
    fontWeight: FontWeight.w500,
    height: height,
    color: fontColor,
  );

  late final TextStyle subTitle18 = TextStyle(
    fontSize: 18 * scale,
    fontWeight: FontWeight.w500,
    height: height,
    color: fontColor,
  );

  late final TextStyle subTitle16 = TextStyle(
    fontSize: 16 * scale,
    fontWeight: FontWeight.w500,
    height: height,
    color: fontColor,
  );

  late final TextStyle subTitle15 = TextStyle(
    fontSize: 15 * scale,
    fontWeight: FontWeight.w500,
    height: height,
    color: fontColor,
  );

  late final TextStyle subTitle14 = TextStyle(
    fontSize: 14 * scale,
    fontWeight: FontWeight.w500,
    height: height,
    color: fontColor,
  );

  late final TextStyle subTitle12 = TextStyle(
    fontSize: 12 * scale,
    fontWeight: FontWeight.w500,
    height: height,
    color: fontColor,
  );

  late final TextStyle subTitle10 = TextStyle(
    fontSize: 10 * scale,
    fontWeight: FontWeight.w500,
    height: height,
    color: fontColor,
  );

  late final TextStyle body18 = TextStyle(
    fontSize: 18 * scale,
    fontWeight: FontWeight.normal,
    height: height,
    color: fontColor,
  );

  late final TextStyle body16 = TextStyle(
    fontSize: 16 * scale,
    fontWeight: FontWeight.normal,
    height: height,
    color: fontColor,
  );

  late final TextStyle body14 = TextStyle(
    fontSize: 14 * scale,
    fontWeight: FontWeight.normal,
    height: height,
    color: fontColor,
  );

  late final TextStyle body12 = TextStyle(
    fontSize: 12 * scale,
    fontWeight: FontWeight.normal,
    height: height,
    color: fontColor,
  );
}
