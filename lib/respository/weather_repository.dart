import 'dart:convert';

import 'package:dio/dio.dart';
import '../data/_model.dart';
import '../data/global_data.dart';
import '../network/api_provider.dart';

class UserRepository {
  static const String networkURL = '/weather';
  static const String washingURL = '/washingcarday';

  //단기예보
  static Future<void> getShortForm(int nx,int ny) async {
    var res = await ApiProvider().get(
      networkURL,
      urlParam: 'short/$nx/$ny'
    );

    if (res != null) {
      print(res);
    }

    // return user;
  }

  //중기예보
  static Future<void> getMiddleForm(String regId) async {
    var res = await ApiProvider().get(
        networkURL,
        urlParam: 'middle/$regId'
    );

    if (res != null) {
      print(res);
    }

    // return user;
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
}