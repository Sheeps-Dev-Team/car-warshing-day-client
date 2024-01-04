import 'package:car_washing_day/data/global_data.dart';
import 'package:car_washing_day/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final TextEditingController nicknameController = TextEditingController();

  final List<String> dataTableColumns = [
    '세차일',
    '지속기간',
    '지속일',
  ];

  RxString selectedArea = ''.obs; // 선택된 시, 도
  RxString selectedSubArea = ''.obs; // 선택된 구, 군
  RxString selectedPrecipitationProbability = ''.obs; // 선택된 강수 확률

  @override
  void onInit() {
    // 유저 데이터 세팅
    setUserData();

    super.onInit();
  }

  final user = User(
    email: '',
    loginType: '',
    nickName: '',
    address: '',
    pop: 0,
  );

// 유저 데이터 세팅
  void setUserData() {
    if (GlobalData.loginUser != null) {
      // 닉네임
      nicknameController.text = GlobalData.loginUser!.nickName;

      // 위치
      final List<String> splitList = GlobalData.loginUser!.address.split('|');
      selectedArea(splitList.first);
      selectedSubArea(splitList.last);
    }
  }
}
