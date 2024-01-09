import 'package:car_washing_day/config/weather_assets.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../global_data.dart';

enum SkyType { sunny, cloudy, overcast } // 하늘 상태 - 맑음, 구름 많음, 흐림

enum RainingType { none, rain, rainAndSnow, snow, shower } // 강수 형태 - 없음, 비, 비/눈, 눈, 소나기

class Weather {
  Weather({
    required this.skyType,
    required this.rainingType,
    required this.pop,
    required this.dateTime,
  });

  final SkyType skyType; // 하늘 상태
  final RainingType rainingType; // 강수 형태
  final int pop; // 강수 확률
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
          return WeatherAssets.rainy;
        case RainingType.shower:
          return WeatherAssets.rainy;
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

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      skyType: json['skyType'] ?? SkyType.sunny,
      rainingType: json['rainingType'] ?? RainingType.none,
      pop: json['pop'] ?? 0,
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  // fromJson 날씨 리스트 형태로
  static List<Weather> fromJsonForList(Map<String, dynamic> json, {int addDays = 0}) {
    final DateTime now = DateTime.now();
    final DateTime n = DateTime(now.year, now.month, now.day);

    List<Weather> list = [];

    late final Weather currentWeather; // 현재 날씨
    List<int> popList = []; // 강수 확률 리스트
    List<String> skyList = []; // 하늘 상태 리스트

    for (int i = 0; i < json.length; i++) {
      final String key = json.keys.toList()[i];
      final value = json.values.toList()[i];

      // 오늘 날씨 세팅
      if (key == 'now') {
        currentWeather = Weather(
          skyType: intToSkyType(int.parse(value['sky'] ?? '1')),
          rainingType: RainingType.values[int.parse(value['pty'] ?? '0')],
          pop: int.parse(value['pop']),
          dateTime: n,
        );

        list.add(currentWeather);
      } else {
        // 강수 확률
        if (key.startsWith('rnSt')) {
          popList.add(value);
        } else {
          // 하늘 상태
          skyList.add(value);
        }
      }
    }

    // 오늘을 제외한 날씨 세팅
    int prePop = 0;
    SkyType preSkyType = SkyType.sunny;
    RainingType preRainingType = RainingType.none;

    for (int i = 0; i < popList.length; i++) {
      final String sky = skyList[i];
      final int pop = popList[i];
      final SkyType skyType = stringToSkyType(sky);
      final RainingType rainingType = stringToRainingType(sky);

      if (i == 10 || i == 11 || i == 12) {
        // 중기 8 9 10 오전, 오후로 나눠져 있지 않음
        list.add(
          Weather(
            skyType: skyType,
            rainingType: rainingType,
            pop: pop,
            dateTime: n.add(Duration(days: i - 2)),
          ),
        );
      } else {
        if (i.isEven) {
          prePop = pop;
          preSkyType = skyType;
          preRainingType = rainingType;
        } else {
          final Weather weather = Weather(
            skyType: compareForSkyType(preSkyType, skyType), // 하늘 상태 더 비관적인게 들어감
            rainingType: compareForRainingType(preRainingType, rainingType), // 강수 형태 더 비관적인게 들어감
            pop: prePop < pop ? pop : prePop, // 강수 확률 더 큰게 들어감
            dateTime: n.add(Duration(days: i ~/ 2 + addDays)),
          );

          list.add(weather);
        }
      }
    }

    return list;
  }

  // int -> SkyTpe
  static SkyType intToSkyType(int sky) {
    switch (sky) {
      case 1:
        return SkyType.sunny;
      case 3:
        return SkyType.cloudy;
      case 4:
        return SkyType.overcast;
      default:
        return SkyType.sunny;
    }
  }

  // string -> SkyType
  static SkyType stringToSkyType(String sky) {
    switch (sky) {
      case '맑음':
        return SkyType.sunny;
      case '구름많음':
        return SkyType.cloudy;
      case '구름많고 비':
        return SkyType.cloudy;
      case '구름많고 눈':
        return SkyType.cloudy;
      case '구름많고 비/눈':
        return SkyType.cloudy;
      case '구름많고 소나기':
        return SkyType.cloudy;
      case '흐림':
        return SkyType.overcast;
      case '흐리고 비':
        return SkyType.overcast;
      case '흐리고 눈':
        return SkyType.overcast;
      case '흐리고 비/눈':
        return SkyType.overcast;
      case '흐리고 소나기':
        return SkyType.overcast;
      default:
        return SkyType.sunny;
    }
  }

  // string -> RainingType
  static RainingType stringToRainingType(String sky) {
    switch (sky) {
      case '맑음':
        return RainingType.none;
      case '구름많음':
        return RainingType.none;
      case '구름많고 비':
        return RainingType.rain;
      case '구름많고 눈':
        return RainingType.snow;
      case '구름많고 비/눈':
        return RainingType.rainAndSnow;
      case '구름많고 소나기':
        return RainingType.shower;
      case '흐림':
        return RainingType.none;
      case '흐리고 비':
        return RainingType.rain;
      case '흐리고 눈':
        return RainingType.snow;
      case '흐리고 비/눈':
        return RainingType.rainAndSnow;
      case '흐리고 소나기':
        return RainingType.shower;
      default:
        return RainingType.none;
    }
  }

  // 하늘 상태 비교
  static SkyType compareForSkyType(SkyType a, SkyType b) {
    switch (a) {
      case SkyType.sunny:
        return b;
      case SkyType.cloudy:
        if (b == SkyType.overcast) {
          return b;
        } else {
          return a;
        }
      case SkyType.overcast:
        return a;
      default:
        return SkyType.sunny;
    }
  }

  // 강수 형태 비교
  static RainingType compareForRainingType(RainingType a, RainingType b) {
    switch (a) {
      case RainingType.none:
        return b;
      case RainingType.rain:
        return a;
      case RainingType.rainAndSnow:
        return a;
      case RainingType.snow:
        if (b == RainingType.none) {
          return a;
        } else {
          return b;
        }
      case RainingType.shower:
        return a;
      default:
        return RainingType.none;
    }
  }
}
