import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static const storage = FlutterSecureStorage();

  static const String keyEmail = 'email'; // 이메일
  static const String keyLoginType = 'loginType'; // 로그인 타입
  static const String keyAddress = 'address'; // 위치

  // 자동 로그인 정보 저장
  static Future<void> setLoginData({required String email, required String loginType}) async {
    await storage.write(key: Storage.keyEmail, value: email);
    await storage.write(key: Storage.keyLoginType, value: loginType);
  }

  // 로그인 정보 삭제
  static Future<void> deleteLoginData() async {
    await storage.delete(key: keyEmail);
    await storage.delete(key: keyLoginType);
  }

  // 위치 데이터 저장
  static Future<void> setAddressData(String address) async {
    await storage.write(key: keyAddress, value: address);
  }

  // 이메일
  static Future<String?> getEmail() async => await storage.read(key: keyEmail);

  // 로그인 타입
  static Future<String?> getLoginType() async => await storage.read(key: keyLoginType);

  // 위치
  static Future<String?> getAddress() async => await storage.read(key: keyAddress);
}
