import 'dart:convert';

import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/data/global_data.dart';
import '../_model.dart';

class User {
  User({
    this.userId = nullInt,
    required this.email,
    required this.loginType,
    required this.nickName,
    required this.address,
    required this.pop,
    this.washingCarDay,
    this.isExit = false,
    this.alarm = true,
    this.createdAt,
    this.lastModifiedAt,
  });

  int userId;
  String email;
  String loginType;
  String nickName;
  String address;
  int pop;
  WashingCarDay? washingCarDay;
  bool isExit; // 탈퇴 여부
  bool alarm;
  DateTime? createdAt;
  DateTime? lastModifiedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['badgeCount'] != null) {
      GlobalData.badgeCount = json['badgeCount']!;
    }

    if (json['alarm'] != null) {
      GlobalData.alarm = json['alarm'];
    }

    if (json['accessToken'] != null) {
      GlobalData.accessToken = json['schema'] + ' ' + json['accessToken'];
    }

    WashingCarDay? washingCarDay;
    if (json['washingcardays'] != null) {
      for (var i = 0; i < json['washingcardays'].length; ++i) {
        washingCarDay = WashingCarDay.fromJson(json['washingcardays'][i]);
      }
    }

    return User(
      userId: json['userId'],
      email: json['email'] ?? '',
      loginType: json['loginType'] ?? '',
      nickName: json['nickName'] ?? '',
      address: json['address'] ?? '',
      pop: json['custom_pop'] ?? defaultPop,
      washingCarDay: washingCarDay,
      isExit: json['is_exit'] ?? false,
      alarm: json['alarm'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      lastModifiedAt: json['lastModifiedAt'] == null
          ? null
          : DateTime.parse(json['lastModifiedAt']),
    );
  }

  String toCreateJsonEncode() {
    Map<String, dynamic> map = {
      'email': email,
      'loginType': loginType,
      'nickName': nickName,
      'address': address,
      'custom_pop': pop,
      'alarm': alarm,
    };

    return jsonEncode(map);
  }

  String toUpdateJsonEncode() {
    Map<String, dynamic> map = {
      'loginType': loginType,
      'nickName': nickName,
      'address': address,
      'custom_pop': pop,
      'alarm': alarm,
    };

    return jsonEncode(map);
  }
}
