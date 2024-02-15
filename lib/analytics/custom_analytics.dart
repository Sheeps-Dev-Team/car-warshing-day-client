import 'package:firebase_analytics/firebase_analytics.dart';

class CustomAnalytics {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static const String signUp = 'signUp'; // 회원 가입
  static const String login = 'login'; // 로그인
  static const String logout = 'logout'; // 로그아웃
  static const String userEdit = 'user_edit'; // 유저 정보 수정
  static const String userExit = 'user_exit'; // 회원 탈퇴
  static const String carWashRegistration = 'car_wash_registration'; // 세차 등록
  static const String carWashDelete = 'car_wash_delete'; // 세차 등록 해제

  // 회원 가입
  static Future<void> signUpEvent({Map<String, dynamic>? parameters}) async{
    analytics.logEvent(
      name: signUp,
      parameters: parameters,
    );
  }

  // 로그인
  static Future<void> loginEvent({Map<String, dynamic>? parameters}) async{
    analytics.logEvent(
      name: login,
      parameters: parameters,
    );
  }

  // 로그아웃
  static Future<void> logoutEvent({Map<String, dynamic>? parameters}) async{
    analytics.logEvent(
      name: logout,
      parameters: parameters,
    );
  }

  // 유저 정보 수정
  static Future<void> userEditEvent({Map<String, dynamic>? parameters}) async{
    analytics.logEvent(
      name: userEdit,
      parameters: parameters,
    );
  }

  // 회원 탈퇴
  static Future<void> userExitEvent({Map<String, dynamic>? parameters}) async{
    analytics.logEvent(
      name: userExit,
      parameters: parameters,
    );
  }

  // 세차 등록
  static Future<void> carWashRegistrationEvent({Map<String, dynamic>? parameters}) async{
    analytics.logEvent(
      name: carWashRegistration,
      parameters: parameters,
    );
  }

  // 세차 등록 해제
  static Future<void> carWashDeleteEvent({Map<String, dynamic>? parameters}) async{
    analytics.logEvent(
      name: carWashDelete,
      parameters: parameters,
    );
  }
}