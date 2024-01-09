import 'package:car_washing_day/config/storage.dart';
import 'package:get/get.dart';

import '../../../data/global_data.dart';

class HomeController extends GetxController {
  final DateTime now = DateTime.now();

  RxString address = ''.obs; // 위치

  // 위치 세팅
  void setAddress() async{
    address(GlobalData.loginUser?.address ?? await Storage.getAddress());
  }
}