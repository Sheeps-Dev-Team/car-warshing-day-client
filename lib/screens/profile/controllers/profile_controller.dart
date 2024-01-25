import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/config/storage.dart';
import 'package:car_washing_day/data/global_data.dart';
import 'package:car_washing_day/data/models/user.dart';
import 'package:car_washing_day/repository/user_repository.dart';
import 'package:car_washing_day/screens/login/login_page.dart';
import 'package:car_washing_day/screens/main/main_page.dart';
import 'package:car_washing_day/util/global_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final TextEditingController nicknameController = TextEditingController();

  final List<String> dataTableColumns = [
    '세차일',
    '지속기간',
    '지속일',
  ];

  bool isEditMode = false; //회원가입 후 상태

  RxString nickname = ''.obs; // 닉네임
  RxString selectedArea = ''.obs; // 선택된 시, 도
  RxString selectedSubArea = ''.obs; // 선택된 구, 군
  RxString selectedPrecipitationProbability = '$defaultPop%'.obs; // 선택된 강수 확률
  RxBool isAlarm = true.obs; // 알림

  // 기본 isOk
  RxBool get isOk => (nickname.isNotEmpty && selectedArea.isNotEmpty && selectedSubArea.isNotEmpty && selectedPrecipitationProbability.isNotEmpty).obs;

  // 수정 isOk
  RxBool get isEditOk {
    final User user = GlobalData.loginUser!;

    return (isOk.value && (nickname.value != user.nickName ||
            '${selectedArea.value}$division${selectedSubArea.value}' != user.address ||
            int.parse(selectedPrecipitationProbability.value.replaceFirst('%', '')) != user.pop ||
            isAlarm.value != user.alarm))
        .obs;
  }

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

      // 알림
      isAlarm(GlobalData.loginUser!.alarm);
    }
  }

  // 유저 생성
  void createUser() async {
    GlobalFunction.loadingDialog(); // 로딩 시작

    final User obj = User(
      email: GlobalData.loginUser!.email,
      loginType: GlobalData.loginUser!.loginType,
      nickName: nickname.value,
      address: '${selectedArea.value}$division${selectedSubArea.value}',
      pop: int.parse(selectedPrecipitationProbability.value.replaceFirst('%', '')),
      alarm: isAlarm.value,
    );

    User? user = await UserRepository.create(obj);

    Get.close(1); // 로딩 끝
    if (user != null) {
      if(user.email == '409') {
        // 중복 이메일 처리
        await Storage.deleteLoginData(); // 로그인 정보 삭제
        GlobalData.resetData(); // 글로벌 데이터 리셋
        Get.offAll(() => LoginPage());

        GlobalFunction.showCustomDialog(description: '이미 가입되어 있는 이메일입니다.');
      } else {
        GlobalData.loginUser = user;
        Storage.setAddressData(obj.address); // 로컬에 위치 데이터 저장

        Get.offAll(() => MainPage());
      }
    } else {
      GlobalFunction.showToast(msg: '잠시 후 다시 시도해 주세요.');
    }
  }

  // 유저 수정
  void updateUser() async {
    GlobalFunction.loadingDialog(); // 로딩 시작

    final User obj = User(
      email: GlobalData.loginUser!.email,
      loginType: GlobalData.loginUser!.loginType,
      nickName: nickname.value,
      address: '${selectedArea.value}$division${selectedSubArea.value}',
      pop: int.parse(selectedPrecipitationProbability.value.replaceFirst('%', '')),
      alarm: isAlarm.value,
    );

    String? res = await UserRepository.update(obj);

    if (res != null) {
      GlobalData.loginUser!.nickName = obj.nickName;
      GlobalData.loginUser!.address = obj.address;
      GlobalData.loginUser!.pop = obj.pop;
      GlobalData.loginUser!.alarm = obj.alarm;

      // 수정 후 상태 관리용
      isAlarm.toggle();
      isAlarm.toggle();

      await Storage.setAddressData(obj.address); // 로컬에 위치 데이터 저장

      // 날씨 데이터 세팅
      await GlobalFunction.setWeatherList(obj.address);
      Get.close(1); // 로딩 끝
      GlobalFunction.showToast(msg: '수정이 완료되었습니다.');
    } else {
      Get.close(1); // 로딩 끝
      GlobalFunction.showToast(msg: '잠시후 다시 시도해 주세요.');
    }
  }

  // 로그아웃
  void logout() {
    GlobalFunction.showCustomDialog(
      title: '로그아웃 하시겠어요?',
      showCancelBtn: true,
      okFunc: GlobalFunction.logout,
    );
  }

  // 회원 탈퇴
  void deleteUser() {
    GlobalFunction.showCustomDialog(
      title: '정말 탈퇴하시겠어요?',
      description: '회원 탈퇴 시 데이터 복구는 불가능합니다.',
      showCancelBtn: true,
      okText: '탈퇴',
      okFunc: () async {
        String? res = await UserRepository.delete(GlobalData.loginUser!.userId);

        if (res != null) {
          GlobalFunction.logout();
        } else {
          GlobalFunction.showToast(msg: '잠시후 다시 시도해 주세요.');
        }
      },
    );
  }

  // 알림 변경
  void onChangedAlarm(bool value) {
    isAlarm(value);
  }
}
