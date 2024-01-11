import './_model.dart';

class GlobalData {
  static User? loginUser;
  static String? accessToken;
  static String? fcmToken;
  static int? badgeCount;
  static bool? alarm;

  static String? address; // user address or local address
  static List<Weather> weatherList = []; // 날씨 리스트
  static Weather? currentWeather; // 현재 날씨

  static DateTime? currentBackPressTime;

  // 데이터 리셋
  static void resetData() {
    loginUser = null;
    accessToken = null;
    fcmToken = null;
    badgeCount = null;
    alarm = null;
  }
}
