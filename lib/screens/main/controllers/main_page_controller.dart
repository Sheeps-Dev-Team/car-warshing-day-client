import 'package:car_washing_day/screens/calendar/calendar_page.dart';
import 'package:car_washing_day/screens/home/home_page.dart';
import 'package:car_washing_day/screens/login/login_page.dart';
import 'package:car_washing_day/screens/profile/profile_page.dart';
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
      'page': () => ProfilePage(),
      //'page': () => LoginPage(),
      'iconPath': GlobalAssets.svgPerson,
    },
  ];

  int pageIndex = 0;
  Widget get page => navList[pageIndex]['page']();

  void onChangedPage(int index) {
    pageIndex = index;
    update();
  }
}
