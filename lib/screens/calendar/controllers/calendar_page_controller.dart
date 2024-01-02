import 'dart:math';

import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../data/models/weather.dart';

class CalendarPageController extends GetxController {
  final ItemScrollController itemScrollController = ItemScrollController();
  final DateTime n = DateTime.now();
  late final DateTime now = DateTime(n.year, n.month, n.day);

  late DateTime selectedDate = now;

  late final List<Weather> weatherList = List.generate(
    10,
    (index) => Weather(
      skyType: SkyType.values[Random().nextInt(SkyType.values.length)],
      rainingType: RainingType.values[Random().nextInt(RainingType.values.length - 1)],
      pop: Random().nextInt(100),
      pcp: '강수 없음',
      dateTime: now.add(Duration(days: index)),
    ),
  );

  @override
  void onClose() {

    super.onClose();
  }

  // 선택 날짜 변경
  void onSelectionChanged(DateTime dateTime){
    selectedDate = dateTime;
    update();
  }
}
