import 'dart:convert';

import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/data/global_data.dart';
import '../_model.dart';

class User {
  User({
    this.userId = '',
    required this.email,
    required this.loginType,
    required this.nickName,
    required this.address,
    required this.pop,
    this.washingCarDay,
    this.alarm = true,
    this.createdAt,
    this.updatedAt,
  });

  String userId;
  String email;
  String loginType;
  String nickName;
  String address;
  int pop;
  WashingCarDay? washingCarDay;
  bool alarm;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['badgeCount'] != null) {
      GlobalData.badgeCount = json['badgeCount']!;
    }

    if (json['alarm'] != null) {
      GlobalData.alarm = json['alarm'];
    }

    // if (json['accessToken'] != null) {
    //   GlobalData.accessToken = json['schema'] + ' ' + json['accessToken'];
    // }

    WashingCarDay? washingCarDay;
    if (json['washing_car_days'] != null) {
      for (var i = 0; i < json['washing_car_days'].length; ++i) {
        washingCarDay = WashingCarDay.fromJson(json['washing_car_days'][i]);
      }
    }

    return User(
      userId: json['user_id'] ?? '',
      email: json['email'] ?? '',
      loginType: json['login_type'] ?? '',
      nickName: json['nickname'] ?? '',
      address: json['address'] ?? '',
      pop: json['custom_pop'] ?? defaultPop,
      washingCarDay: washingCarDay,
      alarm: json['alarm'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'email': email,
        'login_type': loginType,
        'nickname': nickName,
        'address': address,
        'pop': pop,
        'alarm': alarm.toString(),
      };

  String toCreateJsonEncode() {
    Map<String, dynamic> map = {
      'email': email,
      'login_type': loginType,
      'nickname': nickName,
      'address': address,
      'custom_pop': pop,
      'alarm': alarm,
    };

    return jsonEncode(map);
  }

  String toUpdateJsonEncode() {
    Map<String, dynamic> map = {
      'user_id': GlobalData.loginUser!.userId,
      'login_type': loginType,
      'nickname': nickName,
      'address': address,
      'custom_pop': pop,
      'alarm': alarm,
    };

    return jsonEncode(map);
  }
}
