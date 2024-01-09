import 'dart:math';

import 'package:car_washing_day/data/global_data.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../data/models/weather.dart';
import '../../../util/global_function.dart';

class CalendarPageController extends GetxController {
  final ItemScrollController itemScrollController = ItemScrollController();
  final DateTime n = DateTime.now();
  late final DateTime now = DateTime(n.year, n.month, n.day);

  late DateTime selectedDate = now; // 선택된 날짜

  int get continuousDays => GlobalFunction.getContinuousDays(startIdx: selectedDate.difference(now).inDays); // 예상 지속일

  // 선택 날짜 변경
  void onSelectionChanged(DateTime dateTime){
    selectedDate = dateTime;
    update();
  }
}
