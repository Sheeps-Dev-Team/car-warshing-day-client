import 'dart:io';

import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/config/storage.dart';
import 'package:car_washing_day/data/_model.dart';
import 'package:car_washing_day/data/global_data.dart';
import 'package:car_washing_day/repository/weather_repository.dart';
import 'package:car_washing_day/screens/login/login_page.dart';
import 'package:car_washing_day/util/long_term_forecast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../analytics/custom_analytics.dart';
import '../../../util/global_function.dart';

class CalendarPageController extends GetxController {
  final ItemScrollController itemScrollController = ItemScrollController();
  final DateTime n = DateTime.now();
  late final DateTime now = DateTime(n.year, n.month, n.day);

  late DateTime selectedDate = GlobalData.weatherList.isEmpty ? now : GlobalData.weatherList.first.dateTime; // 선택된 날짜
  late DateTime recommendDate = now; // 추천일

  int get continuousDays =>
      GlobalData.weatherList.isEmpty ? 0 : GlobalFunction.getContinuousDays(startIdx: selectedDate.difference(GlobalData.weatherList.first.dateTime).inDays); // 예상 지속일
  int get recommendContinuousDays =>
      GlobalData.weatherList.isEmpty ? 0 : GlobalFunction.getContinuousDays(startIdx: recommendDate.difference(GlobalData.weatherList.first.dateTime).inDays); // 추천 예상 지속일

  LongTermForecast? longTermForecast; // 장기 예보

  BannerAd? banner; // admob banner
  BannerAd? dialogBanner; // admob banner

  @override
  void onInit() {
    super.onInit();

    // admob 세팅
    banner = getBannerAd();
  }

  void init() {
    // 추천일 세팅
    if (GlobalData.weatherList.isNotEmpty) {
      recommendDate = GlobalFunction.getRecommendDate();
    }
  }

  // 선택 날짜 변경
  void onSelectionChanged(DateTime dateTime) {
    selectedDate = dateTime;
    update();
  }

  // 디테일 다이얼로그 열기
  void openDetailDialog(Widget child) {
    Get.dialog(
      child,
      barrierColor: $style.colors.barrierColor,
    );
  }

  // 장기 예보 세팅
  void setLongTerm() async {
    if (GlobalData.weatherList.isNotEmpty) {
      longTermForecast = LongTermForecast(
        locCode: GlobalFunction.getLongTerm((GlobalData.loginUser?.address ?? await Storage.getAddress())!),
        baseDate: GlobalData.weatherList.last.dateTime,
        baseIsSunny: GlobalData.weatherList.last.rainingType == RainingType.none,
      );

      update(['detailDialog']);
    }
  }

  // 세차일 등록
  void setWashingCarDay({required DateTime periodStart, required DateTime periodEnd}) async {
    if (GlobalData.loginUser != null) {
      GlobalFunction.loadingDialog(); // 로딩 시작

      final List<int> shortTermCodeList = GlobalFunction.getShortTerm(GlobalData.loginUser!.address);

      WashingCarDay? washingCarDay = await WeatherRepository.createWashing(
        WashingCarDay(
          startedAt: periodStart,
          finishedAt: periodEnd,
          nx: shortTermCodeList.first,
          ny: shortTermCodeList.last,
          regId: GlobalFunction.getMidTerm(GlobalData.loginUser!.address),
          checkUpdate: false,
          customPop: GlobalData.loginUser!.pop,
        ),
      );

      Get.close(1); // 로딩 끝
      if (washingCarDay != null) {
        GlobalData.loginUser!.washingCarDay = washingCarDay;
        update(['washingDay']);

        Get.close(1); // 디테일 다이얼로그 닫기
        GlobalFunction.showToast(msg: '세차일 등록이 완료되었습니다.');

        CustomAnalytics.carWashRegistrationEvent(parameters: washingCarDay.toJson()); // 애널리틱스 세차 등록 이벤트
      } else {
        GlobalFunction.showToast(msg: '잠시 후 다시 시도해 주세요.');
      }
    } else {
      Get.close(1); // 디테일 다이얼로그 닫기

      GlobalFunction.showCustomDialog(
        title: '로그인 후 이용 가능합니다 :)',
        okText: '로그인 하기',
        okFunc: () => Get.off(() => LoginPage()),
      );
    }
  }

  // 세차 등록 해제
  void deleteWashingCarDay() async {
    GlobalFunction.loadingDialog(); // 로딩 시작
    String? res = await WeatherRepository.deleteWashing(GlobalData.loginUser!.washingCarDay!.id);

    if (res != null) {
      await CustomAnalytics.carWashDeleteEvent(parameters: GlobalData.loginUser!.washingCarDay!.toJson()); // 애널리틱스 세차 등록 해제 이벤트
      Get.close(2); // 로딩 끝, 디테일 다이얼로그 닫기

      GlobalData.loginUser!.washingCarDay = null;
      update(['washingDay']);
      GlobalFunction.showToast(msg: '세차일 등록 해제가 완료되었습니다.');
    } else {
      Get.close(1); // 로딩 끝
      GlobalFunction.showToast(msg: '잠시 후 다시 시도해 주세요.');
    }
  }

  // 배너 광고 불러오기
  BannerAd getBannerAd() {
    // admob id
    const String iosId = 'ca-app-pub-5743388954735511/7513278459';
    const String iosTestId = 'ca-app-pub-3940256099942544/2934735716';
    const String androidId = 'ca-app-pub-5743388954735511/8033837417';
    const String androidTestId = 'ca-app-pub-3940256099942544/6300978111';

    return BannerAd(
      size: AdSize.banner,
      adUnitId: kDebugMode
          ? Platform.isIOS
              ? iosTestId
              : androidTestId
          : Platform.isIOS
              ? iosId
              : androidId,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    )..load();
  }
}
