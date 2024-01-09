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
    setWeatherData(); // 날씨 데이터 세팅
    super.onInit();
  }

  // 날씨 데이터 세팅
  Future<void> setWeatherData() async {
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
}
