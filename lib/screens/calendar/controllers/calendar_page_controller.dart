import 'dart:math';

import 'package:car_washing_day/data/global_data.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../data/models/weather.dart';

class CalendarPageController extends GetxController {
  final ItemScrollController itemScrollController = ItemScrollController();
  final DateTime n = DateTime.now();
  late final DateTime now = DateTime(n.year, n.month, n.day);

  late DateTime selectedDate = now;

  List<Weather> get weatherList {
    List<Weather> list = [...GlobalData.weatherList];

    list.removeAt(0);

    return list;
  }

  // 선택 날짜 변경
  void onSelectionChanged(DateTime dateTime){
    selectedDate = dateTime;
    update();
  }
}
