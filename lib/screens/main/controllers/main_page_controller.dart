import 'package:car_washing_day/screens/calendar/calendar_page.dart';
import 'package:car_washing_day/screens/home/home_page.dart';
import 'package:car_washing_day/screens/profile/profile_page.dart';
import 'package:car_washing_day/util/global_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/global_assets.dart';

class MainPageController extends GetxController {
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
    GlobalFunction.setWeatherData().then((value) => update()); // 날씨 데이터 세팅
    super.onInit();
  }

  // 페이지 변경
  void onChangedPage(int index) {
    pageIndex = index;
    update();
  }
}
