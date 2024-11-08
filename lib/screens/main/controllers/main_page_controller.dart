import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:car_washing_day/config/storage.dart';
import 'package:car_washing_day/screens/calendar/calendar_page.dart';
import 'package:car_washing_day/screens/home/home_page.dart';
import 'package:car_washing_day/screens/main/address_input_page.dart';
import 'package:car_washing_day/screens/profile/profile_page.dart';
import 'package:car_washing_day/util/global_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/global_assets.dart';
import '../../../data/global_data.dart';

class MainPageController extends GetxController {
  static get to => Get.find<MainPageController>();

  final List<Map<String, dynamic>> navList = [
    {
      'page': () => HomePage(),
      'iconPath': GlobalAssets.svgHome,
    },
    {
      'page': () => CalendarPage(),
      'iconPath': GlobalAssets.svgCalendar,
    },
    {
      'page': () => ProfilePage(isEditMode: true),
      'iconPath': GlobalAssets.svgPerson,
    },
  ];

  int pageIndex = 0;

  Widget get page => navList[pageIndex]['page']();

  @override
  void onInit() {
    requestAppTracking(); // 앱 추척 허용
    setWeatherData(); // 날씨 데이터 세팅
    super.onInit();
  }

  // 날씨 데이터 세팅
  Future<void> setWeatherData() async {
    if(GlobalData.weatherList.isNotEmpty) return;

    String? address = GlobalData.loginUser?.address ?? await Storage.getAddress();

    // 위치 데이터 있는 경우
    if(address != null) {
      await GlobalFunction.setWeatherList(address);
      update();
    } else {
      // 위치 데이터 없는 경우
      Get.to(() => AddressInputPage());
    }
  }

  // 페이지 변경
  void onChangedPage(int index) {
    pageIndex = index;
    update();
  }

  // 앱 추적 허용
  Future<void> requestAppTracking() async {
    final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;

    if (status == TrackingStatus.notDetermined) {
      AppTrackingTransparency.requestTrackingAuthorization();
    }
  }
}
