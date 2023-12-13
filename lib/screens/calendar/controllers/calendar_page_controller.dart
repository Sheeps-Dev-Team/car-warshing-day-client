import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../data/models/weather.dart';

class CalendarPageController extends GetxController {
  final CalendarController calendarController = CalendarController();
  final DateTime n = DateTime.now();
  late final DateTime now = DateTime(n.year, n.month, n.day);
  final List<String> dayOfWeekList = ['일', '월', '화', '수', '목', '금', '토'];

  late DateTime selectedDate = now;

  late final List<Weather> weatherList = List.generate(
    10,
    (index) => Weather(
      skyType: SkyType.values[Random().nextInt(SkyType.values.length)],
      rainingType: RainingType.values[Random().nextInt(RainingType.values.length - 1) + 1],
      pop: Random().nextInt(100),
      pcp: '강수 없음',
      dateTime: now.add(Duration(days: index)),
    ),
  );

  @override
  void onClose() {
    calendarController.dispose();

    super.onClose();
  }

  // 날짜 변경
  void onSelectionChanged(CalendarSelectionDetails calendarSelectionDetails){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(calendarSelectionDetails.date != null) selectedDate = calendarSelectionDetails.date!;
      update();
    });
  }
}
