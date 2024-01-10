import 'dart:convert';

import 'package:dio/dio.dart';
import '../data/_model.dart';
import '../data/global_data.dart';
import '../network/api_provider.dart';

class WeatherRepository {
  static const String networkURL = '/v1/weather';
  static const String washingURL = '/v1/washingcarday';

  //단기예보
  static Future<List<Weather>> getShortForm(int nx, int ny) async {
    List<Weather> list = [];

    var res = await ApiProvider().get(
      networkURL,
      urlParam: 'short/$nx/$ny'
    );

    if (res != null) {
      list = Weather.fromJsonForList(res);
    }

    return list;
  }

  //중기예보
  static Future<List<Weather>> getMiddleForm(String regId) async {
    List<Weather> list = [];

    var res = await ApiProvider().get(
        networkURL,
        urlParam: 'middle/$regId'
    );

    if (res != null) {
      list = Weather.fromJsonForList(res, addDays: 3);
    }

    return list;
  }

  //세차일 등록
  static Future<WashingCarDay?> createWashing(WashingCarDay obj) async {
    WashingCarDay? washingCarDay;

    var res = await ApiProvider().post(
      washingURL,
      obj.toCreateJsonEncode(),urlParam: GlobalData.loginUser!.userId.toString()
    );

    if (res != null) {
      washingCarDay = WashingCarDay.fromJson(res);
    }

    return washingCarDay;
  }

  // 세차일 삭제
  static Future<String?> deleteWashing(int washingDayId) async {
    var res = await ApiProvider().delete(
      washingURL,
      jsonEncode({}),
      urlParam: '${GlobalData.loginUser!.userId}/$washingDayId',
    );

    return res["message"];
  }
}