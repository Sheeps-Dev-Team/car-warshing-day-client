import 'dart:convert';

import '../data/_model.dart';
import '../data/global_data.dart';
import '../network/api_provider.dart';

class UserRepository {
  static const String networkURL = '/v1/user';

  //가입
  static Future<User?> create(User obj) async {
    User? user;
    var res = await ApiProvider().post(networkURL, obj.toCreateJsonEncode());

    if (res != null) {
      if(res == 409) {
        // 중복된 이메일 처리
        user = User(email: '409', loginType: '', nickName: '', address: '', pop: 0);
      } else {
        user = User.fromJson(res);
      }
    }

    return user;
  }

  //로그인
  static Future<User?> login(String email, String loginType) async {
    //사용자 로그인
    User? user;
    var res = await ApiProvider().post(
      '$networkURL/login',
      jsonEncode({"email": email, "loginType": loginType}),
    );

    if (res != null) {
      user = User.fromJson(res);
    }

    return user;
  }

  //토큰수정
  static Future<String?> updateFcmToken(String fcmToken) async {
    String? resStr;
    var res = await ApiProvider().post(
      '$networkURL/update_fcm_token',
      jsonEncode({"fcm_token": fcmToken}),
      urlParam: GlobalData.loginUser!.userId.toString(),
    );

    if (res != null && res != 409) {
      resStr = res["message"] ?? "";
    }

    return resStr;
  }

  //수정
  static Future<String?> update(User obj) async {
    var res = await ApiProvider().patch(
      networkURL,
      obj.toUpdateJsonEncode(),
    );

    return res["message"];
  }

  // 탈퇴
  static Future<String?> delete(String id) async {
    var res = await ApiProvider().delete(
      networkURL,
      jsonEncode({'user_id': id}),
    );

    return res["message"];
  }
}
