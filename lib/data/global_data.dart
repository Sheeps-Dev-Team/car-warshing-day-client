import './_model.dart';

class GlobalData {
  static User? loginUser;

  static String? accessToken;
  static String? fcmToken;
  static int? badgeCount;
  static bool? alarm;

  // 데이터 리셋
  static void resetData(){
    loginUser = null;
    accessToken = null;
    fcmToken = null;
    badgeCount = null;
    alarm = null;
  }
}