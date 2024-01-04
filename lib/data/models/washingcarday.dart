import 'dart:convert';

import '../../config/constants.dart';

class WashingCarDay {
  WashingCarDay({
    this.id = nullInt,
    required this.startedAt,
    required this.finishedAt,
    required this.nx,
    required this.ny,
    required this.regId,
    required this.checkUpdate,
    required this.customPop,
    this.createdAt,
  });

  int id;
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
      startedAt: DateTime.parse(json['startedAt']),
      finishedAt: DateTime.parse(json['finishedAt']),
      nx: json['nx'] ?? 0,
      ny: json['ny'] ?? 0,
      regId: json['regId'] ?? '',
      customPop: json['customPop'] ?? 0,
      checkUpdate: json['checkUpdate'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toCreateJson() => {
    'startedAt' : startedAt.toString().substring(0,9).replaceAll(('-'), ''),
    'finishedAt' : startedAt.toString().substring(0,9).replaceAll(('-'), ''),
    'nx' : nx,
    'ny' : ny,
    'regId' : regId,
    'customPop' : customPop
  };

  String toCreateJsonEncode() {
    Map<String, dynamic> map = {
      'startedAt' : startedAt.toString().substring(0,9).replaceAll(('-'), ''),
      'finishedAt' : startedAt.toString().substring(0,9).replaceAll(('-'), ''),
      'nx' : nx,
      'ny' : ny,
      'regId' : regId,
      'customPop' : customPop
    };

    return jsonEncode(map);
  }
}