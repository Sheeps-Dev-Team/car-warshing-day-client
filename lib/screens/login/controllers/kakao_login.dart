import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

//성공시 이메일 반환, 실패시 빈 문자열 반환
Future<String> kakaoLogin() async {
  // 카카오톡 설치 여부 확인
// 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  // if (kDebugMode) (await KakaoSdk.origin); // 사용중인 키 해시 확인
  if (kDebugMode) print('카카오 로그인 진입');
  if (await isKakaoTalkInstalled()) {
    if (kDebugMode) print('카카오 설치됨');
    try {
      await UserApi.instance.loginWithKakaoTalk();
      if (kDebugMode) print('카카오톡으로 로그인 성공');
    } catch (error) {
      if (kDebugMode) print('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return '';
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        if (kDebugMode) print('카카오계정으로 로그인 성공');
      } catch (error) {
        if (kDebugMode) print('카카오계정으로 로그인 실패 $error');
        return '';
      }
    }
  } else {
    if (kDebugMode) print('카카오 미설치');
    try {
      await UserApi.instance.loginWithKakaoAccount();
      if (kDebugMode) print('카카오계정으로 로그인 성공');
    } catch (error) {
      if (kDebugMode) print('카카오계정으로 로그인 실패 $error');
      return '';
    }
  }

  String email = '';
  //로그인 성공 후
  try {
    User user = await UserApi.instance.me();
    if (kDebugMode) {
      print('사용자 정보 요청 성공'
          '\n이메일: ${user.kakaoAccount?.email}');
    }
    email = user.kakaoAccount?.email ?? '';
  } catch (error) {
    if (kDebugMode) print('사용자 정보 요청 실패 $error');
  }

  return email;
}
