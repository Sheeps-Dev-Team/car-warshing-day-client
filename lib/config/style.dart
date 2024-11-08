import 'package:flutter/material.dart';

import 's_text_style.dart';

@immutable
class AppStyle {
  AppStyle({double? sizeUnit}) {
    if (sizeUnit == null) {
      scale = 1;
      return;
    } else {
      scale = sizeUnit;
    }
  }

  late final double scale;

  /// App color
  final AppColors colors = AppColors();

  /// Corner radius
  late final Corners corners = Corners(scale);

  /// Box shadow
  final BoxShadows boxShadows = BoxShadows();

  /// Padding and margin values
  late final Insets insets = Insets(scale);

  /// Text styles
  late final STextStyle text = STextStyle(scale);

  /// Animation Durations
  final Times times = Times();
}

/// App color
@immutable
class AppColors {
  final Color primary = const Color(0xFF00B6F1);
  final Color red = const Color(0xFFFF2B00);
  final Color black = const Color(0xFF333333);
  final Color darkGrey = const Color(0xFFAAAAAA);
  final Color grey = const Color(0xFFC4C4C4);
  final Color lightGrey = const Color(0xFFEEEEEE);
  final Color barrierColor = const Color.fromRGBO(0, 0, 0, 0.2);
}

/// Corner radius
@immutable
class Corners {
  Corners(this.scale);

  final double scale;

  late final double $4 = 4 * scale;
  late final double $8 = 8 * scale;
  late final double $10 = 10 * scale;
  late final double $12 = 12 * scale;
  late final double $16 = 16 * scale;
  late final double $24 = 24 * scale;
}

/// Box shadow
@immutable
class BoxShadows {
  final List<BoxShadow> bs1 = const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(0, 0),
      blurRadius: 4,
    ),
  ];

  final List<BoxShadow> bs2 = const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];
}

/// Padding and margin values
@immutable
class Insets {
  Insets(this.scale);

  final double scale;

  late final double $2 = 2 * scale;
  late final double $4 = 4 * scale;
  late final double $6 = 6 * scale;
  late final double $8 = 8 * scale;
  late final double $10 = 10 * scale;
  late final double $12 = 12 * scale;
  late final double $14 = 14 * scale;
  late final double $15 = 15 * scale;
  late final double $16 = 16 * scale;
  late final double $20 = 20 * scale;
  late final double $24 = 24 * scale;
  late final double $30 = 30 * scale;
  late final double $32 = 32 * scale;
  late final double $40 = 40 * scale;
  late final double $48 = 48 * scale;
  late final double $56 = 56 * scale;
  late final double $64 = 64 * scale;
}

/// Animation Durations
@immutable
class Times {
  final Duration ms150 = const Duration(milliseconds: 150);
  final Duration ms300 = const Duration(milliseconds: 300);
}
