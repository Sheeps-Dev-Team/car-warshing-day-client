import 'dart:convert';

import 'package:car_washing_day/data/global_data.dart';
import 'package:intl/intl.dart';

import '../../config/constants.dart';

class WashingCarDay {
  WashingCarDay({
    this.id = '',
    required this.startedAt,
    required this.finishedAt,
    required this.nx,
    required this.ny,
    required this.regId,
    required this.checkUpdate,
    required this.customPop,
    this.createdAt,
  });

  String id;
  DateTime startedAt;
  DateTime finishedAt;
  int nx;
  int ny;
  String regId;
  int customPop;
  bool checkUpdate;
  DateTime? createdAt;

  factory WashingCarDay.fromJson(Map<String, dynamic> json) {
    return WashingCarDay(
      id: json['id'],
      startedAt: DateTime.parse(json['started_at']).add(const Duration(hours: 9)),
      finishedAt: DateTime.parse(json['finished_at']).add(const Duration(hours: 9)),
      nx: json['nx'] ?? 0,
      ny: json['ny'] ?? 0,
      regId: json['regId'] ?? '',
      customPop: json['custom_pop'] ?? 0,
      checkUpdate: json['check_update'] ?? false,
      // createdAt: DateTime.parse(json['createdAt']),
    );
  }

  String toCreateJsonEncode() {
    Map<String, dynamic> map = {
      'user_id': GlobalData.loginUser!.userId,
      'started_at': DateFormat('yyyy-MM-dd').format(startedAt),
      'finished_at': DateFormat('yyyy-MM-dd').format(finishedAt),
      'nx': nx,
      'ny': ny,
      'reg_id': regId,
      'custom_pop': customPop,
    };

    return jsonEncode(map);
  }
}
