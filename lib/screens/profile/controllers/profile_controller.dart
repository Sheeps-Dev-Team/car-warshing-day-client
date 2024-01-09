import 'package:car_washing_day/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final TextEditingController nicknameController = TextEditingController();

  final List<String> dataTableColumns = [
    '세차일',
    '지속기간',
    '지속일',
  ];

  late final bool isEditMode; //회원가입 후 상태

  RxString nickname = ''.obs; // 닉네임
  RxString selectedArea = ''.obs; // 선택된 시, 도
  RxString selectedSubArea = ''.obs; // 선택된 구, 군
  RxString selectedPrecipitationProbability = '40%'.obs; // 선택된 강수 확률

  RxBool get isOk => (nickname.isNotEmpty &&
          selectedArea.isNotEmpty &&
          selectedSubArea.isNotEmpty &&
          selectedPrecipitationProbability.isNotEmpty)
      .obs;

  void init(bool value) {
    isEditMode = value;

    // 유저 데이터 세팅
    setUserData();
  }

// 유저 데이터 세팅
  void setUserData() {
    if (isEditMode && GlobalData.loginUser != null) {
      // 닉네임
      nicknameController.text = GlobalData.loginUser!.nickName;
      nickname(nicknameController.text);

      // 위치
      final List<String> splitList = GlobalData.loginUser!.address.split('|');
      selectedArea(splitList.first);
      selectedSubArea(splitList.last);

      // 강수 확률
      selectedPrecipitationProbability('${GlobalData.loginUser!.pop}%');
    }
  }

  //입력완료 확인 함수
  bool isInputComplete() {
    return nicknameController.text.isNotEmpty &&
        selectedArea.isNotEmpty &&
        selectedSubArea.isNotEmpty &&
        selectedPrecipitationProbability.isNotEmpty;
  }
}
