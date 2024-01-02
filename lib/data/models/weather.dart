import 'package:car_washing_day/config/weather_assets.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';

enum SkyType { sunny, cloudy, overcast } // 하늘 상태 - 맑음, 구름 많음, 흐림

enum RainingType { none, rain, rainAndSnow, snow } // 강수 형태 - 없음, 비, 비/눈, 눈

class Weather {
  Weather({
    required this.skyType,
    required this.rainingType,
    required this.pop,
    required this.pcp,
    required this.dateTime,
  });

  final SkyType skyType; // 하늘 상태
  final RainingType rainingType; // 강수 형태
  final int pop; // 강수 확률
  final String pcp; // 1시간 강수량
  final DateTime dateTime;

  /// 강수 형태가 있으면 rainingType
  /// 강수 형태가 없으면 skyType
  String get getWeatherIcon {
    // 강수 형태가 있는 경우
    if (rainingType != RainingType.none) {
      switch (rainingType) {
        case RainingType.rain:
          return WeatherAssets.rainy;
        case RainingType.snow:
          return WeatherAssets.snowy;
        case RainingType.rainAndSnow:
          return WeatherAssets.snowy;
        default:
          return '';
      }
    } else {
      switch (skyType) {
        case SkyType.sunny:
          return WeatherAssets.sunny;
        case SkyType.cloudy:
          return WeatherAssets.cloudy;
        case SkyType.overcast:
          return WeatherAssets.overcast;
      }
    }
  }

  /// 요일 컬러
  Color get getWeekdayColor {
    if (dateTime.weekday == 7) {
      return $style.colors.red;
    } else if (dateTime.weekday == 6) {
      return $style.colors.primary;
    } else {
      return $style.colors.black;
    }
  }
}
