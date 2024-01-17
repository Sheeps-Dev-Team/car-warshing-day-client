import 'package:car_washing_day/config/storage.dart';
import 'package:car_washing_day/data/global_data.dart';
import 'package:car_washing_day/repository/user_repository.dart';
import 'package:car_washing_day/screens/main/main_page.dart';
import 'package:car_washing_day/screens/main/splash_screen.dart';
import 'package:car_washing_day/screens/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../config/constants.dart';
import '../data/location_data.dart';
import '../data/models/user.dart';
import '../data/models/weather.dart';
import '../repository/weather_repository.dart';

class GlobalFunction {
  // 포커스 해제 함수
  static void unFocus() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  // 다이얼로그
  static Future<void> showCustomDialog({
    Widget? child,
    String title = '',
    String description = '',
    String okText = '확인',
    String cancelText = '취소',
    bool showCancelBtn = false,
    GestureTapCallback? okFunc,
    GestureTapCallback? cancelFunc,
    bool barrierDismissible = true,
  }) {
    // 버튼
    Widget button({required String text, required GestureTapCallback onTap, required Color bgColor, required Color borderColor, required Color fontColor}) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular($style.corners.$12),
          child: Container(
            width: double.infinity,
            height: 48 * sizeUnit,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular($style.corners.$12),
              border: Border.all(color: borderColor, width: 1 * sizeUnit),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: $style.text.subTitle16.copyWith(color: fontColor),
            ),
          ),
        ),
      );
    }

    return Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: $style.insets.$40),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular($style.corners.$12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24 * sizeUnit),
                if (title.isNotEmpty) Text(title, style: $style.text.subTitle16),
                if (child != null) ...[
                  child,
                ] else ...[
                  if (description.isNotEmpty) ...[
                    SizedBox(height: 12 * sizeUnit),
                    Text(
                      description,
                      style: $style.text.body14,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
                SizedBox(height: 24 * sizeUnit),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * sizeUnit),
                  child: Row(
                    children: [
                      if (showCancelBtn) ...[
                        Expanded(
                          child: button(
                            text: cancelText,
                            bgColor: Colors.white,
                            borderColor: $style.colors.primary,
                            fontColor: $style.colors.primary,
                            onTap: cancelFunc ?? () => Get.back(),
                          ),
                        ),
                        SizedBox(width: 8 * sizeUnit),
                      ],
                      Expanded(
                        child: button(
                          text: okText,
                          bgColor: $style.colors.primary,
                          borderColor: $style.colors.primary,
                          fontColor: Colors.white,
                          onTap: okFunc ?? () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16 * sizeUnit),
              ],
            ),
          ),
        ),
      ),
      barrierColor: $style.colors.barrierColor,
      barrierDismissible: barrierDismissible,
    );
  }

  // 토스트
  static void showToast({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: $style.colors.primary,
      textColor: Colors.white,
    );
  }

  // 로그인
  static Future<void> globalLogin({
    required String email,
    required String loginType,
  }) async {
    if (Get.currentRoute != SplashScreen.route) loadingDialog(); // 로딩 시작

    User? user = await UserRepository.login(email, loginType);
    GlobalData.loginUser = user;

    // 자동 로그인 정보 저장
    Storage.setLoginData(email: email, loginType: loginType);

    // 필수 정보 있는 경우
    if (user != null) {
      // 탈퇴한 경우
      if (user.isExit) {
        await Storage.deleteLoginData(); // 로그인 데이터 삭제
        if (Get.currentRoute != SplashScreen.route) Get.close(1); // 로딩 끝

        showCustomDialog(description: '탈퇴된 계정입니다.');
      } else {
        Get.offAll(() => MainPage());
      }
    } else {
      // 필수 정보 없는 경우
      GlobalData.loginUser = User(email: email, loginType: loginType, nickName: '', address: '', pop: 0);
      Get.offAll(() => ProfilePage(isEditMode: false)); // 필수 정보 입력 페이지로 이동
    }
  }

  // 로그아웃
  static Future<void> logout() async {
    await Storage.deleteLoginData(); // 로그인 정보 삭제
    GlobalData.resetData(); // 글로벌 데이터 리셋

    Get.offAll(MainPage());
  }

  // date picker
  static Future<DateTime> datePicker({required BuildContext context, DateTime? initialDateTime, DateTime? minimumDateTime}) async {
    unFocus(); // 포커스 해제

    final DateTime now = DateTime.now();
    final DateTime initDateTime = initialDateTime ?? now;
    DateTime? date;

    await showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 200 * sizeUnit,
              width: double.infinity,
              color: Colors.white,
              child: CupertinoDatePicker(
                backgroundColor: Colors.white,
                initialDateTime: initDateTime,
                mode: CupertinoDatePickerMode.date,
                minimumDate: minimumDateTime,
                maximumYear: now.year,
                onDateTimeChanged: (val) => date = val,
              ),
            ));

    date ??= initDateTime;
    return DateTime(date!.year, date!.month, date!.day, 12);
  }

  // 실명 유효성 검사
  static String? validRealNameErrorText(String name) {
    String? errMsg;

    RegExp regExp = RegExp(r'(^[가-힣]{2,10}$)'); // 2 ~ 10개 한글 입력가능
    if (!regExp.hasMatch(name)) errMsg = '이름을 정확히 입력해 주세요.';
    return errMsg;
  }

  // 핸드폰 유효성 검사
  static String? validPhoneNumErrorText(String number) {
    String? errMsg;

    RegExp regExp = RegExp(r'^\d{10,11}$'); // 10 ~ 11개 숫자 입력가능
    if (!regExp.hasMatch(number)) errMsg = '휴대폰 번호를 정확히 입력해 주세요.';
    return errMsg;
  }

  // 로딩 다이어로그
  static void loadingDialog() {
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(color: $style.colors.primary),
        ),
      ),
    );
  }

  // 단기 좌표
  static List<int> getShortTerm(String address) {
    final List<String> splitList = address.split('|');

    final String userArea = splitList.first; //user의 시, 도
    final String userSubArea = splitList.last; //user의 구, 군

    final List<String> shortTermValue = locationMap[userArea]![userSubArea]!.split(division);
    final List<int> shortTermList = [int.parse(shortTermValue.first), int.parse(shortTermValue.last)];
    return shortTermList;
  }

  //중기 좌표
  static String getMidTerm(String address) {
    final String userArea = address.split('|').first; //user의 시, 도

    final String midTermValue = midTermLocationMap[userArea]!; //중기 코드 추출
    return midTermValue;
  }

  //장기 좌표
  static String getLongTerm(String address) {
    final List<String> splitList = address.split('|');
    final String userArea = splitList.first; //user의 시, 도
    final String userSubArea = splitList.last; //user의 구, 군

    int? longTermValue = regionLongTermLocationMap[userArea]![userSubArea]; //구,군까지 있을때
    int longTermValue2 = regionLongTermLocationMap[userArea]!.values.first; //구,군값이 없을 때

    if (longTermValue != null) {
      //userArea, userSubArea 값이 둘다 존재할때
      return longTermValue.toString();
    } else {
      //userArea만 존재할 때 userSubArea == null 일 때
      return longTermValue2.toString();
    }
  }

  // 날씨 데이터 세팅
  static Future<void> setWeatherList(String address) async {
    List<Weather> list = [];

    // 단기
    final List<int> shortTermCodeList = getShortTerm(address);
    list.addAll(await WeatherRepository.getShortForm(
      shortTermCodeList.first,
      shortTermCodeList.last,
    ));

    if (list.isNotEmpty) {
      // 중기
      final String regId = getMidTerm(address);
      list.addAll(await WeatherRepository.getMiddleForm(regId));

      // 데이터 세팅
      GlobalData.currentWeather = list.first; // 현재 날씨

      // 예보 날씨 세팅
      list.removeAt(0);
    } else {
      GlobalFunction.showToast(msg: '날씨 정보를 받아오지 못했습니다.');
    }

    GlobalData.weatherList = list;
  }

  // 예상 지속일
  static int getContinuousDays({int startIdx = 0}) {
    if (GlobalData.weatherList.isEmpty) return 0;

    final int userPop = GlobalData.loginUser?.pop ?? defaultPop; // 유저 강수 확률 없으면 기본
    int value = 0;

    for (int i = startIdx; i < GlobalData.weatherList.length; i++) {
      final int pop = GlobalData.weatherList[i].pop; // 강수 확률

      if (pop <= userPop) {
        value++;
      } else {
        return value;
      }
    }

    return value;
  }

  // 추천일
  static DateTime getRecommendDate() {
    DateTime recommendDate = GlobalData.weatherList.first.dateTime;
    int maxContinuousDays = 0;

    for (int i = 0; i < GlobalData.weatherList.length; i++) {
      final Weather weather = GlobalData.weatherList[i];
      final int continuousDays = getContinuousDays(startIdx: i);

      if (maxContinuousDays < continuousDays) {
        recommendDate = weather.dateTime;
        maxContinuousDays = continuousDays;
      }
    }

    return recommendDate;
  }
}
