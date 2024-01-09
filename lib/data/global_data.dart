import './_model.dart';

class GlobalData {
  static User? loginUser;
  // static User? loginUser = User(
  //     email: 'test@test.com',
  //     loginType: '1',
  //     nickName: 'test',
  //     address: '인천광역시|연수구',
  //     pop: 30);

  static String? accessToken;
  static String? fcmToken;
  static int? badgeCount;
  static bool? alarm;

  static String? address; // user address or local address
  static List<Weather> weatherList = []; // 날씨 리스트
  static Weather? currentWeather; // 현재 날씨

  // 데이터 리셋
  static void resetData() {
    loginUser = null;
    accessToken = null;
    fcmToken = null;
    badgeCount = null;
    alarm = null;
  }
}
