import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/global_assets.dart';

class MainPageController extends GetxController {
  final List<Map<String, dynamic>> navList = [
    {
      'page': () => const SizedBox.shrink(),
      'label': '홈',
      'iconPath': GlobalAssets.svgHome,
    },
    {
      'page': () => const SizedBox.shrink(),
      'label': '캘린더',
      'iconPath': GlobalAssets.svgCalendar,
    },
  ];

  int pageIndex = 0;
  Widget get page => navList[pageIndex]['page']();

  void onChangedPage(int index) {
    pageIndex = index;
    update();
  }
}
