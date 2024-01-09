import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../data/global_data.dart';

class HomeController extends GetxController {
  final DateTime now = DateTime.now();

  RxString address = ''.obs; // 위치

  // 위치 세팅
  void setAddress() async{
    const FlutterSecureStorage storage = FlutterSecureStorage();
    address(GlobalData.loginUser?.address ?? await storage.read(key: 'address'));
  }
}