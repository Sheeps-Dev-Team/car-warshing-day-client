import 'dart:convert';

import 'package:dio/dio.dart';
import '../data/_model.dart';
import '../data/global_data.dart';
import '../network/api_provider.dart';

class UserRepository {
  static const String networkURL = '/user';

  static Future<User?> userCreate(User obj) async {
    //사용자 로그인
    User? user;
    var res = await ApiProvider().post(
        networkURL,
        jsonEncode(obj.toCreateJson()));

    if (res != null) {
      user = User.fromJson(res);
    }

    return user;
  }

  static Future<User?> userLogin(String email, String loginType) async {
    //사용자 로그인
    User? user;
    var res = await ApiProvider().post(
        '$networkURL/login',
        jsonEncode({
          "email": email,
          "loginType": loginType
        }));

    if (res != null) {
      user = User.fromJson(res);
      GlobalData.loginUser = user;
    }

    return user;
  }

  static Future<String?> updateFcmToken(String fcmToken) async {
    String? resStr;
    var res = await ApiProvider().post(
        '$networkURL/updateFcmToken',jsonEncode({
      "fcmToken" : fcmToken
    }), urlParam: GlobalData.loginUser!.userId.toString() );

    if (res != null) {
      resStr = res["message"] ?? "";
    }

    return resStr;
  }
}
